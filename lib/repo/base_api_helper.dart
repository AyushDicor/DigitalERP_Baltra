import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:digitalerp/model/response_model.dart';
import 'package:digitalerp/repo/request_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BaseApiHelper {
  /// POST request
  static Future<ResponseItem> postRequest(
      String requestUrl,
      Map<String, dynamic> requestData, {
        bool? passAuthToken = false,
      }) async {
    return await http
        .post(Uri.parse(requestUrl), body: json.encode(requestData), headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// PUT request
  static Future<ResponseItem> putRequest(
      String requestUrl,
      Map<String, dynamic> requestData, {
        bool? passAuthToken = false,
      }) async {
    return await http
        .put(Uri.parse(requestUrl), body: json.encode(requestData), headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// GET request
  static Future<ResponseItem> getRequest(
      String requestUrl, {
        Map<String, dynamic>? params,
        bool? passAuthToken = false,
      }) async {
    log('requestUrl=================>>>>>${requestUrl}');
    return await http
        .get(Uri.parse(requestUrl), headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// DELETE request
  static Future<ResponseItem> deleteRequest(String requestUrl, {bool? passAuthToken = false}) async {
    return await http
        .delete(Uri.parse(requestUrl), headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// PATCH request
  static Future<ResponseItem> patchRequest(
      String requestUrl,
      Map<String, dynamic> requestData, {
        bool? passAuthToken = false,
      }) async {
    return await http
        .patch(Uri.parse(requestUrl), body: json.encode(requestData), headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// Upload form data with image(s)
  static Future<ResponseItem> uploadFormData({
    required String requestUrl,
    Map<String, dynamic>? requestData,
    bool? passAuthToken = false,
    List<File>? imageFiles,
    String? singleImage,
  }) async {
    var request = http.MultipartRequest("POST", Uri.parse(requestUrl));

    // Single image
    if (singleImage != null) {
      request.files.add(await http.MultipartFile.fromPath('myStory', singleImage));
    }
    // Multiple images
    else if (imageFiles != null && imageFiles.isNotEmpty) {
      for (var file in imageFiles) {
        request.files.add(await http.MultipartFile.fromPath('myStory', file.path));
      }
    }

    if (passAuthToken == true) {
      request.headers.addAll({"Authorization": "Bearer YOUR_TOKEN_HERE"});
    }

    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse).then((value) => onValue(value));
    }).onError((error, stackTrace) => onError(error));
  }

  /// Upload status with form fields only
  static Future uploadStatus({required String requestUrl, required Map<String, String> requestData}) async {
    var request = http.MultipartRequest("POST", Uri.parse(requestUrl));
    request.fields.addAll(requestData);

    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse).then((value) => uploadOnStatus(value));
    });
  }

  static Future uploadOnStatus(http.Response response) async {
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("Upload Success");
    } else {
      debugPrint("Upload Failed");
    }
  }

  /// Decode base64 string
  String base64Decode(String encoded) {
    return utf8.decode(base64.decode(encoded));
  }

  /// GET request with token check
  static Future<ResponseItem> getRequestCheckToken(
      String requestUrl, {
        Map<String, dynamic>? params,
        bool? passAuthToken = false,
      }) async {
    return await http
        .get(Uri.parse(requestUrl), headers: requestHeader())
        .then((response) => onTokenValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// Handle response
  static Future<ResponseItem> onValue(http.Response response) async {
    debugPrint("Status Code: ${response.statusCode}");
    // log("Response Data: ${response.body}");

    final ResponseItem result = ResponseItem(status: false, message: "Something went wrong.");

    dynamic data = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      result.status = true;
      result.data = data;
      result.message = data["message"] ?? "";
      result.statusCode = response.statusCode;
      debugPrint("Request Success");
    } else if (response.statusCode == 400) {
      result.message = data["message"] ?? "";
      result.statusCode = response.statusCode;
    } else if (response.statusCode == 401) {
      result.message = data["message"] ?? "";
      result.statusCode = response.statusCode;
      // Handle session expiration here
    } else {
      result.message = data["message"] ?? "";
      result.statusCode = response.statusCode;
      debugPrint("Error: ${result.message}");
      debugPrint("Response: $data");
    }
    return result;
  }

  /// Handle response for token check
  static Future<ResponseItem> onTokenValue(http.Response response) async {
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response: ${response.body}");

    final ResponseItem result = ResponseItem(status: false, message: "Something went wrong.");

    if (response.statusCode == 200 || response.statusCode == 201) {
      result.status = true;
      result.statusCode = response.statusCode;
      debugPrint("Token Valid");
    } else if (response.statusCode == 400) {
      result.statusCode = response.statusCode;
      Get.back();
    } else if (response.statusCode == 401) {
      result.statusCode = response.statusCode;
      // Handle logout/session expired
    } else {
      result.statusCode = response.statusCode;
      debugPrint("Token Error: ${result.message}");
    }
    return result;
  }

  /// Handle errors
  static ResponseItem onError(error) {
    debugPrint("Error caused: $error");
    String message = "Unsuccessful request";

    if (error is SocketException) {
      message = "No Internet Connection";
    } else if (error is FormatException) {
      message = "Bad response format";
    }

    return ResponseItem(data: null, message: message, status: false);
  }
}
// TODO Implement this library.