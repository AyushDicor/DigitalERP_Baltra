// To parse this JSON data, do
//
//     final orderDetailResponse = orderDetailResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailResponse orderDetailResponseFromJson(String str) => OrderDetailResponse.fromJson(json.decode(str));

String orderDetailResponseToJson(OrderDetailResponse data) => json.encode(data.toJson());

class OrderDetailResponse {
  OrderDetailResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<OrderDetailData>? data;
  String? message;
  int? status;

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) => OrderDetailResponse(
    success: json['success'],
    data: json['data'] == null
        ? null:List<OrderDetailData>.from(json['data'].map((x) => OrderDetailData.fromJson(x))),
    message: json['message'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': List<dynamic>.from(data!.map((x) => x.toJson())),
    'message': message,
    'status': status,
  };
}

class OrderDetailData {
  OrderDetailData({
    this.orderid,
    this.orderno,
    this.orderdate,
    this.partyname,
    this.partyid,
    this.amount,
    this.executivename,
    this.orderstatus,
    this.details,
  });

  int? orderid;
  String? orderno;
  String? orderdate;
  String? partyname;
  int? partyid;
  double? amount;
  String? executivename;
  String? orderstatus;
  List<ProductDetailData>? details;

  factory OrderDetailData.fromJson(Map<String, dynamic> json) => OrderDetailData(
    orderid: json['orderid'],
    orderno: json['orderno'],
    orderdate: json['orderdate'],
    partyname: json['partyname'],
    partyid: json['partyid'],
    amount: json['amount'],
    executivename: json['executivename'],
    orderstatus: json['orderstatus'],
    details:  json['details'] == null
        ? null
        :List<ProductDetailData>.from(json['details'].map((x) => ProductDetailData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'orderid': orderid,
    'orderno': orderno,
    'orderdate': orderdate,
    'partyname': partyname,
    'partyid': partyid,
    'amount': amount,
    'executivename': executivename,
    'orderstatus': orderstatus,
    'details': List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class ProductDetailData {
  ProductDetailData({
    this.productname,
    this.quantity,
    this.unit,
    this.rate,
    this.amount,
    this.productid,
    this.productimage,
  });

  String? productname;
  double? quantity;
  String? unit;
  double? rate;
  double? amount;
  int? productid;
  String? productimage;

  factory ProductDetailData.fromJson(Map<String, dynamic> json) => ProductDetailData(
    productname: json['productname'],
    quantity: json['quantity'],
    unit: json['unit'],
    rate: json['rate'],
    amount: json['amount'],
    productid: json['productid'],
    productimage: json["productimage"],
  );

  Map<String, dynamic> toJson() => {
    'productname': productname,
    'quantity': quantity,
    'unit': unit,
    'rate': rate,
    'amount': amount,
    'productid': productid,
    'productimage': productimage,
  };
}
