
import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_details/product_details_view.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/select_category_controller.dart';
import 'package:digitalerp/screen/ui/login/login_controller.dart';
import 'package:digitalerp/screen/ui/login/login_view.dart';
import 'package:get/get.dart';


class AppDependencies {
  static Future<void> init() async {
    Get.lazyPut(() => const LoginView());
    Get.create(() => const ProductDetailsView());
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<LeaveHistoryController>(() => LeaveHistoryController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SelectCategoryController>(() => SelectCategoryController(), fenix: true);
/*    Get.put(const DashboardView(), permanent: true);
    Get.put(const AttendanceView(), permanent: true);
    Get.put(const ExecutiveListView(), permanent: true);
    Get.put(const OrderView(), permanent: true);
    Get.put(const VisitPlanView(), permanent: true);
    Get.put(const CustomerListView(), permanent: true);
    Get.put(const ImageView(), permanent: true);
    Get.put(const AccountModuleView(), permanent: true);*/
  }
}
