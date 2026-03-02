import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool _offlineMode = false;
  bool _audExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Admin Panel 🔒', showBack: true),
      body: Stack(
        children: [
          Row(
            children: [
              const VestaSidebar(selectedRoute: ''),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Warning banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: VestaColors.yellow.withAlpha(50),
                          border: Border.all(color: VestaColors.yellow),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '⚠️ Admin / Debug Tools — Internal Use Only',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Debug info cards
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const _AdminRow('App Version', '1.62'),
                              const _AdminRow('Environment',
                                  'wn-dev-r3.crm.dynamics.com'),
                              const _AdminRow(
                                  'User', 'jake.williams@vestahome.com'),
                              const _AdminRow('AUD Queue Count', '0'),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Offline Mode',
                                      style: TextStyle(fontSize: 13)),
                                  Switch(
                                    value: _offlineMode,
                                    onChanged: (v) =>
                                        setState(() => _offlineMode = v),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: VestaColors.red,
                                  foregroundColor: Colors.white),
                              onPressed: () {},
                              child: const Text('Clear Cache'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: VestaColors.blueDark,
                                  foregroundColor: Colors.white),
                              onPressed: () {},
                              child: const Text('Force Reload'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // AUD Records expandable
                      Card(
                        child: ExpansionTile(
                          title: const Text('View AUD Records'),
                          initiallyExpanded: _audExpanded,
                          onExpansionChanged: (v) =>
                              setState(() => _audExpanded = v),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'No AUD records in queue.',
                                style: TextStyle(
                                    color: VestaColors.grayMediumDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Dark overlay to indicate admin/hidden
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                color: Colors.black.withAlpha(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminRow extends StatelessWidget {
  final String label;
  final String value;

  const _AdminRow(this.label, this.value);

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
