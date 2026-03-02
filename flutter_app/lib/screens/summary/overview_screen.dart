import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/overview'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionCard(
                    title: 'Job Info',
                    child: Column(
                      children: const [
                        _OverviewRow('Customer', 'Robert Thompson'),
                        _OverviewRow('Address', '123 Oak St, Austin TX'),
                        _OverviewRow('Stage', 'In Progress'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Rooms',
                    child: Column(
                      children: const [
                        _OverviewRow('Total Rooms', '5'),
                        _OverviewRow('Complete', '1 / 5'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Windows',
                    child: Column(
                      children: const [
                        _OverviewRow('Total Windows', '3'),
                        _OverviewRow('Measured', '2 / 3'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Labor Items',
                    child: Column(
                      children: const [
                        _OverviewRow('Window Removal', 'Qty: 3'),
                        _OverviewRow('Window Installation', 'Qty: 3'),
                        _OverviewRow('Trim Installation', 'Qty: 6'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Materials',
                    child: Column(
                      children: const [
                        _OverviewRow('2x4 Pine (Grade A)', 'Qty: 10'),
                        _OverviewRow('Vinyl Sill (White)', 'Qty: 3'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Documents',
                    child: Column(
                      children: const [
                        _OverviewRow('Signed', '1 / 3'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Photos',
                    child: Column(
                      children: const [
                        _OverviewRow('Photos taken', '3'),
                      ],
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

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

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
                    fontSize: 15, fontWeight: FontWeight.w600)),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  final String label;
  final String value;

  const _OverviewRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: VestaColors.grayMediumDark, fontSize: 13)),
          Text(value, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
