import 'package:flutter/material.dart';
import 'dart:async';

class DecouvrirPage extends StatefulWidget {
  const DecouvrirPage({super.key});

  @override
  State<DecouvrirPage> createState() => _DecouvrirPageState();
}

class _DecouvrirPageState extends State<DecouvrirPage> {
  String _selectedFilter = "Tout";
  int _currentQuoteIndex = 0;
  Timer? _quoteTimer;
  String? _expandedGalleryItem;

  // Liste des témoignages pour l'animation automatique
  final List<Map<String, String>> _quotes = [
    {
      "text":
          "L'ISTC m'a donné les outils pour lancer mon agence créative à 23 ans.",
      "author": "Mariama D. • Promo 2022, Arts & Images"
    },
    {
      "text": "Une formation d'excellence qui lie théorie et pratique réelle.",
      "author": "Jean-Paul K. • Promo 2021, Publicité"
    },
    {
      "text": "Le campus de Bouaké offre un cadre idéal pour l'apprentissage.",
      "author": "Saran T. • Licence 3, Marketing"
    },
  ];

  @override
  void initState() {
    super.initState();
    // Change la citation toutes les 4 secondes
    _quoteTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _quoteTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // --- Header Vert (Identité ISTC) ---
          _buildHeader(),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // --- Barre de Filtres Coulissante ---
                  _buildFilterBar(),

                  const SizedBox(height: 25),

                  // --- Liste de cartes dynamiques ---
                  if (_selectedFilter == "Tout" ||
                      _selectedFilter == "Événements")
                    _buildContentCard(
                      "WORKSHOP",
                      "UI/UX Masterclass • Bouaké",
                      "Auditorium • 60 places",
                      "12 Oct 2024",
                      const Color(0xFF1A45A0),
                      Icons.palette_rounded,
                    ),

                  if (_selectedFilter == "Tout" ||
                      _selectedFilter == "Formations")
                    _buildContentCard(
                      "CONFÉRENCE",
                      "Marketing Digital en Côte d'Ivoire",
                      "Amphi A • 100 places",
                      "28 Oct 2024",
                      const Color(0xFF107C41),
                      Icons.campaign_rounded,
                    ),

                  const SizedBox(height: 30),

                  // --- Section Galerie ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Galerie",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Voir tout",
                              style: TextStyle(color: Colors.orange))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildGallerySection(),

                  const SizedBox(height: 30),

                  // --- Témoignages (Citations animées) ---
                  _buildTestimonialSection(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF107C41),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Découvrir",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const Text("Explorez l'univers ISTC Bouaké",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15)),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.white70),
                hintText: "Rechercher un événement, une actu...",
                hintStyle: TextStyle(color: Colors.white60, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    final filters = [
      "Tout",
      "Événements",
      "Formations",
      "Vie Étudiante",
      "Concours"
    ];
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedFilter == filters[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filters[index]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF5720A) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 8)
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentCard(String tag, String title, String loc, String date,
      Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
                color: color,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Icon(icon, color: Colors.white.withOpacity(0.5), size: 60),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(tag,
                        style: const TextStyle(
                            color: Color(0xFFF5720A),
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(date,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.redAccent),
                    const SizedBox(width: 5),
                    Text(loc,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _galleryIcon(
                  "Motion Design",
                  Icons.draw_rounded,
                  const Color(0xFFF5720A),
                  "L'art d'animer des graphismes pour la pub."),
              _galleryIcon(
                  "Photo",
                  Icons.camera_rounded,
                  const Color(0xFF1A45A0),
                  "Maîtriser la lumière et la composition."),
              _galleryIcon(
                  "Vidéo",
                  Icons.videocam_rounded,
                  const Color(0xFF107C41),
                  "Réalisation de clips et reportages."),
              _galleryIcon("Stratégie", Icons.insights_rounded, Colors.purple,
                  "Analyse de marché et plans médias."),
            ],
          ),
        ),
        if (_expandedGalleryItem != null)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange.withOpacity(0.1))),
            child: Text(_expandedGalleryItem!,
                style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87)),
          ),
      ],
    );
  }

  Widget _galleryIcon(String label, IconData icon, Color color, String desc) {
    bool isSelected = _expandedGalleryItem == desc;
    return GestureDetector(
      onTap: () =>
          setState(() => _expandedGalleryItem = isSelected ? null : desc),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                              color: color.withOpacity(0.4), blurRadius: 10)
                        ]
                      : []),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimonialSection() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey<int>(_currentQuoteIndex),
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFF102A43),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            const Icon(Icons.format_quote_rounded,
                color: Color(0xFFF5720A), size: 40),
            const SizedBox(height: 10),
            Text(
              _quotes[_currentQuoteIndex]["text"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  height: 1.5),
            ),
            const SizedBox(height: 20),
            Text(
              _quotes[_currentQuoteIndex]["author"]!,
              style: const TextStyle(
                  color: Color(0xFFF5720A),
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
