

import 'package:digitalerp/performace_management/perfomace_list_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class PerformanceController extends AppBaseController{
  HomeController homeController = Get.find<HomeController>();

  List<PerformanceData> performanceData =[];
  List<ExecutiveDropdownData> executiveList = [];
  ExecutiveDropdownData? selectExecutive ;
  DateTime? firstDateInDate;
  DateTime? lastDateInDate;

  @override
  void onInit() {
    getPerformanceList();
    getExecutiveDropdownList();
    super.onInit();
  }

  String firstDate =  DateFormat(AppString.ddMMyyyy).format(
      DateTime(DateTime.now().year, DateTime.now().month, 1));
  String lastDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());

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


  void selectExecutiveValue(ExecutiveDropdownData value) {
    selectExecutive = value;
    update();
  }


  void getExecutiveDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
      };
      // body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
      // body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '369622';

      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveList= res.data ?? [];
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


void getPerformanceList() async {

  setBusy(true);
  try{
    Map<String, String>body ={};
    body[RequestKeys.compId] =
    // '68';
        homeController.currentUserData?.compId.toString()??'';
    body[RequestKeys.branchId] =
    // "121";
        homeController.currentUserData?.branchId.toString()??'';
    body[RequestKeys.userId] =
    // "462675";
        homeController.currentUserData?.userid.toString()??'';
    body[RequestKeys.fromDate] =
    // "2023-12-01";
        DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(firstDate));
    body[RequestKeys.toDate] =
    // "2023-12-31";
        DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(lastDate));

    body[RequestKeys.executiveId] =
    // "151640";
        selectExecutive?.executiveId.toString()??'';
    var res = await api.getPerformanceResponse(body);
    if(res.status==200){
      performanceData = res.data ??[];
    }
    else{
      ShowMessage.showSnackBar('Performance List res.status not 200', res.message.toString());
    }
  }catch(e){
    ShowMessage.showSnackBar('Performance List catch', '$e');
  }
  finally{
    setBusy(false);
  }
}

}