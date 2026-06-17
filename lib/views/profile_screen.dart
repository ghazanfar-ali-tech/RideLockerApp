import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_profile_screen.dart';
import 'app_preferences_screen.dart';
import 'helpsupport_screen.dart';
import 'subscription_screen.dart';
=======
import 'package:ride_locker_app/views/app_preferences_screen.dart';
import 'package:ride_locker_app/views/edit_profile_screen.dart';
import 'package:ride_locker_app/views/helpsupport_screen.dart';
import 'package:ride_locker_app/views/subscription_screen.dart';
import 'package:ride_locker_app/routes/app_routes.dart';
>>>>>>> origin/hamza_wasiq

class BikeProvider with ChangeNotifier {
  final List<Map<String, dynamic>> bikes = [
    {
      "name": "Bike Name",
      "plate": "",
      "battery": "85%",
      "signal": "STRONG",
      "status": "LIVE",
    },
    {
      "name": "Bike Name",
      "plate": "",
      "battery": "85%",
      "signal": "STRONG",
      "status": "Secured",
    },
  ];
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final bikeProvider = Provider.of<BikeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ================= PROFILE STREAM =================
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: getUserStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: Colors.green);
                  }

                  if (!snapshot.hasData || snapshot.data?.data() == null) {
                    return const CircleAvatar(radius: 55);
                  }

                  final data = snapshot.data!.data()!;

                  final imageUrl = (data['imageUrl'] ?? '').toString();
                  final name = (data['name'] ?? 'No Name').toString();
                  final email = (data['email'] ?? '').toString();
                  final phone = (data['phone'] ?? '').toString();

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null,
                        child: imageUrl.isEmpty
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),

                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "PRO",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(email, style: const TextStyle(color: Colors.grey)),

                      const SizedBox(height: 5),

                      Text(phone, style: const TextStyle(color: Colors.grey)),
                    ],
                  );
                },
              ),

              const SizedBox(height: 25),

              // ================= EDIT BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff39E58C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.editProfile,
                    );
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // ================= BIKE SECTION =================
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Linked Bikes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "ADD NEW",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bikeProvider.bikes.length,
                itemBuilder: (context, index) {
                  final bike = bikeProvider.bikes[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xff111111),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.pedal_bike,
                            color: Colors.greenAccent,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bike["name"] ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Plate:",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.battery_full,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    bike["battery"] ?? "",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(width: 15),
                                  const Icon(Icons.wifi, color: Colors.grey),
                                  Text(
                                    bike["signal"] ?? "",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            bike["status"] ?? "",
                            style: TextStyle(
                              color: bike["status"] == "LIVE"
                                  ? Colors.blue
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // ================= MENU =================
              buildMenuTile(
                Icons.settings,
                "App Preferences",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.appPreferences,
                  );
                },
              ),

              buildMenuTile(
                Icons.help_outline,
                "Help & Support",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.helpSupport,
                  );
                },
              ),

              buildMenuTile(
                Icons.subscriptions,
                "Subscriptions",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.subscription,
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuTile(
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: const Color(0xff111111),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.grey),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 18,
          ),
        ),
      ),
    );
  }
}
