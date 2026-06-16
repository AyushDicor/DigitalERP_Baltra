// To parse this JSON data, do
//
//     final executiveDropdownResponse = executiveDropdownResponseFromJson(jsonString);

import 'dart:convert';

ExecutiveDropdownResponse executiveDropdownResponseFromJson(String str) =>
    ExecutiveDropdownResponse.fromJson(json.decode(str));

String executiveDropdownResponseToJson(ExecutiveDropdownResponse data) =>
    json.encode(data.toJson());

class ExecutiveDropdownResponse {
  ExecutiveDropdownResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<ExecutiveDropdownData>? data;
  String? message;
  int? status;

  factory ExecutiveDropdownResponse.fromJson(Map<String, dynamic> json) =>
      ExecutiveDropdownResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<ExecutiveDropdownData>.from(
            json['data'].map((x) => ExecutiveDropdownData.fromJson(x))),
        message: json['message'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'status': status,
      };
}

class ExecutiveDropdownData {


  ExecutiveDropdownData({
    this.executiveId,
    this.executiveName,});

  int? executiveId;
  String? executiveName;

  factory ExecutiveDropdownData.fromJson(Map<String, dynamic> json) =>
      ExecutiveDropdownData(
        executiveId: json['executiveid'],
        executiveName: json['executivename'],
      );

  Map<String, dynamic> toJson() => {
        'executiveid': executiveId,
        'executivename': executiveName,
      };
}
