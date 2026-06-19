import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/views/profile_screen.dart';
import '../providers/home_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/action_box.dart';
import '../widgets/alert_row.dart';
import '../widgets/nav_item.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<HomeProvider>().selectedIndex;
    final homeProvider = context.read<HomeProvider>();
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
        onPressed: homeProvider.resetToHome,
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
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding * 0.85,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavItem(
                    label: 'Home',
                    icon: Icons.home_rounded,
                    active: selectedIndex == 0,
                    onTap: () => homeProvider.setSelectedIndex(0),
                  ),
                  NavItem(
                    label: 'Track',
                    icon: Icons.location_on,
                    active: selectedIndex == 1,
                    onTap: () {
                      homeProvider.setSelectedIndex(1);
                      Navigator.pushNamed(context, AppRoutes.track).then((_) {
                        homeProvider.resetToHome();
                      });
                    },
                  ),
                  SizedBox(width: size.width * 0.13),
                  NavItem(
                    label: 'Alert',
                    icon: Icons.notifications_outlined,
                    active: selectedIndex == 2,
                    onTap: () {
                      homeProvider.setSelectedIndex(2);
                      Navigator.pushNamed(context, AppRoutes.alerts).then((_) {
                        homeProvider.resetToHome();
                      });
                    },
                  ),
                  NavItem(
                    label: 'Profile',
                    icon: Icons.person_outline,
                    active: selectedIndex == 3,

                    onTap: () {
                      homeProvider.setSelectedIndex(3);
                      Navigator.pushNamed(context, AppRoutes.profile).then((_) {
                        homeProvider.resetToHome();
                      });
                    },
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
            const Text(
              'Good Morning, Ahmed 👋',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              'YOUR GARAGE',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                  Text(
                    'YAMAHA YBR 125G',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text('LHR-4821', style: TextStyle(color: Colors.white70)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF062B11),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'LOCKED',
                  style: TextStyle(
                    color: Color(0xFF00E676),
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 40,
                    height: 12,
                    color: const Color(0xFF00E676),
                  ),
                ),
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
        StatCard(label: 'FUEL', value: '78%'),
        StatCard(label: 'BATTERY', value: '92%'),
        StatCard(label: 'ENGINE', value: '68°C'),
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
            ActionBox(icon: Icons.directions_bike, label: 'Bike Status'),
            SizedBox(width: 12),
            ActionBox(icon: Icons.map, label: 'Geo-Fence'),
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
            Text(
              'RECENT ALERTS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('View all →', style: TextStyle(color: Colors.greenAccent)),
          ],
        ),
        const SizedBox(height: 8),
        const AlertRow(
          color: Colors.redAccent,
          icon: Icons.notifications_active,
          text: 'Motion detected near bike',
          time: '2m ago',
        ),
        const SizedBox(height: 8),
        const AlertRow(
          color: Colors.orangeAccent,
          icon: Icons.fence,
          text: 'Left Geo-fence boundary',
          time: '1h ago',
        ),
      ],
    );
  }
}
