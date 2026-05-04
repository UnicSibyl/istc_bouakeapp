import 'package:flutter/material.dart';
import 'pages/accueil_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTC Polytechnique Bouaké',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AccueilPage(),
    const Scaffold(body: Center(child: Text("Découvrir"))),
    const Scaffold(body: Center(child: Text("Mon Espace"))),
    const Scaffold(body: Center(child: Text("Le Réseau"))),
    const Scaffold(body: Center(child: Text("Réglages"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1F26), // Fond sombre maquette
        selectedItemColor: const Color(0xFFF5720A), // Orange pour l'actif
        unselectedItemColor: Colors.white54, // Blanc tamisé pour les autres
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: "Accueil"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: "Découvrir"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Mon Espace"),
          BottomNavigationBarItem(
              icon: Icon(Icons.language), label: "Le Réseau"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Réglages"),
        ],
      ),
    );
  }
}
