
import 'dart:convert';

AddContactsDetailsResponse addContactsDetailsResponseFromJson(String str) => AddContactsDetailsResponse.fromJson(json.decode(str));

String addContactsDetailsResponseToJson(AddContactsDetailsResponse data) => json.encode(data.toJson());


class AddContactsDetailsResponse {
  bool? success;
  Null? data;
  String? message;
  int? status;

  AddContactsDetailsResponse({this.success, this.data, this.message, this.status});

  AddContactsDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
