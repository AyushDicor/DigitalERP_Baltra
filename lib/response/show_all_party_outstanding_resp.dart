// To parse this JSON data, do
//
//     final misOutstandingResp = misOutstandingRespFromJson(jsonString);

import 'dart:convert';

MisOutstandingResp misOutstandingRespFromJson(String str) => MisOutstandingResp.fromJson(json.decode(str));

String misOutstandingRespToJson(MisOutstandingResp data) => json.encode(data.toJson());

class MisOutstandingResp {
  bool? success;
  List<MisOutstandingData>? data;
  String? message;
  int? status;

  MisOutstandingResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory MisOutstandingResp.fromJson(Map<String, dynamic> json) => MisOutstandingResp(
    success: json["success"],
    data: List<MisOutstandingData>.from(json["data"]?.map((x) => MisOutstandingData.fromJson(x)) ??[]),
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

class MisOutstandingData {
  String? partyid;
  String? partyname;
  String? mobileno;
  String? address;
  String? executivename;
  String? balance;
  String? balancetype;

  MisOutstandingData({
    this.partyid,
    this.partyname,
    this.mobileno,
    this.address,
    this.executivename,
    this.balance,
    this.balancetype,
  });

  factory MisOutstandingData.fromJson(Map<String, dynamic> json) => MisOutstandingData(
    partyid: json["partyid"],
    partyname: json["partyname"],
    mobileno: json["mobileno"],
    address: json["address"],
    executivename: json["executivename"],
    balance: json["balance"],
    balancetype: json["balancetype"],
  );

  Map<String, dynamic> toJson() => {
    "partyid": partyid,
    "partyname": partyname,
    "mobileno": mobileno,
    "address": address,
    "executivename": executivename,
    "balance": balance,
    "balancetype": balancetype,
  };
}
