import 'package:flutter/material.dart';

class MonEspacePage extends StatefulWidget {
  const MonEspacePage({super.key});

  @override
  State<MonEspacePage> createState() => _MonEspacePageState();
}

class _MonEspacePageState extends State<MonEspacePage> {
  String? role;
  bool isLogged = false;

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    if (role == null) {
      return _buildRoleChoice();
    }

    if (!isLogged) {
      return _buildLogin();
    }

    return _buildStudentSpace();
  }

  // 🔘 Choix rôle
  Widget _buildRoleChoice() {
    return Scaffold(
      appBar: AppBar(title: const Text("Mon Espace")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadioListTile(
            title: const Text("Je suis étudiant(e)"),
            value: "etudiant",
            groupValue: role,
            onChanged: (value) => setState(() => role = value.toString()),
          ),
          RadioListTile(
            title: const Text("Je suis professeur(e)"),
            value: "prof",
            groupValue: role,
            onChanged: (value) => setState(() => role = value.toString()),
          ),
        ],
      ),
    );
  }

  // 🔐 Login
  Widget _buildLogin() {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Entrez les informations ci-dessous"),
            const SizedBox(height: 20),

            TextField(decoration: const InputDecoration(labelText: "Login")),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => setState(() => isLogged = true),
              child: const Text("Se connecter"),
            ),
          ],
        ),
      ),
    );
  }

  // 🎓 Espace étudiant avec swipe
  Widget _buildStudentSpace() {
    return Scaffold(
      appBar: AppBar(title: const Text("Espace étudiant")),
      body: PageView(
        controller: _controller,
        children: const [
          Center(child: Text("Mes notes")),
          Center(child: Text("Scolarité")),
          Center(child: Text("Mes cours")),
          Center(child: Text("Emplois du temps")),
          Center(child: Text("Modules validés")),
        ],
      ),
    );
  }
}
