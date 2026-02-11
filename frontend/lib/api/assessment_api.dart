import 'dart:convert';
import 'package:http/http.dart' as http;

class AssessmentApi {
    static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> assess(List<String> symptoms) async {
    final res = await http.post(
      Uri.parse("$baseUrl/assessment/ask"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"symptoms": symptoms}),
    );

    if (res.statusCode != 200) {
      throw Exception("Assessment failed");
    }

    return jsonDecode(res.body);
  }

}
