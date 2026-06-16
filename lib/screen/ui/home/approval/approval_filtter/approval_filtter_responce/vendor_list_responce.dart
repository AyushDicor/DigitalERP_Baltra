import 'dart:convert';

VendorListResponse vendorListResponseFromJson(String str) => VendorListResponse.fromJson(json.decode(str));

String vendorListResponseToJson(VendorListResponse data) => json.encode(data.toJson());

class VendorListResponse {
  VendorListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  VendorListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(VendorListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<VendorListData>? data;
  String? message;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}

class VendorListData {
  VendorListData({
      this.vendorid, 
      this.vendorname,});

  VendorListData.fromJson(dynamic json) {
    vendorid = json['vendorid'];
    vendorname = json['vendorname'];
  }
  num? vendorid;
  String? vendorname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendorid'] = vendorid;
    map['vendorname'] = vendorname;
    return map;
  }

}