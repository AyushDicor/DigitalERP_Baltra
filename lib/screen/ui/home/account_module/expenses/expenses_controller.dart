import 'dart:convert';
import 'dart:io';

import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ExpensesController extends AppBaseController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final FocusNode amountFocus = FocusNode();
  final FocusNode remarkFocus = FocusNode();
  List<String> paymentOptionList = ['Cash', 'Online'];
  HomeController homeController = Get.find<HomeController>();

  final picker = ImagePicker();
  var selectedImage = ''.obs;
  var selectedImageBase64 = ''.obs;
  var selectedImageFileName = ''.obs;

  void setSelectedImage(String value) {
    selectedImage.value = value;
    update();
  }

  void getImage(ImageSource source) async {
    Get.back();
    var pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 65,
    );
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      selectedImageBase64.value = base64.encode(file.readAsBytesSync());
      selectedImageFileName.value = file.path.split('/').last;
      setSelectedImage(file.path);
    }
  }

  String? selectedDropdown1Value;
  String? selectedDropdown2Value;

  List dropdown1List = ['Executive name 1', 'Executive name 2', 'Executive name 3'];
  List dropdown2List = ['Executive head 1', 'Executive head 2', 'Executive head 3'];

  List<CustomerData> executiveHeadList = [];
  List<ExecutiveDropdownData> executiveList = [];
  ExecutiveDropdownData? selectedExecutive;
  CustomerData? selectedExecutiveHead;

  String selectDate = AppString.dateTimeEmpty;

  int selectedIndex = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    getExecutiveDropDownList();
    getExecutiveHeadDropdownList();
    super.onInit();
  }

  Future<void> getExecutiveDropDownList({String? executiveId}) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = executiveId ?? '0';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }

  Future<void> getExecutiveHeadDropdownList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        // RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '342613',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
      };
      var res = await api.expensesHeadList(body);
      if (res.status == 200) {
        executiveHeadList = res.data ?? [];
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

  void setSelectedDate(String value) {
    selectDate = value;
    update();
  }

  void setSelectedIndex(int value) {
    selectedIndex = value;
    update();
  }

  void setExecutiveNameValue(ExecutiveDropdownData? value) {
    selectedExecutive = value;
    update();
  }

  void setExecutiveHeadValue(CustomerData? value) {
    selectedExecutiveHead = value;
    update();
  }

  void tapOnSubmit() {
    if (selectDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select Date');
    } /*else if (selectedExecutive?.executiveName?.isEmpty ?? true) {
      ShowMessage.showSnackBar('Please check', 'Please select Executive Name');
    }*/
    else if (selectedExecutiveHead?.partyname?.isEmpty ?? true) {
      ShowMessage.showSnackBar('Please check', 'Please select selectedExecutiveHead');
    } else if (amountController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please enter Amount');
    } else if (remarkController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please enter Remark');
    } else if (selectedIndex == 1 && selectedImage.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please upload Image');
    } else {
      expensesEntrySubmit();
    }
  }

  Future<void> expensesEntrySubmit() async {
    try {
      String date = formatDate(selectDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '39',
        RequestKeys.voucherType: VoucherType.expense,
        RequestKeys.partyId:
            homeController.currentUserData?.accountCode.toString() ?? selectedExecutive?.executiveId.toString() ?? '',
        RequestKeys.date: date,
        RequestKeys.amount: amountController.text,
        RequestKeys.paymentMode: paymentOptionList[selectedIndex],
        RequestKeys.paymentModeLedgerId: selectedExecutiveHead?.partyid.toString() ?? '',
        RequestKeys.chequeNo: '',
        RequestKeys.chequeDate: '1990-01-01',
        RequestKeys.remarks: remarkController.text,
        RequestKeys.photo: selectedImageBase64.value,
        RequestKeys.filename: selectedImageFileName.value,
      };
      var res = await api.expenseEntrySubmit(body);
      if (res.status == 200) {
        Get.back();
        ShowMessage.showSnackBar('Expense Entry Success', res.message.toString());
      } else {
        ShowMessage.showSnackBar('Expense res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    }
  }
}
