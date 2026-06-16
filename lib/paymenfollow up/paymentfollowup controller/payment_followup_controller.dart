import 'package:digitalerp/paymenfollow%20up/payment_followup_response/payment_followup_details_response.dart';
import 'package:digitalerp/paymenfollow%20up/payment_followup_response/payment_followup_list_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentFollowupController extends AppBaseController{
  HomeController homeController = Get.find<HomeController>();

  TextEditingController followupRemarkController = TextEditingController();
  final FocusNode followupRemarkFocusNode = FocusNode();


  List<PaymentFollowupListData> paymentFollowupListData = [];
  List<PaymentFollowupDetailsData> paymentFollowupDetailsData =[];
  List<CustomerListData> partyList = [];
  CustomerListData? selectParty ;
  String followupDate  = AppString.ddMMyyyy;
  String nextFollowupDate = AppString.ddMMyyyy ;


  void selectPartyValue( value) {
    selectParty = value;
    update();
  }

  void selectFollowupDate(String value){
    followupDate = value;
    update();
  }

  void selectNextFollowupDate(String value){
    nextFollowupDate = value;
    update();
  }


  @override
  void onInit() {
    getPaymentFollowupListApi();
    getPartyDropdownList();
    super.onInit();
  }


  Future<void> getPaymentFollowupListApi() async {
    setBusy(true);
    try{
      Map<String , String> body={};
      body[RequestKeys.compId] =
      // '68';
          homeController.currentUserData?.compId.toString()?? '';
      body[RequestKeys.branchId] =
      // '121';
          homeController.currentUserData?.branchId.toString()?? '';
      body[RequestKeys.userId] =
      // '462675';
          homeController.currentUserData?.userid.toString()?? '';
      body[RequestKeys.partyId] = selectParty?.partyid.toString()?? '0';

      var res = await api.getPaymentFollowupListResponse(body);
      if(res.status ==200){
        paymentFollowupListData = res.data ??[];
      }
      else{
        ShowMessage.showSnackBar('Payment FollowupList res.status not 200', res.message.toString());

      }

    }catch(e){
      ShowMessage.showSnackBar('Payment FollowupList res. catch', e.toString());
    }
    finally{setBusy(false);
    }
  }
  Future<void> getPaymentFollowupDetailsApi(String followupId) async {
    setBusy(true);
    try{
      Map<String , String> body={};
      body[RequestKeys.compId] =
      // '68';
      homeController.currentUserData?.compId.toString()?? '';
      body[RequestKeys.branchId] =
      // '121';
          homeController.currentUserData?.branchId.toString()??'';
      body[RequestKeys.userId] =
      // '462675';
      homeController.currentUserData?.userid.toString()?? '';
      body[RequestKeys.followupId] = followupId.toString();
      // followupId.toString();

      var res = await api.getPaymentFollowupDetailsResponse(body);
      if(res.status ==200){
        paymentFollowupDetailsData = res.data ??[];
      }
      else{
        ShowMessage.showSnackBar('payment FollowupDetails res.status not 200', res.message.toString());

      }

    }catch(e){
      ShowMessage.showSnackBar('payment FollowupDetails res. catch', e.toString());
    }
    finally{setBusy(false);
    }
  }
  Future<void> getPaymentFollowupSaveApi (String followupId) async {
    setBusy(true);
    try{
      Map<String , String> body={};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString()?? '';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString()?? '';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString()?? '';
      body[RequestKeys.yearId] = homeController.currentUserData?.yearId.toString()??'';
      // body[RequestKeys.yearId] = homeController.currentUserData?.yearId.toString()??'';
      body[RequestKeys.followupId] =followupId.toString();
      body[RequestKeys.followupRemarks] = followupRemarkController.text.tr.toString();
      body[RequestKeys.fromDate] = followupDate.toString();
      body[RequestKeys.nextFollowupDate] = nextFollowupDate.toString();
      body[RequestKeys.followupType] = 'payment';

      var res = await api.getPaymentFollowupSaveResponse(body);
      if(res.status ==200){
        res.data ??[];
      }
      else{
        ShowMessage.showSnackBar('OrderFollowupDetails res.status not 200', res.message.toString());

      }

    }catch(e){
      ShowMessage.showSnackBar('OrderFollowupDetails res. catch', e.toString());
    }
    finally{setBusy(false);
    }
  }

  void getPartyDropdownList() async {
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
        partyList = res.data ?? [];
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





}