import 'package:flutter/material.dart';
import 'dart:async';

class MonEspacePage extends StatefulWidget {
  const MonEspacePage({super.key});

  @override
  State<MonEspacePage> createState() => _MonEspacePageState();
}

class _MonEspacePageState extends State<MonEspacePage> {
  int _screenIndex = 0; // 0: Rôle, 1: Login, 2: Dashboard
  String _selectedRole = "";
  bool _showWelcome = true;

  final Color _istcBlue = const Color(0xFF1A45A0);
  final Color _istcOrange = const Color(0xFFF5720A);

  @override
  Widget build(BuildContext context) {
    if (_screenIndex == 0) return _buildRoleSelection();
    if (_screenIndex == 1) return _buildLogin();
    return _buildStudentDashboard();
  }

  // --- 1. SÉLECTION DU RÔLE (Fidèle à la maquette) ---
  Widget _buildRoleSelection() {
    return Scaffold(
      backgroundColor: _istcBlue,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("MON ESPACE • RÔLE",
            style: TextStyle(
                color: _istcBlue, fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Center(child: _buildIconCircle(Icons.school, Colors.white, 40)),
          const SizedBox(height: 20),
          const Text("Mon Espace",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const Text("Sélectionnez votre profil pour continuer",
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 50),
          _roleCard("Je suis étudiant(e)", "Accès à mes cours & notes",
              "student", Icons.person),
          _roleCard("Je suis professeur(e)", "Gestion des cours & classes",
              "prof", Icons.work_outline),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: _largeBtn("Continuer →", () {
              if (_selectedRole == "student") setState(() => _screenIndex = 1);
            }),
          )
        ],
      ),
    );
  }

