import 'package:flutter/material.dart';
import 'model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationItem> _items = [];
  bool _unreadOnly = false;

  NotificationProvider() {
    _items = [
      NotificationItem(id: '1', category: NotificationCategory.theft, title: 'Theft Alert', description: 'Suspicious movement detected', timestamp: DateTime.now().subtract(const Duration(minutes: 2)), isRead: false),
      NotificationItem(id: '2', category: NotificationCategory.geoFence, title: 'Geo-fence', description: 'geo-fence entrance/ exit', timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isRead: false),
      NotificationItem(id: '3', category: NotificationCategory.system, title: 'System Update', description: 'System update Successfully', timestamp: DateTime.now().subtract(const Duration(hours: 1)), isRead: true),
      NotificationItem(id: '4', category: NotificationCategory.theft, title: 'Theft Alert', description: 'Suspicious movement detected', timestamp: DateTime.now().subtract(const Duration(minutes: 2)), isRead: false),
      NotificationItem(id: '5', category: NotificationCategory.geoFence, title: 'Geo-fence', description: 'geo-fence entrance/ exit', timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isRead: false),
    ];
  }

  List<NotificationItem> get items => _items;
  bool get unreadOnly => _unreadOnly;

  List<NotificationItem> getFilteredByCategory(int tabIndex) {
    List<NotificationItem> list = _items;
    switch (tabIndex) {
      case 1: list = list.where((n) => n.category == NotificationCategory.theft).toList(); break;
      case 2: list = list.where((n) => n.category == NotificationCategory.geoFence).toList(); break;
      case 3: list = list.where((n) => n.category == NotificationCategory.system).toList(); break;
    }
    if (_unreadOnly) list = list.where((n) => !n.isRead).toList();
    return list;
  }

  void markRead(String id) {
    final item = _items.firstWhere((n) => n.id == id);
    if (!item.isRead) {
      item.isRead = true;
      notifyListeners();
    }
  }

  void markAllRead() {
    for (var item in _items) item.isRead = true;
    notifyListeners();
  }

  void toggleUnread() {
    _unreadOnly = !_unreadOnly;
    notifyListeners();
  }

  void addMockNotification() {
    final now = DateTime.now();
    final type = [NotificationCategory.theft, NotificationCategory.geoFence, NotificationCategory.system][now.second % 3];
    _items.insert(0, NotificationItem(
      id: now.millisecondsSinceEpoch.toString(),
      category: type,
      title: type == NotificationCategory.theft ? 'Theft Alert' : (type == NotificationCategory.geoFence ? 'Geo-fence' : 'System Update'),
      description: type == NotificationCategory.theft ? 'Suspicious movement detected' : (type == NotificationCategory.geoFence ? 'Geo-fence crossed' : 'New update available'),
      timestamp: now,
      isRead: false,
    ));
    notifyListeners();
  }
}