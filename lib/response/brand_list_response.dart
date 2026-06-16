

import 'dart:convert';

BrandListResponse brandListResponseFromJson(String str) => BrandListResponse.fromJson(json.decode(str));
String brandListResponseToJson(BrandListResponse data) => json.encode(data.toJson());

class BrandListResponse {
  BrandListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  BrandListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BrandListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<BrandListData>? data;
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

class BrandListData {
  BrandListData({
      this.brandid, 
      this.brandname, 
      this.brandimage,});

  BrandListData.fromJson(dynamic json) {
    brandid = json['brandid'];
    brandname = json['brandname'];
    brandimage = json['brandimage'];
  }
  num? brandid;
  String? brandname;
  String? brandimage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brandid'] = brandid;
    map['brandname'] = brandname;
    map['brandimage'] = brandimage;
    return map;
  }

}