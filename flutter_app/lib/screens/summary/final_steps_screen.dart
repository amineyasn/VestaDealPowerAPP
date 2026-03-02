import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class FinalStepsScreen extends StatelessWidget {
  const FinalStepsScreen({super.key});

  static const List<Map<String, dynamic>> _checklist = [
    {'label': 'All windows measured', 'done': true},
    {'label': 'Lead tests completed', 'done': true},
    {'label': 'Labor items added', 'done': true},
    {'label': 'Materials added', 'done': true},
    {'label': 'Documents signed', 'done': false},
    {'label': 'Photos taken', 'done': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Final Steps', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/final'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: _checklist
                            .map((item) => ListTile(
                                  leading: Icon(
                                    (item['done'] as bool)
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: (item['done'] as bool)
                                        ? VestaColors.green
                                        : VestaColors.grayMediumDark,
                                  ),
                                  title: Text(
                                    '${item['label']}${(item['done'] as bool) ? ' ✓' : ''}',
                                    style: TextStyle(
                                      color: (item['done'] as bool)
                                          ? Colors.black87
                                          : VestaColors.grayMediumDark,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  VestaAdvanceButton(
                    icon: Icons.email_outlined,
                    iconColor: VestaColors.blueDark,
                    label: 'Send to Office',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  VestaAdvanceButton(
                    icon: Icons.check_circle_outline,
                    iconColor: VestaColors.green,
                    label: 'Complete Job',
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/saving'),
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
