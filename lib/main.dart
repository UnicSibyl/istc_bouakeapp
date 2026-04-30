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
      title: 'ISTC Bouaké',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
        fontFamily: 'DMSans', // Applique la police à toute l'appli
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
    const Scaffold(body: Center(child: Text("Espace"))),
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
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Découvrir",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Espace"),
          BottomNavigationBarItem(icon: Icon(Icons.hub), label: "Réseau"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Réglages",
          ),
        ],
      ),
    );
  }
}
