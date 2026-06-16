import 'dart:convert';

TaskUpdateResponse taskUpdateResponseFromJson(String str) =>
    TaskUpdateResponse.fromJson(json.decode(str));
String taskUpdateResponseToJson(TaskUpdateResponse data) =>
    json.encode(data.toJson());

class TaskUpdateResponse {
  TaskUpdateResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  TaskUpdateResponse.fromJson(dynamic json) {
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
