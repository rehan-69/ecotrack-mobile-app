import 'package:flutter/material.dart';
import 'package:project/services/complaint_service.dart';

class ComplaintProvider extends ChangeNotifier {
  final ComplaintService _complaintService = ComplaintService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  String? selectedWaste;

  Future<void> createComplaint({
    required String complaintId,
    required String description,
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
        description: description,
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
