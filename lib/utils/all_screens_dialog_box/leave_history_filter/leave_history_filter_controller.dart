import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/custom_dialogbox.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
//
// class LeaveHistoryFilterController extends AppBaseController {
//   LeaveHistoryController leaveHistoryController = Get.find<LeaveHistoryController>();
//
//   HomeController homeController = Get.find<HomeController>();
//   String firstDate =  DateFormat(AppString.ddMMyyyy).format(DateTime(
//       DateTime.now().year,
//       DateTime.now().month-1,
//       DateTime.now().day ,
//       DateTime.now().hour,
//       DateTime.now().minute,
//       DateTime.now().second));
//   String lastDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());
//
//   MonthData? selectedMonthDropdownValue;
//   List<MonthData> monthDropdownList = [
//     MonthData('April', 4),
//     MonthData('May', 5),
//     MonthData('June', 6),
//     MonthData('July', 7),
//     MonthData('August', 8),
//     MonthData('September', 9),
//     MonthData('October', 10),
//     MonthData('November', 11),
//     MonthData('December', 12),
//     MonthData('January', 1),
//     MonthData('February', 2),
//     MonthData('March', 3),
//   ];
//   RxBool isFilterByDate = true.obs;
//   RxBool isFilterByMonth = false.obs;
//
//   void setDate(String value, bool isFirstDate) {
//     if (isFirstDate) {
//       firstDate = value;
//     } else {
//       lastDate = value;
//     }
//     update();
//   }
//
//   void setSelectedMonthValue(MonthData? value) {
//     selectedMonthDropdownValue = value;
//     update();
//   }
//
//
//   void tapOnDateSwitch() {
//     isFilterByDate.value = true;
//     isFilterByMonth.value = false;
//     selectedMonthDropdownValue = null;
//   }
//
//   void tapOnMonthSwitch() {
//     isFilterByMonth.value = true;
//     isFilterByDate.value = false;
//     firstDate = AppString.dateTimeEmpty;
//     lastDate = AppString.dateTimeEmpty;
//   }
//
//
//
//   // void tapOnDateOrMonthSwitch() {
//   //   isFilterByDate.value = !(isFilterByDate.value);
//   //   isFilterByMonth.value = !(isFilterByMonth.value);
//   //   if (isFilterByDate.value) {
//   //     selectedMonthDropdownValue = null;
//   //   }
//   //   if (isFilterByMonth.value) {
//   //     firstDate = AppString.dateTimeEmpty;
//   //     lastDate = AppString.dateTimeEmpty;
//   //   }
//   // }
//
//
//   bool isValidate() {
//     if (isFilterByDate.value && firstDate == AppString.dateTimeEmpty) {
//       ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
//       return false;
//     } else if (isFilterByDate.value && lastDate == AppString.dateTimeEmpty) {
//       ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectToDateTxt);
//       return false;
//     } else if (isFilterByDate.value &&
//         (DateFormat(AppString.ddMMyyyy).parse(lastDate).isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate)))) {
//       ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
//       return false;
//     } else if (isFilterByMonth.value && (selectedMonthDropdownValue?.name.isEmpty ?? true)) {
//       ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectMonthTxt);
//       return false;
//     } else {
//       return true;
//     }
//   }
//
//   void onApplyFilter() {
//     String fromDate = '';
//     String toDate = '';
//
//     if (isValidate()) {
//       if (isFilterByMonth.value) {
//         int currentYear = int.parse('${homeController.currentUserData?.yearId?.split('-').first}');
//
//         currentYear = ((selectedMonthDropdownValue?.id ?? 5) < 4) ? currentYear + 1 : currentYear;
//         String monthFirstDate = formatDate(
//             DateTime(
//               currentYear,
//               selectedMonthDropdownValue?.id ?? 4,
//               1,
//             ).toString(),
//             AppString.dateTimeFormat,
//             AppString.ddMMyyyy);
//         String monthLastDate = formatDate(
//             DateTime(currentYear, (selectedMonthDropdownValue?.id ?? 3) + 1)
//                 .subtract(
//                   const Duration(
//                     days: 1,
//                   ),
//                 )
//                 .toString(),
//             AppString.dateTimeFormat,
//             AppString.ddMMyyyy);
//         fromDate = formatDate(monthFirstDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
//         toDate = formatDate(monthLastDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
//       } else {
//         fromDate = formatDate(firstDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
//         toDate = formatDate(lastDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
//       }
//       leaveHistoryController.getDetails(
//         fromDate: fromDate,
//         toDate: toDate,
//       );
//       leaveHistoryController.selectedMonth = selectedMonthDropdownValue;
//       Get.back();
//     }
//   }
// }



