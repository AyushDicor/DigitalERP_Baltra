// To parse this JSON data, do
//
//     final partyLedgerPdfResponse = partyLedgerPdfResponseFromJson(jsonString);

import 'dart:convert';

PdfUrlResponse pdfUrlResponseFromJson(String str) => PdfUrlResponse.fromJson(json.decode(str));

String pdfUrlResponseToJson(PdfUrlResponse data) => json.encode(data.toJson());

class PdfUrlResponse {
  PdfUrlResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<PartyLedgerPdfData>? data;
  String? message;
  int? status;

  factory PdfUrlResponse.fromJson(Map<String, dynamic> json) => PdfUrlResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<PartyLedgerPdfData>.from(json["data"]!.map((x) => PartyLedgerPdfData.fromJson(x))),
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

class PartyLedgerPdfData {
  PartyLedgerPdfData({
    this.url,
  });

  String? url;

  factory PartyLedgerPdfData.fromJson(Map<String, dynamic> json) => PartyLedgerPdfData(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
