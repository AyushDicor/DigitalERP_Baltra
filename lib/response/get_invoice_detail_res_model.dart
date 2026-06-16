class GetInvoiceDetailResModel {
  GetInvoiceDetailResModel({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  GetInvoiceDetailResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InvoiceDetailData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<InvoiceDetailData>? data;
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

class InvoiceDetailData {
  InvoiceDetailData({
      this.itemname, 
      this.quantity, 
      this.price, 
      this.amount,});

  InvoiceDetailData.fromJson(dynamic json) {
    itemname = json['itemname'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
  }
  String? itemname;
  String? quantity;
  String? price;
  String? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemname'] = itemname;
    map['quantity'] = quantity;
    map['price'] = price;
    map['amount'] = amount;
    return map;
  }

}