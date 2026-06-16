
import 'dart:convert';

UpdateApprovalstatusResponse updateApprovalstatusResponseFromJson(String str) => UpdateApprovalstatusResponse.fromJson(json.decode(str));

String updateApprovalstatusResponseToJson(UpdateApprovalstatusResponse data) => json.encode(data.toJson());


class UpdateApprovalstatusResponse {
  UpdateApprovalstatusResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  UpdateApprovalstatusResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  dynamic data;
  String? message;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}