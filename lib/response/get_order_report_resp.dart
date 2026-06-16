// To parse this JSON data, do
//
//     final getOrderReportResp = getOrderReportRespFromJson(jsonString);

import 'dart:convert';

GetOrderReportResp getOrderReportRespFromJson(String str) =>
    GetOrderReportResp.fromJson(json.decode(str));

String getOrderReportRespToJson(GetOrderReportResp data) => json.encode(data.toJson());

class GetOrderReportResp {
  bool? success;
  List<GetOrderReportData>? data;
  String? message;
  int? status;

  GetOrderReportResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetOrderReportResp.fromJson(Map<String, dynamic> json) => GetOrderReportResp(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<GetOrderReportData>.from(
                json["data"]?.map((x) => GetOrderReportData.fromJson(x))),
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

class GetOrderReportData {
  String? orderno;
  String? orderdate;
  String? partyname;
  String? executivename;
  int? orderid;
  double? totalqty;
  double? totalamount;

  GetOrderReportData({
    this.orderid,
    this.orderno,
    this.orderdate,
    this.partyname,
    this.executivename,
    this.totalqty,
    this.totalamount,
  });

  factory GetOrderReportData.fromJson(Map<String, dynamic> json) => GetOrderReportData(
        orderid: json["orderid"],
        orderno: json["orderno"],
        orderdate: json["orderdate"],
        partyname: json["partyname"],
        executivename: json["executivename"],
        totalqty: json["totalqty"],
        totalamount: json["totalamount"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "orderno": orderno,
        "orderdate": orderdate,
        "partyname": partyname,
        "executivename": executivename,
        "totalqty": totalqty,
        "totalamount": totalamount,
      };
}
