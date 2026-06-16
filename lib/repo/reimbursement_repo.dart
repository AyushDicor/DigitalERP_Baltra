import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:digitalerp/model/response_model.dart';

import 'base_api_helper.dart';
import 'base_url.dart';

class ReimbursementRepo {

  //  Reimbursement type dropdown 
  static Future<ResponseItem> reimbursementSelectTypeList(
      Map<String, dynamic> requestData) async {
    try {
      final url = AppUrls.baseUrl + MethodName.reimbursementDropdown;
      return await BaseApiHelper.postRequest(url, requestData);
    } catch (e) {
      return ResponseItem(
        status: false,
        message: "reimbursementSelectTypeList: ${e.toString()}",
      );
    }
  }

  //  Currency dropdown 
  // static Future<ResponseItem> currencyDropDownList(
  //     Map<String, dynamic> requestData) async {
  //   try {
  //     final url = AppUrls.baseUrl + MethodName.selectCurrency;
  //     return await BaseApiHelper.postRequest(url, requestData);
  //   } catch (e) {
  //     return ResponseItem(
  //       status: false,
  //       message: "currencyDropDownList: ${e.toString()}",
  //     );
  //   }
  // }

  //  Submit reimbursement 
  static Future<ResponseItem> submitReimbursementMethod(
      Map<String, dynamic> requestData) async {
    try {
      final url = AppUrls.baseUrl + MethodName.saveReimbursement;
      return await BaseApiHelper.postRequest(url, requestData);
    } catch (e) {
      return ResponseItem(
        status: false,
        message: "submitReimbursementMethod: ${e.toString()}",
      );
    }
  }

  //  Old list method (backward compat) 
  static Future<ResponseItem> getReimbursementMethod(
      Map<String, dynamic> requestData) async {
    try {
      final url = AppUrls.baseUrl + MethodName.getExpenseListNew;
      return await BaseApiHelper.postRequest(url, requestData);
    } catch (e) {
      return ResponseItem(
        status: false,
        message: "getReimbursementMethod: ${e.toString()}",
      );
    }
  }

  //  Click-detail 
  static Future<ResponseItem> getExpenseDetail(Map<String, dynamic> requestData) async {
    try {
      String requestUrl = AppUrls.baseUrl + MethodName.getExpenseDetail;

      log('=== GetExpenseDetail Request ===');
      log('URL: $requestUrl');
      log('Body: $requestData');

      ResponseItem result = await BaseApiHelper.postRequest(requestUrl, requestData);

      log('GetExpenseDetail Response Status: ${result.statusCode}');
      return result;
    } catch (e) {
      log("getExpenseDetail Repo Exception: $e");
      return ResponseItem(
        status: false,
        statusCode: 500,
        message: "getExpenseDetail Repo : An error occurred: ${e.toString()}",
      );
    }
  }

  //  NEW: GetExpenseListNew 
  //
  // POST http://supportapi.digitalerp.biz/api/GetExpenseListNew
  //
  // Body: { compid, branchid, userid, fromdate, todate, employeeid, siteid }
  // Dates must be "dd-MM-yyyy" format.
  //
  static Future<ResponseItem> getExpenseListNew(
      Map<String, dynamic> requestData) async {
    try {
      // ✅ Make sure MethodName.getExpenseListNew = "GetExpenseListNew"
      //    in your base_url.dart  →  static const getExpenseListNew = "GetExpenseListNew";
      final url = AppUrls.baseUrl + MethodName.getExpenseListNew;

      log('══ getExpenseListNew ══');
      log('URL : $url');
      log('Body: $requestData');

      final result = await BaseApiHelper.postRequest(url, requestData);

      log('Status : ${result.statusCode}');
      log('Message: ${result.message}');

      return result;
    } catch (e, s) {
      log('getExpenseListNew exception: $e', stackTrace: s);
      return ResponseItem(
        status    : false,
        statusCode: 500,
        message   : "getExpenseListNew: ${e.toString()}",
      );
    }
  }

  //  ReimbursementDropdown 
// type values: "SeriesType" | "Site" | "Employee" | "ExpenseGroup" | "ExpenseLedger"
// parentid is required only for ExpenseLedger (pass the selected ExpenseGroup id)
  static Future<ResponseItem> getReimbursementDropdown(
      Map<String, dynamic> requestData) async {
    try {
      final url = AppUrls.baseUrl + MethodName.reimbursementDropdown;
      log('ReimbursementDropdown → type: ${requestData["type"]}');
      return await BaseApiHelper.postRequest(url, requestData);
    } catch (e) {
      return ResponseItem(
        status: false,
        message: "getReimbursementDropdown: ${e.toString()}",
      );
    }
  }

//  UploadReimbursementFile (multipart) 
  static Future<ResponseItem> uploadReimbursementFile(String filePath) async {
    try {
      final url = AppUrls.baseUrl + MethodName.uploadReimbursementFile;
      log('UploadReimbursementFile → $filePath');

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      final streamed = await request.send();
      final body = await streamed.stream.bytesToString();
      log('UploadReimbursementFile response [${ streamed.statusCode}]: $body');

      if (streamed.statusCode == 200) {
        final jsonMap = jsonDecode(body) as Map<String, dynamic>;
        return ResponseItem(
          status: true,
          statusCode: 200,
          data: jsonMap,
          message: jsonMap["message"]?.toString(),
        );
      } else {
        return ResponseItem(
          status: false,
          statusCode: streamed.statusCode,
          message: "Upload failed: HTTP ${streamed.statusCode}",
        );
      }
    } catch (e, s) {
      log('uploadReimbursementFile exception: $e', stackTrace: s);
      return ResponseItem(
        status: false,
        message: "uploadReimbursementFile: ${e.toString()}",
      );
    }
  }

//  SaveReimbursement 
  static Future<ResponseItem> saveReimbursement(
      Map<String, dynamic> requestData) async {
    try {
      final url = AppUrls.baseUrl + MethodName.saveReimbursement;
      log('SaveReimbursement body: ${jsonEncode(requestData)}');
      return await BaseApiHelper.postRequest(url, requestData);
    } catch (e) {
      return ResponseItem(
        status: false,
        message: "saveReimbursement: ${e.toString()}",
      );
    }
  }
}