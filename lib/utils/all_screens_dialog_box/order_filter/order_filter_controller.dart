import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class
OrderFilterController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  OrderController orderController = Get.find<OrderController>();
  String firstDate = AppString.dateTimeEmpty;
  String lastDate = AppString.dateTimeEmpty;

  @override
  void onInit() {
    // TODO: implement onInit
    if (orderController.fromDate != null && firstDate == AppString.dateTimeEmpty) {
      firstDate = formatDate(orderController.fromDate.toString(), AppString.yyyyMMdd, AppString.ddMMyyyy);
      lastDate = formatDate(orderController.todate.toString(), AppString.yyyyMMdd, AppString.ddMMyyyy);
    }
    super.onInit();
  }

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
        lastDate == AppString.dateTimeEmpty &&
        (orderController.selectedExecutiveDropdownValue?.executiveName?.isEmpty ?? true)) {
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
    /*
    else if (DateFormat(ddMMyyyy)
        .parse(lastDate)
        .isAfter(DateTime.parse('${DateTime.now().year.toString()}-12-31 00:00:00.000'))) {
      ShowMessage.showSnackBar(pleaseCheckTxt, dateGreaterThanYear);
      return false;
    }
    */
    else {
      return true;
    }
  }

  void onApplyFilter() {
    int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    /*int currentYear = int.parse(
        '${homeController.currentUserData?.yearId
            ?.split('-')
            .first}');*/
    String monthFirstDate =
        formatDate(DateTime(currentYear, 1, 1).toString(), AppString.dateTimeFormat, AppString.ddMMyyyy);
    String monthLastDate = formatDate(DateTime(currentYear + 1, 1).subtract(const Duration(days: 1)).toString(),
        AppString.dateTimeFormat, AppString.ddMMyyyy);
    if (isValidate()) {
      orderController.fromDate = formatDate(
        firstDate == AppString.dateTimeEmpty ? monthFirstDate : firstDate,
        AppString.ddMMyyyy,
        AppString.yyyyMMdd,
      );
      orderController.todate = formatDate(
        lastDate == AppString.dateTimeEmpty ? monthLastDate : lastDate,
        AppString.ddMMyyyy,
        AppString.yyyyMMdd,
      );
      orderController.getOrderList(status:orderController.status );
      // Navigator.of(context).pop();
      Get.back();
    }
  }
}
