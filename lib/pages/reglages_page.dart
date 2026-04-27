import 'package:flutter/material.dart';

class ReglagesPage extends StatelessWidget {
  const ReglagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Réglages")),
      body: ListView(
        children: const [
          ListTile(title: Text("Mon profil")),
          ListTile(title: Text("Alertes Push")),
          ListTile(title: Text("À propos ISTC Bouaké")),
          ListTile(title: Text("ISTC Abidjan")),
          ListTile(title: Text("Se déconnecter")),
        ],
      ),
    );
  }
}
