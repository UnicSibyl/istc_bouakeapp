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

  final Color _customOrange = const Color(0xFFDA783B);
  final Color _istcBlue = const Color(0xFF1A45A0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 4; // 4 slides au total
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
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
      backgroundColor: const Color(0xFFF8F9FB),
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeaderBlue(),
                  _buildSearchBar(),
                  _buildSlider(),
                  _buildStatsRow(),
                  _buildSectionHeader("Nos formations", action: "Tout voir"),
                  _buildFormationsGrid(),
                  _buildSectionHeader("News & Événements",
                      action: _isExpanded ? "Masquer" : "Voir plus",
                      onTap: () => setState(() => _isExpanded = !_isExpanded)),
                  _buildNewsList(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      height: 220,
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          _sliderCardText(
              "RENTRÉE 2024- 2025",
              "Préparez votre avenir\navec l'ISTC Bouaké",
              "Inscriptions ouvertes"),
          _sliderCardImage("assets/images/slide1.jpg"),
          _sliderCardImage("assets/images/slide2.jpg"),
          _sliderCardImage("assets/images/slide3.jpg"),
        ],
      ),
    );
  }

  Widget _sliderCardImage(String chemin) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(image: AssetImage(chemin), fit: BoxFit.cover),
      ),
      child: Stack(children: [_buildDotsIndicator(4)]),
    );
  }

  Widget _sliderCardText(String tag, String title, String date) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: _istcBlue, borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tag,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _istcBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text("Postuler →"))
            ],
          ),
          _buildDotsIndicator(4),
        ],
      ),
    );
  }

  Widget _buildDotsIndicator(int total) {
    return Positioned(
        bottom: 15,
        right: 20,
        child: Row(
            children: List.generate(
                total,
                (i) => Container(
                    margin: const EdgeInsets.only(left: 4),
                    width: i == _currentPage ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color:
                            i == _currentPage ? _customOrange : Colors.white54,
                        borderRadius: BorderRadius.circular(10))))));
  }

  Widget _buildTopBar() => Container(
      padding: const EdgeInsets.only(top: 50, bottom: 15, left: 20, right: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/LOGO ISTC.png',
              height: 35,
              errorBuilder: (c, e, s) => const Text("ISTC",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          const Icon(Icons.notifications_active, color: Colors.orange),
        ],
      ));

  Widget _buildHeaderBlue() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Text("ISTC Bouaké",
          style: TextStyle(
              color: Color(0xFF1A45A0),
              fontSize: 28,
              fontWeight: FontWeight.bold)));

  Widget _buildSearchBar() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
          decoration: InputDecoration(
              hintText: "Rechercher...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none))));

  Widget _buildStatsRow() => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statItem("2", "Écoles"),
          _statItem("8", "Formations"),
          _statItem("12", "Offres réseau"),
        ],
      ));

  Widget _statItem(String nb, String label) => Column(
        children: [
          Text(nb,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      );

  Widget _buildSectionHeader(String title,
          {String? action, VoidCallback? onTap}) =>
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (action != null)
              GestureDetector(
                  onTap: onTap,
                  child: Text(action, style: TextStyle(color: _customOrange)))
          ]));

  Widget _buildFormationsGrid() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text("Cartes des formations à venir..."));

  Widget _buildNewsList() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text("Liste des événements à venir..."));
}
