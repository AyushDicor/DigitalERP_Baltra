import 'dart:convert';


ShippingDetailsListResponse shippingDetailsListResponseFromJson(String str) => ShippingDetailsListResponse.fromJson(json.decode(str));
String shippingDetailsListResponseToJson(ShippingDetailsListResponse data) => json.encode(data.toJson());

class ShippingDetailsListResponse {
  bool? success;
  List<ShippingDetailsListData>? data;
  String? message;
  int? status;

  ShippingDetailsListResponse(
      {this.success, this.data, this.message, this.status});

  ShippingDetailsListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ShippingDetailsListData>[];
      json['data'].forEach((v) {
        data!.add(new ShippingDetailsListData.fromJson(v));
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

class ShippingDetailsListData {
  int? id;
  String? partyname;
  String? entryno;
  String? entrydate;
  String? shippingaddress;
  String? deliveredto;
  String? dispatchstatus;

  ShippingDetailsListData(
      {this.id,
        this.partyname,
        this.entryno,
        this.entrydate,
        this.shippingaddress,
        this.deliveredto,
        this.dispatchstatus});

  ShippingDetailsListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partyname = json['partyname'];
    entryno = json['entryno'];
    entrydate = json['entrydate'];
    shippingaddress = json['shippingaddress'];
    deliveredto = json['deliveredto'];
    dispatchstatus = json['dispatchstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['partyname'] = this.partyname;
    data['entryno'] = this.entryno;
    data['entrydate'] = this.entrydate;
    data['shippingaddress'] = this.shippingaddress;
    data['deliveredto'] = this.deliveredto;
    data['dispatchstatus'] = this.dispatchstatus;
    return data;
  }
}
