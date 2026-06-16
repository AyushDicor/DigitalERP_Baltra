// To parse this JSON data, do
//
//     final addCustomerToVisitDataResponse = addCustomerToVisitDataResponseFromJson(jsonString);

import 'dart:convert';

AddCustomerToVisitDataResponse addCustomerToVisitDataResponseFromJson(String str) => AddCustomerToVisitDataResponse.fromJson(json.decode(str));

String addCustomerToVisitDataResponseToJson(AddCustomerToVisitDataResponse data) => json.encode(data.toJson());

class AddCustomerToVisitDataResponse {
  AddCustomerToVisitDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory AddCustomerToVisitDataResponse.fromJson(Map<String, dynamic> json) => AddCustomerToVisitDataResponse(
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
