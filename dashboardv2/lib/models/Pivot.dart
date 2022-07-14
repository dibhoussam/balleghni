
class Pivot {
  int? imageId;
  int? reportId;

  Pivot({this.imageId, this.reportId});

  Pivot.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    reportId = json['report_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['report_id'] = this.reportId;
    return data;
  }
}