// To parse this JSON data, do
//
//     final currencyResponseModel = currencyResponseModelFromJson(jsonString);

import 'dart:convert';

CurrencyResponseModel currencyResponseModelFromJson(String str) =>
    CurrencyResponseModel.fromJson(json.decode(str));

String currencyResponseModelToJson(CurrencyResponseModel data) => json.encode(data.toJson());

class CurrencyResponseModel {
  bool? success;
  List<CurrencyList>? data;
  String? message;
  int? status;

  CurrencyResponseModel({this.success, this.data, this.message, this.status});

  factory CurrencyResponseModel.fromJson(Map<String, dynamic> json) => CurrencyResponseModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<CurrencyList>.from(json["data"]!.map((x) => CurrencyList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class CurrencyList {
  String? currencyCode;
  int? currencyId;

  CurrencyList({this.currencyCode, this.currencyId});

  factory CurrencyList.fromJson(Map<String, dynamic> json) =>
      CurrencyList(currencyCode: json["CurrencyCode"], currencyId: json["CurrencyId"]);

  Map<String, dynamic> toJson() => {"CurrencyCode": currencyCode, "CurrencyId": currencyId};
}
// TODO Implement this library.