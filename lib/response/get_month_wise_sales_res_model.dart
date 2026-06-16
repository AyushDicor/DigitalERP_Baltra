class GetMonthWiseSalesResModel {
  GetMonthWiseSalesResModel({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  GetMonthWiseSalesResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MonthWiseSales.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<MonthWiseSales>? data;
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

class MonthWiseSales {
  MonthWiseSales({
      this.invoiceid, 
      this.invoiceno, 
      this.invoicedate, 
      this.partyname, 
      this.totalqty, 
      this.grandtotal,});

  MonthWiseSales.fromJson(dynamic json) {
    invoiceid = json['invoiceid'];
    invoiceno = json['invoiceno'];
    invoicedate = json['invoicedate'];
    partyname = json['partyname'];
    totalqty = json['totalqty'];
    grandtotal = json['grandtotal'];
  }
  num? invoiceid;
  String? invoiceno;
  String? invoicedate;
  String? partyname;
  String? totalqty;
  String? grandtotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceid'] = invoiceid;
    map['invoiceno'] = invoiceno;
    map['invoicedate'] = invoicedate;
    map['partyname'] = partyname;
    map['totalqty'] = totalqty;
    map['grandtotal'] = grandtotal;
    return map;
  }

}