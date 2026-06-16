import 'package:digitalerp/response/approved_or_rejected_leave_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/pending_leave_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/custom_dialogbox.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagerLeaveHistoryController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  List<LeaveData> leaveHistoryList = [];
  List<PendingLeaveData> pendingLeaveList = [];
  bool isManager = false;
  List<ExecutiveDropdownData> executiveList = [];
  ExecutiveDropdownData? selectedDropdownValue;
  MonthData? selectedMonth;
  String? executiveId;
  String? fromDate;
  String? toDate;

  void setSelectDropdownValue(ExecutiveDropdownData? value) {
    selectedDropdownValue = value;
    pendingLeaveList.clear();
    executiveId = value?.executiveId.toString();
    getPendingLeaveList(loading: true);
    update();
  }

  @override
  void onInit() async {
    getExecutiveList();
    super.onInit();
  }

  Future<void> getPendingLeaveList({bool? loading}) async {
    pendingLeaveList.clear();
    setListLoading(loading ?? false);
    update();
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = executiveId ?? '0';
      body[RequestKeys.fromDate] = fromDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
      body[RequestKeys.toDate] = toDate ??
          formatDate(
              DateTime.now().add(const Duration(days: 365)).toString(), AppString.dateTimeFormat, AppString.yyyyMMdd);
      var res = await api.getPendingLeaveList(body);
      if (res.status == 200) {
        pendingLeaveList.addAll(res.data ?? []);

        /// For sorting date wise List
        ///
        pendingLeaveList.sort((a, b) {
          if (DateTime.parse(formatDate(a.date!.split(' ').first.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd))
              .isAfter(DateTime.parse(
                  formatDate(b.date!.split(' ').first.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd)))) {
            return 1;
          }
          return 0;
        });
        update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setListLoading(false);
    }
  }

  Future<void> leaveStatusUpdate({required String id, required bool isApproved}) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.id] = id;
      body[RequestKeys.status] = isApproved ? 'approved' : 'reject';
      var res = await api.updateLeaveStatus(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar('Success Server Res', res.message.toString());
        getPendingLeaveList(loading: true);
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {}
  }

  Future<void> getExecutiveList({String? executiveId}) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = executiveId ?? '0';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveList.addAll(res.data ?? []);
        getPendingLeaveList();
        isManager = (executiveList.length > 1);
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {}
  }
}
