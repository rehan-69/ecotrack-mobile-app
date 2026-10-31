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
  bool isSubmittingComplaint = false;
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
  bool isLoadingMyComplaints = false;
  String? myComplaintsError;

  //My Complaint Variables
  List<RecentComplaint> searchSource = [];
  List<RecentComplaint> filteredComplaints = [];

  List<String> wasteTypes = [];
  bool wasteTypesLoaded = false;

  Future<bool> createComplaint({
    required String description,
    List<String>? image,
    required String title,
    required String wasteType,
    required String location,
    required double latitude,
    required double longitude,
  }) async {
    if (isSubmittingComplaint) {
      print('Duplicate submit blocked');
      return false;
    }

    isSubmittingComplaint = true;
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
      isSubmittingComplaint = false;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMyComplaints() async {
    if (isLoadingMyComplaints || myComplaintsLoaded) return;

    isLoadingMyComplaints = true;
    myComplaintsError = null;
    notifyListeners();

    try {
      final complaints = await _complaintService.getMyComplaints();

      searchSource = complaints;
      filteredComplaints = complaints;

      // API successfully loaded
      myComplaintsLoaded = true;

      print('MY COMPLAINTS COUNT: ${complaints.length}');
    } catch (e) {
      print('GET MY COMPLAINTS ERROR: $e');
      myComplaintsError = e.toString();
    } finally {
      isLoadingMyComplaints = false;
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

    errorMessage = null;
    notifyListeners();

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        errorMessage = 'Please turn on location service';
        return;
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        errorMessage = 'Location permission denied';
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 12),
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      // Set a fallback immediately so the form has a location.
      selectedLocation = 'Current Location';

      try {
        final geocoding = Geocoding();

        final placemarks = await geocoding
            .placemarkFromCoordinates(position.latitude, position.longitude)
            .timeout(const Duration(seconds: 8));

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;

          final locationParts = [place.subLocality, place.locality]
              .whereType<String>()
              .map((part) => part.trim())
              .where((part) => part.isNotEmpty)
              .toList();

          if (locationParts.isNotEmpty) {
            selectedLocation = locationParts.join(', ');
          }
        }
      } catch (e) {
        // GPS coordinates are still available if geocoding fails.
        print('GEOCODING WARNING: $e');
      }

      print('Selected Location: $selectedLocation');
    } catch (e) {
      print('LOCATION ERROR: $e');
      errorMessage = 'Unable to get current location. Please try again.';
    } finally {
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

  void resetMyComplaints() {
    searchSource.clear();
    filteredComplaints.clear();
    isLoadingMyComplaints = false;
    myComplaintsError = null;

    myComplaintsLoaded = false;

    selectedFilter = 'All';
    searchController.clear();

    errorMessage = null;

    notifyListeners();
  }

  Future<void> getWasteTypes() async {
    try {
      wasteTypes = await _complaintService.getWasteTypes();
      wasteTypesLoaded = true;
      notifyListeners();
    } catch (error) {
      wasteTypesLoaded = false;
      errorMessage = error.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }
}
