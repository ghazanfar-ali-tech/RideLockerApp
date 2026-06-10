import 'package:flutter/material.dart';

enum NotificationCategory { theft, geoFence, system }

class NotificationItem {
  final String id;
  final NotificationCategory category;
  final String title;
  final String description;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isRead = false,
  });
}