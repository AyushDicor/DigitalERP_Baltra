
import 'dart:convert';

BranchListResponse branchListResponseFromJson(String str) => BranchListResponse.fromJson(json.decode(str));
String branchListResponseToJson(BranchListResponse data) => json.encode(data.toJson());

class BranchListResponse {
  bool? success;
  List<BranchListData>? data;
  String? message;
  int? status;

  BranchListResponse({this.success, this.data, this.message, this.status});

  BranchListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BranchListData>[];
      json['data'].forEach((v) {
        data!.add(BranchListData.fromJson(v));
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

class BranchListData {
  String? branchname;
  int? branchid;

  BranchListData({this.branchname, this.branchid});

  BranchListData.fromJson(Map<String, dynamic> json) {
    branchname = json['branchname'];
    branchid = json['branchid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branchname'] = branchname;
    data['branchid'] = branchid;
    return data;
  }
}
