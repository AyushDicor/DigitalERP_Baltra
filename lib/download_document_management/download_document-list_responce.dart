

import 'dart:convert';

DownloadDocumentListResponse downloadDocumentListResponseFromJson(String str) => DownloadDocumentListResponse.fromJson(json.decode(str));
String downloadDocumentListResponseToJson(DownloadDocumentListResponse data) => json.encode(data.toJson());




class DownloadDocumentListResponse {
  bool? success;
  List<DownloadDocumentListData>? data;
  String? message;
  int? status;

  DownloadDocumentListResponse(
      {this.success, this.data, this.message, this.status});

  DownloadDocumentListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DownloadDocumentListData>[];
      json['data'].forEach((v) {
        data!.add(DownloadDocumentListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class DownloadDocumentListData {
  int? documentid;
  String? documentno;
  String? documentdate;
  String? partyname;
  String? contactno;
  String? totalqty;
  String? grandtotal;
  String? flag;

  DownloadDocumentListData(
      {this.documentid,
        this.documentno,
        this.documentdate,
        this.partyname,
        this.contactno,
        this.totalqty,
        this.grandtotal,
        this.flag});

  DownloadDocumentListData.fromJson(Map<String, dynamic> json) {
    documentid = json['documentid'];
    documentno = json['documentno'];
    documentdate = json['documentdate'];
    partyname = json['partyname'];
    contactno = json['contactno'];
    totalqty = json['totalqty'];
    grandtotal = json['grandtotal'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentid'] = this.documentid;
    data['documentno'] = this.documentno;
    data['documentdate'] = this.documentdate;
    data['partyname'] = this.partyname;
    data['contactno'] = this.contactno;
    data['totalqty'] = this.totalqty;
    data['grandtotal'] = this.grandtotal;
    data['flag'] = this.flag;
    return data;
  }
}
