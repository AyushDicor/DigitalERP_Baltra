
import 'dart:convert';

PaymentFollowupDetailsResponse  paymentFollowupDetailsResponseFromJson(String str)=> PaymentFollowupDetailsResponse.fromJson(jsonDecode(str));
String paymentFollowupDetailsResponseToJson(PaymentFollowupDetailsResponse data)=>  jsonEncode(data.toJson());



class PaymentFollowupDetailsResponse {
  PaymentFollowupDetailsResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  PaymentFollowupDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentFollowupDetailsData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<PaymentFollowupDetailsData>? data;
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

class PaymentFollowupDetailsData {
  PaymentFollowupDetailsData({
      this.entryno, 
      this.entrydate, 
      this.partyname, 
      this.contactperson, 
      this.contactno, 
      this.username, 
      this.totalquantity, 
      this.balanceamount, 
      this.paymenthistory,});

  PaymentFollowupDetailsData.fromJson(dynamic json) {
    entryno = json['entryno'];
    entrydate = json['entrydate'];
    partyname = json['partyname'];
    contactperson = json['contactperson'];
    contactno = json['contactno'];
    username = json['username'];
    totalquantity = json['totalquantity'];
    balanceamount = json['balanceamount'];
    if (json['paymenthistory'] != null) {
      paymenthistory = [];
      json['paymenthistory'].forEach((v) {
        paymenthistory?.add(PaymentHistory.fromJson(v));
      });
    }
  }
  String? entryno;
  String? entrydate;
  String? partyname;
  String? contactperson;
  String? contactno;
  String? username;
  String? totalquantity;
  String? balanceamount;
  List<PaymentHistory>? paymenthistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['entryno'] = entryno;
    map['entrydate'] = entrydate;
    map['partyname'] = partyname;
    map['contactperson'] = contactperson;
    map['contactno'] = contactno;
    map['username'] = username;
    map['totalquantity'] = totalquantity;
    map['balanceamount'] = balanceamount;
    if (paymenthistory != null) {
      map['paymenthistory'] = paymenthistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PaymentHistory {
  PaymentHistory({
      this.sno, 
      this.followupremarks, 
      this.followupdate, 
      this.nextfollowupdate,});

  PaymentHistory.fromJson(dynamic json) {
    sno = json['sno'];
    followupremarks = json['followupremarks'];
    followupdate = json['followupdate'];
    nextfollowupdate = json['nextfollowupdate'];
  }
  String? sno;
  String? followupremarks;
  String? followupdate;
  String? nextfollowupdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sno'] = sno;
    map['followupremarks'] = followupremarks;
    map['followupdate'] = followupdate;
    map['nextfollowupdate'] = nextfollowupdate;
    return map;
  }

}