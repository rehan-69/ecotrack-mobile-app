import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/home_models.dart';
import 'package:project/services/complaint_service.dart';

class ComplaintProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final ComplaintService _complaintService = ComplaintService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  String? selectedWaste;
  List<XFile> selectedImages = [];
  double? latitude;
  double? longitude;
  String? selectedLocation;
  String? selectedWard;
  String camera = 'Camera';
  String selectedFilter = 'All';
  bool myComplaintsLoaded = false;

  //My Complaint Variables
  List<RecentComplaint> searchSource = [];
  List<RecentComplaint> filteredComplaints = [];

  Future<bool> createComplaint({
    required String description,
    List<String>? image,
    required String title,
    required String wasteType,
    required String location,
    required double latitude,
    required double longitude,
  }) async {
    print('CREATE COMPLAINT STARTED');
    print('Title: $title');
    print('Waste Type: $wasteType');
    print('Location: $location');
    print('Latitude: $latitude');
    print('Longitude: $longitude');
    print('Images: ${image?.length ?? 0}');

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _complaintService.createComplaint(
        description: description,
        image: image,
        title: title,
        wasteType: wasteType,
        location: location,
        latitude: latitude,
        longitude: longitude,
      );

      print('CREATE COMPLAINT SUCCESS');
      return true;
    } catch (e) {
      print('CREATE COMPLAINT ERROR: $e');
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMyComplaints() async {
    if (myComplaintsLoaded) return;

    myComplaintsLoaded = true;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final complaints = await _complaintService.getMyComplaints();

      searchSource = complaints;
      filteredComplaints = complaints;

      print('MY COMPLAINTS COUNT: ${complaints.length}');
    } catch (e) {
      print('GET MY COMPLAINTS ERROR: $e');
      errorMessage = e.toString();
      myComplaintsLoaded = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectCameraFeature(String feature) {
    camera = feature;
    notifyListeners();
  }

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
    print('LOCATION BUTTON CLICKED');

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    print('Location service: $serviceEnabled');

    if (!serviceEnabled) {
      errorMessage = 'Please turn on location service';
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    print('Permission before request: $permission');

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    print('Permission after request: $permission');

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

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');

      latitude = position.latitude;
      longitude = position.longitude;

      final geocoding = Geocoding();

      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        print('--- GEOCODING RESULT ---');
        print('Name: ${place.name}');
        print('Street: ${place.street}');
        print('SubLocality: ${place.subLocality}');
        print('Locality: ${place.locality}');
        print('SubAdministrativeArea: ${place.subAdministrativeArea}');
        print('AdministrativeArea: ${place.administrativeArea}');
        print('PostalCode: ${place.postalCode}');
        print('Country: ${place.country}');

        selectedLocation = [
          place.subLocality,
          place.locality,
        ].where((e) => e != null && e.isNotEmpty).join(', ');

        print('Selected Location: $selectedLocation');
      }

      notifyListeners();
    } catch (e) {
      print('LOCATION ERROR: $e');

      errorMessage = 'Unable to get current location';
      notifyListeners();
    }
  }

  //My Complaint Functions
  void setSearchSource(List<RecentComplaint> complaints) {
    searchSource = complaints;
    filteredComplaints = complaints;
  }

  void searchComplaints() {
    filteredComplaints = searchSource
        .where(
          (complaint) =>
              complaint.complaintId.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ) ||
              complaint.wasteType.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ),
        )
        .toList();

    notifyListeners();
  }

  void selectFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void filterComplaintsByStatus() {
    if (selectedFilter == 'All') {
      filteredComplaints = searchSource;
    } else if (selectedFilter == 'Pending') {
      filteredComplaints = searchSource
          .where((complaint) => complaint.status == 'Pending')
          .toList();
    } else if (selectedFilter == 'In Progress') {
      filteredComplaints = searchSource
          .where((complaint) => complaint.status == 'In Progress')
          .toList();
    } else if (selectedFilter == 'Completed') {
      filteredComplaints = searchSource
          .where((complaint) => complaint.status == 'Completed')
          .toList();
    }
    notifyListeners();
  }

  void clearReportDetailed() {
    selectedImages.clear();
    titleController.clear();
    descriptionController.clear();
    selectedWaste = null;
    selectedLocation = null;
    latitude = null;
    longitude = null;
    notifyListeners();
  }
}
