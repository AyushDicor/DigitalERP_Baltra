import 'dart:convert';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/attendance_summary_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AttendanceController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  bool isAttendanceMarked = false;
  List<AttendanceSummaryData>? attendanceSummaryData;
  Position? currentPosition;
  bool enableBtn = true;
  bool isBtnShow = true;
  String exeId = '';
  final picker = ImagePicker();
  var selectedImage = ''.obs;
  var selectedImageBase64 = ''.obs;
  var selectedImageFileName = ''.obs;
  void setBtnShow() {
    isBtnShow = !isBtnShow;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getAttendanceDetails(true);
    super.onInit();
  }

  void setSelectedImage(String value) {
    selectedImage.value = value;
    update();
  }

  void tapOnApplyLeave() {
    Get.toNamed(AppRoutes.leaveHistory);
  }

  void tapOnApprovedLeave() {
    Get.toNamed(AppRoutes.approvedOrLeaveView, arguments: true);
  }

  void tapOnRejectedLeave() {
    Get.toNamed(AppRoutes.approvedOrLeaveView, arguments: false);
  }

  void tapOnSeeMore() {
    Get.toNamed(AppRoutes.attendanceList,
        arguments: homeController.currentUserData?.userid.toString());
  }

  void getAttendanceDetails(bool isBusy) async {
    setBusy(isBusy);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '0';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '0';
      body[RequestKeys.month] = DateTime.now().month.toString();
      body[RequestKeys.fromDate] = getStartDateOfMonth(DateTime.now());
      body[RequestKeys.toDate] = formatDate(DateTime.now().toString(),
          AppString.dateTimeFormat, AppString.yyyyMMdd);
      body[RequestKeys.filter] = 'yes';
      var res = await api.getAttendanceSummary(body);
      if (res.status == 200) {
        attendanceSummaryData = res.data;

        enableBtn = (attendanceSummaryData?[0].details?.last.date.toString() ==
                    formatDate(DateTime.now().toString(),
                        AppString.dateTimeFormat, AppString.ddMMyyyy) &&
                attendanceSummaryData?[0].details?.last.outTime != null)
            ? false
            : true;

        isAttendanceMarked =
            (attendanceSummaryData?[0].details?.last.date.toString() ==
                        formatDate(DateTime.now().toString(),
                            AppString.dateTimeFormat, AppString.ddMMyyyy) &&
                    attendanceSummaryData?[0].details?.last.outTime == null)
                ? true
                : false;

        /// for location route save API
        homeController.setLocationSending(isAttendanceMarked);
        SharedPre.setValue(SharedPre.isLocationSend, isAttendanceMarked);

        /// For sorting date wise List
        attendanceSummaryData?[0].details?.sort((a, b) {
          if (DateTime.parse(formatDate(
                  a.date.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd))
              .isBefore(DateTime.parse(formatDate(b.date.toString(),
                  AppString.ddMMyyyy, AppString.yyyyMMdd)))) {
            return 1;
          }
          return 0;
        });

        update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res catch', '$e');
    } finally {
      setBusy(false);
    }
  }

  void tapOnMarkAttendance() async {
    setBtnShow();
    try {
      print("Base64=>${selectedImageBase64.value}");
      currentPosition = await getUserCurrentPosition();
      String currentAddress = await getUserCurrentAddress();
      String battery = await getBatteryPercent();
      Map<String, String> body = {
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.yearId:
            homeController.currentUserData?.yearId.toString() ?? '',
        RequestKeys.latitude: currentPosition?.latitude.toString() ?? '0',
        RequestKeys.longitude: currentPosition?.longitude.toString() ?? '0',
        RequestKeys.location: currentAddress.toString(),
        RequestKeys.attendanceType: isAttendanceMarked ? 'close' : 'mark',
        RequestKeys.batteryLevel: battery.toString(),
        RequestKeys.filename: selectedImageFileName.value,
        RequestKeys.photo: selectedImageBase64.value,
      };
      debugPrint("body=>${jsonEncode(body)}");

      // body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '';
      // body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '';
      // body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '';
      // body[RequestKeys.yearId] = homeController.currentUserData?.yearId.toString() ?? '';
      // body[RequestKeys.latitude] = currentPosition?.latitude.toString() ?? '0';
      // body[RequestKeys.longitude] = currentPosition?.longitude.toString() ?? '0';
      // body[RequestKeys.location] = currentAddress.toString();
      // body[RequestKeys.attendanceType] = isAttendanceMarked ? 'close' : 'mark';
      // body[RequestKeys.batteryLevel] = battery.toString();
      // body[RequestKeys.filename] = "";
      // body[RequestKeys.photo]="";
      var res = await api.markAttendance(body);
      if (res.status == 200) {
        isAttendanceMarked = !(isAttendanceMarked);
        getAttendanceDetails(false);
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      setBtnShow();
    }
  }

  Future<void> getExecutiveDropDownList({String? executiveId}) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = executiveId ?? '0';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        // executiveList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }
}
