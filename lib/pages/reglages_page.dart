import 'package:flutter/material.dart';

class ReglagesPage extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkModeInitial;

  const ReglagesPage(
      {super.key,
      required this.onThemeToggle,
      required this.isDarkModeInitial});

  @override
  State<ReglagesPage> createState() => _ReglagesPageState();
}

class _ReglagesPageState extends State<ReglagesPage> {
  bool _pushEnabled = true;
  late bool _darkMode;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.isDarkModeInitial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RÉGLAGES"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("NOTIFICATIONS",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          SwitchListTile(
              title: const Text("Alertes push"),
              value: _pushEnabled,
              onChanged: (v) => setState(() => _pushEnabled = v)),
          const SizedBox(height: 20),
          const Text("COMPTE",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          SwitchListTile(
            title: const Text("Mode sombre"),
            value: _darkMode,
            onChanged: (v) {
              setState(() => _darkMode = v);
              widget.onThemeToggle(v);
            },
          ),
        ],
      ),
    );
  }
}
