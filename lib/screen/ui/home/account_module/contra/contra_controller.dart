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

class ContraController extends AppBaseController {
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocus = FocusNode();
  final FocusNode remarkFocus = FocusNode();

  HomeController homeController = Get.find<HomeController>();

  CustomerData? selectedFromAccount;
  CustomerData? selectedToAccount;
  List<CustomerData> fromAccountList = [];
  List<CustomerData> toAccountList = [];

  String selectDate = AppString.dateTimeEmpty;

  @override
  void onInit() {
    // TODO: implement onInit
    getDropDownList();
    super.onInit();
  }

  Future<void> getDropDownList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.voucherType: VoucherType.contra,
      };
      var res = await api.contraDropdownList(body);
      if (res.status == 200) {
        fromAccountList = res.data ?? [];
        toAccountList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  void tapOnCard() {
    Get.toNamed(AppRoutes.visitPlanDetail);
  }

  void setSelectedDate(String value) {
    selectDate = value;
    update();
  }

  void setFromAccountValue(CustomerData? value) {
    selectedFromAccount = value;
    update();
  }

  void setToAccountValue(CustomerData? value) {
    selectedToAccount = value;
    update();
  }

  void tapOnSubmit() {
    if (selectDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select Date');
    } else if (selectedFromAccount?.partyname?.isEmpty ?? true) {
      ShowMessage.showSnackBar('Please check', 'Please select FromAccount');
    } else if (selectedToAccount?.partyname?.isEmpty ?? true) {
      ShowMessage.showSnackBar('Please check', 'Please select ToAccount');
    } else if (amountController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please enter Amount');
    } else if (remarkController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please enter Remark');
    } else {
      contraEntrySubmit();
    }
  }

  Future<void> contraEntrySubmit() async {
    try {
      var date = formatDate(selectDate, AppString.ddMMyyyy, AppString.yyyyMMdd);

      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '',
        RequestKeys.date: date,
        RequestKeys.voucherType: VoucherType.contra,
        RequestKeys.fromAccount: selectedFromAccount?.partyid.toString() ?? '',
        RequestKeys.toAccount: selectedToAccount?.partyid.toString() ?? '',
        RequestKeys.amount: amountController.text,
        RequestKeys.remarks: remarkController.text,
      };
      var res = await api.contraEntrySubmit(body);
      if (res.status == 200) {
        Get.back();
        ShowMessage.showSnackBar('res.status 200', res.message.toString());
      } else {
        ShowMessage.showSnackBar('res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    }
  }
}
