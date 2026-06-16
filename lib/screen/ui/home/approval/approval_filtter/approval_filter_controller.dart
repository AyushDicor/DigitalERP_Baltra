import 'dart:convert';
import 'dart:developer';
import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_detail/approval_details_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_document/approval_document_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/client_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/documentname_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/item_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/vendor_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_list/approvals_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/submit/update_approvalstatus_responce.dart';
import 'package:digitalerp/screen/ui/home/dashboard/dashboard_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApprovalFilterController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  TextEditingController remarkController = TextEditingController();

  String firstDate = DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());

  List<DocumentData> filterDocumentData = [];
  List<ClientListData> filterClientListData = [];
  List<ItemListData> filterItemListData = [];
  List<StatusListData> filterStatusListData = [];
  List<VendorListData> filterVendorListData = [];
  List<UpdateApprovalstatusResponse> value = [];
  ApprovalDetailData? approvalDetailData;
  List<ApprovalDocument> approvalDocument = [];
  ApprovalListData approvalListData = ApprovalListData();

  DocumentData? document;
  StatusListData? statusid;
  StatusListData? statusname;
  DocumentData? selectedDocument;
  ClientListData? selectedClient;
  ItemListData? selectedItemList;
  StatusListData? selectedstatus;
  VendorListData? selectedvendor;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      approvalListData = Get.arguments;
      selectedstatus = null;
      log('approvalListData==>${jsonEncode(approvalListData.toJson())}');
      log('filterStatusListData==>${filterStatusListData.map((e) => jsonEncode(e.toJson())).toList()}');
    }
    print('GET AR=>$ApprovalListData');
    getDocumentList();
    getClientList();
    getItemList();
    getStatusList();
    getVendorList();
    // getApprovalDetails();
  }

  DateTime? firstDateInDate;
  DateTime? lastDateInDate;

  void setDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDate = value;
    } else {
      lastDate = value;
    }
    update();
  }

  void setDateByDate(DateTime value, bool isFirstDate) {
    if (isFirstDate) {
      firstDateInDate = value;
    } else {
      lastDateInDate = value;
    }
    update();
  }

  bool dateValidate() {
    if (firstDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(
          AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
      return false;
    } else if (lastDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(
          AppString.pleaseCheckTxt, AppString.selectToDateTxt);
      return false;
    } else if (DateFormat(AppString.ddMMyyyy)
        .parse(lastDate)
        .isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate))) {
      ShowMessage.showSnackBar(
          AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
      return false;
    }
    /*
    else if (DateFormat(ddMMyyyy).parse(lastDate).isAfter(DateTime.now())) {
      ShowMessage.showSnackBar(pleaseCheckTxt, dateGreaterThanTodayTxt);
      return false;
    }
    */
    else {
      return true;
    }
  }

  // void onApprovalFilterApply() {
  //   int currentYear = int.parse(
  //       '${homeController.currentUserData?.yearId?.split('-').first}');
  //   String monthFirstDate = formatDate(DateTime(currentYear, 4, 1).toString(),
  //       AppString.dateTimeFormat, AppString.ddMMyyyy);
  //   String monthLastDate = formatDate(
  //       DateTime(currentYear + 1, (3) + 1)
  //           .subtract(const Duration(days: 1))
  //           .toString(),
  //       AppString.dateTimeFormat,
  //       AppString.ddMMyyyy);
  //   if (dateValidate()) {}
  // }

  void onChangedDocumentDataValue(newValue) {
    selectedDocument = newValue;
    update();
  }

  void onChangedClientListValue(ClientListData? newValue) {
    selectedClient = newValue;
    update();
  }

  void onChangedItemValue(ItemListData? newValue) {
    selectedItemList = newValue;
    update();
  }

  void onChangedStatusListValue(StatusListData? value) {
    selectedstatus = value;
    update();
  }

  void onChangedVendorListValue(VendorListData? newValue) {
    selectedvendor = newValue;
    update();
  }

  bool validate() {
    if (remarkController.text.isEmpty) {
      ShowMessage.showSnackBar(
        '',
        'Please enter Remark',
      );
      return false;
    }
    if (selectedstatus == null) {
      ShowMessage.showSnackBar(
        '',
        'Please select status',
      );
      return false;
    }
    return true;
  }

  void onSubmit(String remark) async {
    if (validate() == true) {
      setBusy(true);
      try {
        Map<String, String> body = {};
        body[RequestKeys.approvalid] = approvalListData.approvalid.toString();
        body[RequestKeys.statusId] = selectedstatus?.statusid.toString() ?? '';
        body[RequestKeys.status] = selectedstatus?.statusname.toString() ?? '';
        body[RequestKeys.remarks] = remark.toString();
        body[RequestKeys.compId] =
            homeController.currentUserData?.compId.toString() ?? '';
        body[RequestKeys.branchId] =
            homeController.currentUserData?.branchId.toString() ?? '';
        body[RequestKeys.userId] =
            homeController.currentUserData?.userid.toString() ?? '';
        body[RequestKeys.yearId] =
            homeController.currentUserData?.yearId.toString() ?? '';
        var res = await api.updateApprovalStatusApi(body);
        setBusy(false);
        print('STATUS =>${res.status}');
        print('message =>${res.message}');
        if (res.status == 200) {
          value = res.data ?? [];
          Get.put<HomeViewNewController>(HomeViewNewController())
              .getUnApprovalCount();

          Get.back();
          ShowMessage.showSnackBar('Approval Submit', res.message.toString());
          update();
        } else {
          ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
        }
      } catch (e) {
        setBusy(false);
        ShowMessage.showSnackBar('catch Server Res', '$e');
      }
    }
  }

  Future<void> getDocumentList() async {
    try {
      Map<String, String> body = {
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
      };
      var res = await api.getDocumentData(body);
      if (res.status == 200) {
        filterDocumentData = res.data ?? [];
        selectedDocument = filterDocumentData.firstWhere(
            (element) => element.documentname == "PurchaseOrder",
            orElse: () => DocumentData(
                  documentname: "PurchaseOrder",
                ));
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getDocumentList catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getClientList() async {
    try {
      Map<String, String> body = {
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
      };
      var res = await api.getClientData(body);
      if (res.status == 200) {
        filterClientListData = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getClientList catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getItemList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
      };
      var res = await api.getItemData(body);
      if (res.status == 200) {
        filterItemListData = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getItemData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getStatusList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
      };
      var res = await api.getStatusData(body);
      if (res.status == 200) {
        filterStatusListData = res.data ?? [];
        if (filterStatusListData.isNotEmpty) {
          selectedstatus = filterStatusListData.firstWhere(
            (element) => element.statusname == "Pending",
            orElse: () => filterStatusListData.first,
          );
        } else {
          selectedstatus = null;
        }
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getStatusData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getVendorList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
      };
      var res = await api.getVendorData(body);
      if (res.status == 200) {
        filterVendorListData = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getVendorData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  // Future<void> getApprovalDetails() async {
  //   try {
  //     // ✅ All values as String — postMethod casts to String internally
  //     final Map<String, String> body = {
  //       'approvaltype': item.approvalType ?? '',
  //       'documentid':   (item.documentId ?? 0).toString(),
  //       'compid':       homeController.currentUserData?.compId.toString()   ?? '0',
  //       'branchid':     homeController.currentUserData?.branchId.toString() ?? '0',
  //     };
  //
  //     final res = await api.getApprovalDetails(body);
  //
  //     if ((res.status == 200 || res.success == true) && res.data != null) {
  //       currentDetail = res.data;
  //       if ((res.data!.header?.attachFile ?? '').isNotEmpty) {
  //         currentDocUrl = res.data!.header!.attachFile!;
  //       }
  //     }
  //   } catch (e) {
  //     ShowMessage.showSnackBar('Detail', '$e');
  //   }
  // }

  Future<String> getApprovalDocument(String approvalid) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.approvalid] = approvalid;
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.branchId] =
          homeController.currentUserData!.branchId.toString();
      body[RequestKeys.userId] =
          homeController.currentUserData!.userid.toString();
      body[RequestKeys.yearId] =
          homeController.currentUserData!.yearId.toString();

      var res = await api.getApprovalDocument(body);
      if (res.status == 200) {
        approvalDocument = res.data ?? [];
        return res.data?.first.url ?? "";
      }
      return "";
    } catch (e) {
      ShowMessage.showSnackBar('getDocumentList catch', '$e');
      return "";
    } finally {
      update();
    }
  }
}
