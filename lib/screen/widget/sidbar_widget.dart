import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ====== محتوى السايدبار (يُستخدم في Drawer و Sidebar) ======
class SidebarContent extends StatelessWidget {
  final void Function(String route) onTap;
  const SidebarContent({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "LOGO",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _SidebarItem(
          label: "Dashboard",
          icon: Icons.dashboard,
          route: "/dashboard",
          currentRoute: currentRoute,
          onTap: onTap,
        ),
        _SidebarItem(
          label: "Analytics",
          icon: Icons.analytics,
          route: "/analytics",
          currentRoute: currentRoute,
          onTap: onTap,
        ),
        _SidebarItem(
          label: "Orders",
          icon: Icons.list_alt,
          route: "/orders",
          currentRoute: currentRoute,
          onTap: onTap,
        ),
      ],
    );
  }
}

/// ====== عنصر Sidebar ======
class _SidebarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;
  final String currentRoute;
  final void Function(String) onTap;

  const _SidebarItem({
    required this.label,
    required this.icon,
    required this.route,
    required this.currentRoute,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentRoute == route;

    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.green : Colors.grey[700]),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.green : Colors.black87,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => onTap(route),
    );
  }
}
