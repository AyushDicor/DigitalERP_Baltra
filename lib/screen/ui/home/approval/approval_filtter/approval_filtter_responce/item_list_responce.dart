
import 'dart:convert';

ItemListResponse itemListResponseFromJson(String str) => ItemListResponse.fromJson(json.decode(str));

String itemListResponseToJson(ItemListResponse data) => json.encode(data.toJson());


class ItemListResponse {
  ItemListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  ItemListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<ItemListData>? data;
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

class ItemListData {
  ItemListData({
      this.itemid, 
      this.itemname, 
      this.itemcode, 
      this.itemdescription, 
      this.itemimage, 
      this.unit, 
      this.rate, 
      this.requiredpoint, 
      this.quantity, 
      this.unitid,});

  ItemListData.fromJson(dynamic json) {
    itemid = json['itemid'];
    itemname = json['itemname'];
    itemcode = json['itemcode'];
    itemdescription = json['itemdescription'];
    itemimage = json['itemimage'];
    unit = json['unit'];
    rate = json['rate'];
    requiredpoint = json['requiredpoint'];
    quantity = json['quantity'];
    unitid = json['unitid'];
  }
  num? itemid;
  String? itemname;
  String? itemcode;
  String? itemdescription;
  String? itemimage;
  String? unit;
  num? rate;
  num? requiredpoint;
  num? quantity;
  num? unitid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemid'] = itemid;
    map['itemname'] = itemname;
    map['itemcode'] = itemcode;
    map['itemdescription'] = itemdescription;
    map['itemimage'] = itemimage;
    map['unit'] = unit;
    map['rate'] = rate;
    map['requiredpoint'] = requiredpoint;
    map['quantity'] = quantity;
    map['unitid'] = unitid;
    return map;
  }

}