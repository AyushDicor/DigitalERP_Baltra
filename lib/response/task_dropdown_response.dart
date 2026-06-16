import 'dart:convert';

TaskDropdownResponse taskDropdownResponseFromJson(String str) =>
    TaskDropdownResponse.fromJson(json.decode(str));
String taskDropdownResponseToJson(TaskDropdownResponse data) =>
    json.encode(data.toJson());

class TaskDropdownResponse {
  TaskDropdownResponse({this.success, this.data, this.message, this.status});

  TaskDropdownResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) => data?.add(TaskDropdownItem.fromJson(v)));
    }
    message = json['message'];
    status = json['status'];
  }

  bool? success;
  List<TaskDropdownItem>? data;
  String? message;
  int? status;

  Map<String, dynamic> toJson() => {
    'success': success,
    if (data != null) 'data': data?.map((v) => v.toJson()).toList(),
    'message': message,
    'status': status,
  };
}

class TaskDropdownItem {
  TaskDropdownItem({this.id, this.name});

  TaskDropdownItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}