// To parse this JSON data, do
//
//     final subCategoryBrandData = subCategoryBrandDataFromJson(jsonString);

import 'dart:convert';

SubCategoryBrandData subCategoryBrandDataFromJson(String str) => SubCategoryBrandData.fromJson(json.decode(str));

String subCategoryBrandDataToJson(SubCategoryBrandData data) => json.encode(data.toJson());

class SubCategoryBrandData {
  SubCategoryBrandData({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<BrandData>? data;
  String? message;
  int? status;

  factory SubCategoryBrandData.fromJson(Map<String, dynamic> json) => SubCategoryBrandData(
        success: json["success"],
        data: json["data"] == null ? null : List<BrandData>.from(json["data"].map((x) => BrandData.fromJson(x))),
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

class BrandData {
  BrandData({
    this.subcategoryid,
    this.subcategoryname,
  });

  int? subcategoryid;
  String? subcategoryname;

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
        subcategoryid: json["subcategoryid"],
        subcategoryname: json["subcategoryname"],
      );

  Map<String, dynamic> toJson() => {
        "subcategoryid": subcategoryid,
        "subcategoryname": subcategoryname,
      };

  @override
  String toString() {
    return 'BrandData{subcategoryid: $subcategoryid, subcategoryname: $subcategoryname}';
  }

// BrandData(this.subcategoryid, this.subcategoryname);
}
// To parse this JSON data, do
//
//     final productData = productDataFromJson(jsonString);

ProductData productDataFromJson(String str) => ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  ProductData({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<ProductDataList>? data;
  String? message;
  int? status;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<ProductDataList>.from(json["data"].map((x) => ProductDataList.fromJson(x))),
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

class ProductDataList {
  ProductDataList(
      {this.itemid,
      this.itemname,
      this.itemcode,
      this.itemdescription,
      this.isInCart,
      this.itemimage,
      this.unit,
      this.rate,
      this.requiredpoint,
      this.quantity,
      required unitid,
      this.isTextField});

  int? itemid;
  int? unitid;
  String? itemname;
  String? itemcode;
  String? itemdescription;
  bool? isInCart;
  String? itemimage;
  String? unit;
  double? rate;
  double? requiredpoint;
  double? quantity;
  bool? isTextField;

  factory ProductDataList.fromJson(Map<String, dynamic> json) => ProductDataList(
      itemid: json["itemid"],
      itemname: json["itemname"],
      itemcode: json["itemcode"],
      itemdescription: json["itemdescription"],
      itemimage: json["itemimage"],
      unit: json["unit"],
      rate: json["rate"],
      requiredpoint: json["requiredpoint"],
      quantity: json["quantity"],
      isInCart: json["isInCart"] == null ? false : json["quantity"],
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

  @override
  String toString() {
    return 'ProductDataList{itemid: $itemid, itemname: $itemname, itemcode: $itemcode, itemdescription: $itemdescription, isInCart: $isInCart, itemimage: $itemimage, unit: $unit, rate: $rate, requiredpoint: $requiredpoint, quantity: $quantity, unitid: $unitid}';
  }
}
