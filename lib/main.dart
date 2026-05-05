import 'package:flutter/material.dart';
import 'pages/accueil_page.dart';
import 'pages/le_reseau_page.dart';
import 'pages/decouvrir_page.dart'; // Import important !

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
        primarySwatch: Colors.blue,
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
  int _currentIndex = 1; // On démarre sur "Découvrir" pour voir tes modifs

  final List<Widget> _pages = [
    const AccueilPage(),
    const DecouvrirPage(), // Ta nouvelle page dynamique
    const Scaffold(body: Center(child: Text("Page Mon Espace"))),
    const LeReseauPage(),
    const Scaffold(body: Center(child: Text("Page Réglages"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // IndexedStack garde l'état des pages quand on change d'onglet
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF102A43),
        selectedItemColor: const Color(0xFFF5720A),
        unselectedItemColor: Colors.white70,
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
