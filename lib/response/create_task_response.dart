import 'dart:convert';

CreateDirectTaskResponse createDirectTaskResponseFromJson(String str) =>
    CreateDirectTaskResponse.fromJson(json.decode(str));
String createDirectTaskResponseToJson(CreateDirectTaskResponse data) =>
    json.encode(data.toJson());

class CreateDirectTaskResponse {
  CreateDirectTaskResponse({this.success, this.data, this.message, this.status});

  CreateDirectTaskResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }

  bool? success;
  dynamic data;
  String? message;
  int? status;

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data,
    'message': message,
    'status': status,
  };
}