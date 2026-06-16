
import 'dart:convert';

OrderFollowupSaveResponse orderFollowupSaveResponseFromJson(String str) => OrderFollowupSaveResponse.fromJson(jsonDecode(str));

String orderFollowupSaveResponseToJson(OrderFollowupSaveResponse data)=> jsonEncode(data.toJson());
class OrderFollowupSaveResponse {
  OrderFollowupSaveResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  OrderFollowupSaveResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  dynamic data;
  String? message;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}