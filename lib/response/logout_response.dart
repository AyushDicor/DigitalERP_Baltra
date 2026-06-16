// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

CommonResponse commonResponseFromJson(String str) => CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    success: json['success'],
    data: json['data'],
    message: json['message'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data,
    'message': message,
    'status': status,
  };
}
