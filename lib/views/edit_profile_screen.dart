import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ride_locker_app/services/cloudinary_services.dart';
import 'dart:typed_data';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Uint8List? imageBytes;
  String? uploadedImageUrl;

  final TextEditingController nameController = TextEditingController(
    text: "aiman",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "12345678900",
  );
  final TextEditingController emailController = TextEditingController(
    text: "abc@gmail.com",
  );

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  // ================= PICK IMAGE =================
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.first.bytes != null) {
      final bytes = result.files.first.bytes!;

      setState(() {
        imageBytes = bytes;
      });

      // Upload to Cloudinary
      String? imageUrl = await CloudinaryService.uploadImage(bytes);

      if (imageUrl != null) {
        uploadedImageUrl = imageUrl;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Image Uploaded")));
      }
    }
  }

  // ================= LOAD DATA =================
  void loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final data = doc.data();

    if (data != null) {
      nameController.text = data['name'] ?? '';
      phoneController.text = data['phone'] ?? '';
      emailController.text = data['email'] ?? '';
      uploadedImageUrl = data['imageUrl'];
    }
  }

  // ================= UI =================
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
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ================= PROFILE IMAGE =================
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffD9D9D9),
                      image: imageBytes != null
                          ? DecorationImage(
                              image: MemoryImage(imageBytes!),
                              fit: BoxFit.cover,
                            )
                          : uploadedImageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(uploadedImageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: (imageBytes == null && uploadedImageUrl == null)
                        ? const Icon(Icons.person, size: 80, color: Colors.grey)
                        : null,
                  ),

                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff39E58C),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= FIELDS =================
            customTextField(
              controller: nameController,
              hintText: "Full Name",
              icon: Icons.person,
            ),

            const SizedBox(height: 15),

            customTextField(
              controller: phoneController,
              hintText: "Phone",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 15),

            customTextField(
              controller: emailController,
              hintText: "Email",
              icon: Icons.email,
            ),

            const SizedBox(height: 40),

            // ================= SAVE BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff39E58C),
                ),
                onPressed: () async {
                  final uid = FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .set({
                        'name': nameController.text.trim(),
                        'phone': phoneController.text.trim(),
                        'email': emailController.text.trim(),
                        'imageUrl': uploadedImageUrl,
                      }, SetOptions(merge: true));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile Updated")),
                  );

                  Navigator.pop(context);
                },
                child: const Text("Save", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TEXT FIELD WIDGET =================
  Widget customTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xff1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
