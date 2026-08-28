import 'package:flutter/material.dart';
import 'package:project/services/complaint_service.dart';

class ComplaintProvider extends ChangeNotifier {
  final ComplaintService _complaintService = ComplaintService();

  bool isLoading = false;

  String? errorMessage;

  Future<void> createComplaint({
    required String complaintId,
    String? image,
    required String title,
    required String wasteType,
    required String location,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
     await _complaintService.createComplaint(
        complaintId: complaintId,
        image: image,
        title: title,
        wasteType: wasteType,
        location: location,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
