import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/response/transaction_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartyLedgerController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController remarkController = TextEditingController();
  final FocusNode remarkFocus = FocusNode();

  CustomerData? selectedPartyValue;
  TransactionData? selectedTransactionValue;

  List<CustomerData> partyList = [];
  List<TransactionData> transactionList = [];

  String selectFromDate = AppString.dateTimeEmpty;
  String selectToDate = AppString.dateTimeEmpty;

  @override
  void onInit() {
    // TODO: implement onInit
    getPartyList();
    super.onInit();
  }

  Future<void> getPartyList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: false ? '39' : homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: false ? '100' : homeController.currentUserData?.branchId.toString() ?? '342613',
        RequestKeys.userId: false ? '371624' : homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.voucherType: VoucherType.none//.collection,
      };
      var res = await api.collectionCustomerList(body);
      if (res.status == 200) {
        partyList = res.data ?? [];
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

  void setSelectedFromDate(String value) {
    selectFromDate = value;
    update();
  }

  void setSelectedToDate(String value) {
    selectToDate = value;
    update();
  }

  void setSelectedPartyValue(CustomerData? value) {
    selectedPartyValue = value;
    update();
  }

  void setSelectedTransactionValue(TransactionData? value) {
    selectedTransactionValue = value;
    update();
  }

  void showTransaction() {
    if (selectedPartyValue?.partyname?.isEmpty ?? true) {
      ShowMessage.showSnackBar('Please check', 'Please select Party name');
    } else if (selectFromDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select FromDate');
    } else if (selectToDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select ToDate');
    } else {
      getTransactionList();
    }
  }

  Future<void> onShare() async {
    if (transactionList.isEmpty) {
      ShowMessage.showSnackBar('Please check', 'No Transaction Found');
      return;
    }
    try {
      String fromDate = formatDate(selectFromDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
      String toDate = formatDate(selectToDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '39',
        RequestKeys.partyId: selectedPartyValue?.partyid.toString() ?? '`',
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate,
        RequestKeys.transId: selectedTransactionValue?.transid.toString()??"",
      };
      setBusy(true);
      var res = await api.partyLedgerPDF(body);
      if (res.status == 200) {
        /// new way
       await downloadAndSharePdfFile(
          downloadUrl: res.data?.first.url ?? '',
          pdfFileName: 'outstandingFile${DateTime.now().millisecond}',
        );
       setBusy(false);
        /// old way
        /*
        launchInBrowser(Uri.parse(res.data?.first.url ?? ''));
         */
      } else {
        ShowMessage.showSnackBar('partyLedgerPDF Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('partyLedgerPDF catch Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getTransactionList() async {
    selectedTransactionValue=null;
    update();
    transactionList.clear();
    String fromDate = formatDate(selectFromDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
    String toDate = formatDate(selectToDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '39',
        RequestKeys.partyId: selectedPartyValue?.partyid.toString() ?? '0',
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate,
      };
      var res = await api.transactionList(body);
      if (res.status == 200) {
        transactionList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('transactionList res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('transactionList Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  void tapOnSubmit() {
    Get.back();
  }
}
