


import 'dart:convert';

PaymentFollowupListResponse paymentFollowupListResponseFromJson(String str)=> PaymentFollowupListResponse.fromJson(jsonDecode(str));
String paymentFollowupListResponseToJson(PaymentFollowupListResponse data)=>  jsonEncode(data.toJson());

class PaymentFollowupListResponse {
  PaymentFollowupListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  PaymentFollowupListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentFollowupListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<PaymentFollowupListData>? data;
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

class PaymentFollowupListData {
  PaymentFollowupListData({
      this.followupid, 
      this.entryno, 
      this.entrydate, 
      this.partyname, 
      this.contactperson, 
      this.contactno, 
      this.username, 
      this.totalquantity, 
      this.balanceamount,});

  PaymentFollowupListData.fromJson(dynamic json) {
    followupid = json['followupid'];
    entryno = json['entryno'];
    entrydate = json['entrydate'];
    partyname = json['partyname'];
    contactperson = json['contactperson'];
    contactno = json['contactno'];
    username = json['username'];
    totalquantity = json['totalquantity'];
    balanceamount = json['balanceamount'];
  }
  num? followupid;
  String? entryno;
  String? entrydate;
  String? partyname;
  String? contactperson;
  String? contactno;
  String? username;
  String? totalquantity;
  String? balanceamount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['followupid'] = followupid;
    map['entryno'] = entryno;
    map['entrydate'] = entrydate;
    map['partyname'] = partyname;
    map['contactperson'] = contactperson;
    map['contactno'] = contactno;
    map['username'] = username;
    map['totalquantity'] = totalquantity;
    map['balanceamount'] = balanceamount;
    return map;
  }

}