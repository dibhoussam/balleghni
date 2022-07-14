class Address {
  String? wilaya;
  String? street;
  String? commune;
  String? daira;

  Address({this.wilaya, this.street, this.commune, this.daira});

  Address.fromJson(Map<String, dynamic> json) {
    wilaya = json['wilaya'];
    street = json['street'];
    commune = json['commune'];
    daira = json['daira'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wilaya'] = this.wilaya;
    data['street'] = this.street;
    data['commune'] = this.commune;
    data['daira'] = this.daira;
    return data;
  }
}
