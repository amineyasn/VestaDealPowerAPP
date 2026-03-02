import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class CloneWindowScreen extends StatefulWidget {
  const CloneWindowScreen({super.key});

  @override
  State<CloneWindowScreen> createState() => _CloneWindowScreenState();
}

class _CloneWindowScreenState extends State<CloneWindowScreen> {
  int _copies = 1;
  String _room = 'Living Room';

  static const List<String> _rooms = [
    'Living Room',
    'Master Bedroom',
    'Kitchen',
    'Guest Bedroom',
    'Bathroom',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Clone Window', showBack: true),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Clone Window',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                const Text('Cloning: W-001 — 36 3/4" × 48 1/2"',
                    style: TextStyle(color: VestaColors.grayMediumDark)),
                const SizedBox(height: 24),
                const Text('Number of copies',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () =>
                          setState(() => _copies = (_copies - 1).clamp(1, 10)),
                    ),
                    Text('$_copies',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () =>
                          setState(() => _copies = (_copies + 1).clamp(1, 10)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _room,
                  decoration: const InputDecoration(labelText: 'Target Room'),
                  items: _rooms
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => setState(() => _room = v ?? _room),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: VestaColors.blueDark,
                            foregroundColor: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Clone'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
