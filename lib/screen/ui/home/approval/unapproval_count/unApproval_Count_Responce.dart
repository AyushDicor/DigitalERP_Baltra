import 'dart:convert';

UnApprovalCountResponse unApprovalCountResponseFromJson(String str) => UnApprovalCountResponse.fromJson(json.decode(str));

String unApprovalCountResponseToJson(UnApprovalCountResponse data) => json.encode(data.toJson());

class UnApprovalCountResponse {
  UnApprovalCountResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  UnApprovalCountResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UnApprovalCount.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<UnApprovalCount>? data;
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

class UnApprovalCount {
  UnApprovalCount({
      this.counttotalunapproved,});

  UnApprovalCount.fromJson(dynamic json) {
    counttotalunapproved = json['counttotalunapproved'];
  }
  num? counttotalunapproved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['counttotalunapproved'] = counttotalunapproved;
    return map;
  }

}