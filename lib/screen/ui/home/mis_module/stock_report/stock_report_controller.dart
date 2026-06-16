import 'package:digitalerp/response/get_stock_report_resp.dart';
import 'package:digitalerp/response/get_store_name_resp.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/response/subcategory_brand_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:digitalerp/response/get_party_for_parent_resp.dart';
import 'package:digitalerp/response/show_all_party_outstanding_resp.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';

class StockReportController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  List<GetStoreNameData>? storeNameList = [];
  GetStoreNameData? storeName;
  List<GetStockReportData>? list;
  List<StockCategoryList>? stockCategoryList;
  List<BrandData>? subGroupList;
  StockCategoryList? selectedCategoryValue;
  BrandData? selectedSubGroup;
  List<ProductDataList>? itemList;
  ProductDataList? selectedItem;

  @override
  onInit() async {
    // setBusy(true);
    getStoreNameList();
    getMainGroupList();
    // setBusy(false);
    super.onInit();
  }

  void setStoreName(GetStoreNameData? data) {
    storeName = data;
    update();
  }

  void setSubGroup(BrandData? data) {
    selectedSubGroup = data;
    getItemList();
    update();
  }

  void setSelectDropdownValue(StockCategoryList? selectedCategoryValue) {
    this.selectedCategoryValue = selectedCategoryValue;
    getSubGroupList();
    update();
  }

  void setItem(ProductDataList? data) {
    selectedItem = data;
    update();
  }

  void getItemList() async {
    selectedItem=null;
    // subCategoryItemId = (selectedIndex == -1) ? 0 : subCategoryList[selectedIndex].subcategoryid;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.categoryId] = selectedCategoryValue?.categoryid.toString() ?? '';
      body[RequestKeys.subCategoryId] = selectedSubGroup?.subcategoryid.toString() ?? '0';
      body[RequestKeys.brandId] = '0';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString()??'0';


      // body[RequestKeys.rateFrom] = subCategoryItemId.toString();
      // body[RequestKeys.rateTo] = subCategoryItemId.toString();
      // body[RequestKeys.itemName] = "";
      var res = await api.getProductData(body);
      if (res.status == 200) {
        itemList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setListLoading(false);
    }
  }

  Future<void> getMainGroupList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      setBusy(true);
      var res = await api.getStockCategoryData(body);
      if (res.status == 200) {
        stockCategoryList = res.data ?? [];
        //update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  void getSubGroupList() async {
    selectedSubGroup=null;
    update();
    try {
      setListLoading(true);
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.categoryId] = selectedCategoryValue?.categoryid.toString() ?? '0';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString()??'0';

      var res = await api.getSubCategoryBrandData(body);
      if (res.status == 200) {
        subGroupList = res.data ?? [];

        /// for calling product API after category
        // getProductList();

        // if (subCategoryList.length > 1) {
        //   isManager = true;
        // } else {
        //   selectedBrand = subCategoryList.first;
        // }
        update();
      } else {
        ShowMessage.showSnackBar('Server Fail', res.message.toString());
        setListLoading(false);
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
      setListLoading(false);
    } finally {
      setBusy(false);
    }
  }

  Future<void> getStoreNameList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '39';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      // body[RequestKeys.executiveId] = executiveId ?? '0';
      var res = await api.getStoreName(body);
      if (res.status == 200) {
        storeNameList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }

  void onSearch() async {
    if (storeName == null) {
      ShowMessage.showSnackBar('Error', 'PLease Select Store');
      return;
      // } else if (party == null) {
      // } else if (party == null) {
      //   ShowMessage.showSnackBar('Error', 'PLease Select Party Name');
      //   return;
      // } else if (daysCtr.text.isEmpty) {
      //   ShowMessage.showSnackBar('Error', 'PLease Enter Days');
      //   return;
      // } else if (int.parse(daysCtr.text) < 0) {
      //   ShowMessage.showSnackBar('Error', 'PLease Enter Valid Days');
      //   return;
    }
    setBusy(true);
    list=[];
    try {
      Map<String, String> body = {};
      // body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '0';
      body['storeid'] = storeName?.storeid.toString() ?? '0';
      body[RequestKeys.categoryId] = selectedCategoryValue?.categoryid.toString() ?? '0';
      body[RequestKeys.subCategoryId] = selectedSubGroup?.subcategoryid.toString() ?? '0';
      body[RequestKeys.itemId] = selectedItem?.itemid.toString() ?? '0';
      // body[RequestKeys.days] = daysCtr.text;
      var res = await api.getStockReport(body);
      setBusy(false);
      if (res.status == 200) {
        list = res.data ?? [];

        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      setBusy(false);
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }
}
