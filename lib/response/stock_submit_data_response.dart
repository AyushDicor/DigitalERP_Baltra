// To parse this JSON data, do
//
//     final stockSubmitDataResponse = stockSubmitDataResponseFromJson(jsonString);

import 'dart:convert';

StockSubmitDataResponse stockSubmitDataResponseFromJson(String str) => StockSubmitDataResponse.fromJson(json.decode(str));

String stockSubmitDataResponseToJson(StockSubmitDataResponse data) => json.encode(data.toJson());

class StockSubmitDataResponse {
  StockSubmitDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory StockSubmitDataResponse.fromJson(Map<String, dynamic> json) => StockSubmitDataResponse(
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
