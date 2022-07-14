// To parse this JSON data, do
//
//     final phones = phonesFromJson(jsonString);

import 'dart:convert';

Phones phonesFromJson(String str) => Phones.fromJson(json.decode(str));

String phonesToJson(Phones data) => json.encode(data.toJson());

class Phones {
  Phones({
    required this.phones,
  });

  List<Phone> phones;

  factory Phones.fromJson(Map<String, dynamic> json) => Phones(
    phones: List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "phones": List<dynamic>.from(phones.map((x) => x.toJson())),
  };
}

class Phone {
  Phone({
    this.description,
    required this.id,
    required this.phone,
  });

  String? description;
  int id;
  String phone;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    description: json["description"],
    id: json["id"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "id": id,
    "phone": phone,
  };
}
