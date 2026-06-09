import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = Colors.greenAccent.shade400;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RideLockr - Home',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF0F1113),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Color(0xFF00C853)),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04;
    final verticalGap = size.height * 0.014;
    final safeCardRadius = size.width < 380 ? 10.0 : 12.0;
    final titleSize = size.width < 380 ? 18.0 : 20.0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: ListView(
            children: [
              SizedBox(height: verticalGap * 0.6),
              _buildHeader(context, titleSize),
              SizedBox(height: verticalGap),
              _buildVehicleCard(context, safeCardRadius),
              SizedBox(height: verticalGap),
              _buildStatsRow(context),
              SizedBox(height: verticalGap),
              _buildQuickActions(context),
              SizedBox(height: verticalGap * 1.15),
              _buildRecentAlerts(context),
              SizedBox(height: size.height * 0.08),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 0;
          });
        },
        child: const Icon(Icons.lock),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF0B0C0D),
        shape: const CircularNotchedRectangle(),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 66,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    label: 'Home',
                    icon: Icons.home,
                    active: _selectedIndex == 0,
                    onTap: () => setState(() => _selectedIndex = 0),
                  ),
                  _NavItem(
                    label: 'Track',
                    icon: Icons.location_on,
                    active: _selectedIndex == 1,
                    onTap: () => setState(() => _selectedIndex = 1),
                  ),
                  SizedBox(width: size.width * 0.13),
                  _NavItem(
                    label: 'Alert',
                    icon: Icons.notifications,
                    active: _selectedIndex == 2,
                    onTap: () => setState(() => _selectedIndex = 2),
                  ),
                  _NavItem(
                    label: 'Profile',
                    icon: Icons.person,
                    active: _selectedIndex == 3,
                    onTap: () => setState(() => _selectedIndex = 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double titleSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Good Morning, Ahmed 👋', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 4),
            Text('YOUR GARAGE', style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold)),
          ],
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white12,
          child: const Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildVehicleCard(BuildContext context, double radius) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131417),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('YAMAHA YBR 125G', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 6),
                  Text('LHR-4821', style: TextStyle(color: Colors.white70)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF062B11),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('LOCKED', style: TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: Center(
              child: Container(
                height: 12,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(alignment: Alignment.centerLeft, child: Container(width: 40, height: 12, color: const Color(0xFF00E676))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatCard(label: 'FUEL', value: '78%'),
        _StatCard(label: 'BATTERY', value: '92%'),
        _StatCard(label: 'ENGINE', value: '68°C'),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('QUICK ACTIONS', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Row(
          children: const [
            _ActionBox(icon: Icons.directions_bike, label: 'Bike Status'),
            SizedBox(width: 12),
            _ActionBox(icon: Icons.map, label: 'Geo-Fence'),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentAlerts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('RECENT ALERTS', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('View all →', style: TextStyle(color: Colors.greenAccent)),
          ],
        ),
        const SizedBox(height: 8),
        const _AlertRow(color: Colors.redAccent, text: 'Motion detected near bike', time: '2m ago'),
        const SizedBox(height: 8),
        const _AlertRow(color: Colors.orangeAccent, text: 'Left Geo-fence boundary', time: '1h ago'),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFF131418), borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _ActionBox extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionBox({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 72,
        decoration: BoxDecoration(color: const Color(0xFF141516), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.greenAccent, size: 28),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  final Color color;
  final String text;
  final String time;
  const _AlertRow({required this.color, required this.text, required this.time});

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

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.icon, required this.onTap, this.active = false});

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

