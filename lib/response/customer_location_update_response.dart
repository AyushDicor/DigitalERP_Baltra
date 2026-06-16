// To parse this JSON data, do
//
//     final customerLocationUpdateResponse = customerLocationUpdateResponseFromJson(jsonString);

import 'dart:convert';

CustomerLocationUpdateResponse customerLocationUpdateResponseFromJson(String str) =>
    CustomerLocationUpdateResponse.fromJson(json.decode(str));

String customerLocationUpdateResponseToJson(CustomerLocationUpdateResponse data) => json.encode(data.toJson());

class CustomerLocationUpdateResponse {
  CustomerLocationUpdateResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory CustomerLocationUpdateResponse.fromJson(Map<String, dynamic> json) => CustomerLocationUpdateResponse(
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
