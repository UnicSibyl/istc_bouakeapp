import 'package:flutter/material.dart';
import 'pages/accueil_page.dart';
import 'pages/le_reseau_page.dart';
import 'pages/decouvrir_page.dart';
import 'pages/reglages_page.dart'; // Importation de la nouvelle page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // État global pour le mode sombre
  ThemeMode _themeMode = ThemeMode.light;
  // État global pour la connexion (simulé)
  bool _isLoggedIn = true;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  void handleLogin() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTC Polytechnique Bouaké',
      debugShowCheckedModeBanner: false,
      // Thème Clair
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      // Thème Sombre
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      themeMode: _themeMode,
      // Si connecté -> Appli, sinon -> Page Login
      home: _isLoggedIn 
          ? MainNavigator(onThemeChanged: toggleTheme, onLogout: handleLogout) 
          : LoginPage(onLogin: handleLogin),
    );
  }
}

// --- INTERFACE DE CONNEXION (LOGIN) ---
class LoginPage extends StatelessWidget {
  final VoidCallback onLogin;
  const LoginPage({super.key,敦 required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Color(0xFF107C41)),
            const SizedBox(height: 20),
            const Text("CONNEXION", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            const TextField(decoration: InputDecoration(labelText: "Identifiant", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            const TextField(decoration: InputDecoration(labelText: "Mot de passe", border: OutlineInputBorder()), obscureText: true),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF107C41)),
                onPressed: onLogin,
                child: const Text("Se connecter", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainNavigator extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final VoidCallback onLogout;
  const MainNavigator({super.key, required this.onThemeChanged, required this.onLogout});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 4; // On démarre sur Réglages pour voir le résultat

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AccueilPage(),
      const DecouvrirPage(),
      const Scaffold(body: Center(child: Text("Mon Espace Étudiant"))),
      const LeReseauPage(),
      ReglagesPage(onThemeToggle: widget.onThemeChanged, onLogout: widget.onLogout),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : const Color(0xFF102A43),
        selectedItemColor: const Color(0xFFF5720A),
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Découvrir"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Mon Espace"),
          BottomNavigationBarItem(icon: Icon(Icons.language), label: "Le Réseau"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Réglages"),
        ],
      ),
    );
  }
}