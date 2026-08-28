import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/models/home_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  final String baseUrl = "http://127.0.0.1:3000";

  Future<HomeModel> getHomeData() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("jwt_token");

    if (token == null || token.isEmpty) {
      throw Exception("JWT token not found");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/home"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return HomeModel.fromJson(data);
    }

    if (response.statusCode == 401) {
      throw Exception(
        data["message"] ?? "Session expired. Please login again.",
      );
    }

    throw Exception(
      data["message"] ?? "Failed to load home data",
    );
  }
}