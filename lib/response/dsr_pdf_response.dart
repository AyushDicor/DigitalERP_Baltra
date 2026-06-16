// To parse this JSON data, do
//
//     final dsrPdfResponse = dsrPdfResponseFromJson(jsonString);

import 'dart:convert';

DsrPdfResponse dsrPdfResponseFromJson(String str) => DsrPdfResponse.fromJson(json.decode(str));

String dsrPdfResponseToJson(DsrPdfResponse data) => json.encode(data.toJson());

class DsrPdfResponse {
  DsrPdfResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<DsrPdfUrl>? data;
  String? message;
  int? status;

  factory DsrPdfResponse.fromJson(Map<String, dynamic> json) => DsrPdfResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<DsrPdfUrl>.from(json["data"].map((x) => DsrPdfUrl.fromJson(x))),
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

class DsrPdfUrl {
  DsrPdfUrl({
    this.url,
  });

  String? url;

  factory DsrPdfUrl.fromJson(Map<String, dynamic> json) => DsrPdfUrl(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
