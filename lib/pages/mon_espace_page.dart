import 'package:flutter/material.dart';

class MonEspacePage extends StatefulWidget {
  const MonEspacePage({super.key});

  @override
  State<MonEspacePage> createState() => _MonEspacePageState();
}

class _MonEspacePageState extends State<MonEspacePage> {
  // --- ÉTATS ---
  int _screenIndex = 0; // 0: Rôle, 1: Login, 2: Dashboard
  String _selectedRole = "";

  // --- DESIGN ---
  final Color _istcViolet =
      const Color(0xFF1A45A0); // Ton violet institutionnel
  final Color _istcOrange = const Color(0xFFF5720A);
  final Color _istcDarkBlue = const Color(0xFF102A43);

  @override
  Widget build(BuildContext context) {
    if (_screenIndex == 0) return _buildRoleSelection();
    if (_screenIndex == 1) return _buildLogin();
    return _buildStudentDashboard();
  }

  // --- 1. SÉLECTION DU RÔLE ---
  Widget _buildRoleSelection() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
          title: const Text("MON ESPACE • RÔLE",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildIconContainer(Icons.group, _istcViolet),
            const SizedBox(height: 20),
            const Text("Mon Espace",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Sélectionnez votre profil pour continuer",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            _roleOption("Je suis étudiant(e)", "Accès à mes cours & notes",
                "student", Icons.school_outlined),
            const SizedBox(height: 15),
            _roleOption("Je suis professeur(e)", "Gestion des cours & classes",
                "prof", Icons.psychology_outlined),
            const Spacer(),
            _largeButton("Continuer →", () {
              if (_selectedRole == "student") setState(() => _screenIndex = 1);
            }),
          ],
        ),
      ),
    );
  }

  // --- 2. LOGIN FICTIF ---
  Widget _buildLogin() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => _screenIndex = 0))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            decoration: BoxDecoration(
                color: _istcViolet,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30))),
            child: Column(
              children: [
                const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 40)),
                const SizedBox(height: 10),
                const Text("Espace Étudiant",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const Text("Connectez-vous pour accéder à votre espace",
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("LOGIN",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 8),
                const TextField(
                    decoration: InputDecoration(
                        hintText: "ex : istc-bke-0042",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))))),
                const SizedBox(height: 15),
                const Text("MOT DE PASSE",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 8),
                const TextField(
                    decoration: InputDecoration(
                        hintText: "••••••••",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    obscureText: true),
                const SizedBox(height: 30),
                _largeButtonWithIcon("Se connecter", Icons.lock_open,
                    () => setState(() => _screenIndex = 2)),
                const SizedBox(height: 20),
                _infoBox(
                    "Vos identifiants sont fournis par l'administration de l'ISTC Bouaké."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. DASHBOARD ÉTUDIANT ---
  Widget _buildStudentDashboard() {
    return DefaultTabController(
      length: 5, // Tabs normaux
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: _istcViolet,
          foregroundColor: Colors.white,
          leading: const Icon(Icons.school),
          title: const Text("Aminata Koné", style: TextStyle(fontSize: 16)),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => setState(() => _screenIndex = 0))
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Notes"),
              Tab(text: "Scolarité"),
              Tab(text: "Cours"),
              Tab(text: "Planning"),
              Tab(text: "Mémoires"),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _profileHeader(), // Icône, matricule, école
              const SizedBox(height: 20),
              _statHeader(),
              const SizedBox(height: 20),
              _notesSection(),
              const SizedBox(height: 20),
              _toolsSection(), // Mes Outils
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- COMPOSANTS ---

  Widget _profileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ]),
      child: const Row(
        children: [
          CircleAvatar(
              radius: 35,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 40, color: Colors.white)),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aminata Koné",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Arts & Images Numériques — L2",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Text("Matricule : ISTC-BKE-0042",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Mes outils",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: [
            _toolItem("Mes Mémoires", "Dépôt & suivi TFE", Icons.picture_as_pdf,
                Colors.blue),
            _toolItem("Apprendre +", "Ressources extras", Icons.library_books,
                Colors.green),
            _toolItem("Mon Planning", "Cours & examens", Icons.calendar_month,
                Colors.orange),
            _toolItem("Certificats", "Télécharger mes docs", Icons.emoji_events,
                Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _toolItem(String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(desc,
              style: const TextStyle(fontSize: 10, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildIconContainer(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration:
          BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 40),
    );
  }

  Widget _roleOption(String title, String sub, String val, IconData icon) {
    bool isSelected = _selectedRole == val;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = val),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent)),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
            const SizedBox(width: 15),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(sub,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ])),
            Radio(
                value: val,
                groupValue: _selectedRole,
                onChanged: (v) => setState(() => _selectedRole = v.toString())),
          ],
        ),
      ),
    );
  }

  Widget _largeButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: _istcViolet,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: Text(label)),
    );
  }

  Widget _largeButtonWithIcon(String label, IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: _istcOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          icon: Icon(icon),
          label: Text(label)),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.withOpacity(0.3))),
      child: Row(children: [
        const Icon(Icons.info_outline, color: Colors.orange, size: 20),
        const SizedBox(width: 12),
        Expanded(
            child: Text(text,
                style: const TextStyle(color: Colors.orange, fontSize: 12))),
      ]),
    );
  }

  Widget _statHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statBox("4/6", "Modules validés", Colors.green),
        _statBox("14.2", "Moy. générale", Colors.orange),
        _statBox("92%", "Assiduité", Colors.blue),
      ],
    );
  }

  Widget _statBox(String val, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Text(val,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: color)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ]),
    );
  }

  Widget _notesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Notes récentes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TextButton(
              onPressed: () {},
              child: const Text("Tout voir",
                  style: TextStyle(color: Colors.orange))),
        ]),
        _noteTile("Motion Design", "16/20"),
        _noteTile("Publicité Digitale", "13/20"),
      ],
    );
  }

  Widget _noteTile(String title, String note) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        trailing: Text(note,
            style: TextStyle(fontWeight: FontWeight.bold, color: _istcViolet)),
        subtitle: const Text("Validé",
            style: TextStyle(color: Colors.green, fontSize: 11)),
      ),
    );
  }
}
