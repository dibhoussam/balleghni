// To parse this JSON data, do
//
//     final imageUpload = imageUploadFromJson(jsonString);

import 'dart:convert';

ImageUpload imageUploadFromJson(String str) =>
    ImageUpload.fromJson(json.decode(str));

String imageUploadToJson(ImageUpload data) => json.encode(data.toJson());

class ImageUpload {
  ImageUpload({
    required this.status,
    this.hash,
    this.url,
    this.urlThumb,
    this.filetype,
    this.deleteCode,
    this.deleteUrl,
    this.thumbDeleteCode,
    this.thumbDeleteUrl,
  });

  String status;
  String? hash;
  String? url;
  String? urlThumb;
  String? filetype;
  String? deleteCode;
  String? deleteUrl;
  String? thumbDeleteCode;
  String? thumbDeleteUrl;

  factory ImageUpload.fromJson(Map<String, dynamic> json) => ImageUpload(
        status: json["status"],
        hash: json["hash"],
        url: json["url"],
        urlThumb: json["urlThumb"],
        filetype: json["filetype"],
        deleteCode: json["delete_code"],
        deleteUrl: json["delete_url"],
        thumbDeleteCode: json["Thumb_delete_code"],
        thumbDeleteUrl: json["Thumb_delete_url"],
      );

  Map<String, dynamic> toJson() => {
        "image": url,
        "thumbnail": urlThumb,
        "delete_image": deleteUrl,
        "delete_thumbnail": thumbDeleteUrl,
      };
}
