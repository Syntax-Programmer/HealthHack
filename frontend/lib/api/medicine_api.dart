import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class MedicineApi {
  static const String _baseUrl = "http://localhost:8000";

  static Future<Map<String, dynamic>> analyze(File image) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$_baseUrl/medicine/analyze"),
    );

    request.files.add(
      await http.MultipartFile.fromPath("image", image.path),
    );

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception("Medicine analysis failed");
    }

    return jsonDecode(body);
  }
}
