// To parse this JSON data, do
//
//     final cashAndbankLedgerResponse = cashAndbankLedgerResponseFromJson(jsonString);

import 'dart:convert';

CashAndbankLedgerResponse cashAndbankLedgerResponseFromJson(String str) => CashAndbankLedgerResponse.fromJson(json.decode(str));

String cashAndbankLedgerResponseToJson(CashAndbankLedgerResponse data) => json.encode(data.toJson());

class CashAndbankLedgerResponse {
  CashAndbankLedgerResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<CashAndBankLedgerDataList>? data;
  String? message;
  int? status;

  factory CashAndbankLedgerResponse.fromJson(Map<String, dynamic> json) => CashAndbankLedgerResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<CashAndBankLedgerDataList>.from(json["data"]!.map((x) => CashAndBankLedgerDataList.fromJson(x))),
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

class CashAndBankLedgerDataList {
  CashAndBankLedgerDataList({
    this.partyid,
    this.partyname,
  });

  int? partyid;
  String? partyname;

  factory CashAndBankLedgerDataList.fromJson(Map<String, dynamic> json) => CashAndBankLedgerDataList(
    partyid: json["partyid"],
    partyname: json["partyname"],
  );

  Map<String, dynamic> toJson() => {
    "partyid": partyid,
    "partyname": partyname,
  };
}
