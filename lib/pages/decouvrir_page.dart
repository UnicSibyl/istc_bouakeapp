import 'package:flutter/material.dart';
import 'dart:async';

class DecouvrirPage extends StatefulWidget {
  const DecouvrirPage({super.key});

  @override
  State<DecouvrirPage> createState() => _DecouvrirPageState();
}

class _DecouvrirPageState extends State<DecouvrirPage> {
  // Couleurs Officielles ISTC
  static const Color greenISTC = Color(0xFF107C41);
  static const Color blueISTC = Color(0xFF1A45A0);
  static const Color orangeISTC = Color(0xFFDA783B);
  static const Color lightGrey = Color(0xFFF5F7FA);

  // --- GESTION DES ONGLETS / FILTRES ---
  String _selectedTab = "Tout";

  // --- GESTION DE L'AFFICHAGE "FORMATIONS" ---
  String? _selectedEcoleFormation;

  // --- GESTION DE L'AFFICHAGE "DEBOUCHES" ---
  String? _expandedEcoleDebouche; // Gère quelle école est dépliée

  // Stocke maintenant l'élément sélectionné pour afficher proprement le titre et la description
  final Map<String, Map<String, String>?> _selectedDeboucheItem = {
    "arts": null,
    "marketing": null,
  };

  // --- GESTION DU CARROUSEL DE TEMOIGNAGES ---
  int _currentQuoteIndex = 0;
  Timer? _quoteTimer;

  final List<Map<String, String>> _quotes = [
    {
      "text":
          "« L'ISTC m'a donné les outils pour lancer mon agence créative à 23 ans. »",
      "author": "Mariama D. - Promo 2022, Arts & Images"
    },
    {
      "text":
          "« Une formation pratique et immersive. Grâce aux studios, j'ai été opérationnel dès mon premier jour de stage. »",
      "author": "Arnaud K. - Promo 2023, Publicité Marketing"
    },
    {
      "text":
          "« Les masterclasses et le réseau de l'école m'ont permis de signer en CDI avant même la remise des diplômes. »",
      "author": "Fanta T. - Promo 2024, Arts & Images"
    },
  ];

  @override
  void initState() {
    super.initState();
    // Changement automatique de témoignage toutes les 5 secondes
    _quoteTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER VERT AVEC RECHERCHE ---
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
              decoration: const BoxDecoration(
                color: greenISTC,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Découvrir",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const Text("Explorez l'univers ISTC Bouaké",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Rechercher un événement, une actu...",
                      hintStyle:
                          const TextStyle(color: Colors.white60, fontSize: 13),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.white60),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),

