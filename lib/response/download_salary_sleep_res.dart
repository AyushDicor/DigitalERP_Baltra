

import 'dart:convert';

DownloadSalarySleepRes downloadSalarySleepResFromJson(String str) => DownloadSalarySleepRes.fromJson(json.decode(str));
String downloadSalarySleepResToJson(DownloadSalarySleepRes data) => json.encode(data.toJson());



class DownloadSalarySleepRes {
  DownloadSalarySleepRes({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  DownloadSalarySleepRes.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DownloadSalarySleepData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<DownloadSalarySleepData>? data;
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

class DownloadSalarySleepData {
  DownloadSalarySleepData({
      this.id, 
      this.month, 
      this.netsalary, 
      this.urlname,});

  DownloadSalarySleepData.fromJson(dynamic json) {
    id = json['id'];
    month = json['month'];
    netsalary = json['netsalary'];
    urlname = json['urlname'];
  }
  num? id;
  String? month;
  String? netsalary;
  String? urlname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['month'] = month;
    map['netsalary'] = netsalary;
    map['urlname'] = urlname;
    return map;
  }

}