import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/graph/graph_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GraphFilterController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  GraphController graphController = Get.find<GraphController>();
  String firstDate = AppString.dateTimeEmpty;
  String lastDate = AppString.dateTimeEmpty;


  void setDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDate = value;
    } else {
      lastDate = value;
    }
    update();
  }

  bool isValidate() {
    if (firstDate == AppString.dateTimeEmpty &&
        lastDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectToDateTxt);
      return false;
    } else if (firstDate == AppString.dateTimeEmpty && lastDate != AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
      return false;
    } else if (lastDate == AppString.dateTimeEmpty && firstDate != AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectToDateTxt);
      return false;
    } else if (firstDate == AppString.dateTimeEmpty && lastDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.pleaseSelectDate);
      return false;
    } else if (DateFormat(AppString.ddMMyyyy)
        .parse(lastDate)
        .isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate))) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
      return false;
    }
    else {
      return true;
    }
  }

  void onApplyFilter() {
    int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    String monthFirstDate =
        formatDate(DateTime(currentYear, 1, 1).toString(), AppString.dateTimeFormat, AppString.ddMMyyyy);
    String monthLastDate = formatDate(DateTime(currentYear + 1, 1).subtract(const Duration(days: 1)).toString(),
        AppString.dateTimeFormat, AppString.ddMMyyyy);
    if (isValidate()) {
      graphController.fromDate = formatDate(
        firstDate == AppString.dateTimeEmpty ? monthFirstDate : firstDate,
        AppString.ddMMyyyy,
        AppString.yyyyMMdd,
      );
      graphController.todate = formatDate(
        lastDate == AppString.dateTimeEmpty ? monthLastDate : lastDate,
        AppString.ddMMyyyy,
        AppString.yyyyMMdd,
      );
      graphController.getAllGraph();
      // Navigator.of(context).pop();
      Get.back();
    }
  }
}
