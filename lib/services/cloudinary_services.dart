import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const String cloudName = "dlutyuvdq";
  static const String uploadPreset = "ride_locker_preset";

  static Future<String?> uploadImage(Uint8List bytes) async {
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(
        http.MultipartFile.fromBytes("file", bytes, filename: "profile.jpg"),
      );

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = json.decode(res.body);
      return data["secure_url"];
    }

    return null;
  }
}
