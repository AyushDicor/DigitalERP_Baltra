import 'dart:convert';

StatusListResponse statusListResponseFromJson(String str) => StatusListResponse.fromJson(json.decode(str));

String statusListResponseToJson(StatusListResponse data) => json.encode(data.toJson());
class StatusListResponse {
  StatusListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  StatusListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StatusListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<StatusListData>? data;
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

class
StatusListData {
  StatusListData({
      this.statusid, 
      this.statusname,});

  StatusListData.fromJson(dynamic json) {
    statusid = json['statusid'];
    statusname = json['statusname'];
  }
  num? statusid;
  String? statusname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusid'] = statusid;
    map['statusname'] = statusname;
    return map;
  }

}