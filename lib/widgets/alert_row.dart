import 'package:flutter/material.dart';

class AlertRow extends StatelessWidget {
  final Color color;
  final String text;
  final String time;
  final IconData? icon;

  const AlertRow({
    super.key,
    required this.color,
    required this.text,
    required this.time,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final alertIcon = icon ?? (color == Colors.redAccent
        ? Icons.notifications_active
        : Icons.location_on);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF131418),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Colored circle icon — matches Figma notification tile
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(alertIcon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
              const SizedBox(height: 4),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF00E676),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
