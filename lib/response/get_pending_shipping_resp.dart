// To parse this JSON data, do
//
//     final getPendingShippingResp = getPendingShippingRespFromJson(jsonString);

import 'dart:convert';

GetPendingShippingResp getPendingShippingRespFromJson(String str) => GetPendingShippingResp.fromJson(json.decode(str));

String getPendingShippingRespToJson(GetPendingShippingResp data) => json.encode(data.toJson());

class GetPendingShippingResp {
  bool? success;
  List<GetPendingShippingData>? data;
  String? message;
  int? status;

  GetPendingShippingResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetPendingShippingResp.fromJson(Map<String, dynamic> json) => GetPendingShippingResp(
    success: json["success"],
    data:json["data"]==null?null: List<GetPendingShippingData>.from(json["data"].map((x) =>
        GetPendingShippingData.fromJson(x))),
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

class GetPendingShippingData {
  int? id;
  String? entryno;
  String? date;
  String? partyname;
  String? shippingaddress;
  String? deliveredto;
  String? shippingstatus;

  GetPendingShippingData({
    this.id,
    this.entryno,
    this.date,
    this.partyname,
    this.shippingaddress,
    this.deliveredto,
    this.shippingstatus,
  });

  factory GetPendingShippingData.fromJson(Map<String, dynamic> json) => GetPendingShippingData(
    id: json["id"],
    entryno: json["entryno"],
    date: json["date"],
    partyname: json["partyname"],
    shippingaddress: json["shippingaddress"],
    deliveredto: json["deliveredto"],
    shippingstatus: json["shippingstatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entryno": entryno,
    "date": date,
    "partyname": partyname,
    "shippingaddress": shippingaddress,
    "deliveredto": deliveredto,
    "shippingstatus": shippingstatus,
  };
}