            // --- FILTRES (TABS MIS À JOU) ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    _buildFilterChip("Tout"),
                    _buildFilterChip("Événements"),
                    _buildFilterChip("Formations"),
                    _buildFilterChip("Débouchés"),
                  ],
                ),
              ),
            ),

            // --- NAVIGATION INTERNE SELON L'ONGLET SÉLECTIONNÉ ---
            if (_selectedTab == "Tout") ...[
              _buildEventsSection(),
              _buildGalerieSection(),
            ] else if (_selectedTab == "Événements") ...[
              _buildEventsSection(),
            ] else if (_selectedTab == "Formations") ...[
              _buildFormationsContent(),
            ] else if (_selectedTab == "Débouchés") ...[
              _buildDebouchesContent(),
            ],

            const SizedBox(height: 10),
            // --- TÉMOIGNAGE DYNAMIQUE AUTOMATIQUE ---
            _buildQuoteSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget personnalisé de Puce de filtrage interactive
  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? orangeISTC : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: isSelected ? orangeISTC : Colors.grey.shade300),
        ),
        child: Text(label,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- BLOC CONTENU : ÉVÉNEMENTS ---
  Widget _buildEventsSection() {
    return Column(
      children: [
        _buildEventCard(
          category: "WORKSHOP",
          date: "12 Oct 2024",
          title: "UI/UX Masterclass • Bouaké",
          location: "Auditorium",
          places: "60 places",
          headerColor: blueISTC,
          icon: Icons.palette,
        ),
        _buildEventCard(
          category: "CONFÉRENCE",
          date: "28 Oct 2024",
          title: "Marketing Digital en Côte d'Ivoire",
          location: "Amphi A",
          places: "100 places",
          headerColor: greenISTC,
          icon: Icons.campaign,
        ),
      ],
    );
  }

  // --- BLOC CONTENU : GALERIE ---
  Widget _buildGalerieSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Galerie",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Voir tout",
                  style: TextStyle(color: orangeISTC, fontSize: 12)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildGalleryItem(Icons.color_lens, "Motion Design", orangeISTC),
            _buildGalleryItem(Icons.camera_alt, "Photo", blueISTC),
            _buildGalleryItem(Icons.movie, "Vidéo", greenISTC),
          ],
        ),
      ],
    );
  }

  // --- CONTENU DE L'ONGLET FORMATIONS ---
  Widget _buildFormationsContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nos Écoles de Formation",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: blueISTC)),
          const SizedBox(height: 5),
          const Text("Cliquez sur une école pour découvrir son descriptif.",
              style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 15),
          _buildEcoleCardSelection(
            id: "arts",
            title: "Arts & Images Numériques",
            color: blueISTC,
            icon: Icons.palette_rounded,
            description:
                "Cette école forme l'élite créative aux métiers des arts graphiques, du design, de l'animation 2D/3D, de la photographie et de l'audiovisuel numérique, alliant technique et originalité artistique.",
          ),
          const SizedBox(height: 12),
          _buildEcoleCardSelection(
            id: "marketing",
            title: "Publicité Marketing",
            color: orangeISTC,
            icon: Icons.campaign_rounded,
            description:
                "Spécialisée dans la communication, le management de marque et le marketing digital, cette formation prépare aux stratégies publicitaires modernes, à l'analyse de marché et au community management.",
          ),
        ],
      ),
    );
  }

  Widget _buildEcoleCardSelection({
    required String id,
    required String title,
    required Color color,
    required IconData icon,
    required String description,
  }) {
    bool isSelected = _selectedEcoleFormation == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEcoleFormation = isSelected ? null : id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                Icon(
                    isSelected
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white70),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(height: 15),
              const Divider(color: Colors.white30, height: 1),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.87),
                    fontSize: 13,
                    height: 1.4),
              ),
            ]
          ],
        ),
      ),
    );
  }

  // --- CONTENU DE L'ONGLET DÉBOUCHÉS ---
  Widget _buildDebouchesContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Débouchés Professionnels",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: greenISTC)),
          const SizedBox(height: 15),
          _buildEcoleDeboucheExpandable(
            id: "arts",
            title: "Arts & Images Numériques",
            color: blueISTC,
            iconsData: [
              {
                "icon": Icons.camera_alt,
                "label": "Photographe / Réalisateur",
                "desc":
                    "Réalisation de films, clips, captations vidéos professionnelles et shooting de haute qualité."
              },
              {
                "icon": Icons.brush,
                "label": "Designer Graphique",
                "desc":
                    "Création d'identités visuelles, logos, chartes graphiques et supports de communication visuelle."
              },
              {
                "icon": Icons.movie_filter,
                "label": "Motion Designer",
                "desc":
                    "Animation d'éléments graphiques 2D et 3D pour la télévision, le cinéma ou le web."
              },
              {
                "icon": Icons.computer,
                "label": "Concepteur UI/UX",
                "desc":
                    "Design et optimisation des interfaces d'applications mobiles et sites web pour les utilisateurs."
              },
            ],
          ),
          const SizedBox(height: 12),
          _buildEcoleDeboucheExpandable(
            id: "marketing",
            title: "Publicité Marketing",
            color: orangeISTC,
            iconsData: [
              {
                "icon": Icons.trending_up,
                "label": "Chef de Produit",
                "desc":
                    "Gestion du cycle de vie d'un produit, de sa conception à sa commercialisation sur le marché."
              },
              {
                "icon": Icons.forum,
                "label": "Community Manager",
                "desc":
                    "Animation des réseaux sociaux, modération et gestion de l'image de marque en ligne."
              },
              {
                "icon": Icons.lightbulb,
                "label": "Concepteur Rédacteur",
                "desc":
                    "Création de slogans publicitaires, de scripts et rédaction de contenus impactants."
              },
              {
                "icon": Icons.pie_chart,
                "label": "Responsable Média",
                "desc":
                    "Planification et achat d'espaces publicitaires stratégiques (TV, Radio, Web)."
              },
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEcoleDeboucheExpandable({
    required String id,
    required String title,
    required Color color,
    required List<Map<String, dynamic>> iconsData,
  }) {
    bool isExpanded = _expandedEcoleDebouche == id;
    final selectedItem = _selectedDeboucheItem[id];

    return Container(
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _expandedEcoleDebouche = isExpanded ? null : id;
              });
            },
            leading: Icon(Icons.business_center, color: color),
            title: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey),
          ),
          if (isExpanded) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: iconsData.map((item) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDeboucheItem[id] = {
                          "label": item['label'] as String,
                          "desc": item['desc'] as String,
                        };
                      });
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: color.withOpacity(0.3), width: 2),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 5)
                          ]),
                      child: Icon(item['icon'] as IconData,
                          color: color, size: 28),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Zone d'affichage stylisée et sécurisée pour éviter les crashs de texte
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(12, 5, 12, 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  left: BorderSide(color: color.withOpacity(0.5), width: 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedItem != null ? selectedItem["label"]! : "Métiers",
                    style: TextStyle(
                        fontSize: 13,
                        color: color,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedItem != null
                        ? selectedItem["desc"]!
                        : "Cliquez sur une icône pour voir la description du métier.",
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade800, height: 1.4),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

  // Card Événement standard
  Widget _buildEventCard({
    required String category,
    required String date,
    required String title,
    required String location,
    required String places,
    required Color headerColor,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child:
                    Icon(icon, color: Colors.white.withOpacity(0.5), size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: orangeISTC.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(category,
                          style: const TextStyle(
                              color: orangeISTC,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.calendar_today, size: 12, color: blueISTC),
                    const SizedBox(width: 4),
                    Text(date,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.redAccent),
                    Text(" $location",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54)),
                    const SizedBox(width: 15),
                    const Icon(Icons.people, size: 14, color: blueISTC),
                    Text(" $places",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Items de la Galerie
  Widget _buildGalleryItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 80,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 10, color: Colors.black54)),
      ],
    );
  }

  // Section Témoignage
  Widget _buildQuoteSection() {
    final currentQuote = _quotes[_currentQuoteIndex];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: Container(
        key: ValueKey<int>(_currentQuoteIndex),
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: blueISTC, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: orangeISTC,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentQuote["text"]!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        height: 1.3),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentQuote["author"]!,
                    style: const TextStyle(
                        color: orangeISTC,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
