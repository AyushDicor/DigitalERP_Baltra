import 'package:digitalerp/response/get_account_register_ledger_resp.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class PrintReportController extends AppBaseController {
  String selectFromDate = AppString.dateTimeEmpty;
  String selectToDate = AppString.dateTimeEmpty;
  List<GetAccountRegisterLedgerData> executiveList = [];
  GetAccountRegisterLedgerData? selectedExecutive;
  String? selectedLegerType;
  List<String> legerTypeList = ['Both','Debit',"Credit"];
  late final String reportType, title;
  final HomeController homeController = Get.find<HomeController>();

  PrintReportController(this.reportType);

  void seLegerTypeValue(String? value) {
    selectedLegerType = value;
    update();
  }
  void setSelectedExecutiveValue(GetAccountRegisterLedgerData? value) {
    selectedExecutive = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // reportType = Get.arguments ?? '';
    if (reportType == ReportType.accountRegister) {
      getExecutiveList();
      title = "Account Register";
    } else if (reportType == ReportType.dayBook) {
      title = "Day Book";
    } else if (reportType == ReportType.balanceSheet) {
      title = "Balance Sheet";
    } else if (reportType == ReportType.profitAndLoss) {
      title = "Profit And Loss";
    } else if (reportType == ReportType.trialBalance) {
      title = "Trial Balance";
    } else if (reportType == ReportType.dayBook) {
      title = "Day Book";
    } else {
      title = "Undef";
    }
    update();
    super.onInit();
  }

  void getExecutiveList() async {
    selectedExecutive = null;
    Map<String, String> body = {
      RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
      RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '39',
      RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
      RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '39',
      RequestKeys.reportType: reportType,
      // RequestKeys.transId: selectedTransactionValue?.transid.toString()??"",
    };
    var res = await api.getAccountRegisterLedger(body);
    if (res.status == 200) {
      executiveList = res.data ?? [];
      update();
    } else {
      ShowMessage.showSnackBar('partyLedgerPDF Server res.status not 200', res.message.toString());
    }
  }

  void setSelectedFromDate(String value) {
    selectFromDate = value;
    update();
  }

  void setSelectedToDate(String value) {
    selectToDate = value;
    update();
  }

  Future<void> onShare() async {
    if (selectFromDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select FromDate');
      return;
    } else if (selectToDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar('Please check', 'Please select ToDate');
      return;
    }
    setBusy(true);
    try {
      String fromDate = formatDate(selectFromDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
      String toDate = formatDate(selectToDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.yearId: homeController.currentUserData?.yearId.toString() ?? '39',
        if (reportType == ReportType.accountRegister)
          "ledgerid": selectedExecutive?.ledgerid.toString() ?? "",
        if (reportType == ReportType.accountRegister)
          "ledgertype": selectedLegerType?.toLowerCase()??'0'
        else
          RequestKeys.reportType: reportType,
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate,
        // RequestKeys.transId: selectedTransactionValue?.transid.toString()??"",
      };
      var res = reportType == ReportType.accountRegister
          ? await api.printAccountRegisterMisReport(body)
          : await api.printAccountMisReport(body);
      if (res.status == 200) {
        /// new way
        await downloadAndSharePdfFile(
          downloadUrl: res.data?.first.url ?? '',
          pdfFileName: 'ReportFile${DateTime.now().millisecond}',
        );
        setBusy(false);

        /// old way
        /*
        launchInBrowser(Uri.parse(res.data?.first.url ?? ''));
         */
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
    setBusy(false);
  }
}
