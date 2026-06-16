import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/account_menu_model.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:get/get.dart';

class AccountModuleController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  bool? isBackIcon;
  List<AccountMenu> menuList = [
    AccountMenu(color1: orangeColor, color2: red2Color, name: 'Payment Entry', pageName: AppRoutes.paymentEntry),
    AccountMenu(color1: purpleColor, color2: blueColor, name: 'Receipt Entry', pageName: AppRoutes.receiptEntry),
    AccountMenu(color1: greenColor, color2: lightGreenColor, name: 'Collection', pageName: AppRoutes.collection),
    AccountMenu(color1: red3Color, color2: red4Color, name: 'Expenses', pageName: AppRoutes.expense),
    AccountMenu(color1: darkBlueColor, color2: purpleColor, name: 'Party ledger', pageName: AppRoutes.outstanding),
    // AccountMenu(color1: darkBlueColor, color2: purpleColor, name: 'Outstanding', pageName: AppRoutes.outstanding),
    AccountMenu(color1: green3Color, color2: green4Color, name: 'Contra', pageName: AppRoutes.contra),
    AccountMenu(color1: purple2Color, color2: lightOrangeColor, name: 'Journal', pageName: AppRoutes.journalEntry),
    AccountMenu(color1: chocolateColor, color2: fadeGreenColor, name: 'Party Transactions', pageName: AppRoutes.partyTransactions)
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    var arg = Get.arguments;
    if(arg is bool){
      isBackIcon=arg;
    }
    super.onInit();
  }

  void tapOnCard(int index) {
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
  }

  void tapOnCamera() {}
}
