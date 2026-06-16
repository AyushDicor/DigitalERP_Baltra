
import 'dart:convert';

PerformanceListResponse performanceListResponseFromJson(String str)=> PerformanceListResponse.fromJson(jsonDecode(str));
String performanceListResponseToJson(PerformanceListResponse data )=> json.encode(data.toJson());


class PerformanceListResponse {
  PerformanceListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  PerformanceListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PerformanceData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<PerformanceData>? data;
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

class PerformanceData {
  PerformanceData({
      this.executiveid, 
      this.executivename, 
      this.salestarget, 
      this.totalsales, 
      this.totalbilledamt, 
      this.totalcollectedamt, 
      this.totalachive,});

  PerformanceData.fromJson(dynamic json) {
    executiveid = json['executiveid'];
    executivename = json['executivename'];
    salestarget = json['salestarget'];
    totalsales = json['totalsales'];
    totalbilledamt = json['totalbilledamt'];
    totalcollectedamt = json['totalcollectedamt'];
    totalachive = json['totalachive'];
  }
  num? executiveid;
  String? executivename;
  String? salestarget;
  String? totalsales;
  String? totalbilledamt;
  String? totalcollectedamt;
  String? totalachive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['executiveid'] = executiveid;
    map['executivename'] = executivename;
    map['salestarget'] = salestarget;
    map['totalsales'] = totalsales;
    map['totalbilledamt'] = totalbilledamt;
    map['totalcollectedamt'] = totalcollectedamt;
    map['totalachive'] = totalachive;
    return map;
  }

}