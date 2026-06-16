
import 'dart:convert';

OrderFollowupDetailsResponse orderFollowupDetailsResponseFromJson(String str)=> OrderFollowupDetailsResponse.fromJson(jsonDecode(str));
String orderFollowupDetailsResponseToJson(OrderFollowupDetailsResponse data)=>  jsonEncode(data.toJson());

class OrderFollowupDetailsResponse {
  OrderFollowupDetailsResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  OrderFollowupDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(OrderFollowupDetailsData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<OrderFollowupDetailsData>? data;
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

class OrderFollowupDetailsData {
  OrderFollowupDetailsData({
      this.partyname, 
      this.lastorderdate, 
      this.contactperson, 
      this.contactno, 
      this.emailid, 
      this.orderhistory,});

  OrderFollowupDetailsData.fromJson(dynamic json) {
    partyname = json['partyname'];
    lastorderdate = json['lastorderdate'];
    contactperson = json['contactperson'];
    contactno = json['contactno'];
    emailid = json['emailid'];
    if (json['orderhistory'] != null) {
      orderhistory = [];
      json['orderhistory'].forEach((v) {
        orderhistory?.add(OrderHistory.fromJson(v));
      });
    }
  }
  String? partyname;
  String? lastorderdate;
  String? contactperson;
  String? contactno;
  String? emailid;
  List<OrderHistory>? orderhistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['partyname'] = partyname;
    map['lastorderdate'] = lastorderdate;
    map['contactperson'] = contactperson;
    map['contactno'] = contactno;
    map['emailid'] = emailid;
    if (orderhistory != null) {
      map['orderhistory'] = orderhistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class OrderHistory {
  OrderHistory({
      this.sno, 
      this.followupremarks, 
      this.followupdate, 
      this.nextfollowupdate,});

  OrderHistory.fromJson(dynamic json) {
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