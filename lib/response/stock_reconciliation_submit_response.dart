
import 'dart:convert';

StockReconciliationSubmitResponse stockReconciliationSubmitResponseFromJson(String str) => StockReconciliationSubmitResponse.fromJson(json.decode(str));

String stockReconciliationSubmitResponseToJson(StockReconciliationSubmitResponse data) => json.encode(data.toJson());


class StockReconciliationSubmitResponse {
  StockReconciliationSubmitResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  StockReconciliationSubmitResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StockReconciliationSubmitData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<StockReconciliationSubmitData>? data;
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

class StockReconciliationSubmitData {
  StockReconciliationSubmitData({
      this.postingdatetime, 
      this.postingstatus,});

  StockReconciliationSubmitData.fromJson(dynamic json) {
    postingdatetime = json['postingdatetime'];
    postingstatus = json['postingstatus'];
  }
  String? postingdatetime;
  num? postingstatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postingdatetime'] = postingdatetime;
    map['postingstatus'] = postingstatus;
    return map;
  }

}