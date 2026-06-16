
import 'dart:convert';

UpdateShippingValueResponse updateShippingValueResponseFromJson(String str)=> UpdateShippingValueResponse.fromJson(json.decode(str));

String  updateShippingValueResponseToJson(UpdateShippingValueResponse data) => json.encode(data.toJson());

class UpdateShippingValueResponse {
  UpdateShippingValueResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  UpdateShippingValueResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UpdateShippingValueData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<UpdateShippingValueData>? data;
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

class UpdateShippingValueData {
  UpdateShippingValueData({
      this.shippingaddress, 
      this.shippingstatus, 
      this.deliveredto, 
      this.transportname, 
      this.grno, 
      this.vehicleno, 
      this.ewaybillno, 
      this.deliverytype, 
      this.shippingnote, 
      this.document,});

  UpdateShippingValueData.fromJson(dynamic json) {
    shippingaddress = json['shippingaddress'];
    shippingstatus = json['shippingstatus'];
    deliveredto = json['deliveredto'];
    transportname = json['transportname'];
    grno = json['grno'];
    vehicleno = json['vehicleno'];
    ewaybillno = json['ewaybillno'];
    deliverytype = json['deliverytype'];
    shippingnote = json['shippingnote'];
    document = json['document'];
  }
  String? shippingaddress;
  String? shippingstatus;
  String? deliveredto;
  String? transportname;
  String? grno;
  String? vehicleno;
  String? ewaybillno;
  String? deliverytype;
  String? shippingnote;
  String? document;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['shippingaddress'] = shippingaddress;
    map['shippingstatus'] = shippingstatus;
    map['deliveredto'] = deliveredto;
    map['transportname'] = transportname;
    map['grno'] = grno;
    map['vehicleno'] = vehicleno;
    map['ewaybillno'] = ewaybillno;
    map['deliverytype'] = deliverytype;
    map['shippingnote'] = shippingnote;
    map['document'] = document;
    return map;
  }

}