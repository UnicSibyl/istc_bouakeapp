import 'package:flutter/material.dart';

class MonEspacePage extends StatefulWidget {
  const MonEspacePage({super.key});

  @override
  State<MonEspacePage> createState() => _MonEspacePageState();
}

class _MonEspacePageState extends State<MonEspacePage> {
  int _step = 0; // 0: Rôle, 1: Login, 2: Dashboard
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Couleurs Officielles de la maquette
  static const Color blueISTC = Color(0xFF1A45A0);
  static const Color orangeISTC = Color(0xFFDA783B);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_step > 0) setState(() => _step--);
      },
      child: _getCurrentPage(),
    );
  }

  Widget _getCurrentPage() {
    switch (_step) {
      case 0:
        return _buildRolePage();
      case 1:
        return _buildLoginPage();
      case 2:
        return _buildDashboardPage();
      default:
        return _buildRolePage();
    }
  }

  // ==========================================
  // --- PAGE 1 : SELECTION DU RÔLE ----------
  // ==========================================
  Widget _buildRolePage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildAuthHeader("MON ESPACE", Icons.account_circle),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const Text("Identifiez votre profil",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87)),
                const SizedBox(height: 25),
                _selectionCard("Étudiant(e)", "Consulter mes notes & cours",
                    true, Icons.school),
                const SizedBox(height: 15),
                _selectionCard("Enseignant(e)", "Gestion pédagogique", false,
                    Icons.history_edu),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _step = 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueISTC,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text("SUIVANT",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // --- PAGE 2 : CONNEXION (LOGIN) -----------
  // ==========================================
  Widget _buildLoginPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Icon(Icons.lock_person, size: 80, color: blueISTC),
            const SizedBox(height: 20),
            const Text("Connexion",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const SizedBox(height: 40),
            _customTextField("Matricule", Icons.badge_outlined),
            const SizedBox(height: 20),
            _customTextField("Mot de passe", Icons.lock_outline, isPass: true),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () =>
                    setState(() => _step = 2), // Redirige vers le Dashboard
                style: ElevatedButton.styleFrom(
                    backgroundColor: orangeISTC,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text("SE CONNECTER",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // --- PAGE 3 : DASHBOARD ÉTUDIANT ----------
  // ==========================================
  Widget _buildDashboardPage() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F6F9),
      // Menu burger à GAUCHE pour la déconnexion / profil complet
      drawer: _buildLeftMenu(),
      body: Column(
        children: [
          _buildStudentHeader(),

          // Grille d'accès côte à côte comme sur la maquette
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // 2 colonnes côte à côte
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.all(20),
              children: [
                _buildDashboardCard("Notes & Bulletins", Icons.fact_check,
                    Colors.green, "Semestre 1 & 2"),
                _buildDashboardCard("Scolarité", Icons.account_balance,
                    Colors.blue, "Inscriptions & Reçus"),
                _buildDashboardCard("Mes Cours", Icons.assignment, orangeISTC,
                    "Supports & GFX"),
                _buildDashboardCard("Mon Planning", Icons.calendar_today,
                    Colors.purple, "Emploi du temps"),
                _buildDashboardCard("E-Bibliothèque", Icons.menu_book,
                    Colors.teal, "Documents & Thèses"),
                _buildDashboardCard(
                    "Actualités", Icons.campaign, Colors.pink, "Infos Campus"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HEADER DU DASHBOARD ---
  Widget _buildStudentHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
      decoration: const BoxDecoration(
        color: blueISTC,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          // Bouton Menu Burger à gauche
          IconButton(
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.white, size: 28)),
          const SizedBox(width: 10),
          const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white, size: 30)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Aminata Koné",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Text("Arts & Images • L2 (Bouaké)",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPOSANT CARTE DE LA GRILLE (CÔTE À CÔTE) ---
  Widget _buildDashboardCard(
      String title, IconData icon, Color color, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- MENU LATÉRAL DE GAUCHE (BURGER DRAWER) ---
  Widget _buildLeftMenu() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              color: blueISTC,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 15),
                  Text("Aminata Koné",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text("ISTC Polytechnique Bouaké",
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  _menuDrawerTile("Mon Profil", Icons.person_outline, () {}),
                  _menuDrawerTile(
                      "Paramètres de l'espace", Icons.settings_outlined, () {}),
                  const Divider(indent: 20, endIndent: 20, height: 40),
                  _menuDrawerTile("Se déconnecter", Icons.logout, () {
                    Navigator.pop(context); // Ferme le tiroir
                    setState(() => _step = 0); // Retour à la sélection de rôle
                  }, iconColor: Colors.redAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuDrawerTile(String title, IconData icon, VoidCallback onTap,
      {Color iconColor = blueISTC}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  // --- INTERFACE D'AUTHENTIFICATION STYLES ---
  Widget _buildAuthHeader(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 80, bottom: 40),
      decoration: const BoxDecoration(
          color: blueISTC,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 60),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2)),
        ],
      ),
    );
  }

  Widget _selectionCard(
      String title, String sub, bool selected, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: selected ? blueISTC.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: selected ? blueISTC : Colors.grey.shade200, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: selected ? blueISTC : Colors.grey),
          const SizedBox(width: 20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ]),
          const Spacer(),
          if (selected) const Icon(Icons.check_circle, color: blueISTC)
        ],
      ),
    );
  }

  Widget _customTextField(String label, IconData icon, {bool isPass = false}) {
    return TextField(
      obscureText: isPass,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: blueISTC),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
