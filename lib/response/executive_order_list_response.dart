// To parse this JSON data, do
//
//     final executiveOrderListResponse = executiveOrderListResponseFromJson(jsonString);

import 'dart:convert';

ExecutiveOrderListResponse executiveOrderListResponseFromJson(String str) =>
    ExecutiveOrderListResponse.fromJson(json.decode(str));

String executiveOrderListResponseToJson(ExecutiveOrderListResponse data) =>
    json.encode(data.toJson());

class ExecutiveOrderListResponse {
  ExecutiveOrderListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<ExecutiveOrderData>? data;
  String? message;
  int? status;

  factory ExecutiveOrderListResponse.fromJson(Map<String, dynamic> json) =>
      ExecutiveOrderListResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<ExecutiveOrderData>.from(
                json['data'].map((x) => ExecutiveOrderData.fromJson(x))),
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

class ExecutiveOrderData {
  ExecutiveOrderData({
    this.orderid,
    this.orderno,
    this.orderdate,
    this.partyname,
    this.partyid,
    this.amount,
    this.executivename,
    this.orderstatus,
  });

  int? orderid;
  String? orderno;
  String? orderdate;
  String? partyname;
  int? partyid;
  double? amount;
  String? executivename;
  String? orderstatus;

  factory ExecutiveOrderData.fromJson(Map<String, dynamic> json) => ExecutiveOrderData(
        orderid: json['orderid'],
        orderno: json['orderno'],
        orderdate: json['orderdate'],
        partyname: json['partyname'],
        partyid: json['partyid'],
        amount: json['amount'],
        executivename: json['executivename'],
        orderstatus: json['orderstatus'],
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
      };
}
