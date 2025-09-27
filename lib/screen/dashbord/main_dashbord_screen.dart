import 'package:e_commerce_code_pixel/screen/widget/sidbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainDashbordScreen extends StatelessWidget {
  final Widget child;
  const MainDashbordScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      // ==== تصميم الموبايل: AppBar + Drawer ====
      return Scaffold(
        appBar: AppBar(title: const Text("My App")),
        drawer: Drawer(
          child: SidebarContent(
            onTap: (route) {
              Navigator.pop(context); // يغلق Drawer
              context.go(route);
            },
          ),
        ),
        body: child,
      );
    }
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 220,
            color: Colors.white,
            child: SidebarContent(
              onTap: (route) {
                context.go(route);
              },
            ),
          ),
          Expanded(
            child: Container(color: const Color(0xFFF5F5F5), child: child),
          ),
        ],
      ),
    );
  }
}

/// Widget لعنصر داخل السايدبار
class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.green.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.green : Colors.grey[700]),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.green.shade700 : Colors.grey[800],
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
