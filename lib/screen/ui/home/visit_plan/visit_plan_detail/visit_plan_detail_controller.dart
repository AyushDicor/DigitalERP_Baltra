import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/all_visit_data_response.dart';
import 'package:digitalerp/response/visit_check_in_response.dart';
import 'package:digitalerp/response/visit_check_out_response.dart';
import 'package:digitalerp/response/visit_plan_detail_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VisitPlanDetailController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  VisitListData? argument;
  String? visitId;
  List<VisitPlanDetailsDataList> visitPlanDetailList = [];
  List<VisitCheckInData> visitCheckInList = [];
  List<VisitCheckOutData> visitCheckOutList = [];
  TextEditingController remarkController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    argument = Get.arguments;
    getVisitPlanDetailList();
    super.onInit();
  }

  void tapOnStock(VisitPlanDetailsDataList item) {
    Get.toNamed(AppRoutes.stockTakingView, arguments: item.partyid);
  }

  void tapOnOrder(int index) async {
    if (visitPlanDetailList[index].checkstatus == 'Check In') {
    } else if (visitPlanDetailList[index].checkstatus == 'Check Out') {
      ///object convert in json and then saved

      await SharedPre.setValue(SharedPre.selectedCustomer2, visitPlanDetailList[index].toJson());
      Get.toNamed(AppRoutes.orderList, arguments: visitPlanDetailList[index]);
    }
  }

  void tapOnCheckIn(int index) {
    checkInCustomer(index);
    visitPlanDetailList[index].checkstatus = 'Check Out';
    update();
  }

  void tapOnCheckOut(int index) {
    if (visitCheckOutList.isEmpty ? false : visitCheckOutList[index].checkstatus == '') {
    } else {
      checkOutCustomer(index);
      visitPlanDetailList[index].checkstatus = '';
      update();
    }
  }

  void tapOnPayment(int? partyid) {
    Get.toNamed(AppRoutes.collection, arguments: partyid.toString());
  }

  Future<void> getVisitPlanDetailList() async {
    isBusy = true;
    final location = await getUserCurrentPosition();
    try {
      //visitPlanDetailList.clear();
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? ''; //39.toString();
      body[RequestKeys.visitId] = argument?.visitid.toString() ?? ''; //39.toString();
      body[RequestKeys.latitude] = location.latitude.toString(); //39.toString();
      body[RequestKeys.longitude] = location.longitude.toString(); //39.toString();

      var res = await api.visitPlanDetailListData(body);
      if (res.status == 200) {
        visitPlanDetailList = res.data ?? [];
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

  Future<void> checkInCustomer(int index) async {
    isBusy = true;

    final location = await getUserCurrentPosition();
    final address = await getUserCurrentAddress();

    try {
      //visitPlanDetailList.clear();
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? ''; //39.toString();
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? ''; //39.toString();
      body[RequestKeys.partyId] = visitPlanDetailList[index].partyid.toString(); //39.toString();
      body[RequestKeys.visitId] = argument?.visitid.toString() ?? ''; //39.toString();
      body[RequestKeys.latitude] = location.latitude.toString(); //39.toString();
      body[RequestKeys.longitude] = location.longitude.toString(); //39.toString();
      body[RequestKeys.location] = address; //39.toString();

      var res = await api.visitCheckInData(body);
      if (res.status == 200) {
        visitCheckInList = res.data ?? [];
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

  Future<void> checkOutCustomer(int index) async {
    isBusy = true;
    final location = await getUserCurrentPosition();
    final address = await getUserCurrentAddress();
    try {
      //visitPlanDetailList.clear();
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? ''; //39.toString();
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? ''; //39.toString();
      body[RequestKeys.partyId] = visitPlanDetailList[index].partyid.toString(); //39.toString();
      body[RequestKeys.visitId] = argument?.visitid.toString() ?? ''; //39.toString();
      body[RequestKeys.latitude] = location.latitude.toString(); //39.toString();
      body[RequestKeys.longitude] = location.longitude.toString(); //39.toString();
      body[RequestKeys.location] = address; //39.toString();
      body["remark"] = remarkController.text.isEmpty?"":remarkController.text; //39.toString();
      var res = await api.visitCheckOutData(body);
      if (res.status == 200) {
        visitCheckOutList = res.data ?? [];
      } else {
        // ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }
}
