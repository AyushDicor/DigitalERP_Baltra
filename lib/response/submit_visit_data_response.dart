// To parse this JSON data, do
//
//     final submitVisitDataResponse = submitVisitDataResponseFromJson(jsonString);

import 'dart:convert';

SubmitVisitDataResponse submitVisitDataResponseFromJson(String str) => SubmitVisitDataResponse.fromJson(json.decode(str));

String submitVisitDataResponseToJson(SubmitVisitDataResponse data) => json.encode(data.toJson());

class SubmitVisitDataResponse {
  SubmitVisitDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory SubmitVisitDataResponse.fromJson(Map<String, dynamic> json) => SubmitVisitDataResponse(
    success: json["success"],
    data: json["data"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
    "status": status,
  };
}
