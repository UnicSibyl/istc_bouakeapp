import 'package:flutter/material.dart';
import 'pages/accueil_page.dart';
import 'pages/le_reseau_page.dart';
import 'pages/decouvrir_page.dart';
import 'pages/reglages_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTC Polytechnique Bouaké',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      themeMode: _themeMode,
      home: MainNavigator(onThemeChanged: toggleTheme),
    );
  }
}

class MainNavigator extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const MainNavigator({super.key, required this.onThemeChanged});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 4; // On reste sur Réglages pour tes tests

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AccueilPage(),
      const DecouvrirPage(),
      const Scaffold(body: Center(child: Text("Page Mon Espace"))),
      const LeReseauPage(),
      ReglagesPage(onThemeToggle: widget.onThemeChanged),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : const Color(0xFF102A43),
        selectedItemColor: const Color(0xFFF5720A),
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => _currentIndex = index),
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
