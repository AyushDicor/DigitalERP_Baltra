// To parse this JSON data, do
//
//     final customerRemarkUpdateResponse = customerRemarkUpdateResponseFromJson(jsonString);

import 'dart:convert';

CustomerRemarkUpdateResponse customerRemarkUpdateResponseFromJson(String str) =>
    CustomerRemarkUpdateResponse.fromJson(json.decode(str));

String customerRemarkUpdateResponseToJson(CustomerRemarkUpdateResponse data) => json.encode(data.toJson());

class CustomerRemarkUpdateResponse {
  CustomerRemarkUpdateResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory CustomerRemarkUpdateResponse.fromJson(Map<String, dynamic> json) => CustomerRemarkUpdateResponse(
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
