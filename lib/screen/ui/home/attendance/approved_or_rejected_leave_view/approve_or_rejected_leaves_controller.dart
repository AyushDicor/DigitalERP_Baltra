import 'package:digitalerp/response/approved_or_rejected_leave_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/attendance/attendance_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class ApproveOrRejectedLeavesController extends AppBaseController {
  AttendanceController attendanceController = Get.find<AttendanceController>();
  List<LeaveData> leaveList = [];
  bool _isApprovedLeave = true;

  bool get getIsApprovedLeave => _isApprovedLeave;

  void setIsApprovedLeave(bool value) {
    _isApprovedLeave = value;
    update();
  }

  ApproveOrRejectedLeavesController(this._isApprovedLeave);

  @override
  void onInit() {
    super.onInit();
    getDetails(getIsApprovedLeave);
  }

  Future<void> getDetails(bool isApproved) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = attendanceController.homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = attendanceController.homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.leaveStatus] = isApproved ? 'approved' : 'reject';
      var res = await api.getLeaveDetail(body);
      if (res.status == 200) {
        leaveList.addAll(res.data ?? []);

        /// For sorting date wise List
        leaveList.sort((a, b) {
          if (DateTime.parse(formatDate(a.date!.split(' ').first.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd))
              .isAfter(DateTime.parse(
                  formatDate(b.date!.split(' ').first.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd)))) {
            return 1;
          }
          return 0;
        });
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }
}
