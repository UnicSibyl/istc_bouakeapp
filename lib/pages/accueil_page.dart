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
  Timer? _sliderTimer;

  @override
  void initState() {
    super.initState();
    _sliderTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 3;
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.home, color: Colors.orange, size: 18),
            const SizedBox(width: 8),
            Text("ACCUEIL",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1.5)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Bleu ISTC
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              color: const Color(0xFF1A45A0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ISTC Bouaké",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24)),
                      Text("Excellence & Innovation",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 30),
                      Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle))),
                    ],
                  )
                ],
              ),
            ),

            // Barre de Recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05), blurRadius: 10)
                    ]),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Trouver un cours, un prof...",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // Slider avec bouton Postuler
            SizedBox(
              height: 170,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildMainSlider(),
                  _buildImageSlide("assets/images/slide1.jpg"),
                  _buildImageSlide("assets/images/slide2.jpg"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => _buildDot(index))),

            // Section Statistiques
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statCard("2", "Écoles", Icons.school_outlined),
                  _statCard(
                      "8", "Spécialités", Icons.workspace_premium_outlined),
                  _statCard("12", "Partenaires", Icons.handshake_outlined),
                ],
              ),
            ),

            _buildSectionHeader("Formations Disponibles"),

            // Écoles : Arts & Images VS Marketing (Taille augmentée et sous-titres modifiés)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      child: _ecoleCard(
                          "Arts & Images\nNumériques",
                          "Licence - Master",
                          const Color(0xFF1A45A0),
                          Icons.palette_rounded)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _ecoleCard(
                          "Publicité\nMarketing",
                          "Licence - Master",
                          const Color(0xFFDA783B),
                          Icons.campaign_rounded)),
                ],
              ),
            ),

            // Remplacement de 'Actualités Récentes' par 'News & Événements'
            _buildSectionHeader("News & Événements"),
            _buildNewsList(),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSlider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF1A45A0), Color(0xFF2E5BBA)]),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("ADMISSIONS OUVERTES",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Rejoignez l'élite du digital\nà l'ISTC Bouaké",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            // Bouton modifié en "Postuler"
            child: const Text("Postuler",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _statCard(String val, String label, IconData icon) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade100)),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(height: 5),
          Text(val,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1A45A0))),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _ecoleCard(String title, String subtitle, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white24, size: 35),
          const SizedBox(height: 12),
          // Taille du texte augmentée de 13 à 15 pour une meilleure visibilité
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  height: 1.2)),
          const SizedBox(height: 6),
          Text(subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return Column(
      children: [
        _newsTile("Nouveaux équipements GFX",
            "Arrivée de tablettes WACOM au labo.", true),
        _newsTile("Planning des examens",
            "Disponible sur votre espace étudiant.", false),
      ],
    );
  }

  Widget _newsTile(String t, String s, bool isNew) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Row(
          children: [
            Text(t,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            if (isNew) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                child: const Text("NEW",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold)),
              )
            ]
          ],
        ),
        subtitle:
            Text(s, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Text(title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A45A0))),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      height: 5,
      width: _currentPage == index ? 18 : 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _currentPage == index ? Colors.orange : Colors.grey.shade300),
    );
  }

  Widget _buildImageSlide(String path) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(path, fit: BoxFit.cover)));
  }
}
