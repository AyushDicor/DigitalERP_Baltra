// To parse this JSON data, do
//
//     final partyBalanceDetailResponse = partyBalanceDetailResponseFromJson(jsonString);

import 'dart:convert';

PartyBalanceDetailResponse partyBalanceDetailResponseFromJson(String str) =>
    PartyBalanceDetailResponse.fromJson(json.decode(str));

String partyBalanceDetailResponseToJson(PartyBalanceDetailResponse data) =>
    json.encode(data.toJson());

class PartyBalanceDetailResponse {
  PartyBalanceDetailResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<PartyBalanceDetailData>? data;
  String? message;
  int? status;

  factory PartyBalanceDetailResponse.fromJson(Map<String, dynamic> json) =>
      PartyBalanceDetailResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<PartyBalanceDetailData>.from(
                json['data'].map((x) => PartyBalanceDetailData.fromJson(x))),
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

class PartyBalanceDetailData {
  PartyBalanceDetailData({
    this.clientname,
    this.creditlimit,
    this.previousbalance,
    this.remark,
    this.orderstatus,
  });

  String? clientname;
  double? creditlimit;
  double? previousbalance;
  String? remark;
  String? orderstatus;

  factory PartyBalanceDetailData.fromJson(Map<String, dynamic> json) => PartyBalanceDetailData(
        clientname: json['clientname'],
        creditlimit: json['creditlimit'],
        previousbalance: json['previousbalance'],
        remark: json['remark'],
        orderstatus: json['orderstatus'],
      );

  Map<String, dynamic> toJson() => {
        'clientname': clientname,
        'creditlimit': creditlimit,
        'previousbalance': previousbalance,
        'remark': remark,
        'orderstatus': orderstatus,
      };
}
