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

    print('--- CREATE COMPLAINT REQUEST ---');
    print('Title: $title');
    print('Description: $description');
    print('Waste Type: $wasteType');
    print('Location: $location');
    print('Latitude: $latitude');
    print('Longitude: $longitude');
    print('Images: ${image?.length ?? 0}');
    print('Base URL: $baseUrl');

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
        print('Adding image: $imagePath');

        request.files.add(
          await http.MultipartFile.fromPath(
            'images',
            imagePath,
          ),
        );
      }
    }

    print('Sending request...');

    final streamedResponse = await request.send();

    print('Response received');

    final response = await http.Response.fromStream(
      streamedResponse,
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      print('Complaint created successfully');
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