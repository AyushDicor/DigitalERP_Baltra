// To parse this JSON data, do
//
//     final reimburseMentTypeResponseModel = reimburseMentTypeResponseModelFromJson(jsonString);

import 'dart:convert';

ReimburseMentTypeResponseModel reimburseMentTypeResponseModelFromJson(String str) =>
    ReimburseMentTypeResponseModel.fromJson(json.decode(str));

String reimburseMentTypeResponseModelToJson(ReimburseMentTypeResponseModel data) =>
    json.encode(data.toJson());

class ReimburseMentTypeResponseModel {
  bool? success;
  List<ReimbursementDataList>? data;
  String? message;
  int? status;

  ReimburseMentTypeResponseModel({this.success, this.data, this.message, this.status});

  factory ReimburseMentTypeResponseModel.fromJson(Map<String, dynamic> json) =>
      ReimburseMentTypeResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ReimbursementDataList>.from(json["data"]!.map((x) => ReimbursementDataList.fromJson(x))),
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

class ReimbursementDataList {
  String? reimbursementType;
  int? reimbursementid;

  ReimbursementDataList({this.reimbursementType, this.reimbursementid});

  factory ReimbursementDataList.fromJson(Map<String, dynamic> json) => ReimbursementDataList(
    reimbursementType: json["ReimbursementType"],
    reimbursementid: json["Reimbursementid"],
  );

  Map<String, dynamic> toJson() => {
    "ReimbursementType": reimbursementType,
    "Reimbursementid": reimbursementid,
  };
}
// TODO Implement this library.