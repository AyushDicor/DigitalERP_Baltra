import 'package:digitalerp/response/attendance_summary_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class AttendanceListController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();
  late String id;
  List<DayDetails>? dayList = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    await getAttendanceList();
    super.onInit();
  }

  AttendanceListController(String value) {
    id = value;
    update();
  }

  Future<void> getAttendanceList({String? month, String? fromDate, String? toDate}) async {
    dayList?.clear();
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = id /* ?? homeController.currentUserData?.userid.toString() ?? '347614' */;
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.month] = month ?? DateTime.now().month.toString();
      body[RequestKeys.fromDate] = fromDate ?? getStartDateOfMonth(DateTime.now());
      body[RequestKeys.toDate] =
          toDate ?? formatDate(DateTime.now().toString(), AppString.dateTimeFormat, AppString.yyyyMMdd);
      body[RequestKeys.filter] = 'yes';
      var res = await api.getAttendanceList(body);
      if (res.status == 200) {
        dayList = res.data;

        /// For sorting date wise List
        dayList?.sort((a, b) {
          if (DateTime.parse(formatDate(a.date.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd))
              .isBefore(DateTime.parse(formatDate(b.date.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd)))) {
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
