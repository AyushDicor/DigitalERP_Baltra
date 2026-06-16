import 'dart:convert';
import 'dart:developer';

import 'package:digitalerp/model/get_expense_list_new_response_model.dart';
import 'package:digitalerp/model/get_expense_detail_response_model.dart';
import 'package:digitalerp/model/reimbursement_type_response_model.dart';
import 'package:digitalerp/model/select_currency_response_model.dart';
import 'package:digitalerp/model/submit_reimbursement_response_model.dart';
import 'package:digitalerp/repo/reimbursement_repo.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../reimbursement_screen.dart';

class ReimbursementController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  //  Loading flags (Rx so Obx widgets react) 
  final RxBool isLoading = false.obs;
  final RxBool isDetailLoading = false.obs;
  final RxString errorMessage = ''.obs;

  //  Dropdown lists (plain — GetBuilder in add screen rebuilds on update())
  List<ReimbursementDataList> reimbursementList = [];
  List<CurrencyList> currencyDataList = [];

  //  Form controllers 
  final TextEditingController expenseDescriptionController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  //  Selected values — PLAIN nullable (add_reimbursement_screen.dart
  //     assigns these directly: controller.selectedType = ...  ✅)
  ReimbursementDataList? selectedType;
  CurrencyList? selectedCurrency;

  //  Response models 
  ReimburseMentTypeResponseModel? reimburseMentTypeResponseModel;
  CurrencyResponseModel? currencyResponseModel;
  SubmitReimbursementResponseModel? submitReimbursementResponseModel;
  GetExpenseDetailResponseModel? getExpenseDetailResponseModel;
  GetExpenseListNewResponseModel? getExpenseListNewResponseModel;

  //  Reactive lists 
  final RxList<ExpenseData> expenseDataList = <ExpenseData>[].obs;
  final RxList<GetExpenseDetailData> onClickReimbursementList =
      <GetExpenseDetailData>[].obs;
  final RxBool isExpenseLoading = false.obs;
  final RxString errorExpenseMessage = ''.obs;

  //  Attachments 
  List<String> attachments = [];
  List<String> attachmentNames = [];

  String firstDate = DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 30,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());

  // DATE HELPERS

  String formatDateForApi(DateTime d) => DateFormat("dd-MM-yyyy").format(d);
  String formatDateForDisplay(DateTime d) =>
      DateFormat("dd MMM yyyy").format(d);

  DateTime? parseExpenseDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      return DateFormat("dd-MM-yyyy").parse(raw.trim());
    } catch (_) {}
    try {
      return DateFormat("M/d/yyyy h:mm:ss a").parse(raw.trim());
    } catch (_) {}
    return null;
  }

  // SNACKBARS

  void showError(String msg) => Get.snackbar(
        "Error",
        msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
      );

  void showSuccess(String msg) => Get.snackbar(
        "Success",
        msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
      );
  void showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

