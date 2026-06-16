import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/preview_visit_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PreviewController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  VisitPlanController visitPlanController = Get.find<VisitPlanController>();

  List<PreviewVisitDataList> previewVisitDataList = [];
  @override
  void onInit() {
    // TODO: implement onInit
    previewAddedVisitList();
    super.onInit();
  }

  void tapOnCard() {
    Get.toNamed(AppRoutes.visitPlanDetail);
  }

  void tapOnSubmit() async {
    bool isSuccess = await submitAndSaveVisit();

    if (isSuccess) {
      debugPrint('______________${isSuccess}_________');

      backTap();
      //

      //Get.offNamed(AppRoutes.home);
    } else {}
  }

  tapOnDelete(int index) async {
    await deleteVisitAtIndex(index);
    if (previewVisitDataList.isEmpty) {
      backTap();
    }
    update();
  }

  Future<void> previewAddedVisitList() async {
    isBusy = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';

      var res = await api.previewVisitData(body);
      if (res.status == 200) {
        previewVisitDataList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
    }
  }

  Future<void> deleteVisitAtIndex(int index) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
      body[RequestKeys.id] = previewVisitDataList[index].id.toString();

      var res = await api.deleteVisitData(body);
      if (res.status == 200) {
        previewVisitDataList.removeAt(index);
        //
        if (previewVisitDataList.isEmpty) {
          backTap(msg: res.message.toString());
        } else {
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
    }
  }

  Future<bool> submitAndSaveVisit() async {
    String date = formatDate(previewVisitDataList.first.visitdate ?? "", 'dd-MM-yyyy', 'yyyy-MM-dd');
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '39';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
      body[RequestKeys.executiveId] = homeController.currentUserData?.accountCode.toString() ?? '139841';
      body[RequestKeys.yearId] = homeController.currentUserData?.yearId.toString() ?? '39';
      body[RequestKeys.planeDate] = date;

      var res = await api.saveVisitData(body);
      if (res.status == 200) {
        //homeController.onItemTapped(4);
        backTap(msg: res.message.toString());
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
        return true;
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
        return false;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
      return false;
    } finally {
      isBusy = false;
    }
  }
}
