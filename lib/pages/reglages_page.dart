import 'package:flutter/material.dart';

class ReglagesPage extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final VoidCallback onLogout;

  const ReglagesPage(
      {super.key, required this.onThemeToggle, required this.onLogout});

  @override
  State<ReglagesPage> createState() => _ReglagesPageState();
}

class _ReglagesPageState extends State<ReglagesPage> {
  // États des boutons switch
  bool _pushEnabled = true;
  bool _deadlinesEnabled = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("RÉGLAGES",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION PROFIL (Aminata Koné) ---
            _buildProfileHeader(context),

            const SizedBox(height: 25),
            _sectionTitle("NOTIFICATIONS"),
            _buildSwitchItem(Icons.notifications_active, "Alertes push",
                _pushEnabled, (val) => setState(() => _pushEnabled = val)),
            _buildSwitchItem(
                Icons.calendar_month,
                "Rappels deadlines",
                _deadlinesEnabled,
                (val) => setState(() => _deadlinesEnabled = val)),

            const SizedBox(height: 25),
            _sectionTitle("INFORMATIONS"),
            _buildSimpleItem(Icons.location_on, "Contact & Localisation", () {
              _showLocationDialog(context);
            }),
            _buildSimpleItem(
                Icons.school, "À propos de l'antenne ISTC Bouaké", () {}),
            _buildSimpleItem(Icons.link, "ISTC Polytechnique Abidjan", () {}),

            const SizedBox(height: 25),
            _sectionTitle("COMPTE"),
            _buildSwitchItem(Icons.dark_mode, "Mode sombre", _darkMode, (val) {
              setState(() => _darkMode = val);
              widget.onThemeToggle(val);
            }),
            _buildLogoutButton(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS ---

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Text(title,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF102A43), Color(0xFF1A45A0)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.orange,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aminata Koné",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Text("Étudiante • Arts & Images L2",
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white24, elevation: 0),
            child: const Text("Modifier",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _buildSwitchItem(
      IconData icon, String title, bool value, Function(bool) onChanged) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: value ? Colors.orange : Colors.grey),
        title: Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value ? "Activé" : "Désactivé",
                style: TextStyle(
                    color: value ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
            Switch(
                value: value, activeColor: Colors.green, onChanged: onChanged),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.chevron_right, size: 18),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 10),
            Text("Se déconnecter",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Contacts & Localisation"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: Icon(Icons.phone), title: Text("+225 07 00 00 00 00")),
            ListTile(
                leading: Icon(Icons.location_on, color: Colors.red),
                title: Text("Campus de Bouaké")),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"))
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Déconnexion"),
        content: const Text("Voulez-vous vraiment vous déconnecter ?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onLogout();
              },
              child: const Text("Oui, me déconnecter",
                  style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
