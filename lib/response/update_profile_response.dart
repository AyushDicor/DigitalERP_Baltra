// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:digitalerp/response/login_response.dart';

UpdateProfileResponse updateProfileResponseFromJson(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  UserData? data;
  String? message;
  int? status;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
        success: json['success'],
        data: json['data'] == null ? null : UserData.fromJson(json['data']),
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
