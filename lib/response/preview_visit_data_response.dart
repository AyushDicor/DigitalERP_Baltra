// To parse this JSON data, do
//
//     final previewVisitDataResponse = previewVisitDataResponseFromJson(jsonString);

import 'dart:convert';

PreviewVisitDataResponse previewVisitDataResponseFromJson(String str) => PreviewVisitDataResponse.fromJson(json.decode(str));

String previewVisitDataResponseToJson(PreviewVisitDataResponse data) => json.encode(data.toJson());

class PreviewVisitDataResponse {
  PreviewVisitDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<PreviewVisitDataList>? data;
  String? message;
  int? status;

  factory PreviewVisitDataResponse.fromJson(Map<String, dynamic> json) => PreviewVisitDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<PreviewVisitDataList>.from(json["data"]!.map((x) => PreviewVisitDataList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class PreviewVisitDataList {
  PreviewVisitDataList({
    this.id,
    this.clientname,
    this.areaname,
    this.distance,
    this.visitdate,
  });

  int? id;
  String? clientname;
  String? areaname;
  String? distance;
  String? visitdate;

  factory PreviewVisitDataList.fromJson(Map<String, dynamic> json) => PreviewVisitDataList(
    id: json["id"],
    clientname: json["clientname"],
    areaname: json["areaname"],
    distance: json["distance"],
    visitdate: json["visitdate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clientname": clientname,
    "areaname": areaname,
    "distance": distance,
    "visitdate": visitdate,
  };
}
