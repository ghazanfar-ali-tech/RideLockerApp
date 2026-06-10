import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const NavItem({super.key, required this.label, required this.icon, required this.onTap, this.active = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? Colors.greenAccent : Colors.white54, size: 24),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: active ? Colors.greenAccent : Colors.white54, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
