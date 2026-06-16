

import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/client_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/documentname_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/item_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/vendor_list_responce.dart';

class ApprovalFilterModels {
  DocumentData? documentName;
  StatusListData? status;
  ItemListData? item;
  VendorListData? vendor;
  ClientListData? client;
  DateTime? startDate;
  DateTime? endDate;

  ApprovalFilterModels(
      {this.item,
      this.vendor,
      this.client,
      this.status,
      this.documentName,
      this.startDate,
      this.endDate});

  ApprovalFilterModels.fromJson(Map<String, dynamic> json) {
    documentName = json['documentName'];
    status = json['status'];
    item = json['item'];
    vendor = json['vendor'];
    client = json['client'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> json() => {
        "documentName": documentName,
        'status': status,
        'item': item,
        'vendor': vendor,
        'client': client
      };
}
