// To parse this JSON data, do
//
//     final executiveDayLocationDataResponse = executiveDayLocationDataResponseFromJson(jsonString);

import 'dart:convert';

ExecutiveDayLocationDataResponse executiveDayLocationDataResponseFromJson(String str) =>
    ExecutiveDayLocationDataResponse.fromJson(json.decode(str));

String executiveDayLocationDataResponseToJson(ExecutiveDayLocationDataResponse data) => json.encode(data.toJson());

class ExecutiveDayLocationDataResponse {
  ExecutiveDayLocationDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<ExecutiveDayLocationData>? data;
  String? message;
  int? status;

  factory ExecutiveDayLocationDataResponse.fromJson(Map<String, dynamic> json) => ExecutiveDayLocationDataResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ExecutiveDayLocationData>.from(json["data"].map((x) => ExecutiveDayLocationData.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ExecutiveDayLocationData {
  ExecutiveDayLocationData({
    this.latitude,
    this.longitude,
    this.location,
    this.date,
    this.batterylevel,
  });

  String? latitude;
  String? longitude;
  String? location;
  String? date;
  String? batterylevel;

  factory ExecutiveDayLocationData.fromJson(Map<String, dynamic> json) => ExecutiveDayLocationData(
        latitude: json["latitude"],
        longitude: json["longitude"],
        location: json["location"],
        date: json["date"],
        batterylevel: json["batterylevel"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "date": date,
        "batterylevel": batterylevel,
      };
}
