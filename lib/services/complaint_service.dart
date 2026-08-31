import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintService {
  final String baseUrl = 'http://127.0.0.1:3000';

  Future<void> createComplaint({
    required String description,
    List<String>? image,
    required String title,
    required String wasteType,
    required String location,
    required double latitude,
    required double longitude,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('jwt_token');

    if (token == null || token.isEmpty) {
      throw Exception('JWT token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/complaints'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "description": description,
        "image": image,
        "title": title,
        "wasteType": wasteType,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
      }),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return;
    }

    if (response.statusCode == 401) {
      throw Exception(data['message'] ?? 'Session expired. Please login again');
    }

    throw Exception(data['message'] ?? 'Failed to create complaint');
  }
}
