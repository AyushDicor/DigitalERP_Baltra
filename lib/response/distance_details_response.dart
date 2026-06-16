
import 'dart:convert';

DistanceDetailsResponse distanceDetailsResponseFromJson(String str) => DistanceDetailsResponse.fromJson(json.decode(str));

String distanceDetailsResponseToJson(DistanceDetailsResponse data) => json.encode(data.toJson());


class DistanceDetailsResponse {
  DistanceDetailsResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  DistanceDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DistanceDetailsData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  List<DistanceDetailsData>? data;
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

class DistanceDetailsData {
  DistanceDetailsData({
      this.distanceid, 
      this.distance,});

  DistanceDetailsData.fromJson(dynamic json) {
    distanceid = json['distanceid'];
    distance = json['distance'];
  }
  num? distanceid;
  String? distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distanceid'] = distanceid;
    map['distance'] = distance;
    return map;
  }

}