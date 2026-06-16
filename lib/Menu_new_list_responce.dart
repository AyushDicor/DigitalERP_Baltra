
import 'dart:convert';

MenuNewListResponse menuNewListResponseFromJson(String str) => MenuNewListResponse.fromJson(json.decode(str));

String menuNewListResponseToJson(MenuNewListResponse data) => json.encode(data.toJson());

class MenuNewListResponse {
  MenuNewListResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  MenuNewListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MenuNewData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<MenuNewData>? data;
  String? message;
  int? status;

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
class MenuNewData {
  MenuNewData({
    this.menuid,
    this.menuname,
    this.imageurl,
    this.child,});

  MenuNewData.fromJson(dynamic json) {
    menuid = json['menuid'];
    menuname = json['menuname'];
    imageurl = json['imageurl'];
    child = json['child'];
  }
  int? menuid;
  String? menuname;
  String? imageurl;
  int? child;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuid'] = menuid;
    map['menuname'] = menuname;
    map['imageurl'] = imageurl;
    map['child'] = child;
    return map;
  }

}