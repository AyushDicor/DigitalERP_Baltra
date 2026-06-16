// import 'package:digitalerp/Menu_new_list_responce.dart';
// import 'package:digitalerp/app_routes/app_routes.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:get/get.dart';
//
// import 'services/api_service/request_keys.dart';
//
// class MenuDefaultController extends AppBaseController{
//   HomeController homeController = Get.find<HomeController>();
//   List<MenuNewData> menuSubData = [];
//   // int? menuid;
//   // @override
//   // void onInit() {
//   //   super.onInit();
//   //   // getNewSubList(menuid!);
//   // }
//
//   Future<void> getNewSubList(int menuId) async {
//     try {
//       isBusy = true;
//       Map<String, String> body = {};
//       body[RequestKeys.compId] =
//           homeController.currentUserData!.compId.toString();
//
//       body[RequestKeys.branchId] =
//           homeController.currentUserData!.branchId.toString();
//
//       body[RequestKeys.userId] =
//       homeController.currentUserData!.userid.toString();
//       body[RequestKeys.menuId] = menuId.toString();
//       var res = await api.getNewMenuList(body);
//       if (res.status == 200) {
//         print("True Menu");
//
//         menuSubData= res.data ?? [];
//       } else {
//         // ShowMessage.showSnackBar('get New Menu res.status not 200', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('getMenuSubList catch', '$e');
//     } finally {
//       isBusy = false;
//       update();
//     }
//   }
//   //
//   // static String goRoutePage(int menuId, int menusubId){
//   //
//   //   if(menuId == menusubId){}
//   //
//   // }
//
//
// }
//
//
//
//
//
//
//


// menu_default_controller.dart
// 
// DROP-IN replacement. Keeps ALL original real-API logic.
// Adds: _menuIdStack, initMenu(), pushMenu(), popMenu(), currentTitle
// 

import 'package:digitalerp/Menu_new_list_responce.dart';
import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

import 'services/api_service/request_keys.dart';

class MenuDefaultController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  List<MenuNewData> menuSubData = [];

  //  Navigation stack 
  // Was a bare `List<int> newMenuId = []` at global file scope in the old code.
  // Keeping it here prevents stale state across navigations.
  final List<int> _menuIdStack = [];

  //  AppBar title 
  String currentTitle = 'Menu';

  //  Public navigation helpers 

  /// Call ONCE from initState with the root menuId.
  void initMenu(int rootId) {
    _menuIdStack
      ..clear()
      ..add(rootId);
    getNewSubList(rootId);
  }

  /// Drill into a child/parent node.
  void pushMenu(int id) {
    _menuIdStack.add(id);
    getNewSubList(id);
  }

  /// Go up one level.
  /// Returns true  → handled internally (stay on screen, show parent).
  /// Returns false → at root; caller should close the route.
  bool popMenu() {
    if (_menuIdStack.length <= 1) return false;
    _menuIdStack.removeLast();
    getNewSubList(_menuIdStack.last);
    return true;
  }

  bool get isAtRoot => _menuIdStack.length <= 1;

  //  Real API call (original logic kept intact) 
  Future<void> getNewSubList(int menuId) async {
    try {
      isBusy = true;
      menuSubData = [];
      update();

      final Map<String, String> body = {
        RequestKeys.compId:
        homeController.currentUserData!.compId.toString(),
        RequestKeys.branchId:
        homeController.currentUserData!.branchId.toString(),
        RequestKeys.userId:
        homeController.currentUserData!.userid.toString(),
        RequestKeys.menuId: menuId.toString(),
      };

      final res = await api.getNewMenuList(body);

      if (res.status == 200) {
        menuSubData = res.data ?? [];
      } else {
        menuSubData = [];
        // Uncomment to surface API errors to the user:
        // ShowMessage.showSnackBar('getNewSubList', res.message.toString());
      }
    } catch (e) {
      menuSubData = [];
      ShowMessage.showSnackBar('getMenuSubList catch', '$e');
      print('MENU_ID: $menuId → children: ${menuSubData.map((e) => '${e.menuid}:${e.menuname}').toList()}');
    } finally {
      // ✅ Always reset — prevents infinite spinner on API errors
      isBusy = false;
      update();
    }
  }
}