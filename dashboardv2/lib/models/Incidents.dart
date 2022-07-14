// To parse this JSON data, do
//
//     final incidents = incidentsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/Authorities.dart';

Incidents incidentsFromJson(String str) => Incidents.fromJson(json.decode(str));

String incidentsToJson(Incidents data) => json.encode(data.toJson());

class Incidents extends DataTableSource {
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

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    try {
      if (index < rowCount)
        return DataRow.byIndex(index: index, cells: [
          DataCell(
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                incident[index].icon!,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.error,
                    color: Colors.red,
                  );
                },
                width: 20,
                height: 20,
              ),
            ),
          ),
          DataCell(Row(
            children: [
              //ImageIcon(NetworkImage(data.authoritie[index].logo)),

              SizedBox(width: 10),
              Text(incident[index].title),
            ],
          )),
          DataCell(Row(
            children: [
              //ImageIcon(NetworkImage(data.authoritie[index].logo)),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  incident[index].authoritie!.logo,
                  width: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  },
                  height: 20,
                ),
              ),
              SizedBox(width: 10),
              Text(incident[index].authoritie!.name),
            ],
          )),
        ]);
      else
        return null;
    } catch (e) {}
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => incident.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
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
