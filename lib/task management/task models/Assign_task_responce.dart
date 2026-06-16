import 'dart:convert';

AssignTaskResponse assignTaskResponseFromJson(String str) =>
    AssignTaskResponse.fromJson(json.decode(str));

String assignTaskResponseToJson(AssignTaskResponse data) =>
    json.encode(data.toJson());

class AssignTaskResponse {
  AssignTaskResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  AssignTaskResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  dynamic data;
  String? message;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}
