// lib/model/upload_reimbursement_file_response_model.dart

import 'dart:convert';

UploadReimbursementFileResponseModel
uploadReimbursementFileResponseModelFromJson(String str) =>
    UploadReimbursementFileResponseModel.fromJson(json.decode(str));

class UploadReimbursementFileResponseModel {
  bool? success;
  UploadedFileData? data;
  String? message;
  int? status;

  UploadReimbursementFileResponseModel(
      {this.success, this.data, this.message, this.status});

  factory UploadReimbursementFileResponseModel.fromJson(
      Map<String, dynamic> json) =>
      UploadReimbursementFileResponseModel(
        success: json["success"],
        data: json["data"] != null
            ? UploadedFileData.fromJson(json["data"])
            : null,
        message: json["message"],
        status: json["status"],
      );
}

class UploadedFileData {
  /// The server-generated filename — store this and send it in SaveReimbursement
  String? filename;

  UploadedFileData({this.filename});

  factory UploadedFileData.fromJson(Map<String, dynamic> json) =>
      UploadedFileData(
        filename: json["filename"] ?? json["FileName"] ?? json["fileName"],
      );
}