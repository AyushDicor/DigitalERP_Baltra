import 'dart:convert';

RackListResponse rackListResponseFromJson(String str) => RackListResponse.fromJson(json.decode(str));

String rackListResponseToJson(RackListResponse data) => json.encode(data.toJson());
class RackListResponse {
  RackListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  RackListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RackListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<RackListData>? data;
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

class RackListData {
  RackListData({
      this.rackno,});

  RackListData.fromJson(dynamic json) {
    rackno = json['rackno'];
  }
  String? rackno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rackno'] = rackno;
    return map;
  }

}