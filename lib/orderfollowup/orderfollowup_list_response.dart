
import 'dart:convert';

OrderFollowupListResponse orderFollowupListResponseFromJson(String str)=> OrderFollowupListResponse.fromJson(jsonDecode(str));
String orderFollowupListResponseToJson(OrderFollowupListResponse data)=> jsonEncode(data.toJson());

class OrderFollowupListResponse {
  OrderFollowupListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  OrderFollowupListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(OrderFollowupListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<OrderFollowupListData>? data;
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

class OrderFollowupListData {
  OrderFollowupListData({
      this.followupid, 
      this.partyname, 
      this.lastorderdate, 
      this.contactperson, 
      this.contactno, 
      this.emailid, 
      this.country, 
      this.state, 
      this.city,});

  OrderFollowupListData.fromJson(dynamic json) {
    followupid = json['followupid'];
    partyname = json['partyname'];
    lastorderdate = json['lastorderdate'];
    contactperson = json['contactperson'];
    contactno = json['contactno'];
    emailid = json['emailid'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }
  num? followupid;
  String? partyname;
  String? lastorderdate;
  String? contactperson;
  String? contactno;
  String? emailid;
  String? country;
  String? state;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['followupid'] = followupid;
    map['partyname'] = partyname;
    map['lastorderdate'] = lastorderdate;
    map['contactperson'] = contactperson;
    map['contactno'] = contactno;
    map['emailid'] = emailid;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    return map;
  }

}