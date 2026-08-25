import 'package:flutter/material.dart';
import 'package:project/models/home_models.dart';

import 'package:project/services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  HomeModel? homeData;

  bool isLoading = false;

  String? errorMessage;

  Future<void> getHomeData() async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      homeData = await _homeService.getHomeData();
    } catch (e) {
      errorMessage = e.toString();

      debugPrint(
        "Home API Error: $e",
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}