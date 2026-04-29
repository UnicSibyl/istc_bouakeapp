import 'package:flutter/material.dart';

class ReglagesPage extends StatelessWidget {
  const ReglagesPage({super.key});

  // Couleurs de la charte graphique
  final Color _istcViolet = const Color(0xFF6A1B9A);
  final Color _textGrey = const Color(0xFF718096);
  final Color _bgLight = const Color(0xFFF7F9FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(
          Icons.settings_outlined,
          color: Color(0xFF6A1B9A),
          size: 20,
        ),
        title: const Text(
          "RÉGLAGES",
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION PROFIL ---
            _buildProfileCard(),

            const SizedBox(height: 25),
            _sectionTitle("NOTIFICATIONS"),
            _buildSettingItem(
              Icons.notifications_none,
              "Alertes push",
              trailingText: "Activé",
              isSwitch: false,
            ),
            _buildSettingItem(
              Icons.calendar_today_outlined,
              "Rappels deadlines",
              trailingText: "Activé",
              isSwitch: false,
            ),

            const SizedBox(height: 25),
            _sectionTitle("INFORMATIONS"),
            _buildSettingItem(
              Icons.location_on_outlined,
              "Contact & localisation",
              showChevron: true,
            ),
            _buildSettingItem(
              Icons.school_outlined,
              "À propos de l'ISTC",
              showChevron: true,
            ),
            _buildSettingItem(
              Icons.link,
              "ISTC Polytechnique Abidjan",
              showChevron: true,
            ),

            const SizedBox(height: 25),
            _sectionTitle("COMPTE"),
            _buildLogoutItem(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS DE CONSTRUCTION ---

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          color: _textGrey,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: _bgLight,
            child: Icon(Icons.person, color: _istcViolet, size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mon Profil",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  "Voir & modifier mes infos",
                  style: TextStyle(color: _textGrey, fontSize: 13),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title, {
    String? trailingText,
    bool showChevron = false,
    bool isSwitch = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.orangeAccent, size: 22),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Text(
                trailingText,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            if (showChevron)
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildLogoutItem() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5), // Fond très légèrement rouge
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.shade50),
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.redAccent),
        title: const Text(
          "Se déconnecter",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          // Logique de déconnexion
        },
      ),
    );
  }
}
