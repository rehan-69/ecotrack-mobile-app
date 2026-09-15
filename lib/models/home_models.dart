class HomeModel {
  final UserData user;
  final OverViewData overview;
  final List<RecentComplaint> recentComplaints;

  HomeModel({
    required this.user,
    required this.overview,
    required this.recentComplaints,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      user: UserData.fromJson(json["user"]),
      overview: OverViewData.fromJson(json["overview"]),
      recentComplaints: (json["recentComplaints"] as List)
          .map((item) => RecentComplaint.fromJson(item))
          .toList(),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String? mobile;
  final String? location;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.location,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"]?.toString(),
      location: json["location"]?.toString(),
    );
  }
}

class OverViewData {
  final int total;
  final int pending;
  final int inProgress;
  final int completed;

  OverViewData({
    required this.total,
    required this.pending,
    required this.inProgress,
    required this.completed,
  });

  factory OverViewData.fromJson(Map<String, dynamic> json) {
    return OverViewData(
      total: json["total"],
      pending: json["pending"],
      inProgress: json["inProgress"],
      completed: json["completed"],
    );
  }
}

class RecentComplaint {
  final int id;
  final String complaintId;
  final List<String>? image;
  final String wasteType;
  final String location;
  final String status;
  final DateTime createdAt;
  final String description;
  final double? latitude;
  final double? longitude;
  final List<StatusHistory> statusHistory;

  RecentComplaint({
    required this.id,

    required this.complaintId,
    this.image,
    required this.wasteType,
    required this.location,
    required this.status,
    required this.createdAt,
    required this.description,
    this.latitude,
    this.longitude,
    required this.statusHistory,
  });

  factory RecentComplaint.fromJson(Map<String, dynamic> json) {
    return RecentComplaint(
      id: json["id"],
      complaintId: json["complaint_id"].toString(),
      image: (json['image'] as List?)?.map((e) => e.toString()).toList(),
      wasteType: json["waste_type"],
      location: json["location"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]).toLocal(),
      description: json["description"]?.toString() ?? '',
      latitude: json["latitude"] != null
          ? (json["latitude"] as num).toDouble()
          : null,
      longitude: json["longitude"] != null
          ? (json["longitude"] as num).toDouble()
          : null,
      statusHistory:
          (json["statusHistory"] as List?)
              ?.map((item) => StatusHistory.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class StatusHistory {
  final String status;
  final DateTime createdAt;

  StatusHistory({required this.status, required this.createdAt});

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      status: json["status"].toString(),
      createdAt: DateTime.parse(json["created_at"]).toLocal(),
    );
  }
}
