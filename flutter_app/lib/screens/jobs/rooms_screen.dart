import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _Room {
  final String name;
  final int windowCount;
  final bool complete;

  const _Room(
      {required this.name,
      required this.windowCount,
      required this.complete});
}

const List<_Room> _mockRooms = [
  _Room(name: 'Living Room', windowCount: 3, complete: true),
  _Room(name: 'Master Bedroom', windowCount: 2, complete: false),
  _Room(name: 'Kitchen', windowCount: 1, complete: false),
  _Room(name: 'Guest Bedroom', windowCount: 2, complete: false),
  _Room(name: 'Bathroom', windowCount: 1, complete: false),
];

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  late List<_Room> _rooms;

  @override
  void initState() {
    super.initState();
    _rooms = List.from(_mockRooms);
  }

  int get _doneCount => _rooms.where((r) => r.complete).length;

  void _showAddRoomDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Room'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Room name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _rooms.add(_Room(
                      name: controller.text, windowCount: 0, complete: false));
                });
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Add'),
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
          const VestaSidebar(selectedRoute: '/rooms'),
          Expanded(
            child: Column(
              children: [
                // Progress strip
                Container(
                  height: 56,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('JOB-001 Robert Thompson',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      Text('$_doneCount/${_rooms.length} rooms done',
                          style: const TextStyle(
                              color: VestaColors.grayMediumDark, fontSize: 13)),
                    ],
                  ),
                ),
                // Room list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _rooms.length,
                    itemBuilder: (context, index) {
                      final room = _rooms[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            room.complete
                                ? Icons.check_circle
                                : Icons.home_outlined,
                            color: room.complete
                                ? VestaColors.green
                                : VestaColors.grayMediumDark,
                          ),
                          title: Text(room.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${room.windowCount} window${room.windowCount == 1 ? '' : 's'}'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () =>
                              Navigator.of(context).pushNamed('/windows'),
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
                          label: const Text('Add Room'),
                          onPressed: _showAddRoomDialog,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: VestaColors.green,
                              foregroundColor: Colors.white),
                          icon: const Icon(Icons.check),
                          label: const Text('Go to Labor'),
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
