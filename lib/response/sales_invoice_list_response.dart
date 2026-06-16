
import 'dart:convert';

SalesInvoiceListResponse salesInvoiceListResponseFromJson(String str) => SalesInvoiceListResponse.fromJson(json.decode(str));

String salesInvoiceListResponseToJson(SalesInvoiceListResponse data) => json.encode(data.toJson());

class SalesInvoiceListResponse {
  SalesInvoiceListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  SalesInvoiceListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SalesInvoiceData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<SalesInvoiceData>? data;
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

class SalesInvoiceData {
  SalesInvoiceData({
      this.invoiceno, 
      this.invoicedate, 
      this.buyername, 
      this.itemname, 
      this.qty, 
      this.rate, 
      this.gstpercent, 
      this.taxableamt, 
      this.gstamt, 
      this.amount,});

  SalesInvoiceData.fromJson(dynamic json) {
    invoiceno = json['invoiceno'];
    invoicedate = json['invoicedate'];
    buyername = json['buyername'];
    itemname = json['itemname'];
    qty = json['qty'];
    rate = json['rate'];
    gstpercent = json['gstpercent'];
    taxableamt = json['taxableamt'];
    gstamt = json['gstamt'];
    amount = json['amount'];
  }
  String? invoiceno;
  String? invoicedate;
  String? buyername;
  String? itemname;
  num? qty;
  num? rate;
  num? gstpercent;
  num? taxableamt;
  num? gstamt;
  num? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceno'] = invoiceno;
    map['invoicedate'] = invoicedate;
    map['buyername'] = buyername;
    map['itemname'] = itemname;
    map['qty'] = qty;
    map['rate'] = rate;
    map['gstpercent'] = gstpercent;
    map['taxableamt'] = taxableamt;
    map['gstamt'] = gstamt;
    map['amount'] = amount;
    return map;
  }

}