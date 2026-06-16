import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalEntryController extends AppBaseController {
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocus = FocusNode();
  final FocusNode remarkFocus = FocusNode();
  HomeController homeController = Get.find<HomeController>();

  CustomerData? selectedCreditAccount;
  CustomerData? selectedDebitAccount;

  List<CustomerData> creditAccountList = [];
  List<CustomerData> debitAccountList = [];

  String selectDate = AppString.dateTimeEmpty;

  @override
  void onInit() {
    // TODO: implement onInit
    getDropdownList();
    super.onInit();
  }

  Future<void> getDropdownList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: false ? '39' : homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: false ? '100' : homeController.currentUserData?.branchId.toString() ?? '342613',
        RequestKeys.userId: false ? '371624' : homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.voucherType: VoucherType.journal,
      };
      var res = await api.debitCreditAccountList(body);
      if (res.status == 200) {
        creditAccountList = res.data ?? [];
        debitAccountList = res.data ?? [];
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  void tapOnSubmit() {
    if (selectDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select Date');
    } else if (selectedCreditAccount?.partyname?.isEmpty ?? true) {
      ShowMessage.showSnackBar('Please check', 'Please select CreditAccount');
    } else if (selectedDebitAccount?.partyname?.isEmpty ?? true) {
      ShowMessage.showSnackBar('Please check', 'Please select DebitAccount');
    } else if (remarkController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please add Remark');
    } else if (amountController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please add Amount');
    } else {
      journalEntrySubmit();
    }
  }

  Future<void> journalEntrySubmit() async {
    try {
      var date = formatDate(selectDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '',
        RequestKeys.date: date,
        RequestKeys.voucherType: VoucherType.journal,
        RequestKeys.creditAccount: selectedCreditAccount?.partyid.toString() ?? '',
        RequestKeys.debitAccount: selectedDebitAccount?.partyid.toString() ?? '',
        RequestKeys.amount: amountController.text,
        RequestKeys.remarks: remarkController.text,
      };
      var res = await api.journalEntry(body);
      if (res.status == 200) {
        Get.back();
        ShowMessage.showSnackBar('Journal Entry Success', res.message.toString());
      } else {
        ShowMessage.showSnackBar('res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Catch', '$e');
    }
  }

  void tapOnCard() {
    Get.toNamed(AppRoutes.visitPlanDetail);
  }

  void setSelectedDate(String value) {
    selectDate = value;
    update();
  }

  void setCreditAccount(CustomerData? value) {
    selectedCreditAccount = value;
    update();
  }

  void setDebitAccount(CustomerData? value) {
    selectedDebitAccount = value;
    update();
  }
}
