// To parse this JSON data, do
//
//     final deleteVisitDataResponse = deleteVisitDataResponseFromJson(jsonString);

import 'dart:convert';

DeleteVisitDataResponse deleteVisitDataResponseFromJson(String str) => DeleteVisitDataResponse.fromJson(json.decode(str));

String deleteVisitDataResponseToJson(DeleteVisitDataResponse data) => json.encode(data.toJson());

class DeleteVisitDataResponse {
  DeleteVisitDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<DeletedVisitDataRecord>? data;
  String? message;
  int? status;

  factory DeleteVisitDataResponse.fromJson(Map<String, dynamic> json) => DeleteVisitDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<DeletedVisitDataRecord>.from(json["data"]!.map((x) => DeletedVisitDataRecord.fromJson(x))),
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

class DeletedVisitDataRecord {
  DeletedVisitDataRecord({
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

  factory DeletedVisitDataRecord.fromJson(Map<String, dynamic> json) => DeletedVisitDataRecord(
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
