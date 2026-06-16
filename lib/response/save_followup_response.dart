import 'dart:convert';

SaveFollowupResponse saveFollowupResponseFromJson(String str) =>
    SaveFollowupResponse.fromJson(json.decode(str));
String saveFollowupResponseToJson(SaveFollowupResponse data) =>
    json.encode(data.toJson());

class SaveFollowupResponse {
  SaveFollowupResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  SaveFollowupResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null
        ? SaveFollowupData.fromJson(json['data'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  bool? success;
  SaveFollowupData? data;
  String? message;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) map['data'] = data?.toJson();
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}

class SaveFollowupData {
  SaveFollowupData({
    this.result,
    this.message,
    this.newtransid,
    this.entrydate,
    this.status,
    this.lastcomment,
    this.completedquantity,
    this.escalatetoid,
  });

  SaveFollowupData.fromJson(dynamic json) {
    result = json['result'];
    message = json['message'];
    newtransid = json['newtransid'];
    entrydate = json['entrydate'];
    status = json['status'];
    lastcomment = json['lastcomment'];
    completedquantity = json['completedquantity'] != null
        ? double.tryParse(json['completedquantity'].toString())
        : null;
    escalatetoid = json['escalatetoid'];
  }

  String? result;
  String? message;
  int? newtransid;
  String? entrydate;
  String? status;
  String? lastcomment;
  double? completedquantity;
  int? escalatetoid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = result;
    map['message'] = message;
    map['newtransid'] = newtransid;
    map['entrydate'] = entrydate;
    map['status'] = status;
    map['lastcomment'] = lastcomment;
    map['completedquantity'] = completedquantity;
    map['escalatetoid'] = escalatetoid;
    return map;
  }
}