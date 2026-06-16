// To parse this JSON data, do
//
//     final outstandingDataResponse = outstandingDataResponseFromJson(jsonString);

import 'dart:convert';

OutstandingDataResponse outstandingDataResponseFromJson(String str) =>
    OutstandingDataResponse.fromJson(json.decode(str));

String outstandingDataResponseToJson(OutstandingDataResponse data) => json.encode(data.toJson());

class OutstandingDataResponse {
  OutstandingDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<OutstandingData>? data;
  String? message;
  int? status;

  factory OutstandingDataResponse.fromJson(Map<String, dynamic> json) => OutstandingDataResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<OutstandingData>.from(json["data"]!.map((x) => OutstandingData.fromJson(x))),
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

class OutstandingData {
  OutstandingData({
    this.partyname,
    this.creditlimit,
    this.executivename,
    this.totaldueamount,
  });

  String? partyname;
  String? creditlimit;
  String? executivename;
  String? totaldueamount;

  factory OutstandingData.fromJson(Map<String, dynamic> json) => OutstandingData(
        partyname: json["partyname"],
        creditlimit: json["creditlimit"],
        executivename: json["executivename"],
        totaldueamount: json["totaldueamount"],
      );

  Map<String, dynamic> toJson() => {
        "partyname": partyname,
        "creditlimit": creditlimit,
        "executivename": executivename,
        "totaldueamount": totaldueamount,
      };
}
