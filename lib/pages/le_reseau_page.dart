import 'package:flutter/material.dart';

class ReseauPage extends StatelessWidget {
  const ReseauPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Le Réseau")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Bienvenue dans Le Réseau",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),

            const SizedBox(height: 10),

            const Text("Découvrez les offres d'emplois / stages"),

            const SizedBox(height: 20),

            ListTile(
              title: const Text("Arts et Images Numériques"),
              onTap: () {},
            ),

            ListTile(title: const Text("Publicité Marketing"), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
