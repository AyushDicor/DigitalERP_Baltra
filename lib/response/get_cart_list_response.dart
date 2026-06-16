// To parse this JSON data, do
//
//     final getCartListResponse = getCartListResponseFromJson(jsonString);

import 'dart:convert';

GetCartListResponse getCartListResponseFromJson(String str) => GetCartListResponse.fromJson(json.decode(str));

String getCartListResponseToJson(GetCartListResponse data) => json.encode(data.toJson());

class GetCartListResponse {
  GetCartListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<GetCartListData>? data;
  String? message;
  int? status;

  factory GetCartListResponse.fromJson(Map<String, dynamic> json) => GetCartListResponse(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<GetCartListData>.from(json["data"].map((x) => GetCartListData.fromJson(x))),
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

class GetCartListData {
  GetCartListData(
      {this.id,
      this.productimage,
      this.productid,
      this.productname,
      this.unit,
      this.quantity,
      this.itemrate,
      this.total,
      this.subtotal,
      this.shippingamount,
      this.grandtotal,
      this.isTextField});

  int? id;
  String? productimage;
  int? productid;
  String? productname;
  String? unit;
  double? quantity;
  double? itemrate;
  double? total;
  double? subtotal;
  double? shippingamount;
  double? grandtotal;
  bool? isTextField;
  factory GetCartListData.fromJson(Map<String, dynamic> json) => GetCartListData(
      id: json["id"],
      productimage: json["productimage"],
      productid: json["productid"],
      productname: json["productname"],
      unit: json["unit"],
      quantity: json["quantity"],
      itemrate: json["itemrate"],
      total: json["total"],
      subtotal: json["subtotal"],
      shippingamount: json["shippingamount"],
      grandtotal: json["grandtotal"],
      isTextField: json["isTextField"] ?? false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "productimage": productimage,
        "productid": productid,
        "productname": productname,
        "unit": unit,
        "quantity": quantity,
        "itemrate": itemrate,
        "total": total,
        "subtotal": subtotal,
        "shippingamount": shippingamount,
        "grandtotal": grandtotal,
      };
}
