// To parse this JSON data, do
//
//     final executiveListResponse = executiveListResponseFromJson(jsonString);

import 'dart:convert';

ExecutiveListResponse executiveListResponseFromJson(String str) => ExecutiveListResponse.fromJson(json.decode(str));

String executiveListResponseToJson(ExecutiveListResponse data) => json.encode(data.toJson());

class ExecutiveListResponse {
  ExecutiveListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<ExecutiveLatLongData>? data;
  String? message;
  int? status;

  factory ExecutiveListResponse.fromJson(Map<String, dynamic> json) => ExecutiveListResponse(
    success: json['success'],
    data:  json['data'] == null
        ? null
        :List<ExecutiveLatLongData>.from(json['data'].map((x) => ExecutiveLatLongData.fromJson(x))),
    message: json['message'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': List<dynamic>.from(data!.map((x) => x.toJson())),
    'message': message,
    'status': status,
  };
}

class ExecutiveLatLongData {
  ExecutiveLatLongData({
    this.executiveid,
    this.executivename,
    this.attendence,
    this.latitude,
    this.longitude,
    this.location,
    this.userid,
    this.photo,
    this.date,
    //  new dashboard fields (nullable — safe before backend deploys) 
    this.designation,
    this.inTime,
    this.outTime,
    this.locationUpdatedAt,
    this.monthPresent,
    this.monthAbsent,
    this.monthLeave,
    this.totalWorkingDays,
  });

  //  existing fields (unchanged) 
  int? executiveid;
  String? executivename;
  String? attendence;
  double? latitude;
  double? longitude;
  String? location;
  int? userid;
  String? photo;
  String? date;

  //  new fields (ask backend to add to getExecutiveListWithLatLong) 
  String? designation;        // e.g. "Field Executive"
  String? inTime;             // today's check-in  e.g. "09:32 AM"
  String? outTime;            // today's check-out, null if still clocked in
  String? locationUpdatedAt;  // e.g. "10 mins ago"
  int? monthPresent;          // days present this month
  int? monthAbsent;           // days absent this month
  int? monthLeave;            // days on leave this month
  int? totalWorkingDays;      // total working days in the month

  factory ExecutiveLatLongData.fromJson(Map<String, dynamic> json) =>
      ExecutiveLatLongData(
        //  existing keys (preserved exactly) 
        executiveid: json['Executiveid'],
        executivename: json['executivename'],
        attendence: json['attendence'],
        latitude: double.parse(json['latitude'].toString()),
        longitude: double.parse(json['longitude'].toString()),
        location: json['location'],
        userid: json['userid'],
        photo: json['photo'],
        date: json['date'],
        //  new keys (safe — returns null if key absent) 
        designation: json['designation'],
        inTime: json['inTime'],
        outTime: json['outTime'],
        locationUpdatedAt: json['locationUpdatedAt'],
        monthPresent: json['monthPresent'],
        monthAbsent: json['monthAbsent'],
        monthLeave: json['monthLeave'],
        totalWorkingDays: json['totalWorkingDays'],
      );

  Map<String, dynamic> toJson() => {
    //  existing keys (preserved exactly) 
    'Executiveid': executiveid,
    'executivename': executivename,
    'attendence': attendence,
    'latitude': latitude,
    'longitude': longitude,
    'location': location,
    'userid': userid,
    'photo': photo,
    'date': date,
    //  new keys 
    'designation': designation,
    'inTime': inTime,
    'outTime': outTime,
    'locationUpdatedAt': locationUpdatedAt,
    'monthPresent': monthPresent,
    'monthAbsent': monthAbsent,
    'monthLeave': monthLeave,
    'totalWorkingDays': totalWorkingDays,
  };

  @override
  String toString() {
    return 'ExecutiveLatLongData{'
        'executiveid: $executiveid, '
        'executivename: $executivename, '
        'attendence: $attendence, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'location: $location, '
        'userid: $userid, '
        'photo: $photo, '
        'date: $date, '
        'designation: $designation, '
        'inTime: $inTime, '
        'outTime: $outTime, '
        'locationUpdatedAt: $locationUpdatedAt, '
        'monthPresent: $monthPresent, '
        'monthAbsent: $monthAbsent, '
        'monthLeave: $monthLeave, '
        'totalWorkingDays: $totalWorkingDays'
        '}';
  }
}
