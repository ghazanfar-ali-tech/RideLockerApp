import 'package:flutter/material.dart';

void main() {
  runApp(const RideLockrApp());
}

class RideLockrApp extends StatelessWidget {
  const RideLockrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideLockr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFF00FFAA),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFAA),
          secondary: Color(0xFF00D4FF),
          surface: Color(0xFF1E1E1E),
          background: Color(0xFF0A0A0A),
        ),
      ),
      home: const AlertScreen(),
    );
  }
}

// ------------------------------------------------------------
// Notification Model
// ------------------------------------------------------------
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

// ------------------------------------------------------------
// Main Alert Screen
// ------------------------------------------------------------
class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<NotificationItem> _notifications = [];
  bool _showUnreadOnly = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadSampleNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadSampleNotifications() {
    _notifications = [
      NotificationItem(
        id: '1',
        category: NotificationCategory.theft,
        title: 'Theft Alert',
        description: 'Suspicious movement detected',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        category: NotificationCategory.geoFence,
        title: 'Geo-fence',
        description: 'geo-fence entrance/ exit',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),
      NotificationItem(
        id: '3',
        category: NotificationCategory.system,
        title: 'System Update',
        description: 'System update Successfully',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true,
      ),
      NotificationItem(
        id: '4',
        category: NotificationCategory.theft,
        title: 'Theft Alert',
        description: 'Suspicious movement detected',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isRead: false,
      ),
      NotificationItem(
        id: '5',
        category: NotificationCategory.geoFence,
        title: 'Geo-fence',
        description: 'geo-fence entrance/ exit',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),
    ];
  }

  List<NotificationItem> get _filteredNotifications {
    // Category filter based on tab index
    NotificationCategory? categoryFilter;
    switch (_tabController.index) {
      case 0:
        categoryFilter = null;
        break;
      case 1:
        categoryFilter = NotificationCategory.theft;
        break;
      case 2:
        categoryFilter = NotificationCategory.geoFence;
        break;
      case 3:
        categoryFilter = NotificationCategory.system;
        break;
    }

    var filtered = _notifications;
    if (categoryFilter != null) {
      filtered = filtered.where((n) => n.category == categoryFilter).toList();
    }
    if (_showUnreadOnly) {
      filtered = filtered.where((n) => !n.isRead).toList();
    }
    return filtered;
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) _notifications[index].isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) n.isRead = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: Color(0xFF00FFAA),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _toggleUnreadFilter() {
    setState(() {
      _showUnreadOnly = !_showUnreadOnly;
    });
  }

  void _addMockNotification() {
    final now = DateTime.now();
    final randomType = [NotificationCategory.theft, NotificationCategory.geoFence, NotificationCategory.system][now.second % 3];
    final newNotification = NotificationItem(
      id: now.millisecondsSinceEpoch.toString(),
      category: randomType,
      title: randomType == NotificationCategory.theft ? 'Theft Alert' : (randomType == NotificationCategory.geoFence ? 'Geo-fence' : 'System Update'),
      description: randomType == NotificationCategory.theft ? 'Suspicious movement detected' : (randomType == NotificationCategory.geoFence ? 'Geo-fence crossed' : 'New update available'),
      timestamp: now,
      isRead: false,
    );
    setState(() {
      _notifications.insert(0, newNotification);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New notification received'),
        backgroundColor: Color(0xFF00FFAA),
        duration: Duration(seconds: 1),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour ago';
    return '${diff.inDays} days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF00FFAA),
          labelColor: const Color(0xFF00FFAA),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Theft'),
            Tab(text: 'Geo-fence'),
            Tab(text: 'System'),
          ],
          onTap: (_) => setState(() {}), // Refresh when tab changes
        ),
      ),
      body: Column(
        children: [
          // Filter row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Unread toggle
                GestureDetector(
                  onTap: _toggleUnreadFilter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _showUnreadOnly ? const Color(0xFF00FFAA).withOpacity(0.2) : Colors.transparent,
                      border: Border.all(color: const Color(0xFF00FFAA), width: 1.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(_showUnreadOnly ? Icons.check_circle : Icons.circle_outlined, size: 18, color: const Color(0xFF00FFAA)),
                        const SizedBox(width: 8),
                        Text('Unread', style: TextStyle(color: const Color(0xFF00FFAA), fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                // Clear All
                GestureDetector(
                  onTap: _markAllAsRead,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF00D4FF), width: 1.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.clear_all, size: 18, color: Color(0xFF00D4FF)),
                        SizedBox(width: 8),
                        Text('Clear All', style: TextStyle(color: Color(0xFF00D4FF), fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Notification list
          Expanded(
            child: _filteredNotifications.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No notifications', style: TextStyle(color: Colors.white54)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = _filteredNotifications[index];
                      return _buildNotificationCard(notification);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMockNotification,
        backgroundColor: const Color(0xFF00FFAA),
        child: const Icon(Icons.add_alert, color: Colors.black),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    IconData icon;
    Color iconColor;
    switch (notification.category) {
      case NotificationCategory.theft:
        icon = Icons.warning_amber_rounded;
        iconColor = const Color(0xFFFF453A);
        break;
      case NotificationCategory.geoFence:
        icon = Icons.fence;
        iconColor = const Color(0xFF00D4FF);
        break;
      case NotificationCategory.system:
        icon = Icons.system_update_alt;
        iconColor = const Color(0xFF00FFAA);
        break;
    }

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFF453A).withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Color(0xFFFF453A)),
      ),
      onDismissed: (_) => _markAsRead(notification.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: !notification.isRead
              ? Border.all(color: const Color(0xFF00FFAA).withOpacity(0.7), width: 1.2)
              : null,
        ),
        child: ListTile(
          onTap: () => _showNotificationDetails(notification),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [iconColor.withOpacity(0.3), iconColor.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  notification.title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: iconColor, fontSize: 16),
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(color: Color(0xFF00FFAA), shape: BoxShape.circle),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(notification.description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 6),
              Text(_formatTimeAgo(notification.timestamp), style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          trailing: !notification.isRead
              ? IconButton(
                  icon: const Icon(Icons.check_circle_outline, color: Color(0xFF00FFAA), size: 22),
                  onPressed: () => _markAsRead(notification.id),
                )
              : null,
        ),
      ),
    );
  }

  void _showNotificationDetails(NotificationItem notification) {
    if (!notification.isRead) _markAsRead(notification.id);
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(notification.description, style: const TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 12),
            Text(_formatTimeAgo(notification.timestamp), style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFAA),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}