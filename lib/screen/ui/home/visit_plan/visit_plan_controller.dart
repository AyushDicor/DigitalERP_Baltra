import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/all_visit_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/api_service/request_keys.dart';

class VisitPlanController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  final TextEditingController startDateController = TextEditingController();
  final FocusNode startDateFocus = FocusNode();
  final TextEditingController endDateController = TextEditingController();
  final FocusNode endDateFocus = FocusNode();
  String selectedExecutiveId = '';
  String selectedStateId = '';
  String selectedCityId = '';
  String selectedAreaId = '';
  String? fromVisitDate, toVisitDate;
  RxList<VisitListData> visitListData = <VisitListData>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getVisitPlanList();
    super.onInit();
  }

  void resetFilter() {
    selectedExecutiveId = '';
    selectedCityId = '';
    selectedAreaId = '';
    fromVisitDate = null;
    toVisitDate = null;
    getVisitPlanList();
    update();
  }

  void tapOnCard(VisitListData item) {
    Get.toNamed(AppRoutes.visitPlanDetail, arguments: item);
  }

  void tapOnAdd() {
    Get.toNamed(AppRoutes.newVisitPlaning);
  }

  Future<void> getVisitPlanList() async {
    var date = DateTime.now().add(const Duration(days: 30));
    try {
      isBusy = true;
      visitListData.clear();
      String executiveId = '';
      if (selectedExecutiveId.isEmpty) {
        executiveId = homeController.currentUserData?.accountCode.toString() ?? '';
      } else {
        executiveId = selectedExecutiveId;
      }
      String fromDate = fromVisitDate ?? '';
      String toDate = toVisitDate ?? '';
      if (fromDate.isEmpty) {
        fromDate = getStartDateOfMonth(DateTime.now());
      }
      if (toDate.isEmpty) {
        toDate = formatDate(date.toString(), AppString.dateTimeFormat, AppString.yyyyMMdd);
      }
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate,
        RequestKeys.executiveId: executiveId,
        RequestKeys.cityId: selectedCityId.isEmpty ? '0' : selectedCityId,
        RequestKeys.areaId: selectedAreaId.isEmpty ? '0' : selectedAreaId,
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString()??'',
      };
      var res = await api.allVisitListData(body);
      if (res.status == 200) {
        visitListData.value = res.data ?? [];

        ///list sort according to date wise
        visitListData.sort((a, b) {
          return a.visitdate!.compareTo(b.visitdate!);
        });
        //visitListData.value.reversed;
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
}
