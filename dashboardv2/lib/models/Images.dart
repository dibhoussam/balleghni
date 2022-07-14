// To parse this JSON data, do
//
//     final images = imagesFromJson(jsonString);

import 'dart:convert';

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));

String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    required this.images,
  });

  List<MyImage> images;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    images: List<MyImage>.from(json["images"].map((x) => MyImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class MyImage {
  MyImage({
    required this.id,
     required this.image,
     this.pivot,
    required this.thumbnail,
  });

  int id;
  String image;
  Pivot? pivot;
  String thumbnail;

  factory MyImage.fromJson(Map<String, dynamic> json) => MyImage(
    id: json["id"],
    image: json["image"],
    pivot: Pivot.fromJson(json["pivot"]),
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "pivot": pivot?.toJson(),
    "thumbnail": thumbnail,
  };
}

class Pivot {
  Pivot({
    required this.imageId,
    required this.reportId,
  });

  int imageId;
  int reportId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    imageId: json["image_id"],
    reportId: json["report_id"],
  );

  Map<String, dynamic> toJson() => {
    "image_id": imageId,
    "report_id": reportId,
  };
}
