import 'package:digitalerp/response/get_attendance_report_resp.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceReportController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  List<GetAttendanceReportData> attendanceReportList = [];
  String dateMonth = AppString.dateTimeEmpty;

  List<ExecutiveDropdownData>? executiveDropdownList = [];
  ExecutiveDropdownData? selectedExecutiveValue;

  @override
  void onInit() {
    // Set current date automatically
    dateMonth = DateFormat('dd-MM-yyyy').format(DateTime.now());
    getExecutiveDropdownList();
    super.onInit();
  }

  void setExecutiveValue(ExecutiveDropdownData? value) {
    selectedExecutiveValue = value;
    update();
  }

  Future<void> getExecutiveDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveDropdownList?.addAll(res.data!);
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
      await getAttendanceReportList(); // ← auto-fetch with today's date, no executive
    }
  }

  Future<void> getAttendanceReportList() async {
    try {
      String dateMonthString =
          formatDate(dateMonth, 'dd-MM-yyyy', 'yyyy-MM-dd');
      Map<String, String> body = {
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.executiveId:
            selectedExecutiveValue?.executiveId.toString() ?? "0",
        'datemonth': dateMonthString,
        // RequestKeys.transId: selectedTransactionValue?.transid.toString()??"",
      };
      var res = await api.getAttendanceReport(body);
      if (res.status == 200) {
        attendanceReportList = res.data ?? [];
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

  void setDateMonth(String value) {
    dateMonth = value;
    update();
  }

  // void onSearch() async {
  //   if (dateMonth == AppString.dateTimeEmpty) {
  //     ShowMessage.showSnackBar('Validation', 'Please Select Date/Month');
  //     return;
  //   }
  //   getAttendanceReportList();
  // }
  void onSearch() async {
    // date is always set, no need to validate
    getAttendanceReportList();
  }
}
