
import 'dart:convert';

import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executetive_list_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/shipMangement/shipping_details_list_response.dart';
import 'package:digitalerp/shipMangement/shipping_status_response.dart';
import 'package:digitalerp/shipMangement/update_shipment_view.dart';
import 'package:digitalerp/shipMangement/update_shipping_value_response.dart';
import 'package:digitalerp/task%20management/taskmanagementcontroller/task_manage_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ShipManagementController extends AppBaseController{
  HomeController homeController =Get.find<HomeController>();


  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController deliveredController = TextEditingController();
  TextEditingController transportNameController = TextEditingController();
  TextEditingController grNoController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController ewaybillNoController = TextEditingController();
  TextEditingController deliveryTypeController = TextEditingController();
  TextEditingController shippingNoteController = TextEditingController();

  final FocusNode shippingAddressFocus = FocusNode();
  final FocusNode deliveredFocus = FocusNode();
  final FocusNode transportNameFocus = FocusNode();
  final FocusNode grNoFocus = FocusNode();
  final FocusNode vehicleNoFocus = FocusNode();
  final FocusNode ewaybillNoFocus = FocusNode();
  final FocusNode deliveryTypeFocus = FocusNode();
  final FocusNode shippingNoteFocus = FocusNode();


  String selectFromDate = AppString.dateTimeEmpty;
  String selectToDate = AppString.dateTimeEmpty;
  final pickers = ImagePicker();
  var selectedImages = ''.obs;
  var selectedImageBase64 = ''.obs;
  var selectedImageFileNames = ''.obs;

  List<ShippingStatusData> shippingStatusData = [];
  ShippingStatusData? selectShippingStatusData;
  List<ShippingDetailsListData> shippingDetailsListData =[];
  List<CustomerListData> partyDropdown = [];
  List<UpdateShippingValueData> updateShippingValueData =[];
  UpdateShippingValueData?  selectUpdateShippingValueData;


  CustomerListData? selectPartyDropdown;
  DateTime? firstDateInDate;
  DateTime? lastDateInDate;


  void setSelectedImages(String value) {
    selectedImages.value = value;
    update();
  }
  void setSelectedFromDate(String value) {
    selectFromDate = value;
    update();
  }
  void setSelectedToDate(String value) {
    selectToDate = value;
    update();
  }

  String firstDate =  DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day -15,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());

  @override
  void onInit() {
    getShippingDetailsListApi();

    super.onInit();
  }

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


  void setSelectPartyDropdownValue( value) {
    selectPartyDropdown = value;
    update();
  }
  void setSelectShippingStatusDropdown(value) {
    selectShippingStatusData = value;
    update();
  }





  bool _isfollowupValidate(){
    if(shippingAddressController.text.trim().isEmpty){
    ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterShippingAddress);
    return false;
    }
    if(deliveredController.text.trim().isEmpty){
    ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterDelivered);
    return false;
    }
    if(transportNameController.text.trim().isEmpty){
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterGRNo);
      return false;
    }
    if(vehicleNoController.text.trim().isEmpty){
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterVehicleNo);
      return false;
    }
    if(ewaybillNoController.text.trim().isEmpty){
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterEwayBillNo);
      return false;
    }
    if(deliveryTypeController.text.trim().isEmpty){
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterDeliveryType);
      return false;
    }
    if(shippingNoteController.text.trim().isEmpty){
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterShippingNote);
      return false;
    }
    if(selectedImages.isEmpty){
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseSelectFile);
      return false;
    }
    return true;
  }
  bool _filterValidate(){

    if(selectPartyDropdown!.partyname!.isEmpty){
      ShowMessage.showSnackBar(AppString.requiredFieldTxt, AppString.pleaseEnterShippingAddress);
      return false;
    }

    return true;

  }


  void getPartyDropdown() async {
    setBusy(true);
    try {
      Map<String, String> body = {
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
      };
      // body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
      // body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '369622';

      var res = await api.getCustomersDetail(body);
      if (res.status == 200) {
        partyDropdown = res.data ?? [];
      }
      // else {
      //   ShowMessage.showSnackBar(
      //       'getExecutiveDropdown Server res.status not 200', res.message.toString());
      // }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getShippingDetailsListApi() async {

    setBusy(true);
    try{
      Map<String,String > body= {};
      body[RequestKeys.compId] =
      // '71';
          homeController.currentUserData?.compId.toString()??'';
      body[RequestKeys.branchId] =
      // '130';
          homeController.currentUserData?.branchId.toString()??'';
      body[RequestKeys.userId] =
      // '447665';
          homeController.currentUserData?.userid .toString()??'';
     body[RequestKeys.fromDate] =
      DateFormat('yyyy-MM-dd').format(
     DateFormat('dd-MM-yyyy').parse(firstDate),);
     // '2023-01-01';

      body[RequestKeys.toDate] =
      // '2024-01-15';
         DateFormat('yyyy-MM-dd').format(
        DateFormat('dd-MM-yyyy').parse(lastDate),);
     body[RequestKeys.partyId] =
     // '0';
         selectPartyDropdown?.partyid.toString()??'0';
     body[RequestKeys.statusId] =
     // '0';
         selectShippingStatusData?.statusid.toString()??'0';

      var res = await api.getShippingDetailsListResponse(body);
      if(res.status ==200){
        shippingDetailsListData = res.data ??[];
      }else{
        // ShowMessage.showSnackBar('shippingDetailsListJson not res.200', res.message.toString());
      }
    }catch(e){
      ShowMessage.showSnackBar("shippingDetailsListJson catch", e.toString());
    }
    finally{
      setBusy(false);
    }
  }

  Future<void> getShippingStatusApi() async{

    setBusy(true);
    try{
      Map<String,String> body = {};
      body[RequestKeys.compId]=
      // '39';
          homeController.currentUserData?.compId.toString()??'';
      var res = await api.getShippingStatusDetails(body);
      if(res.status == 200){
        shippingStatusData= res.data??[];
        // ShowMessage.showSnackBar('shipping status json Success res.', res.message.toString());
      }
      else{
        ShowMessage.showSnackBar('shipping status Json not 200 res.', res.message.toString());
      }
    }catch(e){
      ShowMessage.showSnackBar('shipping status catch', '$e');
    } finally{
      setBusy(false);
    }
  }

  void getUpdateShipmentApi(String id) async {
    unfocus();
    setBusy(true);
    if (_isfollowupValidate()) {
      try {
        Map<String, String> body = {};
        body[RequestKeys.id] = id.toString();
        body[RequestKeys.compId] =
        // '71';
            homeController.currentUserData?.compId.toString() ?? '';
        body[RequestKeys.branchId] =
        // '130';
            homeController.currentUserData?.branchId.toString() ?? '';
        body[RequestKeys.userId] =
        // '447665';
            homeController.currentUserData?.userid.toString()?? '';
        body[RequestKeys.yearId] =
        // '2023-24';
            homeController.currentUserData?.yearId.toString()??'';
         body[RequestKeys.shippingAddress] = shippingAddressController.text.tr.toString();
         body[RequestKeys.shippingStatusid] = selectShippingStatusData?.statusname.toString()??'';
         body[RequestKeys.shippingStatus] = 'Delivered';
         body[RequestKeys.deliveredTo] = deliveredController.text.tr.toString();
         body[RequestKeys.transportName] = transportNameController.text.tr.toString();
         body[RequestKeys.grNo] = grNoController.text.tr.toString();
         body[RequestKeys.vehicleNo] = vehicleNoController.text.tr.toString();
         body[RequestKeys.ewaybillNo] = ewaybillNoController.text.tr.toString();
         body[RequestKeys.deliveryType] = deliveryTypeController.text.tr.toString();
         body[RequestKeys.ShippingNote] = shippingNoteController.text.tr.toString();
         body[RequestKeys.shippingDocument] = selectedImageBase64.toString();
         body[RequestKeys.filename] = selectedImageFileNames.value;
        var res = await api.getShippingUpdateDetails(body);
        if (res.status == 200) {
            shippingStatusData = res.data ?? [];
          backTap();
          ShowMessage.showSnackBar('updateShipment Success Res', res.message.toString());
        } else {
          // ShowMessage.showSnackBar('updateShipmentJson res.status not 200', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('updateShipmentJson catch', '$e');
      } finally {
        setBusy(false);
      }
    }
  }


  void getUpdateShipmentValueApi(String id) async {
    unfocus();
    setBusy(true);
      try {
        Map<String, String> body = {};
        body[RequestKeys.compId] =
        // "71";
            homeController.currentUserData?.compId.toString()??'71';
        body[RequestKeys.id] =
        // "545";
            id.toString();

        var res = await api.getUpdateShippingValueResponse(body);
        if (res.status == 200) {
          updateShippingValueData = res.data ?? [];

          // ShowMessage.showSnackBar('updateShipmentValueJson Success Res', res.message.toString());
        } else {
          // ShowMessage.showSnackBar('  updateShipmentValue res.status not 200', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('updateShipmentValueJson catch', '$e');
      } finally {
        setBusy(false);
      }
  }

}