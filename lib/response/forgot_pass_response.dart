// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) =>
    ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) => json.encode(data.toJson());

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  ForgotPassResData? data;
  String? message;
  int? status;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResponse(
        success: json["success"],
        data: json["data"] == null ? null : ForgotPassResData.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
        "status": status,
      };
}

class ForgotPassResData {
  ForgotPassResData({
    this.mobileNo,
    this.otp,
  });

  String? mobileNo;
  String? otp;

  factory ForgotPassResData.fromJson(Map<String, dynamic> json) => ForgotPassResData(
        mobileNo: json["mobileno"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "mobileno": mobileNo,
        "otp": otp,
      };
}
