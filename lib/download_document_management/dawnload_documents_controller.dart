import 'package:digitalerp/download_document_management/download_document_type_.dart';
import 'package:digitalerp/download_document_management/download_document-list_responce.dart';
import 'package:digitalerp/download_document_management/download_document_print_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DownloadDocumentController extends AppBaseController{
  HomeController homeController = Get.find<HomeController>();
  String selectDate = AppString.dateTimeEmpty;

  List<DownloadDocumentData> downloadDocumentData =[];
  DownloadDocumentData? selectDocument;
  List<DownloadDocumentListData> downloadDocumentListData = [];
  List<DownloadPrintData> downloadPrintData =[];
  List<CustomerListData> partyListData = [];
  CustomerListData? selectPartyList;
  DateTime? firstDateInDownloadDate;
  DateTime? lastDateInDownloadDate;


  @override
  void onInit() {
    getDownloadDocumentDropDownApi();
    getExecutiveDropdownList();
    super.onInit();
  }

  String firstDownloadDate =  DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day-15,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDownloadDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());


  void setDownloadDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDownloadDate = value;
    } else {
      lastDownloadDate = value;
    }
    update();
  }

  void setDateByDownloadDate(DateTime value, bool isFirstDate) {
    if (isFirstDate) {
      firstDateInDownloadDate = value;
    } else {
      lastDateInDownloadDate = value;
    }
    update();
  }


  void setSelectDocumentTypeDropdown(DownloadDocumentData? value) {
    selectDocument = value;
    update();
  }

  void setSelectedDate(String value) {
    selectDate = value;
    update();
  }
  void setSelectedPartyDropDown(CustomerListData value){
    selectPartyList = value;
    update();
  }


  Future<void> getDownloadDocumentDropDownApi() async {
    setBusy(true);
    try{
      Map<String , String> body= {};
      body[RequestKeys.compId] =
      // '39';
          homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getDownloadDocuments(body);
      downloadDocumentData = res.data ?? [];
      if(res.status ==200){
        // ShowMessage.showSnackBar('Download Document Name List Success ', res.message.toString());
      }
      else{
        ShowMessage.showSnackBar('Download Document Name List res.status not 200 ', res.message.toString());
      }
    }catch(e){
      ShowMessage.showSnackBar('Download Document Name List catch ', '$e');
    } finally{
      setBusy(false);
    }


  }

  Future<void> getDownloadDocumentListApi() async {
    setBusy(true);
    try{
      Map<String , String> body= {};
      body[RequestKeys.compId] =  homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.branchId]=  homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.userId] =  homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.fromDate] = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(firstDownloadDate),);
      body[RequestKeys.toDate] = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(lastDownloadDate),);
      body[RequestKeys.documentname] = selectDocument?.documentname.toString()??'';
      body[RequestKeys.partyId] = selectPartyList?.partyid.toString()??'';
      var res = await api.getDownloadDocumentsList(body);
      downloadDocumentListData = res.data ?? [];
      if(res.status ==200){
        // ShowMessage.showSnackBar('Download Document Name List Success ', res.message.toString());
      }
      else{
        ShowMessage.showSnackBar('Download Document List res.status not 200 ', res.message.toString());
      }
    }catch(e){
      ShowMessage.showSnackBar('Download Document List catch ', '$e');
    } finally{
      setBusy(false);
    }


  }

  Future<String> getDownloadDocumentPrintApi(String documentId) async {
    setBusy(true);
    try{
      Map<String , String> body= {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString()??'';
      body[RequestKeys.branchId] =  homeController.currentUserData?.branchId.toString()?? '';
      body[RequestKeys.userId] =  homeController.currentUserData?.userid.toString()??'';
      body[RequestKeys.yearId] =  homeController.currentUserData?.yearId.toString() ??'';
      body[RequestKeys.flag] = downloadDocumentListData.first.flag ?? '' ;
      body[RequestKeys.documenId] = documentId;
      var res = await api.getDownloadDocumentsPrint(body);

      if(res.status ==200){
        downloadPrintData = res.data ?? [];
        return res.data?.first.url??'';
      }
      return  ShowMessage.showSnackBar('Download Document Print res.status not 200 ', res.message.toString());;
    }catch(e){

      return  ShowMessage.showSnackBar('Download Document Print catch ', '$e');;
    } finally{
      setBusy(false);
    }


  }

  void getExecutiveDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {
          RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '39',
          RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '48',
          RequestKeys.branchId:homeController.currentUserData?.branchId.toString()??"",
      };
      // body[RequestKeys.userId] = '369622';
      // body[RequestKeys.compId] =  '39';

      var res = await api.getPartyWithBranch(body);
      if (res.status == 200) {
        partyListData = res.data ?? [];
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