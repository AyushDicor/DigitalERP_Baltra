// To parse this JSON data, do
//
//     final dashboardDetailsResponse = dashboardDetailsResponseFromJson(jsonString);

import 'dart:convert';

DashboardDetailsResponse dashboardDetailsResponseFromJson(String str) =>
    DashboardDetailsResponse.fromJson(json.decode(str));

class DashboardDetailsResponse {
  DashboardDetailsResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<DashboardDetailsData>? data;
  String? message;
  int? status;

  factory DashboardDetailsResponse.fromJson(Map<String, dynamic> json) =>
      DashboardDetailsResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<DashboardDetailsData>.from(
            json['data'].map((x) => DashboardDetailsData.fromJson(x))),
        message: json['message'],
        status: json['status'],
      );
}

class DashboardDetailsData {
  DashboardDetailsData({
    this.documentId,
    this.documentNumber,
    this.documentType,
    this.documentDate,
    this.title,
    this.description,
    this.executiveName,
  });

  String? documentId;
  String? documentNumber;
  String? documentType;
  String? documentDate;
  // String? docDate;
  String? title;
  String? description;
  String? executiveName;

  factory DashboardDetailsData.fromJson(Map<String, dynamic> json) =>
      DashboardDetailsData(
        documentId: json['documentid'].toString(),
        documentNumber: json['documentnumber'].toString(),
        documentType: json['documenttype'].toString(),
        documentDate: json['documentdate'],
        // docDate: DateTime.parse(json['doc_date']).toIso8601String(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        executiveName: json['executive_name'].toString(),
      );
}
