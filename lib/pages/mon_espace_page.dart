import 'package:flutter/material.dart';

class MonEspacePage extends StatefulWidget {
  const MonEspacePage({super.key});

  @override
  State<MonEspacePage> createState() => _MonEspacePageState();
}

class _MonEspacePageState extends State<MonEspacePage> {
  String? role;
  bool isLogged = false;

  // Couleurs
  final Color _primaryBlue = const Color(0xFF1557B0);
  final Color _darkGreen = const Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    // On retire le Scaffold parent s'il y en avait un pour éviter les superpositions
    if (role == null) return _buildRoleSelection();
    if (!isLogged) return _buildLogin();
    return _buildStudentSpace();
  }

  // --- 1. SÉLECTION DU RÔLE ---
  Widget _buildRoleSelection() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _customAppBar("CONNEXION"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(Icons.school, size: 80, color: Color(0xFFFFB74D)),
            const SizedBox(height: 24),
            const Text(
              "Mon Espace",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _roleCard(
              "Je suis étudiant(e)",
              "Accès à mes cours & notes",
              "etudiant",
              Icons.school_outlined,
            ),
            const SizedBox(height: 16),
            _roleCard(
              "Je suis professeur(e)",
              "Gestion des cours & classes",
              "prof",
              Icons.psychology_outlined,
            ),
            const SizedBox(height: 40),
            _largeButton("Continuer →", () => setState(() {})),
          ],
        ),
      ),
      // bottomNavigationBar supprimé ici
    );
  }

  // --- 2. ÉCRAN LOGIN ---
  Widget _buildLogin() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _customAppBar("LOGIN"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: _primaryBlue,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Espace Étudiant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Entrez les informations ci-dessous",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _customTextField("ex : istc-bke-0042", false),
                  const SizedBox(height: 20),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _customTextField("••••••••", true),
                  const SizedBox(height: 30),
                  _largeButton(
                    "Se connecter",
                    () => setState(() => isLogged = true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar supprimé ici
    );
  }

  // --- 3. ESPACE ÉTUDIANT ---
  Widget _buildStudentSpace() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerStudent(),
            _tabsSection(),
            _statusCard(),
            _notesSection(),
          ],
        ),
      ),
      // bottomNavigationBar supprimé ici
    );
  }

  // --- HELPERS (COMMUNS) ---

  PreferredSizeWidget _customAppBar(String subTitle) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_pin, color: Color(0xFF6B46C1)),
          const SizedBox(width: 8),
          Text(
            "MON ESPACE • $subTitle",
            style: const TextStyle(
              color: Color(0xFF1557B0),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customTextField(String hint, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF7F8FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.withOpacity(0.1)),
        ),
      ),
    );
  }

  Widget _roleCard(String title, String sub, String val, IconData icon) {
    bool selected = role == val;
    return GestureDetector(
      onTap: () => setState(() => role = val),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEFF6FF) : const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xFF90CDF4) : const Color(0xFFE2E8F0),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? _primaryBlue : Colors.grey,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    sub,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(icon, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _largeButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // --- ÉLÉMENTS ESPACE ÉTUDIANT (RAPPEL) ---
  Widget _headerStudent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: BoxDecoration(
        color: _darkGreen,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: const Column(
        children: [
          Text(
            "MON ESPACE • ÉTUDIANT",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 20),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 12),
          Text(
            "Aminata Koné",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Arts & Images Numériques — L2",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _tabsSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "Mes notes | Scolarité | Mes Cours",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _statusCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.check, color: Colors.green),
          SizedBox(width: 10),
          Text("Modules validés : 4 / 6"),
        ],
      ),
    );
  }

  Widget _notesSection() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notes récentes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(title: Text("Motion Design"), trailing: Text("16/20")),
          ListTile(title: Text("Photo Numérique"), trailing: Text("13/20")),
        ],
      ),
    );
  }
}
