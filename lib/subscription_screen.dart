import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isMonthly = true;
  int selectedPlan = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Subscription plan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              const Text(
                "Choose the best plan that fits your needs",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 24),

              // Monthly / Yearly Toggle
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF101523),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMonthly = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isMonthly
                                ? const Color(0xFF33D17A)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                              color: isMonthly
                                  ? Colors.white
                                  : Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMonthly = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isMonthly
                                ? const Color(0xFF33D17A)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Yearly",
                                style: TextStyle(
                                  color: !isMonthly
                                      ? Colors.white
                                      : Colors.grey.shade400,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0x2600E676),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Saves 20%",
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [
                    SubscriptionCard(
                      title: "Basic",
                      price: "PKR.599",
                      selected: selectedPlan == 0,
                      icon: Icons.electric_scooter,
                      features: const [
                        "Real-time Tracking",
                        "Geo-fence Alerts",
                        "History (7 days)",
                        "Email support",
                      ],
                      onTap: () {
                        setState(() {
                          selectedPlan = 0;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    SubscriptionCard(
                      title: "Pro",
                      price: "PKR.1999",
                      selected: selectedPlan == 1,
                      isPopular: true,
                      icon: Icons.shield,
                      features: const [
                        "All Basic Features",
                        "Live Traffic Updates",
                        "History (30 days)",
                        "Priority Support",
                        "Multiple Alerts",
                      ],
                      onTap: () {
                        setState(() {
                          selectedPlan = 1;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    SubscriptionCard(
                      title: "Fleet",
                      price: "PKR.2499",
                      selected: selectedPlan == 2,
                      icon: Icons.groups,
                      features: const [
                        "All Pro Features",
                        "Unlimited Vehicles",
                        "History (90 days)",
                        "Dedicated account Manager",
                      ],
                      onTap: () {
                        setState(() {
                          selectedPlan = 2;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33D17A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool selected;
  final bool isPopular;
  final IconData icon;
  final VoidCallback onTap;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.features,
    required this.selected,
    required this.icon,
    required this.onTap,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0E1321),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected
                    ? const Color(0xFF33D17A)
                    : Colors.white12,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFF1B2336),
                  child: Icon(icon, color: Colors.blueAccent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...features.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check,
                                size: 15,
                                color: Color(0xFF33D17A),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                e,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "/month",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF33D17A)
                              : Colors.white54,
                          width: 2,
                        ),
                      ),
                      child: selected
                          ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF33D17A),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isPopular)
          Positioned(
            top: -10,
            left: 35,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF33D17A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.star, size: 12, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    "Most Popular",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}