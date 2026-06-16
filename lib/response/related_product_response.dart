// To parse this JSON data, do
//
//     final relatedProductsResponse = relatedProductsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:digitalerp/response/unit_list_response.dart';

RelatedProductsResponse relatedProductsResponseFromJson(String str) =>
    RelatedProductsResponse.fromJson(json.decode(str));

String relatedProductsResponseToJson(RelatedProductsResponse data) => json.encode(data.toJson());

class RelatedProductsResponse {
  RelatedProductsResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<RelatedProductList>? data;
  String? message;
  int? status;

  factory RelatedProductsResponse.fromJson(Map<String, dynamic> json) => RelatedProductsResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<RelatedProductList>.from(json["data"].map((x) => RelatedProductList.fromJson(x))),
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

class RelatedProductList {
  RelatedProductList({
    this.itemid,
    this.itemname,
    this.itemcode,
    this.itemdescription,
    this.itemimage,
    this.unit,
    this.rate,
    this.requiredpoint,
    this.quantity,
    this.unitid,
    this.selectedUnit,
    this.isTextField,
  });

  int? itemid;
  String? itemname;
  String? itemcode;
  String? itemdescription;
  String? itemimage;
  String? unit;
  double? rate;
  double? requiredpoint;
  double? quantity;
  int? unitid;
  UnitListData? selectedUnit;
  bool? isTextField;

  factory RelatedProductList.fromJson(Map<String, dynamic> json) => RelatedProductList(
      itemid: json["itemid"],
      itemname: json["itemname"],
      itemcode: json["itemcode"],
      itemdescription: json["itemdescription"],
      itemimage: json["itemimage"],
      unit: json["unit"],
      rate: json["rate"],
      requiredpoint: json["requiredpoint"],
      quantity: json["quantity"],
      unitid: json["unitid"],
      isTextField: json["isTextField"] ?? false);

  Map<String, dynamic> toJson() => {
        "itemid": itemid,
        "itemname": itemname,
        "itemcode": itemcode,
        "itemdescription": itemdescription,
        "itemimage": itemimage,
        "unit": unit,
        "rate": rate,
        "requiredpoint": requiredpoint,
        "quantity": quantity,
        "unitid": unitid,
      };
}
