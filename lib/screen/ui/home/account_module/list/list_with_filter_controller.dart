import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/collection_list_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListWithFilterController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  List<CustomerListData> customerDataList = [];
  List<CollectionData> list = [];

  String? customer;
  CustomerListData? customerdecodedList;
  CustomerListData? selectedDropdownValue;
  String? voucherType;
  String customerName = '';

  @override
  void onInit() async {
    // TODO: implement onInit
    /*if(customerListController.partyName?.isNotEmpty ?? false) {
      dropdownList.add(customerListController.partyName ?? '');

      selectedDropdownValue = customerListController.partyName.toString();
    }*/
    voucherType = Get.arguments;
    setBusy(true);
    // if (voucherType == VoucherType.payment) {
    //   Get.toNamed(AppRoutes.paymentEntry)?.then((value) => getList());
    // } else if (voucherType == VoucherType.receipt) {
    //   Get.toNamed(AppRoutes.receiptEntry)?.then((value) => getList());
    // } else if (voucherType == VoucherType.collection) {
    //   Get.toNamed(AppRoutes.collection)?.then((value) => getList());
    // } else
    if (voucherType == VoucherType.expense) {
      await getExecutiveHeadList();
    } else if (voucherType == VoucherType.payment) {
      await getCollectionList();
    }else if (voucherType == VoucherType.receipt) {
      await getCollectionList();
    }else if (voucherType == VoucherType.collection) {
      await getCollectionList();
    } else if (voucherType == VoucherType.contra) {
      await getAccountList();
    } else if (voucherType == VoucherType.journal) {
      await getJournalList();
    } else {
      await getCustomerList();
    }
    await getList();
    setBusy(false);
    super.onInit();
  }

  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  void tapOnCard() {
    Get.toNamed(AppRoutes.visitPlanDetail);
  }

  void setSelectedDate(String value) {
    selectedDate = value;
    update();
  }

  void onTabAdd() {
    if (voucherType == VoucherType.payment) {
      Get.toNamed(AppRoutes.paymentEntry)?.then((value) => getList());
    } else if (voucherType == VoucherType.receipt) {
      Get.toNamed(AppRoutes.receiptEntry)?.then((value) => getList());
    } else if (voucherType == VoucherType.collection) {
      Get.toNamed(AppRoutes.collection)?.then((value) => getList());
    } else if (voucherType == VoucherType.expense) {
      Get.toNamed(AppRoutes.expense)?.then((value) => getList());
    } else if (voucherType == VoucherType.contra) {
      Get.toNamed(AppRoutes.contra)?.then((value) => getList());
    } else if (voucherType == VoucherType.journal) {
      Get.toNamed(AppRoutes.journalEntry)?.then((value) => getList());
    }
    // Get.toNamed(AppRoutes.accountModule, arguments: true);
  }

  void setDropdownValue(CustomerListData? newValue) {
    selectedDropdownValue = newValue;
    getList();
    update();
  }

  String getDropDownHint() {
    if (voucherType == VoucherType.expense) {
      return 'Select Executive Head';
    } else if (voucherType == VoucherType.contra) {
      return 'Select Account';
    }else if (voucherType == VoucherType.journal) {
      return 'Select Account';
    } else {
      return 'Select Customer';
    }
  }
  Future<void> getCollectionList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.voucherType: voucherType.toString(),
        // RequestKeys.voucherType: VoucherType.collection,
      };
      var res = await api.collectionCustomerList(body);
      if (res.status == 200) {
        customerDataList = CustomerDetailResponse.fromJson(res.toJson()).data ?? [];
        for (var element in customerDataList) {
          if (element.partyid.toString() == Get.arguments) {
            customerName = element.partyname ?? '';
            selectedDropdownValue = element;
          } else {
            continue;
          }
        }
      } else {
        ShowMessage.showSnackBar('collectionCustomerList Server res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('collectionCustomerList Server catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }
  Future<void> getJournalList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: false ? '39' : homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: false ? '100' : homeController.currentUserData?.branchId.toString() ?? '342613',
        RequestKeys.userId: false ? '371624' : homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.voucherType: VoucherType.journal,
      };
      var res = await api.debitCreditAccountList(body);
      if (res.status == 200) {
        customerDataList = CustomerDetailResponse.fromJson(res.toJson()).data ?? [];
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getAccountList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.voucherType: voucherType.toString(),
      };
      var res = await api.contraDropdownList(body);
      if (res.status == 200) {
        // fromAccountList = res.data ?? [];
        customerDataList = CustomerDetailResponse.fromJson(res.toJson()).data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getCustomerList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = homeController.currentUserData?.accountCode.toString() ?? '';
      var res = await api.getCustomersDetail(body);
      if (res.status == 200) {
        customerDataList = res.data ?? [];
        for (var element in customerDataList) {
          if (element.partyid.toString() == Get.arguments) {
            customerName = element.partyname ?? '';
            selectedDropdownValue = element;
          } else {
            continue;
          }
        }
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getExecutiveHeadList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        // RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '342613',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
      };
      var res = await api.expensesHeadList(body);
      if (res.status == 200) {
        customerDataList = CustomerDetailResponse.fromJson(res.toJson()).data ?? [];
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getList({
    String? fromDate,
    String? toDate,
  }) async {
    try {
      var res = await api.listWithFilter(
        voucherType: voucherType ?? '',
        compId: homeController.currentUserData?.compId.toString() ?? '39',
        branchId: homeController.currentUserData?.branchId.toString() ?? '100',
        userId: homeController.currentUserData?.userid.toString() ?? '371624',
        fromDate: fromDate ?? getStartDateOfMonth(DateTime.now()),
        toDate: toDate ??
            formatDate(DateTime.now().toString(), AppString.dateTimeFormat, AppString.yyyyMMdd),
        partyId: selectedDropdownValue?.partyid.toString() ?? '0',
      );
      list.clear();
      if (res.status == 200) {
        list = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }
}
