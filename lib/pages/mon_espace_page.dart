import 'package:flutter/material.dart';

class MonEspacePage extends StatefulWidget {
  const MonEspacePage({super.key});

  @override
  State<MonEspacePage> createState() => _MonEspacePageState();
}

class _MonEspacePageState extends State<MonEspacePage> {
  // --- ÉTATS ---
  String? role;
  bool isLogged = false;

  // --- COULEURS DU DESIGN ---
  final Color _primaryBlue = const Color(0xFF1557B0);
  final Color _darkGreen = const Color(0xFF2E7D32);
  final Color _bgLightBlue = const Color(0xFFEFF6FF);
  final Color _borderBlue = const Color(0xFF90CDF4);
  final Color _infoYellow = const Color(0xFFFFF9E6);
  final Color _infoBorder = const Color(0xFFFFE58F);

  @override
  Widget build(BuildContext context) {
    // Navigation conditionnelle
    if (role == null) return _buildRoleSelection();
    if (!isLogged) return _buildLogin();
    return _buildStudentSpace();
  }

  // --- 1. ÉCRAN : SÉLECTION DU PROFIL ---
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
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sélectionnez votre profil pour continuer",
              style: TextStyle(color: Colors.grey),
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
            _largeButton("Continuer →", () {
              if (role != null) {
                setState(() {}); // Rafraîchit pour passer à l'écran login
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Veuillez sélectionner un profil"),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  // --- 2. ÉCRAN : LOGIN ---
  Widget _buildLogin() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _customAppBar("LOGIN", onBack: () => setState(() => role = null)),
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
                  Text(
                    role == "etudiant"
                        ? "Espace Étudiant"
                        : "Espace Professeur",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Entrez vos identifiants ISTC",
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
                    "Identifiant",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A5568),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _customTextField("ex : istc-bke-0042", false),
                  const SizedBox(height: 20),
                  const Text(
                    "Mot de passe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A5568),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _customTextField("••••••••", true),
                  const SizedBox(height: 30),
                  _largeButton(
                    "Se connecter",
                    () => setState(() => isLogged = true),
                  ),
                  const SizedBox(height: 25),
                  _infoBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 3. ÉCRAN : ESPACE ÉTUDIANT ---
  Widget _buildStudentSpace() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _customAppBar(
          "TABLEAU DE BORD",
          color: _darkGreen,
          onBack: () => setState(() => isLogged = false),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _headerStudent(),
              _tabsSection(),
              _statusCard(),
              _notesSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // --- COMPOSANTS RÉUTILISABLES ---

  PreferredSizeWidget _customAppBar(
    String title, {
    Color? color,
    VoidCallback? onBack,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: onBack != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBack,
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: color ?? _primaryBlue,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _infoBox() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _infoYellow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _infoBorder),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Vos identifiants sont fournis par l'administration.",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roleCard(String title, String sub, String val, IconData icon) {
    bool selected = role == val;
    return GestureDetector(
      onTap: () => setState(() => role = val),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? _bgLightBlue : const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _borderBlue : const Color(0xFFE2E8F0),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_off,
              color: selected ? _primaryBlue : Colors.grey,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    sub,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(icon, color: selected ? _primaryBlue : Colors.grey.shade400),
          ],
        ),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
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
            borderRadius: BorderRadius.circular(15),
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

  Widget _headerStudent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: _darkGreen,
      child: const Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 45, color: Colors.white),
          ),
          SizedBox(height: 15),
          Text(
            "Aminata Koné",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "L2 — Arts & Images Numériques",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _tabsSection() {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          labelColor: _primaryBlue,
          indicatorColor: _primaryBlue,
          tabs: const [
            Tab(text: "Notes"),
            Tab(text: "Scolarité"),
            Tab(text: "Cours"),
            Tab(text: "Planning"),
          ],
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _statusCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 40),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Modules validés",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "4 / 6",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _darkGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _notesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Notes récentes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _noteItem("Motion Design", "16/20"),
          _noteItem("Photo Numérique", "13/20"),
          _noteItem("Design Graphique", "15/20"),
        ],
      ),
    );
  }

  Widget _noteItem(String title, String note) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: const Color(0xFFF7F9FC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("Semestre 1"),
        trailing: Text(
          note,
          style: TextStyle(
            color: _primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
