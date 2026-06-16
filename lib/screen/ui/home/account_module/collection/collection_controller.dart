import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/cash_bank_ledger_response.dart';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CollectionController extends AppBaseController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController chequeNoController = TextEditingController();
  HomeController homeController = Get.find<HomeController>();
  final FocusNode amountFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode remarkFocus = FocusNode();
  List<String> paymentOptionList = ['Cash', 'Cheque', 'Online'];
  List<CustomerData> customerDataList = [];
  List<CashAndBankLedgerDataList> cashAndBankLedgerList = [];

  final picker = ImagePicker();
  var selectedImage = ''.obs;
  var selectedImageBase64 = ''.obs;
  var selectedImageFileName = ''.obs;
  String? customer;
  CustomerListData? customerdecodedList;
  var selectedDropdownValue;
  var selectedCollectionLedgerValue;
  bool isSelected = false;
  bool isOnline = false;
  bool isCash = false;
  bool isCheque = false;
  String? argument;
  String customerName = '';

  @override
  void onInit() async{
    // TODO: implement onInit
    setBusy(true);
    await getCustomerList();
    await getCashAndBankLedgerList();
    setBusy(false);
    super.onInit();
  }

  void setSelectedImage(String value) {
    isSelected = true;
    selectedImage.value = value;
    update();
  }

  String selectDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String selectChequeDate = 'Enter cheque date';

  int selectedIndex = 0;

  void tapOnCard() {
    Get.toNamed(AppRoutes.visitPlanDetail);
  }

  void setSelectedDate(String value) {
    selectDate = value;
    update();
  }

  void setSelectedChequeDate(String value) {
    selectChequeDate = value;
    update();
  }

  void setSelectedIndex(int value) {
    selectedIndex = value;
    update();
  }

  onTabAccountModule() {
    Get.toNamed(AppRoutes.accountModule, arguments: true);
  }

  void setDropdownValue(Object? newValue) {
    selectedDropdownValue = newValue;
    update();
  }

  void setCashAndBankLedgerDropdownValue(Object? newValue) {
    selectedCollectionLedgerValue = newValue;
    update();
  }

  void tapOnSubmit() {
    if (selectedDropdownValue == null && argument == null) {
      ShowMessage.showSnackBar('Please check', 'Please select customer');
    } else if (amountController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please add Amount');
    } else if (selectedIndex == 1 && chequeNoController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please add cheque no. ');
    } else if (selectedIndex == 1 && selectChequeDate == 'Enter cheque date') {
      ShowMessage.showSnackBar('Please check', 'Please add cheque Date ');
    } else if (selectedCollectionLedgerValue == null) {
      ShowMessage.showSnackBar('Please check', 'Please select collection Ledger');
    } else if (remarkController.text.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please add Remark');
    } else if (selectedIndex == 1 && selectedImage.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please Add cheque Image');
    } else {
      collectionEntrySubmit();
    }
  }

  void tapOnDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: AppConst.calenderFirstDate ?? DateTime(DateTime.now().year, 1, 1),
        //DateTime.now() - not to allow to choose before today.
        lastDate: AppConst.calenderLastDate ?? DateTime(DateTime.now().year, 12, 31));

    if (pickedDate != null) {
      String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
      setSelectedDate(formattedDate);
    } else {
      if (kDebugMode) {
        print('Date is not selected');
      }
    }
  }

  void tapOnChequeDate(BuildContext context) async {
    amountFocus.unfocus();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: AppConst.calenderFirstDate ?? DateTime.now(),
      lastDate: AppConst.calenderLastDate ?? DateTime(DateTime.now().year, 12, 31),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
      setSelectedChequeDate(formattedDate);
    } else {
      if (kDebugMode) {
        print('Date is not selected');
      }
    }
  }

  Future<void> getCustomerList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.voucherType: VoucherType.collection,
      };
      var res = await api.collectionCustomerList(body);
      if (res.status == 200) {
        customerDataList = res.data ?? [];
        for (var element in customerDataList) {
          if (element.partyid.toString() == Get.arguments) {
            customerName = element.partyname ?? '';
            selectedDropdownValue = element;
          } else {
            continue;
          }
        }
      } else {
        ShowMessage.showSnackBar('collectionCustomerList Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('collectionCustomerList Server catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getCashAndBankLedgerList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.voucherType] = VoucherType.collection;
      var res = await api.cashAndBankLedgerData(body);
      if (res.status == 200) {
        cashAndBankLedgerList = res.data ?? [];
        /*customerDataList.forEach((element) {
          if(element.partyid.toString() == Get.arguments){
            customerName = element.partyname ?? '';
            selectedDropdownValue = element ;
          }else{
            return;
          }
        });*/
      } else {
        ShowMessage.showSnackBar('cashAndBankLedgerData Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('cashAndBankLedgerData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> collectionEntrySubmit() async {
    try {
      String date = formatDate(selectDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      String chequeDate = '1990-01-01';
      if (selectChequeDate != 'Enter cheque date') {
        chequeDate = formatDate(selectChequeDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      }
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '100',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '371624',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '2022-23',
        RequestKeys.voucherType: VoucherType.collection,
        RequestKeys.partyId: argument ?? selectedDropdownValue.partyid.toString(),
        RequestKeys.date: date,
        RequestKeys.amount: amountController.text,
        RequestKeys.paymentMode: paymentOptionList[selectedIndex],
        RequestKeys.paymentModeLedgerId: selectedCollectionLedgerValue.partyid.toString(),
        RequestKeys.chequeNo: chequeNoController.text,
        RequestKeys.chequeDate: chequeDate,
        RequestKeys.remarks: remarkController.text,
        RequestKeys.photo: selectedImageBase64.value,
        RequestKeys.filename: selectedImageFileName.value
      };
      var res = await api.collectionEntrySubmitData(body);
      if (res.status == 200) {
        Get.back();
        ShowMessage.showSnackBar('Server Res Success', res.message.toString());
      } else {
        ShowMessage.showSnackBar('collectionEntrySubmitData res.status Not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('collectionEntrySubmitData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }
}
