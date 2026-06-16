class GetSalesReceiptGraphResModel {
  GetSalesReceiptGraphResModel({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  GetSalesReceiptGraphResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SalesReceiptData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<SalesReceiptData>? data;
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

class SalesReceiptData {
  SalesReceiptData({
      this.type, 
      this.month, 
      this.value,});

  SalesReceiptData.fromJson(dynamic json) {
    type = json['type'];
    month = json['month'];
    value = json['value'];
  }
  String? type;
  String? month;
  num? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['month'] = month;
    map['value'] = value;
    return map;
  }

}