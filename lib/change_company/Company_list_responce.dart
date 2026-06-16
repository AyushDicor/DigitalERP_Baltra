import 'dart:convert';

CompanyListResponse companyListResponseFromJson(String str) => CompanyListResponse.fromJson(json.decode(str));
String companyListResponseToJson(CompanyListResponse data) => json.encode(data.toJson());
// class CompanyListResponse {
//   CompanyListResponse({
//       this.success,
//       this.data,
//       this.message,
//       this.status,});
//
//   CompanyListResponse.fromJson(dynamic json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <CompanyListData>[];
//       json['data'].forEach((v) {
//         data?.add(CompanyListData.fromJson(v));
//       });
//     }
//     message = json['message'];
//     status = json['status'];
//   }
//   bool? success;
//   List<CompanyListData>? data;
//   String? message;
//   int? status;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['success'] = success;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     map['message'] = message;
//     map['status'] = status;
//     return map;
//   }
//
// }
//
// class CompanyListData {
//   CompanyListData({
//     this.companyname,
//     this.compid,});
//
//   CompanyListData.fromJson(dynamic json) {
//     companyname = json['companyname'];
//     compid = json['compid'];
//   }
//   String? companyname;
//   int? compid;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['companyname'] = companyname;
//     map['compid'] = compid;
//     return map;
//   }
//
// }

class CompanyListResponse {
  bool? success;
  List<CompanyListData>? data;
  String? message;
  int? status;

  CompanyListResponse({this.success, this.data, this.message, this.status});

  CompanyListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CompanyListData>[];
      json['data'].forEach((v) {
        data!.add(CompanyListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class CompanyListData {
  String? companyname;
  int? compid;

  CompanyListData({this.companyname, this.compid});

  CompanyListData.fromJson(Map<String, dynamic> json) {
    companyname = json['companyname'];
    compid = json['compid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyname'] = companyname;
    data['compid'] = compid;
    return data;
  }
}