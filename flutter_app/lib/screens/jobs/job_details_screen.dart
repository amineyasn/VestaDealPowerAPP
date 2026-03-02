import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/jobs'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: VestaColors.blueDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('JOB-001',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              SizedBox(height: 4),
                              Text('Robert Thompson',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: VestaColors.statusInfo,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('In Progress',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Property card
                  const _InfoCard(
                    title: '📍 Property',
                    items: [
                      _InfoRow('Address', '123 Oak St'),
                      _InfoRow('City', 'Austin, TX 78701'),
                      _InfoRow('Job Type', 'Window Replacement'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _InfoCard(
                    title: '👤 Homeowner',
                    items: [
                      _InfoRow('Name', 'Robert Thompson'),
                      _InfoRow('Email', 'r.thompson@email.com'),
                      _InfoRow('Phone', '(512) 555-0142'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _InfoCard(
                    title: '📅 Appointment',
                    items: [
                      _InfoRow('Date', 'Mar 5, 2026'),
                      _InfoRow('Technician', 'Jake Williams'),
                      _InfoRow('Stage', 'In Progress'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      VestaAdvanceButton(
                        icon: Icons.home_outlined,
                        iconColor: VestaColors.statusInfo,
                        label: 'Go to Rooms',
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/rooms'),
                      ),
                      const SizedBox(width: 16),
                      VestaAdvanceButton(
                        icon: Icons.phone,
                        iconColor: VestaColors.green,
                        label: 'Call Homeowner',
                        onPressed: () {},
                      ),
                    ],
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

class _InfoCard extends StatelessWidget {
  final String title;
  final List<_InfoRow> items;

  const _InfoCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const Divider(),
            ...items,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label,
                style: const TextStyle(
                    color: VestaColors.grayMediumDark, fontSize: 13)),
          ),
          Expanded(
              child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
