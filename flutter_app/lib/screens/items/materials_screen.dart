import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _MaterialItem {
  final String name;
  final Color swatchColor;
  final String? grade;
  int qty;

  _MaterialItem(
      {required this.name,
      required this.swatchColor,
      this.grade,
      required this.qty});
}

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  bool _deleteMode = false;
  final Set<int> _toDelete = {};

  final List<_MaterialItem> _items = [
    _MaterialItem(
        name: '2x4 Pine',
        swatchColor: const Color(0xFFD2B48C),
        grade: 'Grade A',
        qty: 10),
    _MaterialItem(
        name: 'Vinyl Sill',
        swatchColor: Colors.white,
        grade: null,
        qty: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/materials'),
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
                          contentPadding: const EdgeInsets.all(12),
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
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: item.swatchColor,
                                        border: Border.all(
                                            color: VestaColors.grayMedium),
                                        borderRadius:
                                            BorderRadius.circular(4),
                                      ),
                                    ),
                                  ],
                                ),
                          title: Text(item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500)),
                          subtitle: item.grade != null
                              ? Text(item.grade!,
                                  style: const TextStyle(
                                      color: VestaColors.grayMediumDark,
                                      fontSize: 12))
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    size: 20),
                                onPressed: () => setState(
                                    () => item.qty = (item.qty - 1).clamp(0, 999)),
                              ),
                              Text('${item.qty}',
                                  style: const TextStyle(fontSize: 14)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline,
                                    size: 20),
                                onPressed: () => setState(() => item.qty++),
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
                              Navigator.of(context).pushNamed('/add-materials'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.delete_outline,
                            color: _deleteMode
                                ? VestaColors.red
                                : VestaColors.grayMediumDark),
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
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: VestaColors.green,
                              foregroundColor: Colors.white),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Documents'),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/documents'),
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
