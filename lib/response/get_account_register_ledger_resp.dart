// To parse this JSON data, do
//
//     final getAccountRegisterLedgerResp = getAccountRegisterLedgerRespFromJson(jsonString);

import 'dart:convert';

GetAccountRegisterLedgerResp getAccountRegisterLedgerRespFromJson(String str) => GetAccountRegisterLedgerResp.fromJson(json.decode(str));

String getAccountRegisterLedgerRespToJson(GetAccountRegisterLedgerResp data) => json.encode(data.toJson());

class GetAccountRegisterLedgerResp {
  bool? success;
  List<GetAccountRegisterLedgerData>? data;
  String? message;
  int? status;

  GetAccountRegisterLedgerResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetAccountRegisterLedgerResp.fromJson(Map<String, dynamic> json) => GetAccountRegisterLedgerResp(
    success: json["success"],
    data: List<GetAccountRegisterLedgerData>.from(json["data"].map((x) => GetAccountRegisterLedgerData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data?.map((x) => x.toJson())??[]),
    "message": message,
    "status": status,
  };
}

class GetAccountRegisterLedgerData {
  int? ledgerid;
  String? ledgername;

  GetAccountRegisterLedgerData({
    this.ledgerid,
    this.ledgername,
  });

  factory GetAccountRegisterLedgerData.fromJson(Map<String, dynamic> json) => GetAccountRegisterLedgerData(
    ledgerid: json["ledgerid"],
    ledgername: json["ledgername"],
  );

  Map<String, dynamic> toJson() => {
    "ledgerid": ledgerid,
    "ledgername": ledgername,
  };
}
