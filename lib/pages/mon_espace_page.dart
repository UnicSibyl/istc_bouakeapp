import 'package:flutter/material.dart';

class MonEspacePage extends StatefulWidget {
  const MonEspacePage({super.key});

  @override
  State<MonEspacePage> createState() => _MonEspacePageState();
}

class _MonEspacePageState extends State<MonEspacePage> {
  String? _selectedProfile;
  final Color _istcOrange = const Color(0xFFDA783B);
  final Color _selectionBlue = const Color(0xFF1E61ED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  _buildProfileCard(
                    profileId: 'etudiant',
                    title: "Je suis étudiant.e",
                    subtitle: "Accès à mes cours & notes",
                    icon: Icons.school_outlined,
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(
                    profileId: 'professeur',
                    title: "Je suis professeur.e",
                    subtitle: "Gestion des cours & classes",
                    icon: Icons.psychology_outlined,
                  ),
                ],
              ),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 30),
      decoration: BoxDecoration(
        color: _istcOrange,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
      ),
      child: const Column(
        children: [
          Icon(Icons.account_circle, size: 60, color: Colors.white),
          SizedBox(height: 10),
          Text(
            "Mon Espace",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "Sélectionnez votre profil",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
      {required String profileId,
      required String title,
      required String subtitle,
      required IconData icon}) {
    bool isSelected = _selectedProfile == profileId;
    return GestureDetector(
      onTap: () => setState(() => _selectedProfile = profileId),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isSelected ? _selectionBlue : Colors.black12,
              width: isSelected ? 2.5 : 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected
                  ? _selectionBlue.withOpacity(0.1)
                  : const Color(0xFFF1F5F9),
              child:
                  Icon(icon, color: isSelected ? _selectionBlue : Colors.grey),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? _selectionBlue : Colors.black87)),
                  Text(subtitle,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected ? _selectionBlue : Colors.black12),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _selectedProfile == null ? null : () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectionBlue,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Text("Continuer",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
