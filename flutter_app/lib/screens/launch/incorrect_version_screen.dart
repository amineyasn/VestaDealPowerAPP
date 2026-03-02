import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class IncorrectVersionScreen extends StatelessWidget {
  const IncorrectVersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.whiteSmoke,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      size: 132, color: VestaColors.red),
                  const SizedBox(height: 32),
                  const Text('Vesta Measure', style: VestaText.appTitle),
                  const SizedBox(height: 16),
                  const Text(
                    "Oops! Looks like you're not on the latest version",
                    style: TextStyle(
                        fontSize: 18,
                        color: VestaColors.red,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VestaColors.blueDark,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: const Text('Update App', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward,
                          color: VestaColors.statusInfo, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Swipe to close, and re-open',
                        style: TextStyle(
                            color: VestaColors.statusInfo, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 16,
            bottom: 16,
            child: Text('Version 1.62', style: VestaText.version),
          ),
        ],
      ),
    );
  }
}
