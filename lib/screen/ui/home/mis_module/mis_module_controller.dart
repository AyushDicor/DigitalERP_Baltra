import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/account_menu_model.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MisModuleController extends AppBaseController {
  List<AccountMenu> menuList = [
    AccountMenu(
      color1: orangeColor,
      color2: red2Color,
      name: 'Account Register',
      pageName: AppRoutes.misAccountRegister,
    ),
    AccountMenu(
      color1: purpleColor,
      color2: blueColor,
      name: 'Day Book',
      pageName: AppRoutes.misDayBook,
    ),
    AccountMenu(
      color1: greenColor,
      color2: lightGreenColor,
      name: 'Balance sheet',
      pageName: AppRoutes.misBalanceSheet,
    ),
    AccountMenu(
      color1: red3Color,
      color2: red4Color,
      name: 'Profit and Loss',
      pageName: AppRoutes.misProfitLoss,
    ),
    AccountMenu(
      color1: darkBlueColor,
      color2: purpleColor,
      name: 'Trial Balance',
      pageName: AppRoutes.misTrialBalance,
    ),
    // AccountMenu(color1: darkBlueColor, color2: purpleColor, name: 'Outstanding', pageName: AppRoutes.outstanding),
    AccountMenu(
      color1: green3Color,
      color2: green4Color,
      name: 'Attendance Report',
      pageName: AppRoutes.misAttendanceReport,
    ),
    AccountMenu(
      color1: purple2Color,
      color2: lightOrangeColor,
      name: 'Order Report',
      pageName: AppRoutes.misOrderReport,
    ),
    AccountMenu(
      color1: chocolateColor,
      color2: fadeGreenColor,
      name: 'Outstanding',
      pageName: AppRoutes.misOutstanding,
    ),
    AccountMenu(
      color1:  const Color(0xFF00cccc),
      color2:  const Color(0xFF009999),
      name: 'Pending Shipping',
      pageName: AppRoutes.misPendingShipping,
    ),
    AccountMenu(
      color1:  const Color(0xFFcc9900),
      color2:  const Color(0xFFffcc00),
      name: 'Stock Report',
      pageName: AppRoutes.misStockReport,
    ),
  ];

  void tapOnCard(int index) {
    Get.toNamed(menuList[index].pageName);
    return;
    /// old way
    // Get.toNamed(menuList[index].pageName);
    if (index == 0) {
      Get.toNamed(AppRoutes.entry, arguments: VoucherType.payment);
    } else if (index == 1) {
      Get.toNamed(AppRoutes.entry, arguments: VoucherType.receipt);
    } else if (index == 2) {
      Get.toNamed(AppRoutes.entry, arguments: VoucherType.collection);
    } else if (index == 3) {
      Get.toNamed(AppRoutes.entry, arguments: VoucherType.expense);
    } else if (index == 4) {
      Get.toNamed(menuList[index].pageName);
    } else if (index == 5) {
      Get.toNamed(AppRoutes.entry, arguments: VoucherType.contra);
    } else if (index == 6) {
      Get.toNamed(AppRoutes.entry, arguments: VoucherType.journal);
    } else if (index == 7) {
      Get.toNamed(menuList[index].pageName);
    }
    // Get.toNamed(AppRoutes.entry);
  }
}
