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
  String? _expandedInfo;
  String? _activeSchool;

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
    // Timing de 4 secondes pour les citations
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
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildFilterBar(),
                  const SizedBox(height: 25),
                  _buildMainContent(),
                  const SizedBox(height: 30),
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

  Widget _buildMainContent() {
    switch (_selectedFilter) {
      case "Débouchés":
        return _buildDebouchesContent();
      case "Événements":
        return _buildEvenementsContent();
      case "Formations":
        return _buildFormationsContent();
      case "Vie Étudiante":
        return _buildVieEtudianteContent();
      case "Concours":
        return _buildConcoursContent();
      default:
        return _buildToutContent();
    }
  }

  // --- SECTION TOUT ---
  Widget _buildToutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Métiers & Perspectives",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () => setState(() => _selectedFilter = "Débouchés"),
              child: const Text("Voir tout",
                  style: TextStyle(color: Colors.orange)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildGalleryGrid([
          _infoIcon(
              "Motion Design",
              Icons.movie_filter,
              const Color(0xFFF5720A),
              "Création de graphismes animés pour la TV et le web. (Arts & Images Numériques)"),
          _infoIcon("Chef de Pub", Icons.campaign, const Color(0xFF1A45A0),
              "Responsable de la stratégie publicitaire entre annonceur et agence. (Publicité Marketing)"),
          _infoIcon("UI Designer", Icons.ads_click, const Color(0xFF107C41),
              "Conception d'interfaces mobiles esthétiques et fonctionnelles. (Arts & Images Numériques)"),
        ]),
        const SizedBox(height: 25),
        _buildContentCard("ACTU", "Nouveaux équipements", "Bouaké",
            "Disponible", const Color(0xFF107C41), Icons.computer),
      ],
    );
  }

  // --- SECTION DÉBOUCHÉS ---
  Widget _buildDebouchesContent() {
    return Column(
      children: [
        _buildSchoolAccordion("Arts et Images Numériques", [
          _infoIcon("Réalisateur", Icons.videocam, Colors.black,
              "Direction des productions audiovisuelles et scénarios. (Arts & Images Numériques)"),
          _infoIcon("Infographiste", Icons.brush, Colors.blue,
              "Créateur de visuels print et digitaux (Adobe). (Arts & Images Numériques)"),
          _infoIcon("Photographe", Icons.camera_alt, Colors.orange,
              "Expert prise de vue studio et reportage. (Arts & Images Numériques)"),
          _infoIcon("Monteur Vidéo", Icons.content_cut, Colors.red,
              "Assemblage rythmé des images et du son. (Arts & Images Numériques)"),
          _infoIcon("Webmaster", Icons.language, Colors.teal,
              "Gestionnaire technique des plateformes web. (Arts & Images Numériques)"),
        ]),
        const SizedBox(height: 15),
        _buildSchoolAccordion("Publicité Marketing", [
          _infoIcon("Media Planner", Icons.calendar_month, Colors.indigo,
              "Planification des supports de diffusion pub. (Publicité Marketing)"),
          _infoIcon("Analyste", Icons.bar_chart, Colors.green,
              "Étude des tendances de consommation. (Publicité Marketing)"),
          _infoIcon("Copywriter", Icons.edit_note, Colors.brown,
              "Concepteur de slogans et textes persuasifs. (Publicité Marketing)"),
          _infoIcon("Brand Manager", Icons.stars, Colors.amber,
              "Garant de l'identité d'une marque. (Publicité Marketing)"),
        ]),
      ],
    );
  }

  // --- SECTION FORMATIONS (SANS GALERIE) ---
  Widget _buildFormationsContent() {
    return Column(
      children: [
        _buildSchoolAccordion("École Arts & Images Numériques", null,
            extraInfo:
                "Cycles Licence & Master. Spécialités : Montage, VFX, Dessin académique, Esthétique de l'image."),
        const SizedBox(height: 10),
        _buildSchoolAccordion("École Publicité Marketing", null,
            extraInfo:
                "Cycles Licence & Master. Spécialités : Marketing Digital, Droit de la pub, Stratégie Média."),
      ],
    );
  }

  // --- SECTION ÉVÉNEMENTS ---
  Widget _buildEvenementsContent() {
    return Column(
      children: [
        _buildContentCard("WORKSHOP", "Masterclass Montage", "Salle Mac",
            "12 Mai", const Color(0xFF1A45A0), Icons.movie),
        _buildContentCard("CONFÉRENCE", "Marketing 2026", "Amphi A", "18 Mai",
            const Color(0xFF107C41), Icons.mic),
      ],
    );
  }

  // --- SECTION VIE ÉTUDIANTE ---
  Widget _buildVieEtudianteContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const Text(
        "L'antenne de l'ISTC Polytechnique Bouaké offre un cadre chaleureux. Entre clubs photo et tournois sportifs, l'expérience est unique.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54, height: 1.5),
      ),
    );
  }

  // --- SECTION CONCOURS ---
  Widget _buildConcoursContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orange.withOpacity(0.3))),
      child: const Text(
          "• Accès par concours direct.\n• Épreuves : Culture Générale, Spécialité et Entretien."),
    );
  }

  // --- COMPOSANTS RÉUTILISABLES ---
  Widget _buildSchoolAccordion(String title, List<Widget>? icons,
      {String? extraInfo}) {
    bool isOpen = _activeSchool == title;
    return GestureDetector(
      onTap: () => setState(() => _activeSchool = isOpen ? null : title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
            ]),
        child: Column(
          children: [
            Row(children: [
              const Icon(Icons.school, color: Color(0xFF107C41)),
              const SizedBox(width: 15),
              Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              Icon(isOpen ? Icons.expand_less : Icons.expand_more),
            ]),
            if (isOpen) ...[
              const Divider(height: 25),
              if (icons != null) _buildGalleryGrid(icons),
              if (extraInfo != null)
                Text(extraInfo,
                    style: const TextStyle(fontSize: 13, height: 1.5)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryGrid(List<Widget> items) =>
      Wrap(spacing: 15, runSpacing: 15, children: items);

  Widget _infoIcon(String label, IconData icon, Color color, String desc) {
    bool isSelected = _expandedInfo == desc;
    return GestureDetector(
      onTap: () => setState(() => _expandedInfo = isSelected ? null : desc),
      child: Column(
        children: [
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(15)),
              child: Icon(icon, color: Colors.white)),
          const SizedBox(height: 5),
          SizedBox(
              width: 70,
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold))),
          if (isSelected)
            Container(
              width: 250,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.withOpacity(0.2))),
              child: Text(desc,
                  style: const TextStyle(
                      fontSize: 11, fontStyle: FontStyle.italic)),
            )
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
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      child: const Text("Découvrir\nISTC Polytechnique Bouaké",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFilterBar() {
    final filters = [
      "Tout",
      "Débouchés",
      "Événements",
      "Formations",
      "Vie Étudiante",
      "Concours"
    ];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedFilter == filters[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filters[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(filters[index],
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12))),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentCard(String tag, String title, String loc, String date,
      Color color, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 20)),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text("$loc • $date", style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _buildTestimonialSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: const Color(0xFF102A43),
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        const Icon(Icons.format_quote, color: Colors.orange, size: 30),
        Text(_quotes[_currentQuoteIndex]["text"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontStyle: FontStyle.italic)),
        const SizedBox(height: 10),
        Text(_quotes[_currentQuoteIndex]["author"]!,
            style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 11)),
      ]),
    );
  }
}
