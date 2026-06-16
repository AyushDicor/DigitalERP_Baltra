
import 'dart:convert';

AddContactsViewResponse addContactsViewResponseFromJson(String str) => AddContactsViewResponse.fromJson(json.decode(str));

String addContactsViewResponseToJson(AddContactsViewResponse data) => json.encode(data.toJson());


class AddContactsViewResponse {
  AddContactsViewResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  AddContactsViewResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AddContactsData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<AddContactsData>? data;
  String? message;
  int? status;

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

class AddContactsData {
  AddContactsData({
    this.contactPerson,
    this.designation,
    this.whatsappno,
    this.emailid,
    this.dob,
    this.associatedate,
    this.commissionpercent,});

  AddContactsData.fromJson(dynamic json) {
    contactPerson = json['contactPerson'];
    designation = json['designation'];
    whatsappno = json['whatsappno'];
    emailid = json['emailid'];
    dob = json['dob'];
    associatedate = json['associatedate'];
    commissionpercent = json['commissionpercent'];
  }
  String? contactPerson;
  String? designation;
  String? whatsappno;
  String? emailid;
  String? dob;
  String? associatedate;
  String? commissionpercent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contactPerson'] = contactPerson;
    map['designation'] = designation;
    map['whatsappno'] = whatsappno;
    map['emailid'] = emailid;
    map['dob'] = dob;
    map['associatedate'] = associatedate;
    map['commissionpercent'] = commissionpercent;
    return map;
  }

}