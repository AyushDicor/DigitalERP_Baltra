import 'package:digitalerp/orderfollowup/order_followup_details_response.dart';
import 'package:digitalerp/orderfollowup/orderfollowup_list_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderFollowupController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  TextEditingController followupRemarkController = TextEditingController();

  List<OrderFollowupListData> orderFollowupListData = [];
  List<CustomerListData> partyList = [];
  CustomerListData? selectParty;

  List<OrderFollowupDetailsData> orderFollowupDetailsData = [];
  OrderFollowupDetailsData? selectOrderFollowupData;

  String followupDate = AppString.ddMMyyyy;
  String nextFollowupDate = AppString.ddMMyyyy;

  void selectFollowupDate(String value) {
    followupDate = value;
    update();
  }

  void selectNextFollowupDate(String value) {
    nextFollowupDate = value;
    update();
  }

  void selectPartyValue(value) {
    selectParty = value;
    update();
  }

  @override
  void onInit() {
    getOrderFollowupListResponse();
    getPartyDropdownList();
    super.onInit();
  }

  Future<void> getOrderFollowupListResponse() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          // '68';
          homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.branchId] =
          // '121';
          homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.userId] =
          // '462675';
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.partyId] = selectParty?.partyid.toString() ?? '0';
      var res = await api.getOrderFollowupListResponse(body);
      if (res.status == 200) {
        orderFollowupListData = res.data ?? [];
      } else {
        ShowMessage.showSnackBar(
            'OrderFollowupList res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('OrderFollowupList res. catch', e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> getOrderFollowupDetailsResponse(String followupId) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          // '68';
          homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.userId] =
          // '462675';
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.followupId] = followupId.toString().toString();
      '143584';
      // followupId.toString();

      var res = await api.getOrderFollowupDetailsResponse(body);
      if (res.status == 200) {
        orderFollowupDetailsData = res.data ?? [];
      } else {
        ShowMessage.showSnackBar(
            'OrderFollowupDetails res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('OrderFollowupDetails res. catch', e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> getOrderFollowupSaveResponse(String followupId) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.branchId] =
          homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.yearId] =
          homeController.currentUserData?.yearId.toString() ?? '';
      body[RequestKeys.followupId] = followupId.toString();
      body[RequestKeys.followupRemarks] =
          followupRemarkController.text.tr.toString();
      body[RequestKeys.followupDate] = followupDate.toString();
      body[RequestKeys.nextFollowupDate] = nextFollowupDate.toString();
      body[RequestKeys.followupType] = 'order';

      var res = await api.getPaymentFollowupSaveResponse(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar(
            'OrderFollowupDetails Saved', res.message.toString());
      } else {
        ShowMessage.showSnackBar(
            'OrderFollowupDetails res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('OrderFollowupDetails res. catch', e.toString());
    } finally {
      setBusy(false);
    }
  }

  void getPartyDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
      };
      // body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
      // body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '369622';

      var res = await api.getCustomersDetail(body);
      if (res.status == 200) {
        partyList = res.data ?? [];
      }
      // else {
      //   ShowMessage.showSnackBar(
      //       'getExecutiveDropdown Server res.status not 200',
      //       res.message.toString());
      // }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }
}
