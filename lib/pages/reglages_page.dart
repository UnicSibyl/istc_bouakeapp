import 'package:flutter/material.dart';

class ReglagesPage extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkModeInitial;

  const ReglagesPage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkModeInitial,
  });

  @override
  State<ReglagesPage> createState() => _ReglagesPageState();
}

class _ReglagesPageState extends State<ReglagesPage> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDarkModeInitial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          // --- HEADER PROFIL (ORANGE SELON MAQUETTE) ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
            decoration: const BoxDecoration(
              color: Color(0xFFDA783B), // Orange ISTC
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Column(
              children: [
                // Titre de la page en haut
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings,
                        color: Colors.white.withOpacity(0.8), size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      "RÉGLAGES",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Ligne Profil : Avatar, Textes et Bouton Bleu
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white24,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person,
                            size: 45, color: Color(0xFFDA783B)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Aminata Koné",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                          Text(
                            "Étudiante - Arts & Images L2",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bouton Modifier (Bleu selon maquette)
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A45A0), // Bleu ISTC
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 0),
                      ),
                      child: const Text(
                        "Modifier",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- LISTE DES OPTIONS ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                _buildSectionTitle("NOTIFICATIONS"),
                _buildSettingTile(
                  icon: Icons.notifications_active_outlined,
                  title: "Alertes push",
                  color: Colors.orange,
                  hasBadge: true,
                ),
                _buildSettingTile(
                  icon: Icons.calendar_today_outlined,
                  title: "Rappels deadlines",
                  color: Colors.blue,
                  hasBadge: true,
                ),
                _buildSettingTile(
                  icon: Icons.campaign_outlined,
                  title: "Nouveautés Réseau",
                  color: Colors.amber.shade700,
                  hasBadge: true,
                ),

                const SizedBox(height: 20),
                _buildSectionTitle("INFORMATIONS"),
                _buildSettingTile(
                  icon: Icons.location_on_outlined,
                  title: "Contact & localisation",
                  color: Colors.pinkAccent,
                  showChevron: true,
                ),
                _buildSettingTile(
                  icon: Icons.school_outlined,
                  title: "À propos de l'ISTC",
                  color: Colors.teal,
                  showChevron: true,
                ),
                _buildSettingTile(
                  icon: Icons.link,
                  title: "ISTC Polytechnique Abidjan",
                  color: Colors.blue.shade800,
                  showChevron: true,
                ),

                const SizedBox(height: 20),
                _buildSectionTitle("COMPTE"),
                // Mode Sombre
                Card(
                  elevation: 0.5,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: SwitchListTile(
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.nightlight_round,
                          color: Colors.orange, size: 22),
                    ),
                    title: const Text(
                      "Mode sombre",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      _isDark ? "Activé" : "Désactivé",
                      style: const TextStyle(fontSize: 11),
                    ),
                    value: _isDark,
                    activeColor: const Color(0xFFDA783B),
                    onChanged: (v) {
                      setState(() => _isDark = v);
                      widget.onThemeToggle(v);
                    },
                  ),
                ),
                // Déconnexion
                _buildSettingTile(
                  icon: Icons.logout,
                  title: "Se déconnecter",
                  color: Colors.redAccent,
                  isDestructive: true,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour les titres de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blueGrey.shade300,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // Widget pour une ligne de réglage
  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required Color color,
    bool hasBadge = false,
    bool showChevron = false,
    bool isDestructive = false,
  }) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: () {},
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.redAccent : Colors.black87,
          ),
        ),
        trailing: hasBadge
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9), // Vert très clair
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Activé",
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : (showChevron
                ? const Icon(Icons.chevron_right, size: 18, color: Colors.grey)
                : null),
      ),
    );
  }
}
