// To parse this JSON data, do
//
//     final voucherListResponse = VoucherListResponseFromJson(jsonString);

import 'dart:convert';

VoucherListResponse voucherListResponseFromJson(String str) => VoucherListResponse.fromJson(json.decode(str));

String voucherListResponseToJson(VoucherListResponse data) => json.encode(data.toJson());

class VoucherListResponse {
  VoucherListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<VoucherData>? data;
  String? message;
  int? status;

  factory VoucherListResponse.fromJson(Map<String, dynamic> json) => VoucherListResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<VoucherData>.from(json["data"]!.map((x) => VoucherData.fromJson(x))),
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

class VoucherData {
  VoucherData({
    this.transid,
    this.voucherno,
    this.vouchername,
    this.customername,
    this.date,
    this.amount,
    this.remarks,
  });

  int? transid;
  int? voucherno;
  String? vouchername;
  String? customername;
  String? date;
  String? amount;
  String? remarks;

  factory VoucherData.fromJson(Map<String, dynamic> json) => VoucherData(
        transid: json["transid"],
        voucherno: json["voucherno"],
        vouchername: json["vouchername"],
        customername: json["customername"],
        date: json["date"],
        amount: json["Amount"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "transid": transid,
        "voucherno": voucherno,
        "vouchername": vouchername,
        "customername": customername,
        "date": date,
        "Amount": amount,
        "remarks": remarks,
      };
}
