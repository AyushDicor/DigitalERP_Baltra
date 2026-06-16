// To parse this JSON data, do
//
//     final customerDetailResponse = customerDetailResponseFromJson(jsonString);

import 'dart:convert';

CustomerDetailResponse customerDetailResponseFromJson(String str) => CustomerDetailResponse.fromJson(json.decode(str));

String customerDetailResponseToJson(CustomerDetailResponse data) => json.encode(data.toJson());

class CustomerDetailResponse {
  CustomerDetailResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<CustomerListData>? data;
  String? message;
  int? status;

  factory CustomerDetailResponse.fromJson(Map<String, dynamic> json) => CustomerDetailResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<CustomerListData>.from(json["data"].map((x) => CustomerListData.fromJson(x))),
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

class CustomerListData {
  CustomerListData(
      {this.partyid,
      this.partyname,
      this.mobileno,
      this.address,
      this.location,
      this.executive,
      this.outstanding,
      this.remarks,
      this.isUpdating = false});

  int? partyid;
  String? partyname;
  String? mobileno;
  String? address;
  String? location;
  String? executive;
  String? outstanding;
  String? remarks;
  bool? isUpdating;

  factory CustomerListData.fromJson(Map<String, dynamic> json) => CustomerListData(
        partyid: json["partyid"],
        partyname: json["partyname"].toString(),
        mobileno: json["mobileno"],
        address: json["address"],
        location: json["location"],
        executive: json["executive"].toString(),
        outstanding: json["outstanding"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "partyid": partyid,
        "partyname": partyname,
        "mobileno": mobileno,
        "address": address,
        "location": location,
        "executive": executive,
        "outstanding": outstanding,
        "remarks": remarks,
      };
}
