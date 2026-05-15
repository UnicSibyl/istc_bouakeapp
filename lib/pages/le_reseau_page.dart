import 'package:flutter/material.dart';

class LeReseauPage extends StatefulWidget {
  const LeReseauPage({super.key});

  @override
  State<LeReseauPage> createState() => _LeReseauPageState();
}

class _LeReseauPageState extends State<LeReseauPage> {
  // Pour gérer l'ouverture/fermeture des sections d'écoles
  int? _expandedIndex;

  // Couleurs de la maquette
  static const Color orangeISTC = Color(0xFFF37021);
  static const Color blueArts = Color(0xFF1A3A5F);
  static const Color greenMarketing = Color(0xFF0F5A3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          // HEADER ORANGE (Exactement comme le screen)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(25, 60, 25, 30),
            color: orangeISTC,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.hub,
                        color: Colors.white, size: 18), // Icône réseau
                    const SizedBox(width: 8),
                    const Text("LE RÉSEAU",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 25),
                const Text("Le Réseau",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const Text(
                  "Bienvenue dans Le Réseau.\nDécouvrez les offres disponibles.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildBadge(Icons.push_pin, "12 offres actives"),
                    const SizedBox(width: 10),
                    _buildBadge(Icons.school, "2 écoles"),
                  ],
                )
              ],
            ),
          ),

          // LISTE DES ÉCOLES (Uniquement 2 écoles)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                // École 1
                _buildSchoolSection(
                  index: 0,
                  title: "École des Arts &\nImages Numériques",
                  offersCount: "7 offres disponibles",
                  color: blueArts,
                  icon: Icons.palette,
                  offers: [
                    _offerData("STAGE", "Stagiaire Motion Designer",
                        "Orange CI - Abidjan - 3 mois"),
                    _offerData("EMPLOI", "Graphiste Junior CDI",
                        "Agence Pixel - Bouaké"),
                    _offerData("PROJET", "Brand Design - Start-up tech CI",
                        "Freelance - Remote"),
                  ],
                ),
                const SizedBox(height: 20),
                // École 2
                _buildSchoolSection(
                  index: 1,
                  title: "École de Publicité\nMarketing",
                  offersCount: "5 offres disponibles",
                  color: greenMarketing,
                  icon: Icons.campaign,
                  offers: [
                    _offerData("STAGE", "Assistant Chef de Pub",
                        "Voodoo Group - Abidjan"),
                    _offerData(
                        "EMPLOI", "Social Media Manager", "CinetPay - Plateau"),
                  ],
                ),

                const SizedBox(height: 30),

                // Note informative en bas (Maquette)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05), blurRadius: 10)
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.orange, size: 30),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          "Cliquez sur une école pour dérouler ses offres (stages, emplois, projets). Recliquez pour fermer.",
                          style: TextStyle(
                              fontSize: 12, color: Colors.black87, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Badge (Header)
  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Section École Déroulante
  Widget _buildSchoolSection({
    required int index,
    required String title,
    required String offersCount,
    required Color color,
    required IconData icon,
    required List<Map<String, String>> offers,
  }) {
    bool isExpanded = _expandedIndex == index;

    return Column(
      children: [
        GestureDetector(
          onTap: () =>
              setState(() => _expandedIndex = isExpanded ? null : index),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: isExpanded
                  ? const BorderRadius.vertical(top: Radius.circular(20))
                  : BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.15),
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 1.2)),
                      Text(offersCount,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.white, size: 30),
              ],
            ),
          ),
        ),
        // Si fermé : Petit texte "Appuyez pour voir les offres"
        if (!isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app, size: 14, color: Colors.grey.shade400),
                Text(" Appuyez pour voir les offres",
                    style:
                        TextStyle(color: Colors.grey.shade400, fontSize: 11)),
              ],
            ),
          ),
        // Si ouvert : Liste des offres
        if (isExpanded)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: offers.map((o) => _buildOfferTile(o)).toList(),
            ),
          ),
      ],
    );
  }

  // Tuile d'offre individuelle
  Widget _buildOfferTile(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['type']!,
                    style: TextStyle(
                        color: orangeISTC,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(data['title']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87)),
                Text(data['loc']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: orangeISTC,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: const Size(60, 32),
            ),
            child: const Text("Voir >",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // Helper pour les données
  Map<String, String> _offerData(String type, String title, String loc) {
    return {"type": type, "title": title, "loc": loc};
  }
}
