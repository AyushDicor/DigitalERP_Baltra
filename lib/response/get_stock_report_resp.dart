// To parse this JSON data, do
//
//     final getStockReportResp = getStockReportRespFromJson(jsonString);

import 'dart:convert';

GetStockReportResp getStockReportRespFromJson(String str) => GetStockReportResp.fromJson(json.decode(str));

String getStockReportRespToJson(GetStockReportResp data) => json.encode(data.toJson());

class GetStockReportResp {
  bool? success;
  List<GetStockReportData>? data;
  String? message;
  int? status;

  GetStockReportResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetStockReportResp.fromJson(Map<String, dynamic> json) => GetStockReportResp(
    success: json["success"],
    data:json["data"]==null?null: List<GetStockReportData>.from(json["data"].map((x) =>
        GetStockReportData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data":data==null?null: List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class GetStockReportData {
  String? maingroup;
  String? subgroup;
  String? brand;
  String? itemname;
  double? rate;
  double? quantity;
  String? unit;
  double? amount;

  GetStockReportData({
    this.maingroup,
    this.subgroup,
    this.brand,
    this.itemname,
    this.rate,
    this.quantity,
    this.unit,
    this.amount,
  });

  factory GetStockReportData.fromJson(Map<String, dynamic> json) => GetStockReportData(
    maingroup: json["Maingroup"],
    subgroup: json["subgroup"],
    brand: json["brand"],
    itemname: json["itemname"],
    rate: json["rate"].toDouble(),
    quantity: json["quantity"].toDouble(),
    unit: json["unit"],
    amount: json["amount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Maingroup": maingroup,
    "subgroup": subgroup,
    "brand": brand,
    "itemname": itemname,
    "rate": rate,
    "quantity": quantity,
    "unit": unit,
    "amount": amount,
  };
}
