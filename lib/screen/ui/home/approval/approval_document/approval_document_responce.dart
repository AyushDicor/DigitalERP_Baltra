import 'dart:convert';

ApprovalDocumentResponse  approvalDocumentResponseFromJson(String str) => ApprovalDocumentResponse.fromJson(json.decode(str));

String approvalDocumentResponseToJson(ApprovalDocumentResponse data) => json.encode(data.toJson());

class ApprovalDocumentResponse {
  ApprovalDocumentResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  ApprovalDocumentResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ApprovalDocument.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<ApprovalDocument>? data;
  String? message;
  num? status;

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

class ApprovalDocument {
  ApprovalDocument({
      this.url,});

  ApprovalDocument.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}