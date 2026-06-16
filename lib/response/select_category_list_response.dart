// To parse this JSON data, do
//
//     final selectCategoryListPageBanner = selectCategoryListPageBannerFromJson(jsonString);

import 'dart:convert';


// To parse this JSON data, do
//
//     final categoryData = categoryDataFromJson(jsonString);


CategoryData categoryDataFromJson(String str) => CategoryData.fromJson(json.decode(str));

String categoryDataToJson(CategoryData data) => json.encode(data.toJson());

class CategoryData {
  CategoryData({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<CategoryItem>? data;
  String? message;
  int? status;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    success: json["success"],
    data: json["data"] == null ? null : List<CategoryItem>.from(json["data"].map((x) => CategoryItem.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class CategoryItem {
  CategoryItem({
    this.categoryid,
    this.categoryname,
    this.categoryimage,
    required this.select,
  });

  int? categoryid;
  String? categoryname;
  String? categoryimage;
  bool? select;

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
    categoryid: json["categoryid"],
    categoryname: json["categoryname"],
    categoryimage: json["categoryimage"],
    select: false,
  );

  Map<String, dynamic> toJson() => {
    "categoryid": categoryid,
    "categoryname": categoryname,
    "categoryimage": categoryimage,
  };
}


SelectCategoryListPageBanner selectCategoryListPageBannerFromJson(String str) => SelectCategoryListPageBanner.fromJson(json.decode(str));

String selectCategoryListPageBannerToJson(SelectCategoryListPageBanner data) => json.encode(data.toJson());

class SelectCategoryListPageBanner {
  SelectCategoryListPageBanner({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<BannerItem>? data;
  String? message;
  int? status;

  factory SelectCategoryListPageBanner.fromJson(Map<String, dynamic> json) => SelectCategoryListPageBanner(
    success: json["success"],
    data: json["data"] == null ? null : List<BannerItem>.from(json["data"].map((x) => BannerItem.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class BannerItem {
  BannerItem({
    this.sno,
    this.categoryimage,
  });

  int? sno;
  String? categoryimage;

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
    sno: json["sno"],
    categoryimage: json["categoryimage"],
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "categoryimage": categoryimage,
  };
}
