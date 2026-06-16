// To parse this JSON data, do
//
//     final stockCategoryDataResponse = stockCategoryDataResponseFromJson(jsonString);

import 'dart:convert';

StockCategoryDataResponse stockCategoryDataResponseFromJson(String str) => StockCategoryDataResponse.fromJson(json.decode(str));

String stockCategoryDataResponseToJson(StockCategoryDataResponse data) => json.encode(data.toJson());

class StockCategoryDataResponse {
  StockCategoryDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<StockCategoryList>? data;
  String? message;
  int? status;

  factory StockCategoryDataResponse.fromJson(Map<String, dynamic> json) => StockCategoryDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<StockCategoryList>.from(json["data"]!.map((x) => StockCategoryList.fromJson(x))),
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

class StockCategoryList {
  StockCategoryList({
    this.categoryid,
    this.categoryname,
    this.categoryimage,
  });

  int? categoryid;
  String? categoryname;
  String? categoryimage;

  factory StockCategoryList.fromJson(Map<String, dynamic> json) => StockCategoryList(
    categoryid: json["categoryid"],
    categoryname: json["categoryname"],
    categoryimage: json["categoryimage"],
  );

  Map<String, dynamic> toJson() => {
    "categoryid": categoryid,
    "categoryname": categoryname,
    "categoryimage": categoryimage,
  };
}
