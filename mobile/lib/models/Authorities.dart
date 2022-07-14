// To parse this JSON data, do
//
//     final authorities = authoritiesFromJson(jsonString);

import 'dart:convert';

import 'package:balighni/models/Reports.dart';

import 'Announces.dart';
import 'Branchs.dart';

Authorities authoritiesFromJson(String str) => Authorities.fromJson(json.decode(str));

String authoritiesToJson(Authorities data) => json.encode(data.toJson());

class Authorities {
  Authorities({
    this.code,
    required this.data ,
    this.success
  //  required this.authoritie,
  });

  //List<Authoritie> authoritie;
  int? code;
  DataAuthoritie data;
  bool? success;
  factory Authorities.fromJson(Map<String, dynamic> json) => Authorities(
  //  authoritie: List<Authoritie>.from(json["data"].map((x) => Authoritie.fromJson(x))),
      code: json["code"],
      data: DataAuthoritie.fromJson(json["data"]),
      success: json["success"],

    );

  Map<String, dynamic> toJson() => {
  //  "authorities": List<dynamic>.from(authoritie.map((x) => x.toJson())),
    "code": code,
    "data": data.toJson(),
    "success": success,
  };
}





class DataAuthoritie {
  DataAuthoritie({
    this.currentPage,
    required this.authoritie,
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
  List<Authoritie> authoritie;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String ? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  factory DataAuthoritie.fromJson(Map<String, dynamic> json) => DataAuthoritie(
    currentPage: (json.containsKey("current_page"))? json["current_page"] : null,
    authoritie:(json.containsKey("data"))?  List<Authoritie>.from(json["data"].map((x) => Authoritie.fromJson(x))):[],
    firstPageUrl:(json.containsKey("first_page_url"))?  json["first_page_url"] :null,
    from:(json.containsKey("images"))?  json["from"]:null,
    lastPage: (json.containsKey("last_page"))?  json["last_page"]:null,
    lastPageUrl: (json.containsKey("last_page_url"))? json["last_page_url"]:null ,
    links:(json.containsKey("links"))?  List<Link>.from(json["links"].map((x) => Link.fromJson(x))):null,
    nextPageUrl:(json.containsKey("next_page_url"))?  json["next_page_url"]:null,
    path: (json.containsKey("path"))? json["path"]:null,
    perPage: (json.containsKey("per_page"))? json["per_page"]:null,
    prevPageUrl:(json.containsKey("prev_page_url"))? json["prev_page_url"]:null,
    to:(json.containsKey("to"))? json["to"]:null,
    total: (json.containsKey("total"))?json["total"]:null,
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "authoritie": List<dynamic>.from(authoritie.map((x) => x.toJson())),
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






class Authoritie {
  Authoritie({
      this.announces,
      this.branchs ,
      required this.description,
      required this.id,
      required this.logo,
      required this.name,
      this.slug,
  });

  List<Announce>? announces;
  List<Branch>? branchs;
  String description;
  int id;
  String logo;
  String name;
  String? slug;

  factory Authoritie.fromJson(Map<String, dynamic> json) => Authoritie(
    announces: List<Announce>.from((json.containsKey("announces"))?json["announces"].map((x) => Announce.fromJson(x)):[]),
    branchs: List<Branch>.from((json.containsKey("branchs"))?json["branchs"].map((x) => Branch.fromJson(x)):[]),
    description: (json.containsKey("description"))?  json["description"]:"No Description " ,
    id: (json.containsKey("id"))?  json["id"]:-1 ,
    logo: (json.containsKey("logo"))?  json["logo"]:"null" ,
    name:  (json.containsKey("name"))?  json["name"]:"No Information" ,
    slug:(json.containsKey("slug"))?  json["slug"]:"No Information"  ,
  );

  Map<String, dynamic> toJson() => {
    "announces": List<dynamic>.from(announces!.map((x) => x.toJson())),
    "branchs": List<dynamic>.from(branchs!.map((x) => x.toJson())),
    "description": description,
    "id": id,
    "logo": logo,
    "name": name,
    "slug": slug,
  };
}



