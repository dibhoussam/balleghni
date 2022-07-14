class Location {
  String? address;
  Commune? commune;
  Daira? daira;
  int? id;
  Wilaya? wilaya;

  Location({this.address, this.commune, this.daira, this.id, this.wilaya});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    commune =
        json['commune'] != null ? Commune.fromJson(json['commune']) : null;
    daira = json['daira'] != null ? Daira.fromJson(json['daira']) : null;
    id = json['id'];
    wilaya = json['wilaya'] != null ? Wilaya.fromJson(json['wilaya']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    if (this.commune != null) {
      data['commune'] = this.commune!.toJson();
    }
    if (this.daira != null) {
      data['daira'] = this.daira!.toJson();
    }
    data['id'] = this.id;
    if (this.wilaya != null) {
      data['wilaya'] = this.wilaya!.toJson();
    }
    return data;
  }
}

class Commune {
  String? description;
  late int id;
  String? mapLink;
  late String name;
  String? ar_name;
  Commune(
      {this.description, required this.id, this.mapLink, required this.name});

  Commune.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    mapLink = json['map_link'];
    name = json['name'];
    ar_name = json.containsKey('ar_name') ? json['ar_name'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['map_link'] = this.mapLink;
    data['name'] = this.name;

    return data;
  }
}

class Daira {
  String? description;
  int? id;
  String? mapLink;
  String? name;
  String? slug;
  String? ar_name;

  Daira({this.description, this.id, this.mapLink, this.name, this.slug});

  Daira.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    mapLink = json['map_link'];
    name = json['name'];
    slug = json['slug'];
    ar_name = json['ar_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['map_link'] = this.mapLink;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Wilaya {
  String? description;
  int? id;
  String? logo;
  String? mapLink;
  String? name;
  String? slug;
  String? ar_name;

  Wilaya(
      {this.description,
      this.id,
      this.logo,
      this.mapLink,
      this.name,
      this.slug});

  Wilaya.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    logo = json['logo'];
    mapLink = json['map_link'];
    name = json['name'];
    slug = json['slug'];
    ar_name = json['ar_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['map_link'] = this.mapLink;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
