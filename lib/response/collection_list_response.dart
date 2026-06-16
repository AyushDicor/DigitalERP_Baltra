// To parse this JSON data, do
//
//     final collectionListResponse = collectionListResponseFromJson(jsonString);

import 'dart:convert';

CollectionListResponse collectionListResponseFromJson(String str) => CollectionListResponse.fromJson(json.decode(str));

String collectionListResponseToJson(CollectionListResponse data) => json.encode(data.toJson());

class CollectionListResponse {
  CollectionListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<CollectionData>? data;
  String? message;
  int? status;

  factory CollectionListResponse.fromJson(Map<String, dynamic> json) => CollectionListResponse(
        success: json["success"],
        data:
            json["data"] == null ? [] : List<CollectionData>.from(json["data"]!.map((x) => CollectionData.fromJson(x))),
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

class CollectionData {
  CollectionData({
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

  factory CollectionData.fromJson(Map<String, dynamic> json) => CollectionData(
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
