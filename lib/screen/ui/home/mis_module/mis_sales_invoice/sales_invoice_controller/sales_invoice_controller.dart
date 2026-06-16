
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/party_dropdown_list_response.dart';
import 'package:digitalerp/response/sales_invoice_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/api.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesInvoiceController extends AppBaseController{
  HomeController homeController = Get.find<HomeController>();


  @override
  void onInit() {
    getSalesInvoiceList();
    getPartyDropdownList();
    getExecutiveDropdownList();
    super.onInit();
  }


  void onChangePartyValue(value){
    selectedPartyDropdownValue =value;
    update();
  }
  void onChangeExecutiveValue(value){
    selectedExecutiveDropdownValue =value;
    update();
  }

  String firstDate =  DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day-15,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());


  DateTime? firstDateInDate;
  DateTime? lastDateInDate;
  List<SalesInvoiceData>? salesInvoiceData = [];
  List<ExecutiveDropdownData> executiveList = [];
  List<PartyDropdownData> buyerList = [];

  PartyDropdownData? selectedPartyDropdownValue;
  ExecutiveDropdownData? selectedExecutiveDropdownValue;

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

  Future<void> getSalesInvoiceList() async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.fromDate] =  DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(firstDate),);
      body[RequestKeys.toDate] = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(lastDate),);
      body[RequestKeys.partyId] = selectedPartyDropdownValue?.partyid.toString()??"0";
      body[RequestKeys.executiveId] = selectedExecutiveDropdownValue?.executiveId.toString()??homeController.currentUserData?.accountCode.toString()??"0";
      var res = await Api().salesInvoiceList(body);
      if (res.status == 200) {
        salesInvoiceData= res.data??[];
      } else {
       salesInvoiceData= res.data??[];
        ShowMessage.showSnackBar(
            'SalesInvoiceList Server res.status not 200',
            res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    }finally{
setBusy(false);

    }
  }
  void getExecutiveDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveList = res.data??[];

        final currentUserExecutive = executiveList.firstWhere(
              (exec) => exec.executiveName == homeController.name,
          orElse: () => ExecutiveDropdownData(),
        );

        if (currentUserExecutive != null) {
          selectedExecutiveDropdownValue = currentUserExecutive;
        } else if (executiveList.isNotEmpty) {
          selectedExecutiveDropdownValue = executiveList.first;
        }

        // if (executiveList.length > 1) {
        //   isManager = true;
        // }
        // else {
        //   selectedExecutiveDropdownValue = executiveList.first;
        // }
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
  Future<void> getPartyDropdownList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = homeController.currentUserData?.accountCode.toString() ?? '';
      var res = await api.getPartyDropdownList(body);
      if (res.status == 200) {
        buyerList = res.data??[];
        update();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {}
  }


}