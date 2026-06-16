// To parse this JSON data, do
//
//     final transactionListResponse = transactionListResponseFromJson(jsonString);

import 'dart:convert';

TransactionListResponse transactionListResponseFromJson(String str) =>
    TransactionListResponse.fromJson(json.decode(str));

String transactionListResponseToJson(TransactionListResponse data) => json.encode(data.toJson());

class TransactionListResponse {
  TransactionListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<TransactionData>? data;
  String? message;
  int? status;

  factory TransactionListResponse.fromJson(Map<String, dynamic> json) => TransactionListResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<TransactionData>.from(json["data"]!.map((x) => TransactionData.fromJson(x))),
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

class TransactionData {
  TransactionData({
    this.transid,
    this.voucherdate,
    this.perticular,
    this.voucherno,
    this.vouchertype,
    this.checkno,
    this.chequedate,
    this.dramount,
    this.cramount,
    this.bal,
    this.baltype,
  });

  int? transid;
  String? voucherdate;
  String? perticular;
  String? voucherno;
  String? vouchertype;
  String? checkno;
  String? chequedate;
  String? dramount;
  String? cramount;
  String? bal;
  String? baltype;

  factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
        transid: json["transid"],
        voucherdate: json["voucherdate"],
        perticular: json["perticular"],
        voucherno: json["voucherno"],
        vouchertype: json["vouchertype"],
        checkno: json["checkno"],
        chequedate: json["chequedate"],
        dramount: json["dramount"],
        cramount: json["cramount"],
        bal: json["bal"],
        baltype: json["baltype"],
      );

  Map<String, dynamic> toJson() => {
        "transid": transid,
        "voucherdate": voucherdate,
        "perticular": perticular,
        "voucherno": voucherno,
        "vouchertype": vouchertype,
        "checkno": checkno,
        "chequedate": chequedate,
        "dramount": dramount,
        "cramount": cramount,
        "bal": bal,
        "baltype": baltype,
      };
}
