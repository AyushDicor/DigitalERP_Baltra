import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/account_module/list/list_with_filter_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/custom_dialogbox.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListFilterController extends AppBaseController {
  ListWithFilterController entryController = Get.find<ListWithFilterController>();

  HomeController homeController = Get.find<HomeController>();

  String firstDate = AppString.dateTimeEmpty;
  String lastDate = AppString.dateTimeEmpty;
  MonthData? selectedMonthDropdownValue;
  List<MonthData> monthDropdownList = [
    MonthData('April', 4),
    MonthData('May', 5),
    MonthData('June', 6),
    MonthData('July', 7),
    MonthData('August', 8),
    MonthData('September', 9),
    MonthData('October', 10),
    MonthData('November', 11),
    MonthData('December', 12),
    MonthData('January', 1),
    MonthData('February', 2),
    MonthData('March', 3),
  ];
  RxBool isFilterByDate = true.obs;
  RxBool isFilterByMonth = false.obs;

  void setDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDate = value;
    } else {
      lastDate = value;
    }
    update();
  }

  void setSelectedMonthValue(MonthData? value) {
    selectedMonthDropdownValue = value;
    update();
  }

  void tapOnDateOrMonthSwitch() {
    isFilterByDate.value = !(isFilterByDate.value);
    isFilterByMonth.value = !(isFilterByMonth.value);
    if (isFilterByDate.value) {
      selectedMonthDropdownValue = null;
    }
    if (isFilterByMonth.value) {
      firstDate = AppString.dateTimeEmpty;
      lastDate = AppString.dateTimeEmpty;
    }
  }

  bool isValidate() {
    if (isFilterByDate.value && firstDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
      return false;
    } else if (isFilterByDate.value && lastDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectToDateTxt);
      return false;
    } else if (isFilterByDate.value &&
        (DateFormat(AppString.ddMMyyyy).parse(lastDate).isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate)))) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
      return false;
    } else if (isFilterByMonth.value && (selectedMonthDropdownValue?.name.isEmpty ?? true)) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectMonthTxt);
      return false;
    } else {
      return true;
    }
  }

  void onApplyFilter() {
    String fromDate = '';
    String toDate = '';

    if (isValidate()) {
      if (isFilterByMonth.value) {
        int currentYear = int.parse('${homeController.currentUserData?.yearId?.split('-').first}');

        currentYear = ((selectedMonthDropdownValue?.id ?? 5) < 4) ? currentYear + 1 : currentYear;
        String monthFirstDate = formatDate(
            DateTime(
              currentYear,
              selectedMonthDropdownValue?.id ?? 4,
              1,
            ).toString(),
            AppString.dateTimeFormat,
            AppString.ddMMyyyy);
        String monthLastDate = formatDate(
            DateTime(currentYear, (selectedMonthDropdownValue?.id ?? 3) + 1)
                .subtract(
                  const Duration(
                    days: 1,
                  ),
                )
                .toString(),
            AppString.dateTimeFormat,
            AppString.ddMMyyyy);
        fromDate = formatDate(monthFirstDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
        toDate = formatDate(monthLastDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      } else {
        fromDate = formatDate(firstDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
        toDate = formatDate(lastDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      }
      entryController.getList(
        fromDate: fromDate,
        toDate: toDate,
      );
      Get.back();
    }
  }
}
