import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class LeadTestScreen extends StatefulWidget {
  const LeadTestScreen({super.key});

  @override
  State<LeadTestScreen> createState() => _LeadTestScreenState();
}

class _LeadTestScreenState extends State<LeadTestScreen> {
  String? _result;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Lead Test', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/windows'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Window info
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.window_outlined,
                              color: VestaColors.blueDark),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('W-001 — Window 1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text('36 3/4" × 48 1/2"',
                                  style: TextStyle(
                                      color: VestaColors.grayMediumDark)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Lead Test Result',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _result = 'Negative'),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: _result == 'Negative'
                                  ? VestaColors.green
                                  : VestaColors.green.withAlpha(30),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: VestaColors.green, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle,
                                    color: _result == 'Negative'
                                        ? Colors.white
                                        : VestaColors.green,
                                    size: 36),
                                const SizedBox(height: 8),
                                Text('Negative ✓',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _result == 'Negative'
                                            ? Colors.white
                                            : VestaColors.green)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _result = 'Positive'),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: _result == 'Positive'
                                  ? VestaColors.red
                                  : VestaColors.red.withAlpha(30),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: VestaColors.red, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning_amber_rounded,
                                    color: _result == 'Positive'
                                        ? Colors.white
                                        : VestaColors.red,
                                    size: 36),
                                const SizedBox(height: 8),
                                Text('Positive ⚠',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _result == 'Positive'
                                            ? Colors.white
                                            : VestaColors.red)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: VestaColors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: _result != null
                          ? () => Navigator.of(context).pop()
                          : null,
                      child: const Text('Save Result',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
