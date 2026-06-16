// To parse this JSON data, do
//
//     final otpVerifyResponse = otpVerifyResponseFromJson(jsonString);

import 'dart:convert';

import 'package:digitalerp/response/login_response.dart';

OtpVerifyResponse otpVerifyResponseFromJson(String str) =>
    OtpVerifyResponse.fromJson(json.decode(str));

String otpVerifyResponseToJson(OtpVerifyResponse data) =>
    json.encode(data.toJson());

class OtpVerifyResponse {
  OtpVerifyResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  UserData? data;
  String? message;
  int? status;

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerifyResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : UserData.fromJson(json['data']),
        message: json['message'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
        'status': status,
      };
}
