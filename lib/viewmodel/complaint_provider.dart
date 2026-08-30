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
  List<XFile> selectedImages = [];

  Future<void> createComplaint({
    required String complaintId,
    required String description,
    List<String>? image,
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

  Future<void> retrieveLostImage() async {
    final response = await _picker.retrieveLostData();

    if (response.isEmpty) {
      return;
    }

    if (response.files != null) {
      selectedImages.addAll(response.files!);
      notifyListeners();
    } else if (response.exception != null) {
      errorMessage = response.exception.toString();
      notifyListeners();
    }
  }

  // Future<void> pickImageFromCamera() async {
  //   try {
  //     final image = await _picker.pickImage(source: ImageSource.camera);

  //     if (image != null) {
  //       selectedImages.add(image);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     notifyListeners();
  //   }
  // }

  Future<void> pickImageFromCamera() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1280,
        maxHeight: 1280,
      );

      if (image != null) {
        selectedImages.add(image);
        notifyListeners();
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> pickImageFromGallery() async {
    final images = await _picker.pickMultiImage();

    if (images.isNotEmpty) {
      selectedImages.addAll(images);
      notifyListeners();
    }
  }
}
