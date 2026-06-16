// lib/model/save_reimbursement_response_model.dart

import 'dart:convert';

SaveReimbursementResponseModel saveReimbursementResponseModelFromJson(
    String str) =>
    SaveReimbursementResponseModel.fromJson(json.decode(str));

class SaveReimbursementResponseModel {
  bool? success;
  dynamic data;
  String? message;
  int? status;

  SaveReimbursementResponseModel(
      {this.success, this.data, this.message, this.status});

  factory SaveReimbursementResponseModel.fromJson(Map<String, dynamic> json) =>
      SaveReimbursementResponseModel(
        success: json["success"],
        data: json["data"],
        message: json["message"],
        status: json["status"],
      );
}