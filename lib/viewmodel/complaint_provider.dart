import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/services/complaint_service.dart';

class ComplaintProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final ComplaintService _complaintService = ComplaintService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  String? selectedWaste;
  XFile? selectedImage;

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

  Future<void> pickImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      selectedImage = image;
      notifyListeners();
    }
  }
}
