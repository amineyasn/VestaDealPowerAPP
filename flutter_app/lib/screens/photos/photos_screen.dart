import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  String _mode = 'Default';
  String _photoType = 'Exterior';
  int? _fullScreenIndex;

  static const List<String> _modes = ['Default', 'Window', 'Elevation'];
  static const List<String> _types = ['Exterior', 'Interior', 'Damage', 'Other'];

  final List<Map<String, dynamic>> _photos = [
    // Mock photos pre-populated for UI preview; in production this starts empty
    {'type': 'Exterior', 'label': 'Front Elevation'},
    {'type': 'Interior', 'label': 'Living Room W1'},
    {'type': 'Damage', 'label': 'Rotted Sill'},
  ];

  @override
  Widget build(BuildContext context) {
    if (_fullScreenIndex != null) {
      return _FullScreenPhoto(
        label: _photos[_fullScreenIndex!]['label'] as String,
        onClose: () => setState(() => _fullScreenIndex = null),
      );
    }

    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(showBack: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: VestaColors.blueDark,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.camera_alt),
      ),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/photos'),
          Expanded(
            child: Column(
              children: [
                // Mode tabs
                Container(
                  color: Colors.white,
                  child: Row(
                    children: _modes
                        .map((m) => Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _mode = m),
                                child: Container(
                                  height: 44,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: _mode == m
                                            ? VestaColors.blueDark
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      m,
                                      style: TextStyle(
                                        fontWeight: _mode == m
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _mode == m
                                            ? VestaColors.blueDark
                                            : VestaColors.grayMediumDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                // Photo type chips
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    children: _types
                        .map((t) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(t),
                                selected: _photoType == t,
                                onSelected: (_) =>
                                    setState(() => _photoType = t),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                // Photo grid or empty state
                Expanded(
                  child: _photos.isEmpty
                      ? const Center(
                          child: Text(
                            'Click button above to take photo',
                            style: TextStyle(
                                color: VestaColors.grayMediumDark,
                                fontSize: 20),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: _photos.length,
                          itemBuilder: (context, i) {
                            final photo = _photos[i];
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _fullScreenIndex = i),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: VestaColors.grayMedium,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.image,
                                              size: 48,
                                              color: VestaColors.grayMediumDark),
                                          const SizedBox(height: 8),
                                          Text(
                                            photo['label'] as String,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: VestaColors.grayMediumDark),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    left: 4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        photo['type'] as String,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => setState(
                                          () => _photos.removeAt(i)),
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close,
                                            color: Colors.white, size: 16),
                                      ),
                                    ),
                                  ),
                                ],
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

class _FullScreenPhoto extends StatelessWidget {
  final String label;
  final VoidCallback onClose;

  const _FullScreenPhoto({required this.label, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image, size: 120, color: Colors.white38),
                const SizedBox(height: 16),
                Text(label,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
          Positioned(
            top: 48,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
