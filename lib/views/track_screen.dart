import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  bool _isLiveLocation = false;

  void _toggleLiveLocation() {
    setState(() {
      _isLiveLocation = !_isLiveLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C0D),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1B1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'LIVE TRACKING',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  // Live Location toggle button
                  GestureDetector(
                    onTap: _toggleLiveLocation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _isLiveLocation
                                ? const Color(0xFF003D80)
                                : const Color(0xFF1A1B1E),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              _isLiveLocation
                                  ? const Color(0xFF4DA6FF)
                                  : Colors.white24,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color:
                                _isLiveLocation
                                    ? const Color(0xFF4DA6FF)
                                    : Colors.white54,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Live Location',
                            style: TextStyle(
                              color:
                                  _isLiveLocation
                                      ? const Color(0xFF4DA6FF)
                                      : Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Location bar ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF131417),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFFFF453A),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isLiveLocation
                          ? 'Showing Live Location'
                          : 'Faisal Town, Lahore',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    if (!_isLiveLocation) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Updated just now',
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ── Map area ─────────────────────────────────────────
            Expanded(
              child: Stack(
                children: [
                  // Map background (dark grid style like Figma)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xFF0D1520),
                    child: CustomPaint(painter: _MapGridPainter()),
                  ),

                  // PARK circle
                  Positioned(
                    left: size.width * 0.36,
                    top: size.height * 0.22,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white24,
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'PARK',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bike marker (green pulsing dot with label)
                  Positioned(
                    left: _isLiveLocation ? size.width * 0.58 : size.width * 0.32,
                    top: _isLiveLocation ? size.height * 0.09 : size.height * 0.08,
                    child: _BikeMarker(isLive: _isLiveLocation),
                  ),

                  // Zoom controls (visible when live)
                  if (_isLiveLocation)
                    Positioned(
                      right: 16,
                      top: size.height * 0.15,
                      child: Column(
                        children: [
                          _MapButton(
                            icon: Icons.add,
                            onTap: () {},
                          ),
                          const SizedBox(height: 6),
                          _MapButton(
                            icon: Icons.remove,
                            onTap: () {},
                          ),
                          const SizedBox(height: 6),
                          _MapButton(
                            icon: Icons.explore_outlined,
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  else
                    // Compass button
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: _MapButton(
                        icon: Icons.explore_outlined,
                        onTap: () {},
                      ),
                    ),
                ],
              ),
            ),

            // ── Stats card ───────────────────────────────────────
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF131417),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  // Speed display
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '0',
                        style: TextStyle(
                          color: Color(0xFF00E676),
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'km/h · PARKED',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 20),
                  Container(width: 1, height: 50, color: Colors.white12),
                  const SizedBox(width: 20),

                  // Coordinates
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _CoordRow(label: 'LAT', value: '31.5204°'),
                      SizedBox(height: 6),
                      _CoordRow(label: 'LNG', value: '74.3587°'),
                      SizedBox(height: 6),
                      _CoordRow(label: 'ALT', value: '217 m'),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom padding for FAB
            const SizedBox(height: 80),
          ],
        ),
      ),

      // Lock FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00E676),
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.lock, color: Colors.black, size: 22),
            SizedBox(height: 2),
            Text(
              'Lock',
              style: TextStyle(
                color: Colors.black,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom nav
      bottomNavigationBar: _TrackBottomNav(),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Bottom Navigation (Track tab active)
// ─────────────────────────────────────────────────────────────
class _TrackBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF0B0C0D),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BottomNavItem(
                  label: 'Home',
                  icon: Icons.home_rounded,
                  active: false,
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.home,
                  ),
                ),
                _BottomNavItem(
                  label: 'Track',
                  icon: Icons.location_on,
                  active: true,
                  onTap: () {},
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.13),
                _BottomNavItem(
                  label: 'Alert',
                  icon: Icons.notifications_outlined,
                  active: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.alerts),
                ),
                _BottomNavItem(
                  label: 'Profile',
                  icon: Icons.person_outline,
                  active: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF00E676) : Colors.white38;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (active)
              Container(
                margin: const EdgeInsets.only(top: 3),
                width: 18,
                height: 2,
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Bike marker with green pulsing dot
// ─────────────────────────────────────────────────────────────
class _BikeMarker extends StatefulWidget {
  final bool isLive;
  const _BikeMarker({required this.isLive});

  @override
  State<_BikeMarker> createState() => _BikeMarkerState();
}

class _BikeMarkerState extends State<_BikeMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _pulse = Tween<double>(begin: 0.8, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer pulse ring
            AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) => Transform.scale(
                scale: _pulse.value,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00E676).withOpacity(0.12),
                  ),
                ),
              ),
            ),
            // Inner green circle with bike icon
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF00E676),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.two_wheeler,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // LHR-4821 label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF00E676),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'LHR-4821',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Small map control button
// ─────────────────────────────────────────────────────────────
class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1D24).withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white12),
        ),
        child: Icon(icon, color: Colors.white70, size: 18),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Coordinate row widget
// ─────────────────────────────────────────────────────────────
class _CoordRow extends StatelessWidget {
  final String label;
  final String value;

  const _CoordRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 32,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Custom painter for dark map grid
// ─────────────────────────────────────────────────────────────
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()..color = const Color(0xFF1A2535);
    final blockPaint = Paint()..color = const Color(0xFF111B28);

    // Draw horizontal roads
    for (double y = 0; y < size.height; y += size.height / 5) {
      canvas.drawRect(
        Rect.fromLTWH(0, y + 30, size.width, 28),
        roadPaint,
      );
    }

    // Draw vertical roads
    for (double x = 0; x < size.width; x += size.width / 3) {
      canvas.drawRect(
        Rect.fromLTWH(x + 20, 0, 28, size.height),
        roadPaint,
      );
    }

    // Draw some building blocks
    final blocks = [
      Rect.fromLTWH(5, 5, 60, 55),
      Rect.fromLTWH(80, 5, 55, 55),
      Rect.fromLTWH(size.width - 80, 5, 60, 55),
      Rect.fromLTWH(5, 80, 55, 60),
      Rect.fromLTWH(5, size.height * 0.45, 60, 60),
      Rect.fromLTWH(size.width - 85, size.height * 0.45, 60, 60),
      Rect.fromLTWH(80, size.height * 0.45, 55, 60),
      Rect.fromLTWH(5, size.height * 0.65, 55, 55),
      Rect.fromLTWH(size.width - 80, size.height * 0.65, 60, 55),
    ];

    for (final block in blocks) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(block, const Radius.circular(4)),
        blockPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
