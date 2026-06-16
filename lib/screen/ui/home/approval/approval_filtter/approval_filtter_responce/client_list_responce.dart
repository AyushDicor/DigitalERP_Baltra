

import 'dart:convert';

ClientListResponse clientListResponseFromJson(String str) => ClientListResponse.fromJson(json.decode(str));

String clientListResponseToJson(ClientListResponse data) => json.encode(data.toJson());

class ClientListResponse {
  ClientListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  ClientListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ClientListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<ClientListData>? data;
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

class ClientListData {
  ClientListData({
      this.clientid, 
      this.clientname,});

  ClientListData.fromJson(dynamic json) {
    clientid = json['clientid'];
    clientname = json['clientname'];
  }
  num? clientid;
  String? clientname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clientid'] = clientid;
    map['clientname'] = clientname;
    return map;
  }

}