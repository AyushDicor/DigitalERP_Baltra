
import 'dart:convert';

import 'package:flutter/cupertino.dart';

StockReconciliationReportResponse stockReconciliationReportResponseFromJson(String str) => StockReconciliationReportResponse.fromJson(json.decode(str));
String stockReconciliationReportResponseToJson(StockReconciliationReportResponse data) => json.encode(data.toJson());


class StockReconciliationReportResponse {
  StockReconciliationReportResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  StockReconciliationReportResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StockReconciliationData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<StockReconciliationData>? data;
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

class StockReconciliationData {
  StockReconciliationData({
      this.maingroup, 
      this.subgroup, 
      this.brand, 
      this.itemname, 
      this.rate, 
      this.erpquantity, 
      this.unit, 
      this.amount, 
      this.itemcode, 
      this.rackno, 
      this.itemid, 
      this.lastreconciledate,
     this.phyQtyController,
     this.scarpController,
     this.reOrderController,
     this.miniStkQtyController,
    this.postingdatetime,
    this.postingstatus,
  });

  StockReconciliationData.fromJson(dynamic json) {
    maingroup = json['Maingroup'];
    subgroup = json['subgroup'];
    brand = json['brand'];
    itemname = json['itemname'];
    rate = json['rate'];
    erpquantity = json['erpquantity'];
    unit = json['unit'];
    amount = json['amount'];
    itemcode = json['itemcode'];
    rackno = json['rackno'];
    itemid = json['itemid'];
    phyQtyController = TextEditingController(text: json['erpquantity'].toString());
    scarpController = TextEditingController();
    lastreconciledate = json['lastreconciledate'];
    reOrderController = TextEditingController(text: json['reorderlevel'].toString());
    miniStkQtyController = TextEditingController(text: json['minstockquantity'].toString());
    postingdatetime = json['postingdatetime'];
    postingstatus = json['postingstatus'];
  }
  String? maingroup;
  String? subgroup;
  String? brand;
  String? itemname;
  num? rate;
  num? erpquantity;
  String? unit;
  num? amount;
  String? itemcode;
  String? rackno;
  String? itemid;
  String? lastreconciledate;
  TextEditingController? phyQtyController;
  TextEditingController? scarpController;
  TextEditingController? reOrderController;
  TextEditingController? miniStkQtyController;
  String? postingdatetime;
  num? postingstatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Maingroup'] = maingroup;
    map['subgroup'] = subgroup;
    map['brand'] = brand;
    map['itemname'] = itemname;
    map['rate'] = rate;
    map['erpquantity'] = erpquantity;
    map['unit'] = unit;
    map['amount'] = amount;
    map['itemcode'] = itemcode;
    map['rackno'] = rackno;
    map['itemid'] = itemid;
    map['lastreconciledate'] = lastreconciledate;
    map['phyQtyController'] = phyQtyController?.text;
    map['scarpController'] = scarpController?.text;
    map['reOrderController'] = reOrderController?.text;
    map['miniStkQtyController'] = miniStkQtyController?.text;
    map['postingdatetime'] = postingdatetime;
    map['postingstatus'] = postingstatus;
    return map;
  }

}