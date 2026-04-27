import 'package:flutter/material.dart';

class DecouvrirPage extends StatelessWidget {
  const DecouvrirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Découvrir les filières",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExpansionFiliere(
            "Arts et Images Numériques",
            "assets/icons/graphic.png",
            [
              "Designer Graphique",
              "Motion Designer",
              "Réalisateur 3D",
              "Webdesigner",
            ],
          ),
          const SizedBox(height: 12),
          _buildExpansionFiliere(
            "Publicité Marketing",
            "assets/icons/marketing.png",
            [
              "Chef de produit",
              "Responsable Com",
              "Community Manager",
              "Média Planneur",
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionFiliere(
    String title,
    String iconPath,
    List<String> debouches,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        leading: Image.asset(
          iconPath,
          width: 30,
          errorBuilder: (c, e, s) =>
              const Icon(Icons.school, color: Colors.orangeAccent),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        shape: const Border(), // Enlève les lignes de division par défaut
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Débouchés professionnels :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 10),
                ...debouches
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 10),
                            Text(item),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