class LeaveHistoryFilterController extends AppBaseController {
  LeaveHistoryController leaveHistoryController = Get.find<LeaveHistoryController>();
  HomeController homeController = Get.find<HomeController>();

  String firstDate = DateFormat(AppString.ddMMyyyy).format(
    DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
  );
  String lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());

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

  // ✅ Toggle logic: allow user to switch ON/OFF and keep UI in sync
  void tapOnDateSwitch() {
    isFilterByDate.value = !isFilterByDate.value;

    if (isFilterByDate.value) {
      isFilterByMonth.value = false;
      selectedMonthDropdownValue = null;
    }

    update();
  }

  void tapOnMonthSwitch() {
    isFilterByMonth.value = !isFilterByMonth.value;

    if (isFilterByMonth.value) {
      isFilterByDate.value = false;
      firstDate = AppString.dateTimeEmpty;
      lastDate = AppString.dateTimeEmpty;
    }

    update();
  }

  void setSelectedMonthValue(MonthData? value) {
    selectedMonthDropdownValue = value;

    isFilterByMonth.value = true;
    isFilterByDate.value = false;
    firstDate = AppString.dateTimeEmpty;
    lastDate = AppString.dateTimeEmpty;

    update();
  }

  void setDate(String value, bool isFirstDateSelected) {
    if (isFirstDateSelected) {
      firstDate = value;
    } else {
      lastDate = value;
    }

    isFilterByDate.value = true;
    isFilterByMonth.value = false;
    selectedMonthDropdownValue = null;

    update();
  }

  bool isValidate() {
    if (isFilterByDate.value && firstDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
      return false;
    } else if (isFilterByDate.value && lastDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectToDateTxt);
      return false;
    } else if (isFilterByDate.value &&
        DateFormat(AppString.ddMMyyyy).parse(lastDate).isBefore(
          DateFormat(AppString.ddMMyyyy).parse(firstDate),
        )) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
      return false;
    } else if (isFilterByMonth.value && (selectedMonthDropdownValue?.name.isEmpty ?? true)) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectMonthTxt);
      return false;
    }
    return true;
  }

  void onApplyFilter() {
    String fromDate = '';
    String toDate = '';

    if (isValidate()) {
      if (isFilterByMonth.value) {
        int currentYear = int.parse('${homeController.currentUserData?.yearId?.split('-').first}');
        currentYear = ((selectedMonthDropdownValue?.id ?? 5) < 4) ? currentYear + 1 : currentYear;

        String monthFirstDate = formatDate(
          DateTime(currentYear, selectedMonthDropdownValue?.id ?? 4, 1).toString(),
          AppString.dateTimeFormat,
          AppString.ddMMyyyy,
        );
        String monthLastDate = formatDate(
          DateTime(currentYear, (selectedMonthDropdownValue?.id ?? 3) + 1).subtract(const Duration(days: 1)).toString(),
          AppString.dateTimeFormat,
          AppString.ddMMyyyy,
        );

        fromDate = formatDate(monthFirstDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
        toDate = formatDate(monthLastDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      } else {
        fromDate = formatDate(firstDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
        toDate = formatDate(lastDate, AppString.ddMMyyyy, AppString.yyyyMMdd);
      }

      leaveHistoryController.getDetails(fromDate: fromDate, toDate: toDate);
      leaveHistoryController.selectedMonth = selectedMonthDropdownValue;

      Get.back();
    }
  }
}
