// To parse this JSON data, do
//
//     final executiveListDataResponse = executiveListDataResponseFromJson(jsonString);

import 'dart:convert';

ExecutiveListDataResponse executiveListDataResponseFromJson(String str) => ExecutiveListDataResponse.fromJson(json.decode(str));

String executiveListDataResponseToJson(ExecutiveListDataResponse data) => json.encode(data.toJson());

class ExecutiveListDataResponse {
  ExecutiveListDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<ExecutiveList>? data;
  String? message;
  int? status;

  factory ExecutiveListDataResponse.fromJson(Map<String, dynamic> json) => ExecutiveListDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<ExecutiveList>.from(json["data"]!.map((x) => ExecutiveList.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class ExecutiveList {
  ExecutiveList({
    this.executiveid,
    this.executivename,
  });

  int? executiveid;
  String? executivename;

  factory ExecutiveList.fromJson(Map<String, dynamic> json) => ExecutiveList(
    executiveid: json["executiveid"],
    executivename: json["executivename"],
  );

  Map<String, dynamic> toJson() => {
    "executiveid": executiveid,
    "executivename": executivename,
  };
}
