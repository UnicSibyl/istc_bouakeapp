import 'package:flutter/material.dart';
import 'dart:async';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isExpanded = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Transition toutes les 4 secondes
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 3;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600), // Plus rapide et fluide
          curve: Curves.decelerate,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Gris léger pour le fond
      body: Column(
        children: [
          // Barre de titre "ACCUEIL"
          Container(
            padding: const EdgeInsets.only(top: 45, bottom: 10),
            color: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, color: Color(0xFFF5720A), size: 20),
                SizedBox(width: 8),
                Text(
                  "ACCUEIL",
                  style: TextStyle(
                      color: Color(0xFF1A45A0), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER BLEU ---
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    width: double.infinity,
                    color: const Color(0xFF1E61ED), // Même bleu que le slider
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bienvenue sur l'appli de l'antenne ISTC Polytechnique Bouaké",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "ISTC ",
                                      style: TextStyle(color: Colors.white)),
                                  TextSpan(
                                      text: "Bouaké",
                                      style:
                                          TextStyle(color: Color(0xFFF5720A))),
                                ],
                              ),
                            ),
                            const Icon(Icons.notifications_active,
                                color: Color(0xFFF5720A), size: 30),
                          ],
                        ),
                      ],
                    ),
                  ),

                  _buildSearchBar(),
                  _buildDynamicSlider(),

                  // Statistiques (Compteurs)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCard("2", "Écoles"),
                        _buildStatCard("8", "Formations"),
                        _buildStatCard("12", "Offres réseau"),
                      ],
                    ),
                  ),

                  _buildSectionHeader("Nos formations"),
                  const SizedBox(height: 15),
                  _buildFormationsList(),

                  _buildSectionHeader("News & Événements",
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      isAction: true,
                      actionText: _isExpanded ? "Masquer" : "Voir plus"),

                  _buildNewsCard("WORKSHOP", "UI/UX Masterclass - Bouaké",
                      "12 Oct", Icons.brush, Colors.blue),
                  _buildNewsCard("EXPOSITION", "Digital Arts Showcase 2024",
                      "5 Nov", Icons.movie, Colors.orange),

                  if (_isExpanded) ...[
                    _buildNewsCard("SÉMINAIRE", "Intelligence Artificielle",
                        "15 Nov", Icons.psychology, Colors.green),
                  ],
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS DE SOUTIEN ---

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Rechercher formations, news...",
            prefixIcon: Icon(Icons.search, color: Colors.blue),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicSlider() {
    return SizedBox(
      height: 200,
      child: PageView(
        controller: _pageController,
        children: [
          _buildTextSlide(),
          _buildImageSlide("assets/images/slide1.jpg", "Nos infrastructures"),
          _buildImageSlide("assets/images/slide2.jpg", "Vie étudiante"),
        ],
      ),
    );
  }

  Widget _buildTextSlide() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF1E61ED), Color(0xFF1A45A0)]),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🎓 RENTRÉE 2024–2025",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Préparez votre avenir\navec l'ISTC Bouaké",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const Text("Inscriptions ouvertes jusqu'au 30 sept.",
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white24, elevation: 0),
            child:
                const Text("Postuler →", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlide(String path, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[300],
        image: DecorationImage(
            image: AssetImage(path), fit: BoxFit.cover, onError: (_, __) {}),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.5), Colors.transparent]),
        ),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.bottomLeft,
        child: Text(label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E61ED))),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title,
      {VoidCallback? onTap,
      bool isAction = false,
      String actionText = "Tout voir"}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (isAction)
            GestureDetector(
              onTap: onTap,
              child: Text(actionText,
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildFormationsList() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        children: [
          _buildFormationCard("Arts & Images\nNumériques", "Licence • Master",
              "8 modules", Icons.palette, const Color(0xFF1E61ED)),
          _buildFormationCard("Publicité Marketing", "Licence • Master",
              "7 modules", Icons.campaign, const Color(0xFFD6730E)),
        ],
      ),
    );
  }

  Widget _buildFormationCard(
      String title, String sub, String mod, IconData icon, Color color) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const Spacer(),
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Text(sub,
              style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white24, borderRadius: BorderRadius.circular(10)),
            child: Text(mod,
                style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(
      String cat, String title, String date, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cat,
                    style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                Text(date,
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
