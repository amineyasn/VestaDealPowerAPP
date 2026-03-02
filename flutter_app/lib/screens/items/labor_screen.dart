import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _LaborItem {
  final String name;
  int qty;
  final String unit;

  _LaborItem({required this.name, required this.qty, required this.unit});
}

class LaborScreen extends StatefulWidget {
  const LaborScreen({super.key});

  @override
  State<LaborScreen> createState() => _LaborScreenState();
}

class _LaborScreenState extends State<LaborScreen> {
  bool _deleteMode = false;
  final Set<int> _toDelete = {};

  final List<_LaborItem> _items = [
    _LaborItem(name: 'Window Removal', qty: 3, unit: 'ea'),
    _LaborItem(name: 'Window Installation', qty: 3, unit: 'ea'),
    _LaborItem(name: 'Trim Installation', qty: 6, unit: 'lf'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/labor'),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _items.length,
                    itemBuilder: (context, i) {
                      final item = _items[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: _deleteMode
                              ? Checkbox(
                                  value: _toDelete.contains(i),
                                  onChanged: (v) => setState(() {
                                    if (v == true) {
                                      _toDelete.add(i);
                                    } else {
                                      _toDelete.remove(i);
                                    }
                                  }),
                                )
                              : const Icon(Icons.build_outlined,
                                  color: VestaColors.blueDark),
                          title: Text(item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    size: 20),
                                onPressed: () => setState(
                                    () => item.qty = (item.qty - 1).clamp(0, 999)),
                              ),
                              Text('${item.qty} ${item.unit}',
                                  style: const TextStyle(fontSize: 14)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline,
                                    size: 20),
                                onPressed: () =>
                                    setState(() => item.qty++),
                              ),
                            ],
                          ),
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
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Items'),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/add-labor'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: _deleteMode
                              ? VestaColors.red
                              : VestaColors.grayMediumDark,
                        ),
                        onPressed: () {
                          if (_deleteMode && _toDelete.isNotEmpty) {
                            setState(() {
                              final sorted =
                                  _toDelete.toList()..sort((a, b) => b - a);
                              for (final i in sorted) {
                                _items.removeAt(i);
                              }
                              _toDelete.clear();
                              _deleteMode = false;
                            });
                          } else {
                            setState(() {
                              _deleteMode = !_deleteMode;
                              _toDelete.clear();
                            });
                          }
                        },
                        tooltip: _deleteMode ? 'Confirm Delete' : 'Delete Items',
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: VestaColors.green,
                              foregroundColor: Colors.white),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Materials'),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/materials'),
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
