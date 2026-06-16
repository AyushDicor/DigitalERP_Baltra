class IncentiveGraphDetailResModel {
  IncentiveGraphDetailResModel({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  IncentiveGraphDetailResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(IncentiveGraphData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<IncentiveGraphData>? data;
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

class IncentiveGraphData {
  IncentiveGraphData({
      this.total, 
      this.details,});

  IncentiveGraphData.fromJson(dynamic json) {
    total = json['total'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(IncentiveGraphDetails.fromJson(v));
      });
    }
  }
  num? total;
  List<IncentiveGraphDetails>? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class IncentiveGraphDetails {
  IncentiveGraphDetails({
      this.commisiontype, 
      this.value,});

  IncentiveGraphDetails.fromJson(dynamic json) {
    commisiontype = json['commisiontype'];
    value = json['value'];
  }
  String? commisiontype;
  num? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commisiontype'] = commisiontype;
    map['value'] = value;
    return map;
  }

}