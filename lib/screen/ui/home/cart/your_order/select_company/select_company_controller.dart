import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/your_order_controller.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../../../response/party_dropdown_list_response.dart';
import '../../../../../../services/api_service/request_keys.dart';
import '../../../home_controller.dart';

class SelectCompanyController extends AppBaseController {
  final YourOrderController yourOrderController = Get.find<YourOrderController>();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final HomeController _homeController = Get.find<HomeController>();
  bool isManager = false;
  PartyDropdownData? partyData;

  List<PartyDropdownData> companyList = [];

  ExecutiveDropdownData? selectedDropdownValue;

  Position? currentPosition;


  @override
  void onInit() async{
    // TODO: implement onInit
    getPartyList();
    currentPosition = await getUserCurrentPosition();
    super.onInit();

  }

  void tapOnCard(int index) {
    searchFocus.unfocus();
    // selectedIndexValue = companyList[index];
    update();

    checkCompanyLatLng(index);

    //checkCompanyValidate(index);


   // yourOrderController.selectCompany = companyList[index];
    //update();
    //backTap();
/*     if (companyList[index].isPending) {
      ShowMessage.showSnackBar(messageTxt, companyPendingTxt);
    } else {
      yourOrderController.selectCompany = companyList[index];
      backTap();
    }*/
  }
  void searchCompany(String value) {
    if(value.isEmpty){
      getPartyList();
      update();
    }else{
      final suggestions = companyList.where((element) {
        final productTitle = element.partyname!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      companyList = suggestions;
      update(); }
  }

  void setDropdownValue(ExecutiveDropdownData value) {
    searchFocus.unfocus();
    selectedDropdownValue = value;
    update();
  }

  void tapOnAdd() {
    searchFocus.unfocus();
    Get.toNamed(AppRoutes.addCompany)?.then((value) {
      getPartyList();
    });
  }

  void getPartyList() async {
    try {
      isListLoading = true;
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] = _homeController.currentUserData?.userid.toString() ?? '39';//424655.toString();
      body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString() ?? '39';
      var res = await api.getPartyDropdownList(body);
      if (res.status == 200) {
        companyList = res.data ?? [];
        if (companyList.length > 1) {
          isManager = true;
        } else {
          partyData = companyList.first;
        }
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
      isListLoading = false;
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }
  void checkCompanyValidate(int index) async {
    try {
      isListLoading = true;
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] = _homeController.currentUserData?.userid.toString() ?? '39';
      body[RequestKeys.partyId] = companyList[index].partyid.toString();



      var res = await api.checkPartyValidation(body);
      if (res.status == 200) {
        if(res.success??true){
          yourOrderController.selectCompany = companyList[index];
          update();
          backTap();
        }else{
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }

      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
      isListLoading = false;
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }
  void checkCompanyLatLng(int index) async {
    try {
      isListLoading = true;
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] = _homeController.currentUserData?.userid.toString() ?? '39';
      body[RequestKeys.partyId] = companyList[index].partyid.toString();
      body[RequestKeys.latitude] = currentPosition?.latitude.toString()??'0';
      body[RequestKeys.longitude] = currentPosition?.longitude.toString()??'0';
      var res = await api.matchPartyLatLng(body);
      if (res.status == 200) {
        if(res.success??true){
          yourOrderController.selectCompany = companyList[index];
          print("Selected Compny=>${yourOrderController.selectCompany}");
          update();
          backTap();
        }else{
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }

      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
      isListLoading = false;
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }


}

class CompanyData {
  String? name, companyCode, imageUrl, customerName;
  bool? isPending;

  CompanyData({this.name, this.companyCode, this.imageUrl, this.customerName, this.isPending});
}
