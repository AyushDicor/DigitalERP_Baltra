// To parse this JSON data, do
//
//     final forgotOtpVerifyResponse = forgotOtpVerifyResponseFromJson(jsonString);

import 'dart:convert';

ForgotOtpVerifyResponse forgotOtpVerifyResponseFromJson(String str) =>
    ForgotOtpVerifyResponse.fromJson(json.decode(str));

String forgotOtpVerifyResponseToJson(ForgotOtpVerifyResponse data) => json.encode(data.toJson());

class ForgotOtpVerifyResponse {
  ForgotOtpVerifyResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  ForgotOtpVerifyData? data;
  String? message;
  int? status;

  factory ForgotOtpVerifyResponse.fromJson(Map<String, dynamic> json) => ForgotOtpVerifyResponse(
        success: json["success"],
        data: json["data"] == null ? null : ForgotOtpVerifyData.fromJson(json["data"]),
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

class ForgotOtpVerifyData {
  ForgotOtpVerifyData({
    this.userid,
  });

  String? userid;

  factory ForgotOtpVerifyData.fromJson(Map<String, dynamic> json) => ForgotOtpVerifyData(
        userid: json["userid"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
      };
}
