import 'dart:convert';
import 'package:http/http.dart' as http;

class PinguService {
  Future<String?> pinguCall({
    required String prompt,
    required String content,
  }) async {
    try {
      final url = Uri.parse(
          'https://ominous-space-cod-7gx7pq4g5q3x69-5000.app.github.dev/pingu');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': prompt,
          'content': content,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] as String?;
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
