
import 'dart:convert';

DocumentnameResponse documentnameResponseFromJson(String str) => DocumentnameResponse.fromJson(json.decode(str));

String documentnameResponseToJson(DocumentnameResponse data) => json.encode(data.toJson());

class DocumentnameResponse {
  DocumentnameResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  DocumentnameResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DocumentData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<DocumentData>? data;
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

class DocumentData {
  DocumentData({
      this.documentname,});

  DocumentData.fromJson(dynamic json) {
    documentname = json['Documentname'];
  }
  String? documentname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Documentname'] = documentname;
    return map;
  }

}