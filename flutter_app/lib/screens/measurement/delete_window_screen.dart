import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class DeleteWindowScreen extends StatelessWidget {
  const DeleteWindowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Delete Window', showBack: true),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    size: 64, color: VestaColors.red),
                const SizedBox(height: 16),
                const Text('Delete Window?',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                const Text('W-001 — 36 3/4" × 48 1/2"',
                    style: TextStyle(color: VestaColors.grayMediumDark)),
                const SizedBox(height: 8),
                const Text(
                    'This action cannot be undone. All measurements and options will be deleted.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: VestaColors.grayMediumDark, fontSize: 13)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: VestaColors.red,
                            foregroundColor: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Delete'),
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
