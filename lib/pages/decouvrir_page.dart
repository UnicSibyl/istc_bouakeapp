import 'package:flutter/material.dart';

class DecouvrirPage extends StatelessWidget {
  const DecouvrirPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DÉCOUVRIR",
            style: TextStyle(
                color: Color(0xFF1A45A0), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDiscoveryCard(
              context, "Nos Écoles", Icons.account_balance, Colors.blue),
          _buildDiscoveryCard(
              context, "Vie Étudiante", Icons.groups, Colors.orange),
          _buildDiscoveryCard(
              context, "Bibliothèque", Icons.menu_book, Colors.green),
          _buildDiscoveryCard(context, "Événements", Icons.event, Colors.red),
        ],
      ),
    );
  }

  Widget _buildDiscoveryCard(
      BuildContext context, String title, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
