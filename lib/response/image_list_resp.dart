// To parse this JSON data, do
//
//     final imageListResp = imageListRespFromJson(jsonString);

import 'dart:convert';

ImageListResp imageListRespFromJson(String str) => ImageListResp.fromJson(json.decode(str));

String imageListRespToJson(ImageListResp data) => json.encode(data.toJson());

class ImageListResp {
  bool? success;
  List<ImageListRespData>? data;
  String? message;
  int? status;

  ImageListResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory ImageListResp.fromJson(Map<String, dynamic> json) => ImageListResp(
    success: json["success"],
    data:json["data"]==null?null: List<ImageListRespData>.from(json["data"].map((x) => ImageListRespData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data==null?null:List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class ImageListRespData {
  int? id;
  String? groupName;
  String? title;
  String? description;
  String? image;

  ImageListRespData({
    this.id,
    this.groupName,
    this.title,
    this.description,
    this.image,
  });

  factory ImageListRespData.fromJson(Map<String, dynamic> json) => ImageListRespData(
    id: json["id"],
    groupName: json["groupname"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "groupname": groupName,
    "title": title,
    "description": description,
    "image": image,
  };
}
