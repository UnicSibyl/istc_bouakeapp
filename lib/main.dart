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
      theme: ThemeData(useMaterial3: true),
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
    const Scaffold(body: Center(child: Text("Page Découvrir"))),
    const Scaffold(body: Center(child: Text("Page Mon Espace"))),
    const Scaffold(body: Center(child: Text("Page Le Réseau"))),
    const Scaffold(body: Center(child: Text("Page Réglages"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF102A43), // Bleu nuit au lieu de noir
        selectedItemColor: const Color(0xFFF5720A), // Orange ISTC
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
