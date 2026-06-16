import 'dart:convert';
import 'dart:developer';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/response/outstanding_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class OutstandingController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  String? selectedDropdown1Value;
  String? selectedDropdown2Value;
  String? selectedDropdown3Value;

  List<CustomerData> partyList = [];
  CustomerData? selectedPartyValue;
  OutstandingData? partyOutstandingData;
  String selectFromDate = AppString.dateTimeEmpty;
  String selectToDate = AppString.dateTimeEmpty;

  String currentUserType = '';
  String currentUserName = '';
  CustomerData? selectedDropdown;

  void setSelectedPartyValue(CustomerData? value) {
    selectedPartyValue = value;
    getPartyOutStanding();
  }

  @override
  Future<void> onInit() async {
    getPartyList();

    super.onInit();
  }

  void partyInit() {
    currentUserType = homeController.currentUserData?.usertype.toString() ?? '';
    currentUserName = homeController.currentUserData!.name ?? '';
    print('User Type => ${currentUserType} currentUserName=>$currentUserName');
    print("Name =>  ${homeController.currentUserData!.name}");
    selectedDropdown = partyList.firstWhere(
      (element) =>
          element.partyid == homeController.currentUserData!.accountCode,
      orElse: () => CustomerData(),
    );
    log('controller.partyList:==>${jsonEncode(partyList.map((e) => e.toJson()).toList())}');
    if (selectedDropdown?.partyid == null) {
      selectedDropdown = null;
    }
    if (currentUserType.toLowerCase() == 'customer' &&
        selectedDropdown != null) {
      setSelectedPartyValue(selectedDropdown);
    }
  }

  Future<void> getPartyList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: false
            ? '39'
            : homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: false
            ? '100'
            : homeController.currentUserData?.branchId.toString() ?? '342613',
        RequestKeys.userId: false
            ? '371624'
            : homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.voucherType: VoucherType.none //.collection,
      };
      var res = await api.collectionCustomerList(body);
      if (res.status == 200) {
        partyList = res.data ?? [];
        partyInit();

        // selectedPartyValue = partyList
        //     .firstWhere((party) =>
        // party.partyid == homeController.currentUserData?.accountCode
        // );

        // if (selectedPartyValue != null) {
        //   getPartyOutStanding();
        // }
      } else {
        // ShowMessage.showSnackBar('collectionCustomerList Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getPartyOutStanding() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.partyId: selectedPartyValue?.partyid.toString() ?? '',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '',
      };
      var res = await api.getPartyOutstanding(body);
      if (res.status == 200) {
        partyOutstandingData = res.data?.first;
      } else {
        // ShowMessage.showSnackBar('collectionCustomerList Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  List dropdown2List = ['Credit Limit 1', 'Credit Limit 2', 'Credit limit 3'];
  List dropdown3List = [
    'Executive name 1',
    'Executive name 2',
    'Executive name 3'
  ];

  void tapOnCard() {
    Get.toNamed(AppRoutes.visitPlanDetail);
  }

  void setDropdown1Value(String value) {
    selectedDropdown1Value = value;
    update();
  }

  void setDropdown2Value(String value) {
    selectedDropdown2Value = value;
    update();
  }

  void setDropdown3Value(String value) {
    selectedDropdown3Value = value;
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

  void getPartyLedger() {
    if (selectFromDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select FromDate');
    } else if (selectToDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select ToDate');
    } else {
      getPartyLedgerAPI();
    }
  }

  Future<void> getPartyLedgerAPI() async {
    try {
      String fromDate = formatDate(selectFromDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
      String toDate = formatDate(selectToDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
      Map<String, String> body = {
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.yearId:
            homeController.currentUserData?.yearId.toString() ?? '39',
        RequestKeys.partyId: selectedPartyValue?.partyid.toString() ?? '`',
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate,
      };
      var res = await api.partyLedgerPDF(body);
      print('Dio Response: ${res.toString()}');

      if (res.status == 200) {
        print('PDF URL: ${res.data?.first.url}');

        /// new way
        downloadAndSharePdfFile(
          downloadUrl: res.data?.first.url ?? '',
          pdfFileName: 'outstandingFile${DateTime.now().millisecond}',
        );
        // print("URl=> ${DateTime.now().millisecond}");

        /// old way

        // launchInBrowser(Uri.parse(res.data?.first.url ?? ''));
      } else {
        ShowMessage.showSnackBar(
            'partyLedgerPDF Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('partyLedgerPDF catch Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  void tapOnSubmit() {
    Get.back();
  }
}
