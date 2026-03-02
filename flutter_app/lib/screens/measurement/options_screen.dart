import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _OptionItem {
  final String attribute;
  String value;

  _OptionItem(this.attribute, this.value);
}

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  final List<_OptionItem> _selected = [
    _OptionItem('Frame Color', 'White'),
    _OptionItem('Glass Type', 'Double Pane'),
    _OptionItem('Grid Pattern', 'None'),
    _OptionItem('Grille Style', 'Colonial'),
  ];

  static const List<String> _categories = [
    'Frame Color',
    'Glass Type',
    'Grid Pattern',
    'Grille Style',
    'Hardware',
    'Screen Type',
    'Tint',
    'Opening Style',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Window Options', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/windows'),
          Expanded(
            child: Row(
              children: [
                // Left panel – selected options
                Container(
                  width: 250,
                  color: VestaColors.panelBg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('Selected Options',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: _selected.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final opt = _selected[i];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(opt.attribute,
                                      style: const TextStyle(
                                          color: VestaColors.grayMediumDark,
                                          fontSize: 11)),
                                  Text(opt.value,
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: VestaAdvanceButton(
                          icon: Icons.check,
                          iconColor: VestaColors.green,
                          label: 'Save Options',
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/windows'),
                        ),
                      ),
                    ],
                  ),
                ),
                // Right panel – option categories
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                _categories[i],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
