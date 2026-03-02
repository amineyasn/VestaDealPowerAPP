import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _MarketItem {
  final String name;
  final String category;
  final String unit;
  bool selected = false;

  _MarketItem(
      {required this.name,
      required this.category,
      required this.unit});
}

class AddLaborItemsScreen extends StatefulWidget {
  const AddLaborItemsScreen({super.key});

  @override
  State<AddLaborItemsScreen> createState() => _AddLaborItemsScreenState();
}

class _AddLaborItemsScreenState extends State<AddLaborItemsScreen> {
  String _search = '';
  String _filter = 'All';
  final List<_MarketItem> _items = [
    _MarketItem(name: 'Window Removal', category: 'Removal', unit: 'ea'),
    _MarketItem(name: 'Window Installation', category: 'Installation', unit: 'ea'),
    _MarketItem(name: 'Trim Installation', category: 'Trim', unit: 'lf'),
    _MarketItem(name: 'Frame Repair', category: 'Repair', unit: 'hr'),
    _MarketItem(name: 'Caulking', category: 'Installation', unit: 'lf'),
    _MarketItem(name: 'Screen Installation', category: 'Installation', unit: 'ea'),
    _MarketItem(name: 'Sill Replacement', category: 'Trim', unit: 'ea'),
    _MarketItem(name: 'Debris Removal', category: 'Removal', unit: 'hr'),
  ];

  static const List<String> _filters = [
    'All', 'Installation', 'Removal', 'Trim', 'Repair'
  ];

  List<_MarketItem> get _filtered {
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
      appBar: const VestaTitlebar(title: 'Add Labor Items', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/labor'),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search labor items...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (v) => setState(() => _search = v),
                  ),
                ),
                // Filter chips
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
