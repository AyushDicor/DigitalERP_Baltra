// import 'package:digitalerp/app_routes/app_routes.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_list_view.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/shared_pre.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../response/select_category_list_response.dart';
// import '../../../../../services/api_service/request_keys.dart';
// import '../../../../../utils/show_message.dart';
// import '../../home_controller.dart';
//
// class SelectCategoryController extends AppBaseController {
//   List<BannerItem> bannerSlideList = [];
//   List<CategoryItem> categoryListItem = [];
//   int pageIndex =0;
//   List<Color> color = [
//     red2Color,
//     grBottomColor,
//     categoryColor,
//     darkOrangeColor,
//   ];
//
//   final HomeController _homeController = Get.find<HomeController>();
//   BannerItem? bannerListData;
//   CategoryItem? categoryListData;
//   bool isManager = false;
//   int? categoryId;
//   int? cartListCount;
//
//   final PageController pageController = PageController(
//     initialPage: 0,
//   );
//   int selectedIndex = 0;
//
//
//   @override
//   void onInit() async{
//     // TODO: implement onInit
//
//     String brandList = Get.arguments.toString();
//
//     getBannerList();
//     getCategoryList(brandList);
//     cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);
//     super.onInit();
//   }
//
//   void onClick(int index) {
//     selectedIndex = index;
//     categoryListItem[index].select = !(categoryListItem[index].select ?? false);
//     categoryId = categoryListItem[index].categoryid;
//     print("CatId=>${categoryId}");
//     Get.to(const ProductListView(), arguments: categoryId);
//     update();
//   }
//
//   void onBannerChange(int i) {
//     pageIndex = i;
//     update();
//   }
//
//   void onCartTap(){
//     Get.toNamed(AppRoutes.cart);
//   }
//
//   void getBannerList() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
//       body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString() ?? '';
//       var res = await api.getBannerData(body);
//       if (res.status == 200) {
//         bannerSlideList = res.data ?? [];
//         if (bannerSlideList.length > 1) {
//           isManager = true;
//         } else {
//           bannerListData = bannerSlideList.first;
//         }
//         update();
//       } else {
//         //ShowMessage.showSnackBar('Server Res', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
//
//   void getCategoryList(String brandList) async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
//       body[RequestKeys.brandId] = brandList;
//       body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString()??'0';
//       var res = await api.getCategoryData(body);
//       if (res.status == 200) {
//         categoryListItem = res.data ?? [];
//         if (categoryListItem.length > 1) {
//           isManager = true;
//         } else {
//           categoryListData = categoryListItem.first;
//         }
//         update();
//       } else {
//         ShowMessage.showSnackBar('Server Res', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     pageController.dispose();
//     super.dispose();
//   }
// }
//
// class Category {
//   String title;
//   Color color;
//   String image;
//   bool select;
//
//   Category({required this.select, required this.color, required this.image, required this.title});
// }

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_list_view.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../response/select_category_list_response.dart';
import '../../../../../services/api_service/request_keys.dart';
import '../../../../../utils/show_message.dart';
import '../../home_controller.dart';

class SelectCategoryController extends AppBaseController {
  // ✅ FIX: Use the correct types from your response model.
  // The error was caused by the API helper returning List<Object>
  // (e.g. res.data ?? []) which Flutter can't implicitly cast.
  // Explicitly cast with .cast<T>() or type the empty list correctly.
  List<BannerItem> bannerSlideList = <BannerItem>[];
  List<CategoryItem> categoryListItem = <CategoryItem>[];

  int pageIndex = 0;
  List<Color> color = [
    red2Color,
    grBottomColor,
    categoryColor,
    darkOrangeColor,
  ];

  final HomeController _homeController = Get.find<HomeController>();
  BannerItem? bannerListData;
  CategoryItem? categoryListData;
  bool isManager = false;
  int? categoryId;
  int? cartListCount;

  final PageController pageController = PageController(initialPage: 0);
  int selectedIndex = 0;

  @override
  void onInit() async {
    final String brandList = Get.arguments.toString();
    getBannerList();
    getCategoryList(brandList);
    cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);
    super.onInit();
  }

  void onClick(int index) {
    selectedIndex = index;
    categoryListItem[index].select = !(categoryListItem[index].select ?? false);
    categoryId = categoryListItem[index].categoryid;
    Get.to(const ProductListView(), arguments: categoryId);
    update();
  }

  void onBannerChange(int i) {
    pageIndex = i;
    update();
  }

  void onCartTap() => Get.toNamed(AppRoutes.cart);

  void getBannerList() async {
    setBusy(true);
    try {
      final body = <String, String>{
        RequestKeys.compId:
            _homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId:
            _homeController.currentUserData?.branchId.toString() ?? '',
      };
      final res = await api.getBannerData(body);
      if (res.status == 200) {
        // ✅ FIX: Explicitly cast the list elements to BannerItem
        bannerSlideList =
            (res.data as List?)?.cast<BannerItem>() ?? <BannerItem>[];
        if (bannerSlideList.length > 1) {
          isManager = true;
        } else if (bannerSlideList.isNotEmpty) {
          bannerListData = bannerSlideList.first;
        }
        update();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  void getCategoryList(String brandList) async {
    setBusy(true);
    try {
      final body = <String, String>{
        RequestKeys.compId:
            _homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.brandId: brandList,
        RequestKeys.branchId:
            _homeController.currentUserData?.branchId.toString() ?? '0',
      };
      final res = await api.getCategoryData(body);
      if (res.status == 200) {
        // ✅ FIX: Explicitly cast the list elements to CategoryItem
        categoryListItem =
            (res.data as List?)?.cast<CategoryItem>() ?? <CategoryItem>[];
        if (categoryListItem.length > 1) {
          isManager = true;
        } else if (categoryListItem.isNotEmpty) {
          categoryListData = categoryListItem.first;
        }
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
