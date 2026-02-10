import 'dart:convert';
import 'package:http/http.dart' as http;

class AssessmentApi {
  static const String _baseUrl = 'http://localhost:8000';

  static Future<Map<String, dynamic>> assessSymptoms(
      List<String> symptoms) async {
    final response = await http.post(
      Uri.parse('$_baseUrlap/assessment/ask'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'symptoms': symptoms,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Assessment failed');
    }

    return jsonDecode(response.body);
  }
}
