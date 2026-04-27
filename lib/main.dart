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
  int _currentIndex = 0;

  // Liste des pages dans l'ordre du menu bonjour monsieur xxjfgfjlg
  final List<Widget> _pages = [
    const AccueilPage(),
    const DecouvrirPage(), // Ajouté ici
    const MonEspacePage(),
    const ReseauPage(),
    const ReglagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISTC Bouaké',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
        fontFamily: 'DM Sans',
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF1565C0),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                width: 24,
                height: 24,
                errorBuilder: (c, e, s) => const Icon(Icons.home),
              ),
              label: "Accueil",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/discover.png',
                width: 24,
                height: 24,
                errorBuilder: (c, e, s) => const Icon(Icons.explore),
              ),
              label: "Découvrir",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/user.png',
                width: 24,
                height: 24,
                errorBuilder: (c, e, s) => const Icon(Icons.person),
              ),
              label: "Espace",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/network.png',
                width: 24,
                height: 24,
                errorBuilder: (c, e, s) => const Icon(Icons.hub),
              ),
              label: "Réseau",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/settings.png',
                width: 24,
                height: 24,
                errorBuilder: (c, e, s) => const Icon(Icons.settings),
              ),
              label: "Réglages",
            ),
          ],
        ),
      ),
    );
  }
}
