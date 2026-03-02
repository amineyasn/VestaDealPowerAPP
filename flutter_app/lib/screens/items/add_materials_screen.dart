import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _CatalogItem {
  final String name;
  final String category;
  final String unit;
  bool selected;

  _CatalogItem(
      {required this.name,
      required this.category,
      required this.unit,
      this.selected = false});
}

class AddMaterialsScreen extends StatefulWidget {
  const AddMaterialsScreen({super.key});

  @override
  State<AddMaterialsScreen> createState() => _AddMaterialsScreenState();
}

class _AddMaterialsScreenState extends State<AddMaterialsScreen> {
  String _search = '';
  String _filter = 'All';

  final List<_CatalogItem> _items = [
    _CatalogItem(name: '2x4 Pine', category: 'Lumber', unit: 'lf'),
    _CatalogItem(name: '2x6 Pine', category: 'Lumber', unit: 'lf'),
    _CatalogItem(name: 'Vinyl Sill', category: 'Trim', unit: 'ea'),
    _CatalogItem(name: 'Aluminum Flashing', category: 'Flashing', unit: 'sf'),
    _CatalogItem(name: 'Foam Backer Rod', category: 'Sealant', unit: 'lf'),
    _CatalogItem(name: 'Spray Foam', category: 'Sealant', unit: 'can'),
    _CatalogItem(name: 'Caulk Tube', category: 'Sealant', unit: 'ea'),
    _CatalogItem(name: 'OSB 1/2"', category: 'Sheathing', unit: 'sf'),
  ];

  static const List<String> _filters = [
    'All', 'Lumber', 'Trim', 'Flashing', 'Sealant', 'Sheathing'
  ];

  List<_CatalogItem> get _filtered {
    return _items.where((item) {
      final matchSearch =
          _search.isEmpty || item.name.toLowerCase().contains(_search.toLowerCase());
      final matchFilter = _filter == 'All' || item.category == _filter;
      return matchSearch && matchFilter;
    }).toList();
  }

  int get _selectedCount => _items.where((i) => i.selected).length;

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Add Materials', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/materials'),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search materials...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (v) => setState(() => _search = v),
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: _filters
                        .map((f) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(f),
                                selected: _filter == f,
                                onSelected: (_) =>
                                    setState(() => _filter = f),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final item = filtered[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: CheckboxListTile(
                          value: item.selected,
                          title: Text(item.name),
                          subtitle: Text(
                              '${item.category} · ${item.unit}',
                              style: const TextStyle(
                                  color: VestaColors.grayMediumDark,
                                  fontSize: 12)),
                          onChanged: (v) =>
                              setState(() => item.selected = v ?? false),
                        ),
                      );
                    },
                  ),
                ),
                if (_selectedCount > 0)
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: VestaAdvanceButton(
                      icon: Icons.add,
                      iconColor: VestaColors.green,
                      label: 'Add $_selectedCount Item${_selectedCount == 1 ? '' : 's'}',
                      onPressed: () => Navigator.of(context).pop(),
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
