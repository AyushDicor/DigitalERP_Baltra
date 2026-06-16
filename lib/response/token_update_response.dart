// To parse this JSON data, do
//
//     final tokenUpdateResponse = tokenUpdateResponseFromJson(jsonString);

import 'dart:convert';

TokenUpdateResponse tokenUpdateResponseFromJson(String str) => TokenUpdateResponse.fromJson(json.decode(str));

String tokenUpdateResponseToJson(TokenUpdateResponse data) => json.encode(data.toJson());

class TokenUpdateResponse {
  TokenUpdateResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory TokenUpdateResponse.fromJson(Map<String, dynamic> json) => TokenUpdateResponse(
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
