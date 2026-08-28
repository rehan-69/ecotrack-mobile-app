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
      // await Future.delayed(const Duration(seconds: 3));
      homeData = await _homeService.getHomeData();

      debugPrint("========== HOME DATA ==========");
      debugPrint("User: ${homeData?.user.name}");
      debugPrint("Total: ${homeData?.overview.total}");
      debugPrint("Pending: ${homeData?.overview.pending}");
      debugPrint("Completed: ${homeData?.overview.completed}");

      debugPrint(
        "Recent Complaints Count: ${homeData?.recentComplaints.length}",
      );

      for (final complaint in homeData?.recentComplaints ?? []) {
        debugPrint("Complaint ID: ${complaint.complaintId}");
        debugPrint("Waste Type: ${complaint.wasteType}");
        debugPrint("Location: ${complaint.location}");
        debugPrint("Status: ${complaint.status}");
      }
    } catch (e) {
      errorMessage = e.toString();

      debugPrint("Home API Error: $e");
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}