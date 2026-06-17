import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/providers/auth_providers/login_provider.dart';

class AppPreferencesScreen extends StatefulWidget {
  const AppPreferencesScreen({super.key});

  @override
  State<AppPreferencesScreen> createState() => _AppPreferencesScreenState();
}

class _AppPreferencesScreenState extends State<AppPreferencesScreen> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool darkMode = true;
  bool locationTracking = true;
  bool autoLock = true;
  bool soundAlerts = true;
  bool vibration = true;
  bool dataSync = true;
  String selectedLanguage = "English";
  String selectedUnit = "Kilometers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "App Preferences",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// ── NOTIFICATIONS SECTION ──
            _sectionHeader("Notifications"),
            const SizedBox(height: 12),

            _switchTile(
              icon: Icons.notifications_active_outlined,
              title: "Push Notifications",
              subtitle: "Receive alerts on your device",
              value: pushNotifications,
              onChanged: (val) {
                setState(() {
                  pushNotifications = val;
                });
              },
            ),

            _switchTile(
              icon: Icons.email_outlined,
              title: "Email Notifications",
              subtitle: "Receive updates via email",
              value: emailNotifications,
              onChanged: (val) {
                setState(() {
                  emailNotifications = val;
                });
              },
            ),

            _switchTile(
              icon: Icons.volume_up_outlined,
              title: "Sound Alerts",
              subtitle: "Play sound on alerts",
              value: soundAlerts,
              onChanged: (val) {
                setState(() {
                  soundAlerts = val;
                });
              },
            ),

            _switchTile(
              icon: Icons.vibration,
              title: "Vibration",
              subtitle: "Vibrate on notifications",
              value: vibration,
              onChanged: (val) {
                setState(() {
                  vibration = val;
                });
              },
            ),

            const SizedBox(height: 25),

            /// ── TRACKING SECTION ──
            _sectionHeader("Tracking & Security"),
            const SizedBox(height: 12),

            _switchTile(
              icon: Icons.location_on_outlined,
              title: "Location Tracking",
              subtitle: "Enable real-time GPS tracking",
              value: locationTracking,
              onChanged: (val) {
                setState(() {
                  locationTracking = val;
                });
              },
            ),

            _switchTile(
              icon: Icons.lock_outline,
              title: "Auto-Lock",
              subtitle: "Lock bike when out of range",
              value: autoLock,
              onChanged: (val) {
                setState(() {
                  autoLock = val;
                });
              },
            ),

            _switchTile(
              icon: Icons.sync_outlined,
              title: "Data Sync",
              subtitle: "Auto sync data to cloud",
              value: dataSync,
              onChanged: (val) {
                setState(() {
                  dataSync = val;
                });
              },
            ),

            const SizedBox(height: 25),

            /// ── GENERAL SECTION ──
            _sectionHeader("General"),
            const SizedBox(height: 12),

            _dropdownTile(
              icon: Icons.language,
              title: "Language",
              value: selectedLanguage,
              items: const ["English", "Urdu", "Arabic", "Spanish", "French"],
              onChanged: (val) {
                setState(() {
                  selectedLanguage = val!;
                });
              },
            ),

            const SizedBox(height: 12),

            _dropdownTile(
              icon: Icons.speed,
              title: "Distance Unit",
              value: selectedUnit,
              items: const ["Kilometers", "Miles"],
              onChanged: (val) {
                setState(() {
                  selectedUnit = val!;
                });
              },
            ),

            const SizedBox(height: 12),

            _switchTile(
              icon: Icons.dark_mode_outlined,
              title: "Dark Mode",
              subtitle: "Use dark theme",
              value: darkMode,
              onChanged: (val) {
                setState(() {
                  darkMode = val;
                });
              },
            ),

            const SizedBox(height: 25),

            /// ── DANGER ZONE ──
            _sectionHeader("Danger Zone"),
            const SizedBox(height: 12),

            _actionTile(
              icon: Icons.delete_outline,
              title: "Clear Cache",
              subtitle: "Free up storage space",
              iconColor: Colors.orange,
              onTap: () {
                _showConfirmDialog(
                  title: "Clear Cache",
                  message: "Are you sure you want to clear all cached data?",
                  onConfirm: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cache cleared successfully"),
                        backgroundColor: Color(0xff39E58C),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 12),

            _actionTile(
              icon: Icons.restart_alt,
              title: "Reset Preferences",
              subtitle: "Restore default settings",
              iconColor: Colors.redAccent,
              onTap: () {
                _showConfirmDialog(
                  title: "Reset Preferences",
                  message:
                      "This will restore all settings to default. Continue?",
                  onConfirm: () {
                    setState(() {
                      pushNotifications = true;
                      emailNotifications = false;
                      darkMode = true;
                      locationTracking = true;
                      autoLock = true;
                      soundAlerts = true;
                      vibration = true;
                      dataSync = true;
                      selectedLanguage = "English";
                      selectedUnit = "Kilometers";
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Preferences reset to default"),
                        backgroundColor: Color(0xff39E58C),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 12),

            _actionTile(
              icon: Icons.logout,
              title: "Log Out",
              subtitle: "Sign out from your account",
              iconColor: Colors.redAccent,
              onTap: () {
                _showConfirmDialog(
                  title: "Log Out",
                  message: "Are you sure you want to log out?",
                  onConfirm: () {
                    Provider.of<LoginProvider>(
                      context,
                      listen: false,
                    ).logout(context);
                  },
                );
              },
            ),

            const SizedBox(height: 30),

            /// ── APP VERSION ──
            const Center(
              child: Text(
                "RideLocker v1.0.0",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// ── SECTION HEADER ──
  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xff39E58C),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// ── SWITCH TILE ──
  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff111111),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.grey, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xff39E58C),
            activeTrackColor: const Color(0xff39E58C).withValues(alpha: 0.3),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  /// ── DROPDOWN TILE ──
  Widget _dropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff111111),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.grey, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                dropdownColor: const Color(0xff1E1E1E),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                items: items
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ── ACTION TILE ──
  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xff111111),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  /// ── CONFIRM DIALOG ──
  void _showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message, style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff39E58C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onConfirm,
            child: const Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
