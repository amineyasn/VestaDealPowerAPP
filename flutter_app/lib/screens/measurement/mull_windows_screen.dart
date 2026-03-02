import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class MullWindowsScreen extends StatefulWidget {
  const MullWindowsScreen({super.key});

  @override
  State<MullWindowsScreen> createState() => _MullWindowsScreenState();
}

class _MullWindowsScreenState extends State<MullWindowsScreen> {
  final Set<String> _selected = {};

  static const List<String> _windows = [
    'W-001 — 36 3/4" × 48 1/2"',
    'W-002 — Not measured yet',
    'W-003 — 24 1/8" × 36 3/4"',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Mull Windows', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/windows'),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Select windows to mull together',
                      style: TextStyle(
                          fontSize: 16, color: VestaColors.grayMediumDark)),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _windows.length,
                    itemBuilder: (context, i) {
                      final w = _windows[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: CheckboxListTile(
                          value: _selected.contains(w),
                          title: Text(w),
                          onChanged: (v) {
                            setState(() {
                              if (v == true) {
                                _selected.add(w);
                              } else {
                                _selected.remove(w);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selected.length >= 2
                                ? VestaColors.blueDark
                                : VestaColors.grayMedium,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _selected.length >= 2
                              ? () => Navigator.of(context).pop()
                              : null,
                          child: const Text('Mull Selected'),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
