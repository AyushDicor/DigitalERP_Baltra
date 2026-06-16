// To parse this JSON data, do
//
//     final menuDetailsResponse = menuDetailsResponseFromJson(jsonString);

import 'dart:convert';

MenuDetailsResponse menuDetailsResponseFromJson(String str) => MenuDetailsResponse.fromJson(json.decode(str));

String menuDetailsResponseToJson(MenuDetailsResponse data) => json.encode(data.toJson());

class MenuDetailsResponse {
  MenuDetailsResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<MenuItem>? data;
  String? message;
  int? status;

  factory MenuDetailsResponse.fromJson(Map<String, dynamic> json) => MenuDetailsResponse(
    success: json['success'],
    data: json['data'] == null
        ? null
        : List<MenuItem>.from(json['data'].map((x) => MenuItem.fromJson(x))),
    message: json['message'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': List<dynamic>.from(data!.map((x) => x.toJson())),
    'message': message,
    'status': status,
  };

  @override
  String toString() {
    return 'MenuDetailsResponse{success: $success, data: $data, message: $message, status: $status}';
  }
}

class MenuItem {
  MenuItem({
    this.menuId,
    this.menuName,
  });

  int? menuId;
  String? menuName;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    menuId: json['menu_id'],
    menuName: json['menu_name'],
  );

  Map<String, dynamic> toJson() => {
    'menu_id': menuId,
    'menu_name': menuName,
  };

  @override
  String toString() {
    return 'MenuItem{menuId: $menuId, menuName: $menuName}';
  }
}