  // --- 2. LOGIN (Matricule + i + Cadenas) ---
  Widget _buildLogin() {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => setState(() => _screenIndex = 0))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              width: double.infinity,
              color: _istcBlue,
              child: Column(
                children: [
                  const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white, size: 40)),
                  const SizedBox(height: 15),
                  const Text("Espace Étudiant",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const Text("Connectez-vous pour accéder à votre espace",
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("MATRICULE",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  _input("ex : istc-bke-0042", Icons.badge_outlined),
                  const SizedBox(height: 20),
                  const Text("MOT DE PASSE",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  _input("••••••••", Icons.lock_outline, obscure: true),
                  const SizedBox(height: 30),
                  _largeBtnWithIcon("Se connecter", Icons.lock, () {
                    setState(() => _screenIndex = 2);
                    Timer(const Duration(seconds: 7), () {
                      if (mounted) setState(() => _showWelcome = false);
                    });
                  }),
                  const SizedBox(height: 20),
                  _infoBox(
                      "Vos identifiants sont fournis par l'administration de l'ISTC Bouaké."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 3. DASHBOARD ÉTUDIANT (Multi-onglets) ---
  Widget _buildStudentDashboard() {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _istcBlue,
          foregroundColor: Colors.white,
          title: const Text("TABLEAU DE BORD",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => setState(() => _screenIndex = 0))
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            tabs: [
              Tab(text: "Notes"),
              Tab(text: "Scolarité"),
              Tab(text: "Cours"),
              Tab(text: "Stages Internes"),
              Tab(text: "Emploi du temps"),
              Tab(text: "Mémoires"),
              Tab(text: "Report d'année"),
              Tab(text: "Règlement"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _viewNotes(),
            _viewScolarite(),
            _viewCours(),
            _viewStages(),
            _viewEmploiDuTemps(),
            _viewMemoires(),
            _viewReport(),
            _viewReglement(),
          ],
        ),
      ),
    );
  }

  // --- LES DIFFÉRENTES VUES (TABS) ---

  Widget _viewNotes() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (_showWelcome)
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Text("👋 Bienvenue Aminata !",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold))),
          ),
        _studentInfoCard(),
        const SizedBox(height: 20),
        _statHeader(),
        const SizedBox(height: 25),
        const Text("Mes outils",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _gridTools(),
      ],
    );
  }

  Widget _viewScolarite() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _actionCard("Impression de fiches",
            "Générez vos fiches d'inscription PDF", Icons.print, Colors.blue),
        _actionCard(
            "Générer mes avis de recettes",
            "Activer le lien du 1er versement",
            Icons.receipt_long,
            Colors.orange),
      ],
    );
  }

  Widget _viewStages() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Stages Internes (Agences-Écoles)",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _schoolExpand("Arts & Images Numériques (AIN)",
            "L2+M1 : Mini PP (1 mois) | L3+M2 : PP (2 mois)"),
        _schoolExpand("Publicité Marketing (PUB)",
            "Organisation en agence avec DG et chefs de départements."),
      ],
    );
  }

  Widget _viewCours() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _schoolHeader("VOS COURS (AIN)"),
        _noteItem("Design Graphique", "Lundi 08h"),
        _noteItem("Motion Design", "Mercredi 10h"),
        _schoolHeader("COURS PUB (Simulation)"),
        _noteItem("Stratégie Média", "Indisponible pour votre profil",
            color: Colors.grey),
      ],
    );
  }

  Widget _viewEmploiDuTemps() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Semaine du 12 au 18 Mai",
            style: TextStyle(fontWeight: FontWeight.bold)),
        _noteItem("Cours Magistral : Esthétique", "Amphi A - 08:00",
            color: Colors.blue),
        _noteItem("Atelier : Montage", "Salle Mac - 14:00",
            color: Colors.purple),
      ],
    );
  }

  Widget _viewMemoires() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _memoire("PUB: Le marketing d'influence", "Note: 15/20"),
        _memoire("AIN: La 3D dans le cinéma", "Note: 16/20"),
      ],
    );
  }

  Widget _viewReport() => const Center(
      child: Text("Simulation : Demande de report d'année en attente..."));
  Widget _viewReglement() => const Padding(
      padding: EdgeInsets.all(20),
      child: Text("1. Ponctualité... \n2. Tenue correcte..."));

  // --- WIDGETS UTILES ---

  Widget _studentInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
      child: Row(
        children: [
          const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white, size: 40)),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text("Aminata Koné",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text("Arts & Images Numériques - L2",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Text("Matricule: ISTC-BKE-0042",
                    style: TextStyle(
                        color: _istcBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ]))
        ],
      ),
    );
  }

  Widget _gridTools() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.3,
      children: [
        _toolItem(
            "Mes Mémoires", "Dépôt PDF", Icons.picture_as_pdf, Colors.blue),
        _toolItem(
            "Apprendre +", "Ressources", Icons.library_books, Colors.green),
        _toolItem(
            "Mon Planning", "Examens", Icons.calendar_today, Colors.orange),
        _toolItem("Certificats", "Diplômes", Icons.verified, Colors.purple),
      ],
    );
  }

  Widget _toolItem(String t, String s, IconData i, Color c) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration:
          BoxDecoration(color: c, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(i, color: Colors.white, size: 24),
        const Spacer(),
        Text(t,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        Text(s, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ]),
    );
  }

  Widget _schoolExpand(String title, String desc) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [Padding(padding: const EdgeInsets.all(15), child: Text(desc))],
    );
  }

  Widget _actionCard(String t, String s, IconData i, Color c) {
    return Card(
        child: ListTile(
            leading: Icon(i, color: c),
            title: Text(t),
            subtitle: Text(s),
            trailing: const Icon(Icons.chevron_right)));
  }

  Widget _roleCard(String t, String s, String v, IconData i) {
    bool sel = _selectedRole == v;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = v),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: sel ? _istcOrange : Colors.transparent, width: 2)),
        child: Row(
          children: [
            _buildIconCircle(i, sel ? _istcOrange : Colors.grey, 25),
            const SizedBox(width: 15),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(s,
                      style: const TextStyle(fontSize: 12, color: Colors.grey))
                ])),
            if (sel) Icon(Icons.check_circle, color: _istcOrange)
          ],
        ),
      ),
    );
  }

  Widget _buildIconCircle(IconData i, Color c, double s) => Container(
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: c.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(i, color: c, size: s));
  Widget _largeBtn(String l, VoidCallback o) => SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
          onPressed: o,
          style: ElevatedButton.styleFrom(
              backgroundColor: _istcBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: Text(l)));
  Widget _largeBtnWithIcon(String l, IconData i, VoidCallback o) => SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
          onPressed: o,
          style: ElevatedButton.styleFrom(
              backgroundColor: _istcOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          icon: Icon(i),
          label: Text(l)));
  Widget _input(String h, IconData i, {bool obscure = false}) => TextField(
      obscureText: obscure,
      decoration: InputDecoration(
          hintText: h,
          prefixIcon: Icon(i),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none)));
  Widget _infoBox(String t) => Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Row(children: [
        const Icon(Icons.info, color: Colors.blue),
        const SizedBox(width: 10),
        Expanded(
            child: Text(t,
                style: const TextStyle(fontSize: 12, color: Colors.blue)))
      ]));
  Widget _statHeader() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _statBox("4/6", "Modules", Colors.green),
        _statBox("14.2", "Moyenne", Colors.orange),
        _statBox("92%", "Présence", Colors.blue)
      ]);
  Widget _statBox(String v, String l, Color c) => Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Text(v,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: c, fontSize: 18)),
        Text(l, style: const TextStyle(fontSize: 10))
      ]));
  Widget _noteItem(String t, String s, {Color color = Colors.blue}) => ListTile(
      title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(s),
      leading: Icon(Icons.circle, color: color, size: 12));
  Widget _schoolHeader(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(t,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey)));
  Widget _memoire(String t, String n) => Card(
      child: ListTile(
          leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
          title: Text(t),
          trailing: Text(n,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green))));
}
