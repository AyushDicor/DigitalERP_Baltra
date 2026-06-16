class ShowPerformanceGraphResModel {
  ShowPerformanceGraphResModel({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  ShowPerformanceGraphResModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PerformanceGraphData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<PerformanceGraphData>? data;
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

class PerformanceGraphData {
  PerformanceGraphData({
      this.performancepercent,});

  PerformanceGraphData.fromJson(dynamic json) {
    performancepercent = json['performancepercent'];
  }
  num? performancepercent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['performancepercent'] = performancepercent;
    return map;
  }

}