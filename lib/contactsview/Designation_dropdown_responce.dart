
import 'dart:convert';

DesignationDropdownResponse designationDropdownResponseFromJson(String str) =>
    DesignationDropdownResponse.fromJson(json.decode(str));

String designationDropdownResponseToJson(DesignationDropdownResponse data) =>
    json.encode(data.toJson());


class DesignationDropdownResponse {
  DesignationDropdownResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  DesignationDropdownResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DesignationData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<DesignationData>? data;
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

class DesignationData {
  DesignationData({
    this.designnationid,
    this.designnation,});

  DesignationData.fromJson(dynamic json) {
    designnationid = json['designnationid'];
    designnation = json['designnation'];
  }
  int? designnationid;
  String? designnation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['designnationid'] = designnationid;
    map['designnation'] = designnation;
    return map;
  }

}