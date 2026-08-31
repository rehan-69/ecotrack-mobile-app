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

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/complaints'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['description'] = description;
    request.fields['title'] = title;
    request.fields['wasteType'] = wasteType;
    request.fields['location'] = location;
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();

    if (image != null) {
      for (final imagePath in image) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'images',
            imagePath,
          ),
        );
      }
    }

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(
      streamedResponse,
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return;
    }

    if (response.statusCode == 401) {
      throw Exception(
        data['message'] ??
            'Session expired. Please login again',
      );
    }

    throw Exception(
      data['message'] ??
          'Failed to create complaint',
    );
  }
}