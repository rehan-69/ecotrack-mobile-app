import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  double? latitude;
  double? longitude;
  String? selectedLocation;

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

  //  Future<void> retrieveLostImage() async {
  //   final response = await _picker.retrieveLostData();

  //   if (response.files != null) {
  //     selectedImages.addAll(response.files!);
  //     notifyListeners();
  //   }
  // }

  Future<void> pickImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      selectedImages.add(image);
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

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      errorMessage = 'Please turn on location service';
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      errorMessage = 'Location permission denied';
      notifyListeners();
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      errorMessage = 'Location permission permanently denied';
      notifyListeners();
      return;
    }

    final position = await Geolocator.getCurrentPosition();

    latitude = position.latitude;
    longitude = position.longitude;

    selectedLocation = '${position.latitude}, ${position.longitude}';

    notifyListeners();
  }
}
