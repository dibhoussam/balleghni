// To parse this JSON data, do
//
//     final announces = announcesFromJson(jsonString);

import 'dart:convert';

import 'Authorities.dart';

Announces announcesFromJson(String str) => Announces.fromJson(json.decode(str));

String announcesToJson(Announces data) => json.encode(data.toJson());

class Announces {
  Announces({
    this.code,
    required this.data,
    //required this.announce,
    this.success,
  });

  int? code;
  DataAnnounces data;
//  List<Announce> announce;
  bool? success;

  factory Announces.fromJson(Map<String, dynamic> json) => Announces(
        code: json["code"],
        data: DataAnnounces.fromJson(json["data"]),
        //  announce: List<Announce>.from(json["data"].map((x) => Announce.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "announces": data.toJson(),
        //"announces": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
      };
}

class DataAnnounces {
  DataAnnounces({
    this.currentPage,
    required this.announces,
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
  List<Announce> announces;
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

  factory DataAnnounces.fromJson(Map<String, dynamic> json) => DataAnnounces(
        currentPage:
            (json.containsKey("current_page")) ? json["current_page"] : null,
        announces: (json.containsKey("data"))
            ? List<Announce>.from(json["data"].map((x) => Announce.fromJson(x)))
            : [],
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
        "authoritie": List<dynamic>.from(announces.map((x) => x.toJson())),
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

class Announce {
  Announce({
    required this.authoritie,
    required this.createdAt,
    required this.description,
    required this.description_fr,
    required this.file,
    required this.id,
    required this.title,
  });

  Authoritie? authoritie;
  DateTime createdAt;
  String description;
  String description_fr;
  String file;
  int id;
  String title;

  factory Announce.fromJson(Map<String, dynamic> json) => Announce(
        authoritie: (json.containsKey("authoritie"))
            ? Authoritie.fromJson(json["authoritie"])
            : null,
        createdAt: (json.containsKey("created_at"))
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
        description:
            (json.containsKey("description")) ? json["description"] : null,
        description_fr: (json.containsKey("description_fr"))
            ? json["description_fr"]
            : null,
        file: (json.containsKey("file"))
            ? json["file"]
            : "https://picsum.photos/200/300",
        id: (json.containsKey("id")) ? json["id"] : null,
        title: (json.containsKey("description")) ? json["title"] : null,
      );

  Map<String, dynamic> toJson() => {
        "authoritie": authoritie?.toJson(),
        "created_at": createdAt.toIso8601String(),
        "description": description,
        "file": file,
        "id": id,
        "title": title,
      };
}
