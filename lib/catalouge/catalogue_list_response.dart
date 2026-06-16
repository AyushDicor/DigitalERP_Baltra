
import 'dart:convert';

CatalougeListResponse catalogueListResponseFromJson(String str)=> CatalougeListResponse.fromJson(json.decode(str));
String catalogueListResponse(CatalougeListResponse data) => json.encode(data.toJson());

class CatalougeListResponse {
  CatalougeListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  CatalougeListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CatalougeData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<CatalougeData>? data;
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

class CatalougeData {
  CatalougeData({
      this.categoryname, 
      this.catalouhefile,});

  CatalougeData.fromJson(dynamic json) {
    categoryname = json['categoryname'];
    catalouhefile = json['catalouhefile'];
  }
  String? categoryname;
  String? catalouhefile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryname'] = categoryname;
    map['catalouhefile'] = catalouhefile;
    return map;
  }

}