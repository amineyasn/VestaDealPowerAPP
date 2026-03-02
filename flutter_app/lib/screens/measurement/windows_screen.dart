import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _Window {
  final String id;
  final String label;
  final String? width;
  final String? height;
  final String? leadResult;

  const _Window({
    required this.id,
    required this.label,
    this.width,
    this.height,
    this.leadResult,
  });
}

const List<_Window> _mockWindows = [
  _Window(
      id: 'W-001',
      label: 'Window 1',
      width: '36 3/4"',
      height: '48 1/2"',
      leadResult: 'Negative'),
  _Window(id: 'W-002', label: 'Window 2'),
  _Window(
      id: 'W-003',
      label: 'Window 3',
      width: '24 1/8"',
      height: '36 3/4"',
      leadResult: 'Positive'),
];

class WindowsScreen extends StatefulWidget {
  const WindowsScreen({super.key});

  @override
  State<WindowsScreen> createState() => _WindowsScreenState();
}

class _WindowsScreenState extends State<WindowsScreen> {
  void _showWindowMenu(BuildContext context, _Window window) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Clone Window'),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamed('/clone-window');
            },
          ),
          ListTile(
            leading: const Icon(Icons.science_outlined),
            title: const Text('Lead Test'),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamed('/lead-test');
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_column_outlined),
            title: const Text('Mull Windows'),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamed('/mull-windows');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: VestaColors.red),
            title: const Text('Delete Window',
                style: TextStyle(color: VestaColors.red)),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamed('/delete-window');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/windows'),
          Expanded(
            child: Column(
              children: [
                // Room header
                Container(
                  height: 56,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.home_outlined,
                          color: VestaColors.blueDark),
                      const SizedBox(width: 8),
                      const Text('Living Room',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      const Spacer(),
                      Text('${_mockWindows.length} windows',
                          style: const TextStyle(
                              color: VestaColors.grayMediumDark,
                              fontSize: 13)),
                    ],
                  ),
                ),
                // Window list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _mockWindows.length,
                    itemBuilder: (context, index) {
                      final w = _mockWindows[index];
                      final measured = w.width != null;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: VestaColors.blueDark, width: 2),
                              color: measured
                                  ? VestaColors.blueDark.withAlpha(30)
                                  : Colors.transparent,
                            ),
                            child: const Icon(Icons.window_outlined,
                                color: VestaColors.blueDark, size: 24),
                          ),
                          title: Text(w.label,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                measured
                                    ? '${w.width} × ${w.height}'
                                    : 'Not measured yet',
                                style: TextStyle(
                                    color: measured
                                        ? Colors.black87
                                        : VestaColors.grayMediumDark),
                              ),
                              if (w.leadResult != null)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: w.leadResult == 'Negative'
                                        ? VestaColors.green
                                        : VestaColors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Lead: ${w.leadResult}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ),
                                ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () => _showWindowMenu(context, w),
                          ),
                          onTap: () =>
                              Navigator.of(context).pushNamed('/measure-window'),
                        ),
                      );
                    },
                  ),
                ),
                // Bottom buttons
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Window'),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: VestaColors.green,
                              foregroundColor: Colors.white),
                          icon: const Icon(Icons.check),
                          label: const Text('Save & Continue'),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/labor'),
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
