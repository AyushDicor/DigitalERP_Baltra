// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  UserData? data;
  String? message;
  int? status;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json['success'],
        data:  json['data'] == null
            ? null
            :UserData.fromJson(json['data']),
        message: json['message'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
        'status': status,
      };
}

class UserData {
  UserData({
    this.userid,
    this.name,
    this.usertype,
    this.compId,
    this.branchId,
    this.accountCode,
    this.yearId,
    this.mobile,
    this.address,
    this.mobileVerifyStatus,
    this.profileStatus,
    this.photo,
    this.email,
    this.otp,

  });

  int? userid;
  String? name;
  String? usertype;
  int? compId;
  int? branchId;
  int? accountCode;
  String? yearId;
  String? mobile;
  String? address;
  int? mobileVerifyStatus;
  int? profileStatus;
  String? photo;
  String? email;
  String? otp;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userid: json['userid'],
        name: json['name'],
        usertype: json['usertype'],
        compId: json['compid'],
        branchId: json['branchId'],
        accountCode: json['accountcode'],
        yearId: json['yearid'],
        mobile: json['mobile'],
        address: json['address'],
        mobileVerifyStatus: json['mobileverifystatus'],
        profileStatus: json['profilestatus'],
        photo: json['photo'],
        email: json['email'],
        otp: json['otp'],

      );

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'name': name,
        'usertype': usertype,
        'compid': compId,
        'branchId': branchId,
        'accountcode': accountCode,
        'yearid': yearId,
        'mobile': mobile,
        'address': address,
        'mobileverifystatus': mobileVerifyStatus,
        'profilestatus': profileStatus,
        'photo': photo,
        'email': email,
        'otp': otp,
      };

  @override
  String toString() {
    return 'UserData{userid: $userid, '
        'name: $name,'
        ' usertype: $usertype, '
        'compId: $compId,'
        ' branchId: $branchId,'
        ' accountCode: $accountCode, '
        'yearId: $yearId, '
        'mobile: $mobile,'
        ' address: $address,'
        ' mobileVerifyStatus: $mobileVerifyStatus,'
        ' profileStatus: $profileStatus,'
        ' photo: $photo, '
        'email: $email,'
        'otp: $otp'
        '}';
  }
}
