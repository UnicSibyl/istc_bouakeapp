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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D3B8E)),
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
    const Scaffold(body: Center(child: Text("Espace Étudiant"))),
    const Scaffold(body: Center(child: Text("Réseau"))),
    const Scaffold(body: Center(child: Text("Réglages"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0D3B8E),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Accueil"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_rounded), label: "Découvrir"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: "Espace"),
          BottomNavigationBarItem(
              icon: Icon(Icons.hub_rounded), label: "Réseau"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: "Réglages"),
        ],
      ),
    );
  }
}
