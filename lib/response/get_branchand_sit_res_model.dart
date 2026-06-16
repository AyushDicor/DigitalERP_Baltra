class GetBranchandSitResModel {
  GetBranchandSitResModel({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  GetBranchandSitResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BranchandSit.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<BranchandSit>? data;
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

class BranchandSit {
  BranchandSit({
      this.branchid, 
      this.branchname,});

  BranchandSit.fromJson(dynamic json) {
    branchid = json['branchid'];
    branchname = json['branchname'];
  }
  num? branchid;
  String? branchname;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['branchid'] = branchid;
    map['branchname'] = branchname;
    return map;
  }

}