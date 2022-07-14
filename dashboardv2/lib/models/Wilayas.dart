// To parse this JSON data, do
//
//     final wilayamenu = wilayamenuFromJson(jsonString);

import 'dart:convert';

Wilayamenu wilayamenuFromJson(String str) => Wilayamenu.fromJson(json.decode(str));

String wilayamenuToJson(Wilayamenu data) => json.encode(data.toJson());

class Wilayamenu {
  Wilayamenu({
    this.code,
    required this.wilayas,
    this.success,
  });

  int? code;
  List<Wilaya> wilayas;
  bool? success;

  factory Wilayamenu.fromJson(Map<String, dynamic> json) => Wilayamenu(
    code: json["code"],
    wilayas: List<Wilaya>.from(json["data"].map((x) => Wilaya.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "wilayas": List<dynamic>.from(wilayas.map((x) => x.toJson())),
    "success": success,
  };
}

class Wilaya {
  Wilaya({
    required this.dairas,
    this.description,
    required this.id,
    this.logo,
    this.mapLink,
    required this.name,
    required this.slug,
  });

  List<Daira> dairas;
  dynamic description;
  int id;
  dynamic logo;
  dynamic mapLink;
  String name;
  String slug;

  factory Wilaya.fromJson(Map<String, dynamic> json) => Wilaya(
    dairas: List<Daira>.from(json["dairas"].map((x) => Daira.fromJson(x))),
    description: json["description"],
    id: json["id"],
    logo: json["logo"],
    mapLink: json["map_link"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "dairas": List<dynamic>.from(dairas.map((x) => x.toJson())),
    "description": description,
    "id": id,
    "logo": logo,
    "map_link": mapLink,
    "name": name,
    "slug": slug,
  };
}

class Daira {
  Daira({
    required this.communes,
    this.description,
    required this.id,
    this.mapLink,
    required this.name,
    required this.slug,
    required this.wilayaId,
  });

  List<Commune> communes;
  dynamic description;
  int id;
  dynamic mapLink;
  String name;
  String slug;
  int wilayaId;

  factory Daira.fromJson(Map<String, dynamic> json) => Daira(
    communes: List<Commune>.from(json["communes"].map((x) => Commune.fromJson(x))),
    description: json["description"],
    id: json["id"],
    mapLink: json["map_link"],
    name: json["name"],
    slug: json["slug"],
    wilayaId: json["wilaya_id"],
  );

  Map<String, dynamic> toJson() => {
    "communes": List<dynamic>.from(communes.map((x) => x.toJson())),
    "description": description,
    "id": id,
    "map_link": mapLink,
    "name": name,
    "slug": slug,
    "wilaya_id": wilayaId,
  };
}

class Commune {
  Commune({
    required this.dairaId,
    this.description,
    required this.id,
    this.mapLink,
    required this.name,
  });

  int dairaId;
  dynamic description;
  int id;
  dynamic mapLink;
  String name;

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
    dairaId: json["daira_id"],
    description: json["description"],
    id: json["id"],
    mapLink: json["map_link"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "daira_id": dairaId,
    "description": description,
    "id": id,
    "map_link": mapLink,
    "name": name,
  };
}