// Optional: Keep private one if you want
  void _showErrorSnackbar(String message) {
    showErrorSnackbar(message);
  }

  // Add this method to your controller
  void resetFilters() {
    // Reset to last 30 days
    firstDate = DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 30,
    ));
    lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());

    update();
  }

  // GET EXPENSE LIST

  Future<void> getExpenseListNew({
    String? fromDate,
    String? toDate,
    int? employeeId,
    int? siteId,
    int? branchId,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      expenseDataList.clear();
      update();


      final requestData = <String, dynamic>{
        'compid': homeController.currentUserData?.compId.toString() ?? '',
        'userid': homeController.currentUserData?.userid.toString() ?? '',
        //'branchid': validBranchId, // ← Use valid branch ID
        'branchid': homeController.currentUserData?.branchId.toString() ?? '',
        // 'datefrom': '2026-01-01', // Wide date range for testing
        // 'dateto': '2026-12-31',
        'datefrom': DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(firstDate)),
        'dateto': DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(lastDate)),
        "employeeid": employeeId ?? 0,
        "siteid": siteId ?? 0,
      };

      log('╔══ GetExpenseListNew REQUEST ══');
      log('║  Body: ${jsonEncode(requestData)}');
      log('╚══════════════════════════════');

      final result = await ReimbursementRepo.getExpenseListNew(requestData);

      log('╔══ GetExpenseListNew RESPONSE ══');
      log('║  Status: ${result.statusCode}');
      log('║  Raw   : ${jsonEncode(result.data)}');
      log('╚════════════════════════════════');

      if (result.statusCode == 200 && result.data != null) {
        Map<String, dynamic>? jsonMap;
        final raw = result.data;
        if (raw is Map<String, dynamic>) {
          jsonMap = raw;
        } else if (raw is String) {
          jsonMap = jsonDecode(raw) as Map<String, dynamic>?;
        }

        if (jsonMap != null) {
          getExpenseListNewResponseModel =
              GetExpenseListNewResponseModel.fromJson(jsonMap);
          expenseDataList.assignAll(getExpenseListNewResponseModel?.data ?? []);
          log('✅ Loaded ${expenseDataList.length} records');
        } else {
          errorMessage.value = "Unexpected response format";
          showError(errorMessage.value);
        }
      } else {
        errorMessage.value = result.message ?? "Failed to load expense list";
        showError(errorMessage.value);
      }
    } catch (e, s) {
      errorMessage.value = "Something went wrong loading expenses";
      log('❌ getExpenseListNew: $e', stackTrace: s);
      showError(errorMessage.value);
    } finally {
      isLoading.value = false;
      update();
    }
  }



  Future<void> getReimbursementRecords({String? fromDate, String? toDate}) =>
      getExpenseListNew(fromDate: fromDate, toDate: toDate);

  //
  // GET EXPENSE DETAIL
  //

  Future<void> getExpenseDetail(int expenseId) async {
    if (expenseId <= 0) {
      Get.snackbar(
        "Error",
        "Invalid Expense ID",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isExpenseLoading.value = true;
      errorExpenseMessage.value = '';
      // No need for update() when using .obs

      final requestData = {
        "eid": expenseId,
        'compid': homeController.currentUserData?.compId.toString() ?? '',
        'branchid': homeController.currentUserData?.branchId.toString() ?? '',
      };

      log('GetExpenseDetail Request: $requestData');

      final result = await ReimbursementRepo.getExpenseDetail(requestData);

      if (result.statusCode == 200 && result.data != null) {
        getExpenseDetailResponseModel =
            GetExpenseDetailResponseModel.fromJson(result.data);
        log('FULL RESPONSE: ${result.data}');

        if (getExpenseDetailResponseModel?.success == true) {
          log('✅ Expense Detail Loaded - Items: ${getExpenseDetailResponseModel?.data?.items.length ?? 0}');
        } else {
          errorMessage.value =
              getExpenseDetailResponseModel?.message ?? "Failed to load detail";
          _showErrorSnackbar(
              errorMessage.value); // We'll define this properly below
        }
      } else {
        errorMessage.value = "Failed to load expense details";
        _showErrorSnackbar(errorMessage.value);
      }
    } catch (e, s) {
      log("Error in getExpenseDetail: $e", stackTrace: s);
      errorMessage.value = "Something went wrong while loading details";
      _showErrorSnackbar(errorMessage.value);
    } finally {
      isExpenseLoading.value = false;
    }
  }
  
  // DROPDOWNS
  

  Future<void> reimbursementSelectTypeData() async {
    try {
      final result = await ReimbursementRepo.reimbursementSelectTypeList(
          {"compid": homeController.currentUserData?.compId?.toString() ?? ""});
      if (result.statusCode == 200) {
        reimburseMentTypeResponseModel =
            ReimburseMentTypeResponseModel.fromJson(result.data);
        reimbursementList =
            reimburseMentTypeResponseModel?.data?.toList() ?? [];
        log('reimbursementList: ${reimbursementList.length} types');
      }
    } catch (e, s) {
      log('reimbursementSelectTypeData: $e', stackTrace: s);
    } finally {
      update();
    }
  }


  // Future<void> pickCurrencyData() async {
  //   try {
  //     final result = await ReimbursementRepo.currencyDropDownList(
  //         {"compid": homeController.currentUserData?.compId?.toString() ?? ""});
  //     if (result.statusCode == 200) {
  //       currencyResponseModel = CurrencyResponseModel.fromJson(result.data);
  //       currencyDataList = currencyResponseModel?.data?.toList() ?? [];
  //       log('currencyDataList: ${currencyDataList.length} currencies');
  //     }
  //   } catch (e, s) {
  //     log('pickCurrencyData: $e', stackTrace: s);
  //   } finally {
  //     update();
  //   }
  // }

  // 
  // SUBMIT
  // 

  // Future<void> submitReimbursement() async {
  //   if (selectedType == null) {
  //     showError("Please select reimbursement type");
  //     return;
  //   }
  //   if (dateController.text.isEmpty) {
  //     showError("Please select expense date");
  //     return;
  //   }
  //   if (amountController.text.trim().isEmpty) {
  //     showError("Please enter amount");
  //     return;
  //   }
  //   if (selectedCurrency == null) {
  //     showError("Please select currency");
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //     update();
  //
  //     final requestData = <String, dynamic>{
  //       "compid": homeController.currentUserData?.compId?.toString() ?? "",
  //       "branchid": homeController.currentUserData?.branchId?.toString() ?? "",
  //       "userid": homeController.currentUserData?.userid?.toString() ?? "",
  //       "yearid": homeController.currentUserData?.yearId?.toString() ?? "",
  //       "reimbursementid": selectedType?.reimbursementid,
  //       "ReimbursementType": selectedType?.reimbursementType?.toString() ?? "",
  //       "ExpenseDate": dateController.text,
  //       "ExpenseDescription": expenseDescriptionController.text,
  //       "Amount": amountController.text,
  //       "Currency": selectedCurrency?.currencyCode?.toString() ?? "",
  //       "files": attachments,
  //       "AdditionalNotes": notesController.text,
  //     };
  //
  //     final result =
  //         await ReimbursementRepo.submitReimbursementMethod(requestData);
  //
  //     if (result.statusCode == 200) {
  //       submitReimbursementResponseModel =
  //           SubmitReimbursementResponseModel.fromJson(result.data);
  //       _clearForm();
  //       showSuccess(
  //         submitReimbursementResponseModel?.message ??
  //             "Reimbursement submitted successfully",
  //       );
  //       Get.off(() => const ReimbursementListScreen());
  //     } else {
  //       showError(result.message ?? "Failed to submit reimbursement");
  //     }
  //   } catch (e, s) {
  //     log('submitReimbursement: $e', stackTrace: s);
  //     showError("Error submitting reimbursement");
  //   } finally {
  //     isLoading.value = false;
  //     update();
  //   }
  // }
  // 
// UPDATE REIMBURSEMENT (Edit existing via SaveReimbursement API)
//

  /// Uploads a single local file and returns the server filename.
  /// Returns empty string on failure.
  Future<String> uploadSingleFile(String localPath) async {
    try {
      final res = await ReimbursementRepo.uploadReimbursementFile(localPath);
      if (res.status == true && res.statusCode == 200) {
        final jsonData = res.data as Map<String, dynamic>?;
        return jsonData?['data']?['filename'] as String?
            ?? jsonData?['filename'] as String?
            ?? '';
      }
      log('❌ uploadSingleFile failed: ${res.message}');
      return '';
    } catch (e) {
      log('❌ uploadSingleFile exception: $e');
      return '';
    }
  }

  Future<bool> updateReimbursement({
    required int expenseId,
    required int seriesId,
    required String expenseNo,
    required String expenseDate,   // yyyy-MM-dd
    required int siteId,
    required int reqId,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      isLoading.value = true;
      update();

      // Total = sum of all item amounts
      final total = items.fold<double>(
        0.0, (sum, item) => sum + ((item['amount'] as num?)?.toDouble() ?? 0.0),
      );

      final requestData = <String, dynamic>{
        "expenseid":   expenseId,   // >0 = update existing
        "seriesid":    seriesId,
        "expenserno":  expenseNo,
        "expensedate": expenseDate,
        "siteid":      siteId,
        "reqid":       reqId,
        "amount":      total,
        "compid":      homeController.currentUserData?.compId    ?? 0,
        "branchid":    homeController.currentUserData?.branchId  ?? 0,
        "userid":      homeController.currentUserData?.userid    ?? 0,
        "yearid":      homeController.currentUserData?.yearId?.toString() ?? "",
        "items":       items,
      };

      log('╔══ UpdateReimbursement REQUEST ══');
      log('║  Body: ${jsonEncode(requestData)}');
      log('╚════════════════════════════════');

      final result = await ReimbursementRepo.saveReimbursement(requestData);

      log('╔══ UpdateReimbursement RESPONSE ══');
      log('║  Status: ${result.statusCode}');
      log('║  Raw   : ${jsonEncode(result.data)}');
      log('╚══════════════════════════════════');

      if (result.statusCode == 200 && result.data != null) {
        final success = result.data['success'] == true;
        final msg = result.data['message']?.toString() ??
            (success ? "Updated successfully" : "Update failed");

        if (success) {
          showSuccess(msg);
          return true;
        } else {
          showError(msg);
          return false;
        }
      } else {
        showError(result.message ?? "Failed to update reimbursement");
        return false;
      }
    } catch (e, s) {
      log('❌ updateReimbursement: $e', stackTrace: s);
      showError("Error updating reimbursement");
      return false;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void _clearForm() {
    selectedType = null;
    selectedCurrency = null;
    dateController.clear();
    expenseDescriptionController.clear();
    amountController.clear();
    notesController.clear();
    attachments.clear();
    attachmentNames.clear();
  }

  // 
  // LIFECYCLE
  // 

  @override
  void onInit() {
    super.onInit();
    // Only dropdowns — list screen loads expense data itself (no double call)
    Future.delayed(Duration.zero, () {
      reimbursementSelectTypeData();
    //pickCurrencyData();
    });
  }

  @override
  void onClose() {
    expenseDescriptionController.dispose();
    amountController.dispose();
    notesController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
