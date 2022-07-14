// To parse this JSON data, do
//
//     final reports = reportsFromJson(jsonString);

import 'dart:convert';
import 'package:balighni/models/Images.dart';
import 'package:balighni/models/Incidents.dart';
import 'package:balighni/models/Location.dart';
//import 'package:balighni/models/Wilayas.dart';

Reports reportsFromJson(String str) => Reports.fromJson(json.decode(str));
String reportsToJson(Reports data) => json.encode(data.toJson());

class Reports {
  Reports({
    this.code,
    required this.data,
    this.success,
  });

  int? code;
  Data data;
  bool? success;

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        code: (json.containsKey("code")) ? json["code"] : 500,
        data: (json.containsKey("code"))
            ? Data.fromJson(json["data"])
            : Data(reports: []),
        success: (json.containsKey("success")) ? json["success"] : "error",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "success": success,
      };
}

class Data {
  Data({
    this.currentPage,
    required this.reports,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Report> reports;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage:
            (json.containsKey("current_page")) ? json["current_page"] : null,
        reports: List<Report>.from(json["data"].map((x) => Report.fromJson(x))),
        firstPageUrl: (json.containsKey("first_page_url"))
            ? json["first_page_url"]
            : null,
        from: (json.containsKey("images")) ? json["from"] : null,
        lastPage: (json.containsKey("last_page")) ? json["last_page"] : null,
        lastPageUrl:
            (json.containsKey("last_page_url")) ? json["last_page_url"] : null,
        links: (json.containsKey("links"))
            ? List<Link>.from(json["links"].map((x) => Link.fromJson(x)))
            : null,
        nextPageUrl:
            (json.containsKey("next_page_url")) ? json["next_page_url"] : null,
        path: (json.containsKey("path")) ? json["path"] : null,
        perPage: (json.containsKey("per_page")) ? json["per_page"] : null,
        prevPageUrl:
            (json.containsKey("prev_page_url")) ? json["prev_page_url"] : null,
        to: (json.containsKey("to")) ? json["to"] : null,
        total: (json.containsKey("total")) ? json["total"] : null,
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.active,
    this.label,
    this.url,
  });

  bool? active;
  String? label;
  String? url;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        active: json["active"],
        label: json["label"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "label": label,
        "url": url == null ? null : url,
      };
}

class Report {
  Report({
    required this.createdAt,
    this.description = '',
    this.globalStatus = 1,
    required this.id,
    required this.images,
    required this.incidentTypes,
    required this.latitude,
    required this.location,
    required this.longitude,
    this.updatedAt,
    required this.userId,
  });

  DateTime createdAt;
  String description;
  int globalStatus;
  int id;
  List<MyImage> images;
  List<Incident> incidentTypes;
  double latitude;
  Location? location;
  double longitude;
  DateTime? updatedAt;
  String userId;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        createdAt: DateTime.parse(json["created_at"]),
        description: json["description"],
        globalStatus: json["global_status"],
        id: json["id"],
        images: (json.containsKey("images"))
            ? List<MyImage>.from(json["images"].map((x) => MyImage.fromJson(x)))
            : [],
        incidentTypes: (json.containsKey("incident_types"))
            ? List<Incident>.from(
                json["incident_types"].map((x) => Incident.fromJson(x)))
            : [],
        latitude: json["latitude"].toDouble(),
        location: (json.containsKey("location"))
            ? Location.fromJson(json["location"])
            : null,
        longitude: json["longitude"].toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "description": description,
        "global_status": globalStatus,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "incident_types":
            List<dynamic>.from(incidentTypes.map((x) => x.toJson())),
        "latitude": latitude,
        "location": location!.toJson(),
        "longitude": longitude,
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
      };
}

class IncidentTypePivot {
  IncidentTypePivot({
    required this.incidentTypeId,
    required this.reportId,
  });

  int incidentTypeId;
  int reportId;

  factory IncidentTypePivot.fromJson(Map<String, dynamic> json) =>
      IncidentTypePivot(
        incidentTypeId: json["incidentType_id"],
        reportId: json["report_id"],
      );

  Map<String, dynamic> toJson() => {
        "incidentType_id": incidentTypeId,
        "report_id": reportId,
      };
}
