// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_document/approval_document_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_model.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/client_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/documentname_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/item_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/vendor_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_list/approvals_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/services/api_service/request_keys.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class ApprovalListController extends AppBaseController {
//   HomeController homeController = Get.find<HomeController>();
//
//   List<ApprovalListData> approvalListData = [];
//   ApprovalDocument approvalDocument = ApprovalDocument();
//   CardConfig? cardConfig;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Load with broader default — no document filter, no status filter
//     getApprovalList(
//       ApprovalFilterModels(
//         status: StatusListData(statusid: 0, statusname: "Pending"),
//         client: ClientListData(clientid: 0, clientname: '0'),
//         vendor: VendorListData(vendorid: 0, vendorname: '0'),
//         item: ItemListData(itemid: 0, itemname: '0'),
//         documentName: DocumentData(documentname: 'PurchaseOrder'), // revert to what was working before
//       ),
//     );
//   }
//
//   Future<void> getApprovalList(ApprovalFilterModels model) async {
//     approvalListData.clear();   // ← clears stale data
//     isBusy = true;              // ← shows loader
//     update();                   // ← triggers rebuild immediately
//
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.userId] =
//           homeController.currentUserData?.userid.toString() ?? '';
//       body[RequestKeys.compId] =
//           homeController.currentUserData?.compId.toString() ?? '';
//       body[RequestKeys.branchId] =
//           homeController.currentUserData?.branchId.toString() ?? '';
//       body[RequestKeys.documentname] =
//           model.documentName?.documentname ?? 'PurchaseOrder';
//       body[RequestKeys.clientid] = model.client?.clientid.toString() ?? '0';
//       body[RequestKeys.status] =
//           model.status?.statusname.toString() ?? 'Pending';
//       body[RequestKeys.vendorid] = model.vendor?.vendorid.toString() ?? '0';
//       body[RequestKeys.itemId] = model.item?.itemid.toString() ?? '0';
//       body[RequestKeys.fromDate] = model.startDate == null
//           ? DateFormat('yyyy-MM-dd').format(DateTime(
//           DateTime.now().year,
//           DateTime.now().month - 1,
//           DateTime.now().day))
//           : DateFormat('yyyy-MM-dd').format(model.startDate!);
//       body[RequestKeys.toDate] = model.endDate == null
//           ? DateFormat('yyyy-MM-dd').format(DateTime.now())
//           : DateFormat('yyyy-MM-dd').format(model.endDate!);
//
//       // DEBUG — remove after fixing
//       print('APPROVAL REQ => $body');
//
//       var res = await api.getApprovalListData(body);
//
//       // DEBUG — remove after fixing
//       print('APPROVAL RES status => ${res.status}');
//       print('APPROVAL RES data count => ${res.data?.length}');
//       print('APPROVAL RES message => ${res.message}');
//
//       if (res.status == 200) {
//         approvalListData = res.data ?? [];
//       }
//       if (res.cardConfig != null) {
//         cardConfig = CardConfig.fromJson(res.cardConfig!);
//       }
//     } catch (e) {
//       print('getApprovalList catch => $e');
//       ShowMessage.showSnackBar('getApprovalList catch', '$e');
//     } finally {
//       isBusy = false;
//       update();
//     }
//   }
// }
