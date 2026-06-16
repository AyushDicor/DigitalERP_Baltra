import 'dart:convert';

DownloadDocumentTypeResponse downloadDocumentTypeResponseFromJson(String str) => DownloadDocumentTypeResponse.fromJson(json.decode(str));
String downloadDocumentTypeResponseToJson(DownloadDocumentTypeResponse data) => json.encode(data.toJson());

class DownloadDocumentTypeResponse {
  DownloadDocumentTypeResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  DownloadDocumentTypeResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DownloadDocumentData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<DownloadDocumentData>? data;
  String? message;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}

class DownloadDocumentData {
  DownloadDocumentData({
    this.did,
    this.documentname,});

  DownloadDocumentData.fromJson(dynamic json) {
    did = json['did'];
    documentname = json['documentname'];
  }
  int? did;
  String? documentname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['did'] = did;
    map['documentname'] = documentname;
    return map;
  }

}