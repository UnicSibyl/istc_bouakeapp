import 'package:flutter/material.dart';
import 'pages/accueil_page.dart';
import 'pages/decouvrir_page.dart';
import 'pages/le_reseau_page.dart';
import 'pages/mon_espace_page.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'ISTC Polytechnique Bouaké',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFDA783B),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A45A0)),
      ),
      themeMode: _themeMode,
      home: MainNavigator(
        onThemeChanged: toggleTheme,
        currentThemeMode: _themeMode,
      ),
    );
  }
}

class MainNavigator extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final ThemeMode currentThemeMode;

  const MainNavigator({
    super.key,
    required this.onThemeChanged,
    required this.currentThemeMode,
  });

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    const AccueilPage(),
    const DecouvrirPage(),
    const MonEspacePage(), // C'est ici que se trouve ton choix de profil
    const LeReseauPage(),
    const ReglagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF102A43),
        selectedItemColor: const Color(0xFFDA783B),
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: 'Découvrir'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Espace'),
          BottomNavigationBarItem(icon: Icon(Icons.language), label: 'Réseau'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Réglages'),
        ],
      ),
    );
  }
}
