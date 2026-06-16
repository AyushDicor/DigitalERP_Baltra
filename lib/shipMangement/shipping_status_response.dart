

import 'dart:convert';

ShippingStatusResponse shippingStatusResponseFromJson(String str)=> ShippingStatusResponse.fromJson(json.decode(str));

String shippingStatusResponseToJSon(ShippingStatusResponse data )=> json.encode(data.toJson());

class ShippingStatusResponse {
  bool? success;
  List<ShippingStatusData>? data;
  String? message;
  int? status;

  ShippingStatusResponse({this.success, this.data, this.message, this.status});

  ShippingStatusResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ShippingStatusData>[];
      json['data'].forEach((v) {
        data!.add(new ShippingStatusData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class ShippingStatusData {
  int? statusid;
  String? statusname;

  ShippingStatusData({this.statusid, this.statusname});

  ShippingStatusData.fromJson(Map<String, dynamic> json) {
    statusid = json['statusid'];
    statusname = json['statusname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusid'] = this.statusid;
    data['statusname'] = this.statusname;
    return data;
  }
}
