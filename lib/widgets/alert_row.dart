import 'package:flutter/material.dart';

class AlertRow extends StatelessWidget {
  final Color color;
  final String text;
  final String time;
  const AlertRow({required this.color, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF0F1112), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
          Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
