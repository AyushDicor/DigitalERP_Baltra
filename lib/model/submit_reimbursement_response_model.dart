// To parse this JSON data, do
//
//     final submitReimbursementResponseModel = submitReimbursementResponseModelFromJson(jsonString);

import 'dart:convert';

SubmitReimbursementResponseModel submitReimbursementResponseModelFromJson(String str) =>
    SubmitReimbursementResponseModel.fromJson(json.decode(str));

String submitReimbursementResponseModelToJson(SubmitReimbursementResponseModel data) =>
    json.encode(data.toJson());

class SubmitReimbursementResponseModel {
  bool? success;
  dynamic data;
  String? message;
  int? status;

  SubmitReimbursementResponseModel({this.success, this.data, this.message, this.status});

  factory SubmitReimbursementResponseModel.fromJson(Map<String, dynamic> json) =>
      SubmitReimbursementResponseModel(
        success: json["success"],
        data: json["data"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {"success": success, "data": data, "message": message, "status": status};
}
  // TODO Implement this library.