import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/brand_list_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/select_category_view.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectBrandController extends AppBaseController {
  // List<BannerItem> bannerSlideList = [];
  List<BrandItem> brandListItem = [];
  int pageIndex = 0;
  List<Color> color = [
    red2Color,
    grBottomColor,
    categoryColor,
    darkOrangeColor,
  ];

  final HomeController _homeController = Get.find<HomeController>();
  // BannerItem? bannerListData;
  BrandItem? brandListData;
  bool isManager = false;
  int? brandId;
  int? cartListCount;

  final PageController pageController = PageController(
    initialPage: 0,
  );
  int selectedIndex = 0;
  String? brandName;

  @override
  void onInit() async {
    // TODO: implement onInit
    // getBannerList();
    getBrandList();
    cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);
    super.onInit();
  }

  void onClick(int index) async {
    selectedIndex = index;
    // categoryListItem[index].select = !(categoryListItem[index].select ?? false);
    // await SharedPre.getStringValue(SharedPre.selectedBrand);
    brandId = brandListItem[index].brandid;
    brandName = brandListItem[index].brandname;
    SharedPre.setValue(SharedPre.selectedBrand, brandName);

    Get.to(const SelectCategoryView(), arguments: brandId);

    update();
  }

  void onBannerChange(int i) {
    pageIndex = i;
    update();
  }

  void onCartTap() {
    Get.toNamed(AppRoutes.cart);
  }

  /*void getBannerList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      var res = await api.getBannerData(body);
      if (res.status == 200) {
        bannerSlideList = res.data ?? [];
        if (bannerSlideList.length > 1) {
          isManager = true;
        } else {
          bannerListData = bannerSlideList.first;
        }
        update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }*/

  void getBrandList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] = _homeController.currentUserData?.userid.toString() ?? '423652';
      body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString() ?? '0';
      var res = await api.getBrandData(body);
      if (res.status == 200) {
        brandListItem = res.data ?? [];
        if (brandListItem.length > 1) {
          isManager = true;
        } else {
          brandListData = brandListItem.first;
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
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }
}

class Category {
  String title;
  Color color;
  String image;
  bool select;

  Category({required this.select, required this.color, required this.image, required this.title});
}
