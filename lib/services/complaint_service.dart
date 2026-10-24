import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/home_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintService {
  final String baseUrl = "https://ecotrack-mobile-backend.onrender.com";

  // createComplaint method to create a new complaint

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
          await http.MultipartFile.fromPath('images', imagePath),
        );
      }
    }

    print('Sending request...');

    final streamedResponse = await request.send();

    print('Response received');

    final response = await http.Response.fromStream(streamedResponse);

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      print('Complaint created successfully');
      return;
    }

    if (response.statusCode == 401) {
      throw Exception(data['message'] ?? 'Session expired. Please login again');
    }

    throw Exception(data['message'] ?? 'Failed to create complaint');
  }

  // getMyComplaints method to fetch complaints for the Logged-in user

  Future<List<RecentComplaint>> getMyComplaints() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('jwt_token');

    if (token == null || token.isEmpty) {
      throw Exception('JWT token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/complaints/my'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print('--- GET MY COMPLAINTS ---');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return (data['complaints'] as List)
          .map((item) => RecentComplaint.fromJson(item))
          .toList();
    }

    if (response.statusCode == 401) {
      throw Exception(data['message'] ?? 'Session expired. Please login again');
    }

    throw Exception(data['message'] ?? 'Failed to fetch complaints');
  }

  Future<List<String>> getWasteTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/waste-types'));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return List<String>.from(
        (data['wasteTypes'] as List).map((item) => item['name'].toString()),
      );
    }

    throw Exception(data['message'] ?? 'Failed to fetch waste types');
  }

  Future<RecentComplaint> getComplaintById(int id) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('jwt_token');

    if (token == null || token.isEmpty) {
      throw Exception('JWT token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/complaints/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print('--- GET COMPLAINT DETAIL ---');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final complaint = Map<String, dynamic>.from(data['complaint']);

      complaint['statusHistory'] = data['statusHistory'] ?? [];

      return RecentComplaint.fromJson(complaint);
    }

    if (response.statusCode == 401) {
      throw Exception(data['message'] ?? 'Session expired. Please login again');
    }

    throw Exception(data['message'] ?? 'Failed to fetch complaint details');
  }
}
