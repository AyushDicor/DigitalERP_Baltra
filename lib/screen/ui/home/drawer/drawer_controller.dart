import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppDrawerController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  tapOnUser(BuildContext context) {
    Navigator.pop(context);
    Get.toNamed(AppRoutes.profile);
  }

  tapOnAccount(BuildContext context) {
    Navigator.pop(context);
    // int index = homeController.bottomList.indexWhere((element) => element.id == '8');
    // homeController.onItemTapped(index);
  Get.toNamed(AppRoutes.accountModule);
  }

  tapOnExpenses(BuildContext context) {
    Navigator.pop(context);
    Get.toNamed(AppRoutes.expense);
  }

  tapOnChangeCompany(BuildContext context) {
    Navigator.pop(context);
    Get.toNamed(AppRoutes.changeCompany);
  }
  // tapOnPerformance(BuildContext context) {
  //   Navigator.pop(context);
  //   Get.toNamed(AppRoutes.performance);
  // }
  tapOnhome(BuildContext context) {
    Navigator.pop(context);
    Get.toNamed(AppRoutes.homeNew);
  }
}
