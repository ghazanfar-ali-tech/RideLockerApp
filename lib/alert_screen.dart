import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'notification_provider.dart';

// RideLockrApp moved here to keep main.dart minimal
class RideLockrApp extends StatelessWidget {
  const RideLockrApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
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

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> with SingleTickerProviderStateMixin {
  late TabController _tc;

  @override
  void initState() {
    super.initState();
    _tc = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  String _timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour ago';
    return '${diff.inDays} days ago';
  }

  void _showDetails(BuildContext context, NotificationItem n, NotificationProvider provider) {
    if (!n.isRead) provider.markRead(n.id);
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(n.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(n.description, style: const TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 12),
            Text(_timeAgo(n.timestamp), style: const TextStyle(color: Colors.grey)),
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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();
    final filteredItems = provider.getFilteredByCategory(_tc.index);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tc,
          indicatorColor: const Color(0xFF00FFAA),
          labelColor: const Color(0xFF00FFAA),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Theft'),
            Tab(text: 'Geo-fence'),
            Tab(text: 'System'),
          ],
          onTap: (_) => setState(() {}), // only rebuilds UI for tab change, no data mutation
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: provider.toggleUnread,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: provider.unreadOnly ? const Color(0xFF00FFAA).withOpacity(0.2) : Colors.transparent,
                      border: Border.all(color: const Color(0xFF00FFAA), width: 1.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(provider.unreadOnly ? Icons.check_circle : Icons.circle_outlined, size: 18, color: const Color(0xFF00FFAA)),
                        const SizedBox(width: 8),
                        const Text('Unread', style: TextStyle(color: Color(0xFF00FFAA), fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.markAllRead();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All notifications marked as read'),
                        backgroundColor: Color(0xFF00FFAA),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
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
          Expanded(
            child: filteredItems.isEmpty
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
                    itemCount: filteredItems.length,
                    itemBuilder: (_, i) => _buildCard(context, filteredItems[i], provider),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addMockNotification();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('New notification received'),
              backgroundColor: Color(0xFF00FFAA),
              duration: Duration(seconds: 1),
            ),
          );
        },
        backgroundColor: const Color(0xFF00FFAA),
        child: const Icon(Icons.add_alert, color: Colors.black),
      ),
    );
  }

  Widget _buildCard(BuildContext context, NotificationItem n, NotificationProvider provider) {
    late IconData icon;
    late Color color;
    switch (n.category) {
      case NotificationCategory.theft:
        icon = Icons.warning_amber_rounded;
        color = const Color(0xFFFF453A);
        break;
      case NotificationCategory.geoFence:
        icon = Icons.fence;
        color = const Color(0xFF00D4FF);
        break;
      case NotificationCategory.system:
        icon = Icons.system_update_alt;
        color = const Color(0xFF00FFAA);
        break;
    }

    return Dismissible(
      key: Key(n.id),
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
      onDismissed: (_) => provider.markRead(n.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: !n.isRead ? Border.all(color: const Color(0xFF00FFAA).withOpacity(0.7), width: 1.2) : null,
        ),
        child: ListTile(
          onTap: () => _showDetails(context, n, provider),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.3), color.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  n.title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16),
                ),
              ),
              if (!n.isRead)
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
              Text(n.description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 6),
              Text(_timeAgo(n.timestamp), style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          trailing: !n.isRead
              ? IconButton(
                  icon: const Icon(Icons.check_circle_outline, color: Color(0xFF00FFAA), size: 22),
                  onPressed: () => provider.markRead(n.id),
                )
              : null,
        ),
      ),
    );
  }
}