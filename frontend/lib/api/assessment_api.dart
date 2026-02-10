import 'dart:convert';
import 'package:http/http.dart' as http;

class AssessmentApi {
    static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> assess({
    required int age,
    required String gender,
    required List<String> symptoms,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/assessment/ask"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "age": age,
        "gender": gender,
        "symptoms": symptoms,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "API Error ${response.statusCode}: ${response.body}",
      );
    }

    return jsonDecode(response.body);
  }
}
