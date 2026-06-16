import 'dart:convert';

import 'package:digitalerp/contactsview/Designation_dropdown_responce.dart';
import 'package:digitalerp/contactsview/contacts_view_responce.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/account_module/payment_entry/payment_entry_view.dart';
import 'package:digitalerp/screen/ui/home/add_company/add_company_view.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomerListController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController whatsAppNumberController =
      TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController comissionController = TextEditingController();
  final FocusNode contactPersonFocus = FocusNode();
  final FocusNode whatsAppNumberFocus = FocusNode();
  final FocusNode designationFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode comissionFocus = FocusNode();

  final ScrollController customerScrollController = ScrollController();
  final ScrollController executiveFilterScrollController = ScrollController();
  final FocusNode searchFocus = FocusNode();

  ExecutiveDropdownData? selectedDropdownValue;
  List<ExecutiveDropdownData> executiveList = [];
  List<DesignationData> designationList = [];
  List<CustomerListData> customerList = [];
  List<AddContactsData> addContactsViewList = [];
  DesignationData? selectDesignation;
  String? customerAddress;
  Position? position;
  String? partyName;
  String selectFromDate = AppString.dateTimeEmpty;
  String selectToDate = AppString.dateTimeEmpty;

  String selectDateOfBirth = 'Date of Birth';
  String selectAssociateDate = 'Associate Date';

  void setSelectedDate(String value) {
    selectDateOfBirth = value;
    update();
  }

  void clearSelectedDate() {
    selectDateOfBirth = 'Lead Date';
    update();
  }

  void setSelectedAssociateDate(String value) {
    selectAssociateDate = value;
    update();
  }

  void clearSelectedAssociateDate() {
    selectAssociateDate = 'Associate Date';
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit

    getDropdownList();
    super.onInit();
  }

  List<CustomerListData> searchList = [];

  List<CustomerListData> executiveFilterList = [];

  void setSelectDropdownValue(ExecutiveDropdownData? value) {
    selectedDropdownValue = value;
    update();

    executiveFilterList.clear();
    for (var customerData in customerList) {
      if (customerData.executive!
          .toLowerCase()
          .contains(value?.executiveName?.toLowerCase() ?? '')) {
        executiveFilterList.add(customerData);
        update();
      }
    }
  }

  setSegmentValue(int i) {
    update();
  }

  void onSearchTextChanged(String text) async {
    if (text.isNotEmpty) {
      searchList.clear();
      if ((selectedDropdownValue?.executiveName?.isNotEmpty ?? false) &&
          (executiveList.length > 1)) {
        for (var customerData in executiveFilterList) {
          if (customerData.partyname!
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              customerData.executive!
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              customerData.mobileno!.contains(text)) {
            searchList.add(customerData);
            update();
          }
        }
      } else {
        for (var customerData in customerList) {
          if (customerData.partyname!
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              customerData.executive!
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              customerData.mobileno!.contains(text)) {
            searchList.add(customerData);
            update();
          }
        }
      }
    } else {
      searchList.clear();
      update();
    }
  }

  void getDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveList.addAll(res.data!);
        if (executiveList.length == 1) {
          selectedDropdownValue = executiveList.first;
          update();
          getCustomerList();
        } else {
          getCustomerList();
        }
        //   ShowMessage.showSnackBar('Server Res11111', res.message.toString());
        // }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      //setBusy(false);
    }
  }

  void getCustomerList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] =
          selectedDropdownValue?.executiveId.toString() ?? '0';
      body[RequestKeys.branchId] =
          homeController.currentUserData?.branchId.toString() ?? '';

      var res = await api.getPartyWithBranch(body);
      if (res.status == 200) {
        customerList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('', '${res.message}');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  void onChangedDesignationValue(DesignationData? newValue) {
    selectDesignation = newValue;
    update();
  }

  void getDesignationDropdownList(String partyId) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '369622';
      // body[RequestKeys.userId] = '369622';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      // body[RequestKeys.compId] = '39';
      body[RequestKeys.partyId] = partyId;
      // "partyid": 156795
      var res = await api.getSDesignationDropdown(body);
      if (res.status == 200) {
        designationList = res.data ?? [];
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  void getAddContactsView(String partyId) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      // body[RequestKeys.compId] =  '39';
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '369622';
      // body[RequestKeys.userId] =  '369622';
      body[RequestKeys.partyId] = partyId.toString();
      // body[RequestKeys.partyId] =  "156795" ;
      var res = await api.getAddContactsView(body);
      if (res.status == 200) {
        addContactsViewList = res.data ?? [];
        update();
        ShowMessage.showSnackBar('', '${res.message}');
      } else {
        ShowMessage.showSnackBar('', '${res.message}');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  void getAddContactsDetails(String partyId) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.partyId] = partyId.toString();
      // customerList.first.partyid.toString();
      body[RequestKeys.compId] =
          // '39'.toString();
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] =
          // '48'.toString();
          homeController.currentUserData?.branchId.toString() ?? '48';
      body[RequestKeys.userId] =
          // '369622' .toString();
          homeController.currentUserData?.userid.toString() ?? '369622';
      body[RequestKeys.yearId] =
          // '2023-24'.toString();
          homeController.currentUserData?.yearId.toString() ?? '2023-24';
      body[RequestKeys.contactPerson] =
          contactPersonController.text.tr.toString();
      body[RequestKeys.whatsAppNo] =
          whatsAppNumberController.text.tr.toString();
      body[RequestKeys.designation] =
          selectDesignation!.designnation.toString();
      body[RequestKeys.designationId] =
          selectDesignation!.designnationid.toString();
      body[RequestKeys.emailId] = emailController.text.tr.toString();
      body[RequestKeys.dob] = selectDateOfBirth.toString();
      body[RequestKeys.associateDate] = selectAssociateDate.toString();
      body[RequestKeys.commissionPercent] = comissionController.text.isEmpty
          ? "0"
          : comissionController.text.tr.toString();
      var res = await api.getAddContactsDetails(body);
      if (res.status == 200) {
        addContactsViewList = res.data ?? [];
        update();
        Get.back();
        ShowMessage.showSnackBar('', '${res.message}');
        contactPersonController.clear();
        whatsAppNumberController.clear();
        emailController.clear();
        selectDesignation = null;
        selectDateOfBirth = "Date of Birth";
        selectAssociateDate = "Associate Date";
        comissionController.clear();
        setBusy(false);
      } else {
        //ShowMessage.showSnackBar('', '${res.message}');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  void tapOnMarkLocation(int index) async {
    //if(customerList[index].partyid == homeController.currentUserData?.userid)

    setListLoading(true);
    if (searchController.text.isEmpty) {
      customerList[index].isUpdating = true;
      position = await getUserCurrentPosition();
      customerAddress = await getUserCurrentAddress();
      var updatedLocation = customerList[index];
      updatedLocation.location = customerAddress;
      customerList.removeAt(index);
      customerList.insert(index, updatedLocation);

      updateLocation(
          index, position?.longitude, position?.latitude, customerAddress);
      customerList[index].isUpdating = false;
    } else {
      searchList[index].isUpdating = true;
      position = await getUserCurrentPosition();
      customerAddress = await getUserCurrentAddress();
      var updatedLocation = searchList[index];
      updatedLocation.location = customerAddress;
      searchList.removeAt(index);
      searchList.insert(index, updatedLocation);
      searchList[index].isUpdating = false;

      updateLocation(
          index, position?.longitude, position?.latitude, customerAddress);
    }

    update();
  }

  void tapOnAdd() {
    Get.to(const AddCompanyView());
  }

  void tapOnOrder(int index) async {
    if (searchController.text.isEmpty) {
      String encodedMap = json.encode(customerList[index]);
      await SharedPre.setValue(SharedPre.selectedCustomer, encodedMap);
    } else {
      SharedPre.setValue(SharedPre.selectedCustomer, searchList[index]);
    }
    homeController.onItemTapped(index);
    update();
    //Get.to(const OrderView());
  }

  void tapOnPaymentEntry(int index) async {
    if (searchController.text.isEmpty) {
      partyName = customerList[index].partyname ?? '';
      //String encodedMap = json.encode(customerList[index]);
      // await SharedPre.setValue(SharedPre.selectedCustomer, encodedMap);
    } else {
      partyName = searchList[index].partyname ?? '';
      //SharedPre.setValue(SharedPre.selectedCustomer, searchList[index]);
    }
    Get.to(const PaymentEntryView(isPayment: true, title: 'Payment Entry'));
  }

  void updateLocation(
      int index, double? longitude, double? latitude, String? address) async {
    //setListLoading(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ??
              '342613'; //'424655';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.partyId] = searchController.text.isEmpty
          ? customerList[index].partyid.toString()
          : searchList[index].partyid.toString();
      body[RequestKeys.latitude] = latitude.toString();
      body[RequestKeys.longitude] = longitude.toString();
      body[RequestKeys.location] = address ?? '';
      var res = await api.updateCustomersLocation(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar('', '${res.message}');
      } else {
        ShowMessage.showSnackBar('', '${res.message}');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setListLoading(false);
    }
  }

  void updateRemark(int index, String text) async {
    if (searchController.text.isEmpty) {
      var updatedObj = customerList[index];
      updatedObj.remarks = text;
      customerList.removeAt(index);
      customerList.insert(index, updatedObj);
      callUpdateLocationApi(index, text);
    } else {
      var updatedObj = searchList[index];
      updatedObj.remarks = text;
      searchList.removeAt(index);
      searchList.insert(index, updatedObj);
      callUpdateLocationApi(index, text);
    }
  }

  void callUpdateLocationApi(int index, String text) async {
    Position position = await getUserCurrentPosition();
    String location = await getUserCurrentAddress();
    //setListLoading(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ??
              '342613'; //'424655';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.partyId] = searchController.text.isEmpty
          ? customerList[index].partyid.toString()
          : searchList[index].partyid.toString();
      body[RequestKeys.remarks] = text.isEmpty ? '-----' : text;
      body[RequestKeys.latitude] = position.latitude.toString();
      body[RequestKeys.longitude] = position.longitude.toString();
      body[RequestKeys.location] = location;

      var res = await api.updateCustomersRemarks(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar('', '${res.message}');
      } else {
        ShowMessage.showSnackBar('', '${res.message}');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      //setListLoading(false);
    }
  }
}
