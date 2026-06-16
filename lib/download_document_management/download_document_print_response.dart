
import 'dart:convert';

DownloadDocumentPrintResponse downloadDocumentPrintResponseFromJson(String str) => DownloadDocumentPrintResponse.fromJson(json.decode(str));
String downloadDocumentPrintResponseToJson(DownloadDocumentPrintResponse data) => json.encode(data.toJson());



class DownloadDocumentPrintResponse {
  bool? success;
  List<DownloadPrintData>? data;
  String? message;
  int? status;

  DownloadDocumentPrintResponse(
      {this.success, this.data, this.message, this.status});

  DownloadDocumentPrintResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DownloadPrintData>[];
      json['data'].forEach((v) {
        data!.add(new DownloadPrintData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class DownloadPrintData {
  String? url;

  DownloadPrintData({this.url});

  DownloadPrintData.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
