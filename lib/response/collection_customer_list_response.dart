// To parse this JSON data, do
//
//     final collectionCustomerListResponse = collectionCustomerListResponseFromJson(jsonString);

import 'dart:convert';

CollectionCustomerListResponse collectionCustomerListResponseFromJson(String str) =>
    CollectionCustomerListResponse.fromJson(json.decode(str));

String collectionCustomerListResponseToJson(CollectionCustomerListResponse data) => json.encode(data.toJson());

class CollectionCustomerListResponse {
  CollectionCustomerListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<CustomerData>? data;
  String? message;
  int? status;

  factory CollectionCustomerListResponse.fromJson(Map<String, dynamic> json) => CollectionCustomerListResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<CustomerData>.from(json["data"]!.map((x) => CustomerData.fromJson(x))),
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

class CustomerData {
  CustomerData({
    this.partyid,
    this.partyname,
  });

  int? partyid;
  String? partyname;

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        partyid: json["partyid"],
        partyname: json["partyname"],
      );

  Map<String, dynamic> toJson() => {
        "partyid": partyid,
        "partyname": partyname,
      };
}
