class GetApproverNameResModel {
  GetApproverNameResModel({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  GetApproverNameResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ApproverNameData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<ApproverNameData>? data;
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

class ApproverNameData {
  ApproverNameData({
      this.approverid, 
      this.approvername,});

  ApproverNameData.fromJson(dynamic json) {
    approverid = json['approverid'];
    approvername = json['approvername'];
  }
  num? approverid;
  String? approvername;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['approverid'] = approverid;
    map['approvername'] = approvername;
    return map;
  }

}