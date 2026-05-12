import 'package:flutter/material.dart';

class LeReseauPage extends StatefulWidget {
  const LeReseauPage({super.key});

  @override
  State<LeReseauPage> createState() => _LeReseauPageState();
}

class _LeReseauPageState extends State<LeReseauPage> {
  bool _isArtsExpanded = false;
  bool _isPubExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LE RÉSEAU",
            style: TextStyle(
                color: Color(0xFF1A45A0), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSchoolHeader(
                "École des Arts",
                Icons.palette,
                const Color(0xFF1E61ED),
                _isArtsExpanded,
                () => setState(() => _isArtsExpanded = !_isArtsExpanded)),
            if (_isArtsExpanded) _buildJobCard("Motion Designer", "Orange CI"),
            const SizedBox(height: 10),
            _buildSchoolHeader(
                "École de Publicité",
                Icons.campaign,
                const Color(0xFF107C41),
                _isPubExpanded,
                () => setState(() => _isPubExpanded = !_isPubExpanded)),
            if (_isPubExpanded)
              _buildJobCard("Chef de Projet Pub", "Voodoo Group"),
          ],
        ),
      ),
    );
  }

  Widget _buildSchoolHeader(String title, IconData icon, Color color,
      bool isExp, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 15),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ]),
            Icon(isExp ? Icons.expand_less : Icons.expand_more,
                color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(String title, String company) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12)),
      child: Text("$title - $company"),
    );
  }
}
