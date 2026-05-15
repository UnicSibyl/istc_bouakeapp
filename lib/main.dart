import 'package:flutter/material.dart';
import 'pages/accueil_page.dart';
import 'pages/decouvrir_page.dart';
import 'pages/mon_espace_page.dart';
import 'pages/le_reseau_page.dart';
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
        colorSchemeSeed: const Color(0xFF1A45A0),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFDA783B),
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: MainNavigation(
        onThemeToggle: toggleTheme,
        isDark: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDark;

  const MainNavigation({
    super.key,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // La liste est dans le build pour réagir au changement de thème
    final List<Widget> pages = [
      const AccueilPage(),
      const DecouvrirPage(),
      const MonEspacePage(),
      const LeReseauPage(),
      ReglagesPage(
        onThemeToggle: widget.onThemeToggle,
        isDarkModeInitial: widget.isDark,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFDA783B),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: 'Découvrir'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Mon Espace'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center), label: 'Le Réseau'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Réglages'),
        ],
      ),
    );
  }
}
