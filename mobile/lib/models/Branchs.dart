// To parse this JSON data, do
//
//     final branchs = branchsFromJson(jsonString);

import 'dart:convert';

import 'Location.dart';
import 'Authorities.dart';
import 'Phones.dart';

Branchs branchsFromJson(String str) => Branchs.fromJson(json.decode(str));

String branchsToJson(Branchs data) => json.encode(data.toJson());

class Branchs {
  Branchs({
     this.code,
    required this.branch,
     this.success,
  });

  int? code;
  List<Branch> branch;
  bool? success;

  factory Branchs.fromJson(Map<String, dynamic> json) => Branchs(
    code: (json.containsKey("code"))? json["code"]: null,
    branch: List<Branch>.from(json["data"].map((x) => Branch.fromJson(x))),
    success: (json.containsKey("sucess"))? json["success"]:null,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "branch": List<dynamic>.from(branch.map((x) => x.toJson())),
    "success": success,
  };
}

class Branch {
  Branch({
    this.authoritie,
     this.dg,
    this.email,
    required this.id,
     this.location,
    this.mapLink,
     this.phones,
  });

  Authoritie? authoritie;
  int? dg;
  String? email;
  int id;
  Location? location;
  String? mapLink;
  List<Phone>? phones;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    authoritie:(json.containsKey("authoritie"))? Authoritie.fromJson(json["authoritie"]):null,
    dg:(json.containsKey("dg"))?  json["dg"] :0,
    email: (json.containsKey("email"))?  json["email"] : "no Mail",
    id: json["id"],
    location: (json.containsKey("location"))?  Location.fromJson(json["location"]) : null ,
    mapLink: (json.containsKey("map_link"))? json["map_link"] :"no MapLink",
    phones:(json.containsKey("phones"))?  List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))) :[],
  );

  Map<String, dynamic> toJson() => {
    "authoritie": authoritie?.toJson(),
    "dg": dg,
    "email": email,
    "id": id,
    "location": location?.toJson(),
    "map_link": mapLink,
    "phones": List<dynamic>.from(phones!.map((x) => x.toJson())),
  };
}


