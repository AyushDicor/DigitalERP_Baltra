// To parse this JSON data, do
//
//     final stateDataResponse = stateDataResponseFromJson(jsonString);

import 'dart:convert';

StateDataResponse stateDataResponseFromJson(String str) => StateDataResponse.fromJson(json.decode(str));

String stateDataResponseToJson(StateDataResponse data) => json.encode(data.toJson());

class StateDataResponse {
  StateDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<StateDataList>? data;
  String? message;
  int? status;

  factory StateDataResponse.fromJson(Map<String, dynamic> json) => StateDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<StateDataList>.from(json["data"]!.map((x) => StateDataList.fromJson(x))),
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

class StateDataList {
  StateDataList({
    this.stateid,
    this.statename,
  });

  int? stateid;
  String? statename;

  factory StateDataList.fromJson(Map<String, dynamic> json) => StateDataList(
    stateid: json["stateid"],
    statename: json["statename"],
  );

  Map<String, dynamic> toJson() => {
    "stateid": stateid,
    "statename": statename,
  };
}
