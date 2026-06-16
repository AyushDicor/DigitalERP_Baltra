// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) => ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) => json.encode(data.toJson());

class ProductDetailResponse {
  ProductDetailResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<ProductDetailsData>? data;
  String? message;
  int? status;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
    success: json["success"],
    data: json["data"] == null ? null : List<ProductDetailsData>.from(json["data"].map((x) => ProductDetailsData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class ProductDetailsData {
  ProductDetailsData({
    this.itemId,
    this.itemName,
    this.itemCode,
    this.itemDescription,
    this.itemImage,
    this.unit,
    this.rate,
    this.requiredPoint,
    this.quantity,
  });

  int? itemId;
  String? itemName;
  String? itemCode;
  String? itemDescription;
  String? itemImage;
  String? unit;
  double? rate;
  double? requiredPoint;
  double? quantity;

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) => ProductDetailsData(
    itemId: json["itemid"],
    itemName: json["itemname"],
    itemCode: json["itemcode"],
    itemDescription: json["itemdescription"],
    itemImage: json["itemimage"],
    unit: json["unit"],
    rate: json["rate"],
    requiredPoint: json["requiredpoint"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "itemid": itemId,
    "itemname": itemName,
    "itemcode": itemCode,
    "itemdescription": itemDescription,
    "itemimage": itemImage,
    "unit": unit,
    "rate": rate,
    "requiredpoint": requiredPoint,
    "quantity": quantity,
  };
}
