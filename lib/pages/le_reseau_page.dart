import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeReseauPage extends StatefulWidget {
  const LeReseauPage({super.key});

  @override
  State<LeReseauPage> createState() => _LeReseauPageState();
}

class _LeReseauPageState extends State<LeReseauPage> {
  bool _isArtsExpanded = false;
  bool _isPubExpanded = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Erreur sur le lien: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: Column(
        children: [
          // Barre de titre blanche
          Container(
            padding: const EdgeInsets.only(top: 45, bottom: 10),
            color: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.language, color: Color(0xFFF5720A), size: 20),
                SizedBox(width: 8),
                Text("LE RÉSEAU",
                    style: TextStyle(
                        color: Color(0xFF1A45A0), fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Section Orange (Header)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    color: const Color(0xFFD6730E),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Le Réseau",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        const Text(
                            "Bienvenue dans Le Réseau.\nDécouvrez les offres disponibles.",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            _buildTopBadge("📌 12 offres actives"),
                            const SizedBox(width: 10),
                            _buildTopBadge("🏠 2 écoles"),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // École des Arts
                  _buildEcoleHeader(
                    title: "École des Arts & Images Numériques",
                    subtitle: "7 offres disponibles",
                    icon: Icons.palette,
                    color: const Color(0xFF1E61ED),
                    isExpanded: _isArtsExpanded,
                    onTap: () =>
                        setState(() => _isArtsExpanded = !_isArtsExpanded),
                  ),
                  if (_isArtsExpanded) ...[
                    _buildOffreCard(
                        "STAGE",
                        "Stagiaire Motion Designer",
                        "Orange CI • Abidjan",
                        Colors.orange,
                        "https://www.orange.ci"),
                    _buildOffreCard(
                        "EMPLOI",
                        "Graphiste Junior CDI",
                        "Agence Pixel • Bouaké",
                        Colors.green,
                        "https://linkedin.com"),
                    _buildOffreCard("PROJET", "Brand Design — Tech CI",
                        "Freelance • Remote", Colors.blue, "https://malt.fr"),
                  ],

                  const SizedBox(height: 15),

                  // École de Publicité
                  _buildEcoleHeader(
                    title: "École de Publicité Marketing",
                    subtitle: "5 offres disponibles",
                    icon: Icons.campaign,
                    color: const Color(0xFF107C41),
                    isExpanded: _isPubExpanded,
                    onTap: () =>
                        setState(() => _isPubExpanded = !_isPubExpanded),
                  ),
                  if (_isPubExpanded) ...[
                    _buildOffreCard(
                        "EMPLOI",
                        "Responsable Marketing",
                        "Antenne Bouaké • CDI",
                        Colors.green,
                        "https://istcpolytechnique.ci"),
                  ],

                  // Infobulle d'aide
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.orange.withOpacity(0.3))),
                      child: const Row(
                        children: [
                          Icon(Icons.lightbulb_outline, color: Colors.orange),
                          SizedBox(width: 10),
                          Expanded(
                              child: Text(
                                  "Cliquez sur une école pour dérouler ses offres. Recliquez pour fermer.",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.brown))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBadge(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(20)),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      );

  Widget _buildEcoleHeader(
      {required String title,
      required String subtitle,
      required IconData icon,
      required Color color,
      required bool isExpanded,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
            ]),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: isExpanded
                      ? const BorderRadius.vertical(top: Radius.circular(20))
                      : BorderRadius.circular(20)),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 15),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(subtitle,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ])),
                  Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.white, size: 30),
                ],
              ),
            ),
            if (!isExpanded)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("👆 Appuyez pour voir les offres",
                    style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffreCard(
          String type, String title, String info, Color color, String url) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border(left: BorderSide(color: color, width: 4))),
        child: Row(
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(type,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 10)),
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(info,
                      style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ])),
            ElevatedButton(
              onPressed: () => _launchUrl(url),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30)),
              child: const Text("Voir ↗", style: TextStyle(fontSize: 10)),
            ),
          ],
        ),
      );
}
