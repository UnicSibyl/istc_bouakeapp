import 'package:flutter/material.dart';

class ProfileSelectionPage extends StatefulWidget {
  const ProfileSelectionPage({super.key});

  @override
  State<ProfileSelectionPage> createState() => _ProfileSelectionPageState();
}

class _ProfileSelectionPageState extends State<ProfileSelectionPage> {
  // Variable pour stocker le profil sélectionné
  String? _selectedProfile;

  // Tes codes couleurs corrigés
  final Color _istcOrange = const Color(0xFFDA783B); // Ton orange #da783b
  final Color _selectionBlue = const Color(0xFF1E61ED); // Bleu de sélection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- FOND DE PAGE BLANC ---
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(), // L'en-tête orange
          Expanded(
            child: Container(
              color: Colors.white, // Corps de la page en blanc
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  children: [
                    // Carte Étudiant.e
                    _buildProfileCard(
                      profileId: 'etudiant',
                      title: "Je suis étudiant.e",
                      subtitle: "Accès à mes cours & notes",
                      icon: Icons.school_outlined,
                    ),
                    const SizedBox(height: 20),
                    // Carte Professeur.e
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
          ),
          _buildBottomButton(), // Le bouton en bas
        ],
      ),
    );
  }

  // --- EN-TÊTE ORANGE (#DA783B) ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 70, left: 25, right: 25, bottom: 40),
      decoration: BoxDecoration(
        color: _istcOrange, // REMPLACÉ : C'est bien orange maintenant !
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
      ),
      child: const Column(
        children: [
          Icon(Icons.account_circle, size: 70, color: Colors.white),
          SizedBox(height: 15),
          Text(
            "Mon Espace",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Sélectionnez votre profil pour continuer",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14.5),
          ),
        ],
      ),
    );
  }

  // --- CARTE DE PROFIL (BORDURE BLEUE SI SÉLECTIONNÉ) ---
  Widget _buildProfileCard({
    required String profileId,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    bool isSelected = _selectedProfile == profileId;

    return GestureDetector(
      onTap: () => setState(() => _selectedProfile = profileId),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          // --- RECTANGLE DE SÉLECTION BLEU ---
          border: Border.all(
            color: isSelected ? _selectionBlue : Colors.black12,
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? _selectionBlue.withOpacity(0.1)
                  : Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icône qui change de couleur selon la sélection
            CircleAvatar(
              radius: 25,
              backgroundColor: isSelected
                  ? _selectionBlue.withOpacity(0.1)
                  : const Color(0xFFF1F5F9),
              child: Icon(icon,
                  color: isSelected ? _selectionBlue : Colors.grey, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isSelected ? _selectionBlue : Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
            // Petit rond de validation bleu
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? _selectionBlue : Colors.black12,
            ),
          ],
        ),
      ),
    );
  }

  // --- BOUTON DE VALIDATION ---
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.white, // Pied de page en blanc
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: _selectedProfile == null
              ? null
              : () {
                  // Ton action ici
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectionBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBackgroundColor: Colors.grey.shade200,
          ),
          child: const Text(
            "Continuer",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
