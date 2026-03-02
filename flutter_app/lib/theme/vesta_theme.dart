import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// Colors
// ─────────────────────────────────────────────
class VestaColors {
  VestaColors._();

  static const Color blueDark = Color(0xFF0D59A2);
  static const Color blueNavy = Color(0xFF00126B);
  static const Color whiteSmoke = Color(0xFFF5F5F5);
  static const Color titlebarBlue = Color(0xFF1A459D);
  static const Color grayLight = Color(0xFFF3F2F1);
  static const Color grayMedium = Color(0xFFD2D0CE);
  static const Color grayMediumDark = Color(0xFF8A8886);
  static const Color green = Color(0xFF1FA770);
  static const Color red = Color(0xFFD13438);
  static const Color yellow = Color(0xFFFFC600);
  static const Color panelBg = Color(0xFFFAF9F8);
  static const Color statusInfo = Color(0xFF3860B2);
}

// ─────────────────────────────────────────────
// Text Styles
// ─────────────────────────────────────────────
class VestaText {
  VestaText._();

  static const TextStyle appTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 32,
    fontWeight: FontWeight.w300,
    color: Colors.black87,
  );

  static const TextStyle screenTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: VestaColors.grayMediumDark,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 16,
    color: Colors.black87,
  );

  static const TextStyle version = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: VestaColors.grayMediumDark,
  );
}

// ─────────────────────────────────────────────
// Sidebar model
// ─────────────────────────────────────────────
class SidebarItem {
  final IconData icon;
  final String label;
  final String route;

  const SidebarItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

const List<SidebarItem> kSidebarItems = [
  SidebarItem(icon: Icons.work_outline, label: 'Jobs', route: '/jobs'),
  SidebarItem(icon: Icons.home_outlined, label: 'Rooms', route: '/rooms'),
  SidebarItem(
      icon: Icons.window_outlined, label: 'Windows', route: '/windows'),
  SidebarItem(icon: Icons.build_outlined, label: 'Labor', route: '/labor'),
  SidebarItem(
      icon: Icons.attach_file, label: 'Materials', route: '/materials'),
  SidebarItem(
      icon: Icons.description_outlined, label: 'Docs', route: '/documents'),
  SidebarItem(
      icon: Icons.camera_alt_outlined, label: 'Photos', route: '/photos'),
  SidebarItem(
      icon: Icons.list_alt_outlined, label: 'Overview', route: '/overview'),
  SidebarItem(
      icon: Icons.directions_car_outlined, label: 'Final', route: '/final'),
];

// ─────────────────────────────────────────────
// VestaTitlebar
// ─────────────────────────────────────────────
class VestaTitlebar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;

  const VestaTitlebar({
    super.key,
    this.title = 'Vesta Measure',
    this.showBack = false,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: VestaColors.titlebarBlue,
      toolbarHeight: 60,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      automaticallyImplyLeading: false,
      title: Text(title, style: VestaText.screenTitle),
      actions: actions,
    );
  }
}

// ─────────────────────────────────────────────
// VestaSidebar
// ─────────────────────────────────────────────
class VestaSidebar extends StatelessWidget {
  final String selectedRoute;

  const VestaSidebar({super.key, required this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: VestaColors.blueDark,
      child: Column(
        children: kSidebarItems
            .map((item) => _SidebarTile(item: item, selected: item.route == selectedRoute))
            .toList(),
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final SidebarItem item;
  final bool selected;

  const _SidebarTile({required this.item, required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          Navigator.of(context).pushNamed(item.route);
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: selected
              ? const Border(
                  left: BorderSide(color: VestaColors.yellow, width: 3))
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: selected ? Colors.white : Colors.white70,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 10,
                color: selected ? Colors.white : Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// VestaAdvanceButton
// ─────────────────────────────────────────────
class VestaAdvanceButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onPressed;

  const VestaAdvanceButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: iconColor,
            radius: 16,
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// VestaProgressBar
// ─────────────────────────────────────────────
class VestaProgressBar extends StatelessWidget {
  final double percent; // 0.0 to 1.0

  const VestaProgressBar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Container(
          height: 10,
          decoration: BoxDecoration(
            color: VestaColors.grayMedium,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: width * percent.clamp(0.0, 1.0),
              decoration: BoxDecoration(
                color: VestaColors.blueDark,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        );
      },
    );
  }
}
