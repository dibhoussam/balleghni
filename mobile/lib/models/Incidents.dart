// To parse this JSON data, do
//
//     final incidents = incidentsFromJson(jsonString);

import 'dart:convert';

import '../models/Authorities.dart';

Incidents incidentsFromJson(String str) => Incidents.fromJson(json.decode(str));

String incidentsToJson(Incidents data) => json.encode(data.toJson());

class Incidents {
  Incidents({
    this.code,
    required this.incident,
    this.success,
  });

  int? code;
  List<Incident> incident;
  bool? success;

  factory Incidents.fromJson(Map<String, dynamic> json) => Incidents(
        code: json["code"],
        incident:
            List<Incident>.from(json["data"].map((x) => Incident.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "incident": List<dynamic>.from(incident.map((x) => x.toJson())),
        "success": success,
      };
}

class Incident {
  Incident({
    this.authoritie,
    this.description,
    this.icon,
    required this.id,
    this.slug,
    required this.title,
  });

  Authoritie? authoritie;
  String? description;
  String? icon;
  int id;
  String? slug;
  String title;

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
        authoritie: (json.containsKey("authoritie"))
            ? Authoritie.fromJson(json["authoritie"])
            : null,
        description: json["description"],
        icon: json["icon"],
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "authoritie": authoritie?.toJson(),
        "description": description,
        "icon": null, //,icon,
        "value": id,
        "slug": slug,
        "label": title,
      };
}
