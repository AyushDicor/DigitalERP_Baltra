// To parse this JSON data, do
//
//     final orderDetailPdfDownloadResponse = orderDetailPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailPdfDownloadResponse orderDetailPdfDownloadResponseFromJson(String str) => OrderDetailPdfDownloadResponse.fromJson(json.decode(str));

String orderDetailPdfDownloadResponseToJson(OrderDetailPdfDownloadResponse data) => json.encode(data.toJson());

class OrderDetailPdfDownloadResponse {
  OrderDetailPdfDownloadResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<PdfData>? data;
  String? message;
  int? status;

  factory OrderDetailPdfDownloadResponse.fromJson(Map<String, dynamic> json) => OrderDetailPdfDownloadResponse(
    success: json['success'] == null ? null : json["success"],
    data: json['data'] == null ? null : List<PdfData>.from(json["data"].map((x) => PdfData.fromJson(x))),
    message: json['message'] == null ? null : json["message"],
    status: json['status'] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class PdfData {
  PdfData({
    this.url,
  });

  String? url;

  factory PdfData.fromJson(Map<String, dynamic> json) => PdfData(
    url: json['url'] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
