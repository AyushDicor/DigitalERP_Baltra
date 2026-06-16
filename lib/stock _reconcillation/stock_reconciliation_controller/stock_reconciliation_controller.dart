import 'dart:convert';
import 'dart:developer';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/brand_list_response.dart';
import 'package:digitalerp/response/executive_list_with_lat_long_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/get_store_name_resp.dart';
import 'package:digitalerp/response/rack_list_response.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/response/stock_reconcilation_report_response.dart';
import 'package:digitalerp/response/stock_reconciliation_submit_response.dart';
import 'package:digitalerp/response/subcategory_brand_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StockReconciliationController extends AppBaseController{
  HomeController homeController = Get.find<HomeController>();

  TextEditingController itemController = TextEditingController();

  TextEditingController reconciliationDayController = TextEditingController();

  List<GetStoreNameData>? storeNameDataList = [];
  GetStoreNameData? storeNameData;
  List<StockCategoryList>? stockMainCategoryList;
  StockCategoryList? selectedMainCategoryValue;
  List<BrandData>? subGroupList;
  BrandData? selectedSubGroup;
  List<ProductDataList>? itemList;
  ProductDataList? selectedItem;
  List<BrandListData>? brandList;
  BrandListData? selectBrandList;
  bool isCheckingStockMoment = false;
  List<RackListData>? rackList;
  RackListData? selectRackNoList;
  List<StockReconciliationData> stockReconciliationReportList=[];
  StockReconciliationData? selectStockReconciliationReport;
  ExecutiveDropdownData? selectedDropdownValue;
  List<ExecutiveDropdownData>? executiveDropdownList = [];
  List<StockReconciliationSubmitData>? stockReconciliationSubmitData= [];

  bool loading = false;


  void clearSelectedItem() {
    selectedItem = null;
    update();
  }

  void loadingValue (bool value){
    loading = value;
    update();
  }

  void tapOnCheck() {
    isCheckingStockMoment = !isCheckingStockMoment;
    update();
  }

  void setStoreName(GetStoreNameData? data) {
    storeNameData = data;
    update();

  }

  void setSelectMainGroupValue(StockCategoryList? selectedCategoryValue) {
    selectedMainCategoryValue = selectedCategoryValue;
    getSubGroupList();
    update();
  }

  void setSubGroup(BrandData? data) {
    selectedSubGroup = data;
    getItemList();
    update();
  }

  void setItem(ProductDataList? data) {
    selectedItem = data;
    update();
  }

  String selectDate = 'Select Date';
  void setSelectedDate(String value) {
    selectDate = value;
    update();
  }
  void setBrand(BrandListData? data){
    selectBrandList = data;
    // getRackList();
    update();
  }
  void setRackNo(RackListData? data){
    selectRackNoList = data;
    update();
  }

  String firstDate =  DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month-1,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());
  String postingDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());
  String postingTime = DateFormat('hh:mm:ss a').format(DateTime.now());

  DateTime? firstDateInDate;
  DateTime? lastDateInDate;

  void setDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDate = value;
    } else {
      lastDate = value;
    }
    update();
  }

  void setDateByDate(DateTime value, bool isFirstDate) {
    if (isFirstDate) {
      firstDateInDate = value;
    } else {
      lastDateInDate = value;
    }
    update();
  }

  void setPostingDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      postingDate = value;
    }
    update();
  }

  void setPostingTime(String value) {
      postingTime = value;
    update();
  }



  @override
  void onInit() {
    getStoreNameList();
    getMainGroupList();
    getBrandNameList();
    getDropdownList();
    getRackList();
    super.onInit();
  }

  Future<void> getStoreNameList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '39';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      // body[RequestKeys.executiveId] = executiveId ?? '0';
      var res = await api.getStoreName(body);
      if (res.status == 200) {
        storeNameDataList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
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
        stockMainCategoryList = res.data ?? [];
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
      body[RequestKeys.categoryId] = selectedMainCategoryValue?.categoryid.toString() ?? '0';
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
  void getItemList() async {
    selectedItem=null;
    // subCategoryItemId = (selectedIndex == -1) ? 0 : subCategoryList[selectedIndex].subcategoryid;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.categoryId] = selectedMainCategoryValue?.categoryid.toString() ?? '';
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
  void getBrandNameList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '68';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '462675';
      var res = await api.getBrandList(body);
      if (res.status == 200) {
        brandList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    }
  }
  void getRackList() async {
    // selectRackNoList = null;
    // subCategoryItemId = (selectedIndex == -1) ? 0 : subCategoryList[selectedIndex].subcategoryid;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '68';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString()??'121';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString()??'261608';
      body[RequestKeys.categoryId] = "0";
          // selectedMainCategoryValue?.categoryid.toString() ?? '0';
      body[RequestKeys.subCategoryId] = "0";
          // selectedSubGroup?.subcategoryid.toString() ?? '0';
      body[RequestKeys.brandId] = "0";
          // selectBrandList?.brandid.toString()??'0';
      body[RequestKeys.itemId] = "0";
          // selectedItem?.itemid.toString()??'0';
      var res = await api.getRackNoList(body);
      if (res.status == 200) {
        rackList = res.data ?? [];
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', "Rack Number Not Available");
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setListLoading(false);
    }
  }

  // Future <void> getStockReconciliationReportList() async {
  //   try {
  //     Map<String, String> body = {};
  //     body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '68';
  //     body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString()??'121';
  //     body["storeid"] = storeNameData?.storeid.toString()??'0';
  //     body[RequestKeys.categoryId] = selectedMainCategoryValue?.categoryid.toString() ?? '0';
  //     body[RequestKeys.subCategoryId] = selectedSubGroup?.subcategoryid.toString() ?? '0';
  //     body[RequestKeys.brandId] = selectBrandList?.brandid.toString()??'0';
  //     body[RequestKeys.itemId] = selectedItem?.itemid.toString()??'0';
  //     body["rackno"] =  selectRackNoList?.rackno.toString()??'0';
  //     body["stockmovementdate"] =  isCheckingStockMoment.toString();
  //      body["movementfrom"] = DateFormat(AppString.ddMMyyyy).format(firstDate as DateTime);
  //     body["movementto"] = lastDate;
  //     body["lastreconsilationdays"] =  reconciliationDayController.text;
  //
  //     var res = await api.getStockReconciliationReportDetails(body);
  //
  //     if (res.status == 200) {
  //       stockReconciliationReportList = res.data ?? [];
  //       print("StockReconciliationReportList BODY :- ${jsonEncode(body)}");
  //       update();
  //     } else {
  //       ShowMessage.showSnackBar('Server Res',"Not Data Found");
  //     }
  //   } catch (e) {
  //     ShowMessage.showSnackBar('Server Res', '$e');
  //   } finally {
  //     setListLoading(false);
  //   }
  // }

  Future <void> submitStockReconciliationReportList(StockReconciliationData stockReconciliationData) async {
    loadingValue(true);
    try {
      List<Map> itemList =[];
      Map<String, dynamic> body = {};
      body["vouchernumber"] = "0";
      body["postingdate"] =  DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(postingDate),);
      body["postingtime"] = DateFormat('hh:mm a').format(DateTime.now())??postingTime;
      body["godownid"] = storeNameData?.storeid.toString()??'0';
      body[RequestKeys.compId] = homeController.currentUserData?.compId?? '68';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId??'121';
      body[RequestKeys.userId] = homeController.currentUserData?.userid??'261608';
      body[RequestKeys.yearId] = homeController.currentUserData?.yearId.toString()??'2024-25';
     itemList= [
    {
      "itemid":stockReconciliationData.itemid,
       "erpquantity":stockReconciliationData.erpquantity,
       "physicalquantity":stockReconciliationData.phyQtyController!.text.isEmpty?"0":stockReconciliationData.phyQtyController!.text,
       "scrapquantity": stockReconciliationData.scarpController!.text.isEmpty?"0":stockReconciliationData.scarpController!.text,
       "reorderlevel": stockReconciliationData.reOrderController!.text.isEmpty?"0":stockReconciliationData.reOrderController!.text,
       "minstockquantity": stockReconciliationData.miniStkQtyController!.text.isEmpty?"0":stockReconciliationData.miniStkQtyController!.text,
       "countedby": selectedDropdownValue?.executiveId??"0",

     }
       // body["erpquantity"] = stockReconciliationReportList.map((e) => e.erpquantity);
       // body["physicalquantity"] = stockReconciliationReportList.map((e) =>e.phyQtyController!.text.isEmpty?"0":e.phyQtyController!.text);
       // body["scrapquantity"] = stockReconciliationReportList.map((e) =>e.scarpController!.text.isEmpty?"0":e.scarpController!.text);
       // body["reorderlevel"] = stockReconciliationReportList.map((e) =>e.reOrderController!.text.isEmpty?"0":e.reOrderController!.text);
       // body["minstockquantity"] = stockReconciliationReportList.map((e) =>e.miniStkQtyController!.text.isEmpty?"0":e.miniStkQtyController!.text);
       // body["countedby"] = selectedDropdownValue?.executiveId??"0";
];

     // itemList = stockReconciliationReportList.map((e) => {
     //   "itemid":e.itemid,
     //    "erpquantity":e.erpquantity,
     //    "physicalquantity":e.phyQtyController!.text.isEmpty?"0":e.phyQtyController!.text,
     //    "scrapquantity": e.scarpController!.text.isEmpty?"0":e.scarpController!.text,
     //    "reorderlevel": e.reOrderController!.text.isEmpty?"0":e.reOrderController!.text,
     //    "minstockquantity": e.miniStkQtyController!.text.isEmpty?"0":e.miniStkQtyController!.text,
     //    "countedby": selectedDropdownValue?.executiveId??"0",
     //
     //  }).toList();

     body["itemdetails"] =itemList;
     log("Body ==>${jsonEncode(body)}");
      var res = await api.submitReconciliationReportDetails(body);
      if (res.status == 200) {
        final containIndex=   stockReconciliationReportList.indexWhere((element) => element.itemid==stockReconciliationData.itemid);
        print("Index ==>${containIndex}");
        if(containIndex>-1){
          stockReconciliationReportList[containIndex].postingstatus= res.data?.first.postingstatus;
          stockReconciliationReportList[containIndex].postingdatetime= res.data?.first.postingdatetime;
          update();
        }
        ShowMessage.showSnackBar('Submit Stock Reconciliation Details', res.message.toString());
      } else {
        ShowMessage.showSnackBar('Server Res', "Not Submit StockReconciliation");
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      loadingValue(false);
    }
  }


  void onSearch(BuildContext context) async {


    if(storeNameData == null){
      ShowMessage.showSnackBar('Error', 'PLease Select Store');

    }
    else if(selectRackNoList == null ){
      ShowMessage.showSnackBar('Error', 'PLease Select Rack/Bin');

    } else {
      setBusy(true);
      stockReconciliationReportList = [];
      Navigator.pop(context);
      try {
        Map<String, String> body = {};
        body[RequestKeys.compId] =
            homeController.currentUserData?.compId.toString() ?? '68';
        body[RequestKeys.branchId] =
            homeController.currentUserData?.branchId.toString() ?? '121';
        body["storeid"] = storeNameData?.storeid.toString() ?? '0';
        body[RequestKeys.categoryId] =
            selectedMainCategoryValue?.categoryid.toString() ?? '0';
        body[RequestKeys.subCategoryId] =
            selectedSubGroup?.subcategoryid.toString() ?? '0';
        body[RequestKeys.brandId] = selectBrandList?.brandid.toString() ?? '0';
        body[RequestKeys.itemId] = selectedItem?.itemid.toString() ?? '0';
        body["rackno"] = selectRackNoList?.rackno.toString()??'0';
        body["stockmovementdate"] =
        isCheckingStockMoment == true ? "Yes" : "No";
        body["movementfrom"] = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(firstDate),);
        body["movementto"] =  DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(lastDate),);
        body["lastreconsilationdays"] = reconciliationDayController.text.isEmpty
            ? "0"
            : reconciliationDayController.text;

        var res = await api.getStockReconciliationReportDetails(body);
        if (res.status == 200) {
          stockReconciliationReportList = res.data ?? [];
          print("StockReconciliationReportList BODY :- ${jsonEncode(body)}");
          update();
        } else {
          ShowMessage.showSnackBar('Server Res', "Not Data Found");
        }
        setBusy(false);
      } catch (e) {
        ShowMessage.showSnackBar('catch Server Res', '$e');
      }
    }
  }

  Future<void> getDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveDropdownList?.addAll(res.data!);
        // if (dropdownList?.length == 1) {
        //   setSelectDropdownValue(dropdownList?[0]);
        // }
        // else{

        // }
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  setSelectDropdownValue(value){
    selectedDropdownValue = value;
    update();

  }

}



