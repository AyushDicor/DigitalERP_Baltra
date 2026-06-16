// // import 'package:digitalerp/Menu_new_list_responce.dart';
// // import 'package:digitalerp/download_document_management/download_documents_view.dart';
// // import 'package:digitalerp/menu_default_controller.dart';
// // import 'package:digitalerp/orderfollowup/order_followup_view.dart';
// // import 'package:digitalerp/paymenfollow%20up/payment_followup_view.dart';
// // import 'package:digitalerp/salary_sleep/salary_sleep.dart';
// // import 'package:digitalerp/screen/base/base_controller.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/collection/collection_view.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/contra/contra_view.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/expenses/expsenes_view.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/journal_entry/journal_entry_view.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/outstanding/outstanding_view.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/party_ledger/party_transactions_view.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/payment_entry/payment_entry_view.dart';
// // import 'package:digitalerp/screen/ui/home/account_module/receipt_entry/receipt_entry_view.dart';
// // import 'package:digitalerp/screen/ui/home/manager_leave_history_view/manager_leave_history_view.dart';
// // import 'package:digitalerp/screen/ui/home/mis_module/attendance_report/attendance_report_view.dart';
// // import 'package:digitalerp/screen/ui/home/mis_module/mis_order/mis_order_view.dart';
// // import 'package:digitalerp/screen/ui/home/mis_module/mis_sales_invoice/sales_invoice_view.dart';
// // import 'package:digitalerp/screen/ui/home/mis_module/pending_shipping/pending_shipping_view.dart';
// // import 'package:digitalerp/screen/ui/home/mis_module/print_report/print_report_view.dart';
// // import 'package:digitalerp/screen/ui/home/mis_module/stock_report/stock_report_view.dart';
// // import 'package:digitalerp/screen/ui/home/order/order_view.dart';
// // import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation.dart';
// // import 'package:digitalerp/task%20management/task_list_view.dart';
// // import 'package:digitalerp/utils/app_constant.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // import 'screen/ui/home/approval/approval_list/approval_list_Screen.dart';
// // import 'screen/ui/home/mis_module/mis_outstanding/mis_outstanding_view.dart';
// // import 'shipMangement/shipping_details_view.dart';
// // import 'utils/my_app_bar.dart';
// //
// //
// // List<int> newMenuId = [
// //
// // ];
// //
// // class MenuDefaultScreen extends StatelessWidget {
// //   int menuID;
// //     MenuDefaultScreen({super.key, required this.menuID}) ;
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return  WillPopScope(
// //       onWillPop: () {
// //         if(newMenuId.length==1){
// //           return Future.value(true);
// //         }
// //         else{
// //           newMenuId.removeLast();
// //           Get.put<MenuDefaultController>(MenuDefaultController()).getNewSubList(newMenuId.last);
// //           return Future.value(false);
// //         }
// //       },
// //       child: GetBuilder<MenuDefaultController>(
// //         initState: (state) {
// //           Get.put<MenuDefaultController>(MenuDefaultController()).getNewSubList(menuID);},
// //           init: MenuDefaultController(),
// //           builder: (controller) {
// //             return Scaffold(
// //               body: Stack(
// //               children: [
// //                 Positioned(
// //                   top: 0,
// //                   left: 0,
// //                   right: 0,
// //                   bottom: 0,
// //                   child: Container(
// //                     decoration: const BoxDecoration(
// //                       image: DecorationImage(
// //                         image: AssetImage('assets/images/dashboard_bg.png'),
// //                         fit: BoxFit.fill,
// //                       ),
// //                     ),
// //                     child: SafeArea(
// //                       child: MyAppBar(
// //                         title: 'Default',
// //                         onBackTap: () {
// //                           if(newMenuId.length==1){
// //                             Get.back();
// //                           }
// //                           else{
// //                             newMenuId.removeLast();
// //                             controller.getNewSubList(newMenuId.last);
// //                           }
// //
// //                           },
// //                         // showApprovalIcon: false,
// //                         // onFilterTap: () async {
// //                         //   final filterDialog =
// //                         //   await Get.dialog(
// //                         //       ApprovalFilterScreen());
// //                         //   if (filterDialog != null) {
// //                         //     final approvalFilterModels =
// //                         //     (filterDialog as ApprovalFilterModels);
// //                         //     Get.find<ApprovalListController>()
// //                         //         .getApprovalList(approvalFilterModels);
// //                         //   }
// //                         //   log('FILTER DIALOG ==>$filterDialog');
// //                         // },
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Positioned(
// //                   top: Get.height * 0.30,
// //                   left: 10,
// //                   right: 10,
// //                   bottom: 20,
// //                   child: SingleChildScrollView(
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(2.0),
// //                       child: Column(
// //                           children: [
// //                             controller.isBusy
// //                             ?  SizedBox(child: showLoader(),)
// //                                 : controller.menuSubData?.isEmpty ?? true
// //                                 ? SizedBox(
// //                               height: Get.height * .4,
// //                               child: centerText('Not Menu Available '),
// //                             )
// //                             :  GridView.builder(
// //                               shrinkWrap: true,
// //                               padding: EdgeInsets.zero,
// //                               physics:
// //                               const NeverScrollableScrollPhysics(),
// //                               itemCount: controller.menuSubData.length,
// //                               itemBuilder: (context, index) {
// //                                 return menuList(controller.menuSubData.elementAt(index),controller);
// //                               },
// //                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),),
// //                           ]
// //
// //                       ),
// //
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //               ),
// //             );
// //
// //       }),
// //     );
// //   }
// //
// //   menuList(MenuNewData menuNewData, MenuDefaultController controller) {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Container(
// //         width: Get.width * 0.960,
// //         height: Get.height * 0.110,
// //         decoration: BoxDecoration(
// //           color: Colors.grey.shade200,),
// //         child: InkWell(
// //           onTap: (){
// //
// //             controller.getNewSubList(menuNewData.menuid!);
// //
// //               if(menuNewData.menuid == 2409){
// //                 Get.to(OrderView());
// //               }
// //               else if(menuNewData.menuid == 2410){
// //                 Get.to(ShippingDetailsView());
// //               }
// //               else if(menuNewData.menuid == 2388){
// //                 Get.to(ManagerLeaveHistoryView());
// //               }
// //               else if(menuNewData.menuid == 2389){
// //                 Get.to(ApprovalList());
// //               }
// //               else if(menuNewData.menuid == 2405){
// //                 Get.to(TaskListView());
// //               }
// //               else if(menuNewData.menuid == 2406){
// //                 Get.to(AssignTaskView());
// //               }
// //               else if(menuNewData.menuid == 2401){
// //                 Get.to(DownloadDocumentsView());
// //               }
// //               else if(menuNewData.menuid == 2402){
// //                 Get.to(OrderFollowupView());
// //               }
// //               else if(menuNewData.menuid == 2403){
// //                 Get.to(PaymentFollowupView());
// //               }
// //               else if(menuNewData.menuid == 2415) {
// //                 Get.to(AttendanceReportView());
// //               }
// //               else if (menuNewData.menuid == 2497){
// //                 Get.to(StockReconciliation());
// //               }
// //               else if(menuNewData.menuid == 2416) {
// //                 Get.to(MisOrderView());
// //               }
// //               else if(menuNewData.menuid == 2417) {
// //                 Get.to(PendingShippingView());
// //               }
// //               else if(menuNewData.menuid == 2515) {
// //                 Get.to(SalarySleep());
// //               }
// //               else if(menuNewData.menuid == 2516) {
// //                 Get.to(SalesInvoiceView());
// //               }
// //
// //               else if(menuNewData.menuid == 2418) {
// //                 Get.to(StockReportView());
// //               }
// //               else if(menuNewData.menuid == 2393){
// //                 Get.to(CollectionView());
// //               }
// //               else if(menuNewData.menuid == 2394){
// //                 Get.to(ReceiptEntryView());
// //               }
// //               else if(menuNewData.menuid == 2395){
// //                 Get.to(PaymentEntryView(isPayment: true, title: 'Payment Entry'));
// //               }
// //               else if(menuNewData.menuid == 2396){
// //                 Get.to(JournalEntryView());
// //               }
// //               else if(menuNewData.menuid == 2397){
// //                 Get.to(ContraView());
// //               }
// //               else if(menuNewData.menuid == 2407) {
// //                 Get.to(ExpensesView());
// //               }
// //               else if(menuNewData.menuid == 2398) {
// //                 Get.to(OutstandingView());
// //               }
// //               else if(menuNewData.menuid == 2399) {
// //                 Get.to(PrintReportView(reportType: ReportType.dayBook));
// //               }
// //               else if(menuNewData.menuid == 2400) {
// //                 Get.to(PrintReportView(reportType: ReportType.accountRegister));
// //               }
// //               else if(menuNewData.menuid == 2408) {
// //                 Get.to(PartyTransactionsView());
// //               }
// //               else if(menuNewData.menuid == 2411) {
// //                 Get.to(MisOutstandingView());
// //               }
// //               else if(menuNewData.menuid == 2412) {
// //                 Get.to(PrintReportView(reportType: ReportType.balanceSheet));
// //               }
// //               else if(menuNewData.menuid == 2413) {
// //                 Get.to(PrintReportView(reportType: ReportType.profitAndLoss));
// //               }
// //               else if(menuNewData.menuid == 2414) {
// //                 Get.to(PrintReportView(reportType: ReportType.trialBalance));
// //               }
// //
// //               else{
// //                 newMenuId.add( menuNewData.menuid!);
// //               }
// //
// //
// //
// //     },
// //           child: Padding(
// //             padding: const EdgeInsets.all(5.0),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 10),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Center(child: Text(menuNewData.menuname ?? '',style: const TextStyle().xstyle)),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //
// //
// // }
// //
// //
// //
// // // class MenuDefaultNewScreen extends StatelessWidget {
// // //   int menuIDNew;
// // //   MenuDefaultNewScreen({super.key, required this.menuIDNew}) ;
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return  GetBuilder<MenuDefaultController>(
// // //         initState: (state) {
// // //           Get.put<MenuDefaultController>(MenuDefaultController()).getNewSubList(menuIDNew);},
// // //         init: MenuDefaultController(),
// // //         builder: (controller) {
// // //           return Scaffold(
// // //             body: Stack(
// // //               children: [
// // //                 Positioned(
// // //                   top: 0,
// // //                   left: 0,
// // //                   right: 0,
// // //                   bottom: 0,
// // //                   child: Container(
// // //                     decoration: const BoxDecoration(
// // //                       image: DecorationImage(
// // //                         image: AssetImage('assets/images/dashboard_bg.png'),
// // //                         fit: BoxFit.fill,
// // //                       ),
// // //                     ),
// // //                     child: SafeArea(
// // //                       child: MyAppBar(
// // //                         title: 'Defaults',
// // //                         onBackTap: () => Get.back()
// // //                         // showApprovalIcon: false,
// // //                         // onFilterTap: () async {
// // //                         //   final filterDialog =
// // //                         //   await Get.dialog(
// // //                         //       ApprovalFilterScreen());
// // //                         //   if (filterDialog != null) {
// // //                         //     final approvalFilterModels =
// // //                         //     (filterDialog as ApprovalFilterModels);
// // //                         //     Get.find<ApprovalListController>()
// // //                         //         .getApprovalList(approvalFilterModels);
// // //                         //   }
// // //                         //   log('FILTER DIALOG ==>$filterDialog');
// // //                         // },
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 Positioned(
// // //                   top: Get.height * 0.30,
// // //                   left: 10,
// // //                   right: 10,
// // //                   bottom: 20,
// // //                   child: SingleChildScrollView(
// // //                     child: Padding(
// // //                       padding: const EdgeInsets.all(2.0),
// // //                       child: Column(
// // //                           children: [
// // //                             controller.isBusy
// // //                                 ?  SizedBox(child: showLoader(),)
// // //                                 : controller.menuSubData?.isEmpty ?? true
// // //                                 ? SizedBox(
// // //                               height: Get.height * .4,
// // //                               child: centerText('Not Menu Available '),
// // //                             )
// // //                                 :  GridView.builder(
// // //                               shrinkWrap: true,
// // //                               padding: EdgeInsets.zero,
// // //                               physics:
// // //                               const NeverScrollableScrollPhysics(),
// // //                               itemCount: controller.menuSubData.length,
// // //                               itemBuilder: (context, index) {
// // //                                 return menuList(controller.menuSubData.elementAt(index),controller);
// // //                               },
// // //                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),),
// // //                           ]
// // //
// // //                       ),
// // //
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //
// // //         });
// // //   }
// // //
// // //   menuList(MenuNewData menuNewData, MenuDefaultController controller) {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(8.0),
// // //       child: Container(
// // //         width: Get.width * 0.960,
// // //         height: Get.height * 0.110,
// // //         decoration: BoxDecoration(
// // //           color: Colors.grey.shade200,),
// // //         child: InkWell(
// // //           onTap: (){
// // //             controller.getNewSubList(menuNewData.menuid!);
// // //
// // //             if(menuNewData.menuid == 2393){
// // //               Get.to(CollectionView());
// // //             }
// // //             else if(menuNewData.menuid == 2394){
// // //               Get.to(ReceiptEntryView());
// // //             }
// // //             else if(menuNewData.menuid == 2395){
// // //               Get.to(PaymentEntryView(isPayment: true, title: 'Payment Entry'));
// // //             }
// // //             else if(menuNewData.menuid == 2396){
// // //               Get.to(JournalEntryView());
// // //             }
// // //             else if(menuNewData.menuid == 2397){
// // //               Get.to(ContraView());
// // //             }
// // //             else if(menuNewData.menuid == 2407) {
// // //               Get.to(ExpensesView());
// // //             }
// // //             else if(menuNewData.menuid == 2398) {
// // //               Get.to(OutstandingView());
// // //             }
// // //             else if(menuNewData.menuid == 2399) {
// // //               Get.to(PrintReportView(reportType: ReportType.dayBook));
// // //             }
// // //             else if(menuNewData.menuid == 2400) {
// // //               Get.to(PrintReportView(reportType: ReportType.accountRegister));
// // //             }
// // //             else if(menuNewData.menuid == 2408) {
// // //               Get.to(PartyTransactionsView());
// // //             }
// // //             else if(menuNewData.menuid == 2411) {
// // //               Get.to(MisOutstandingView());
// // //             }
// // //             else if(menuNewData.menuid == 2412) {
// // //               Get.to(PrintReportView(reportType: ReportType.balanceSheet));
// // //             }
// // //             else if(menuNewData.menuid == 2413) {
// // //               Get.to(PrintReportView(reportType: ReportType.profitAndLoss));
// // //             }
// // //             else if(menuNewData.menuid == 2414) {
// // //               Get.to(PrintReportView(reportType: ReportType.trialBalance));
// // //             }
// // //
// // //           },
// // //           child: Padding(
// // //             padding: const EdgeInsets.all(5.0),
// // //             child: Padding(
// // //               padding: const EdgeInsets.symmetric(horizontal: 10),
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   Center(child: Text(menuNewData.menuname ?? '',style: const TextStyle().xstyle)),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //
// // //
// // //
// // // }
//
// // new_menu_defalut_screen.dart   ← keep filename exactly as your project has it
// // 
// // Floating speed-dial menu.  All items come from the API — fully dynamic.
// // Adding a new menuid = ONE line in _routeMap. Nothing else changes.
// // 
//
// import 'package:digitalerp/Menu_new_list_responce.dart';
// import 'package:digitalerp/download_document_management/download_documents_view.dart';
// import 'package:digitalerp/menu_default_controller.dart';
// import 'package:digitalerp/orderfollowup/order_followup_view.dart';
// import 'package:digitalerp/paymenfollow%20up/payment_followup_view.dart';
// import 'package:digitalerp/salary_sleep/salary_sleep.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/account_module/collection/collection_view.dart';
// import 'package:digitalerp/screen/ui/home/account_module/contra/contra_view.dart';
// import 'package:digitalerp/screen/ui/home/account_module/expenses/expsenes_view.dart';
// import 'package:digitalerp/screen/ui/home/account_module/journal_entry/journal_entry_view.dart';
// import 'package:digitalerp/screen/ui/home/account_module/outstanding/outstanding_view.dart';
// import 'package:digitalerp/screen/ui/home/account_module/party_ledger/party_transactions_view.dart';
// import 'package:digitalerp/screen/ui/home/account_module/payment_entry/payment_entry_view.dart';
// import 'package:digitalerp/screen/ui/home/account_module/receipt_entry/receipt_entry_view.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_Screen.dart';
// import 'package:digitalerp/screen/ui/home/manager_leave_history_view/manager_leave_history_view.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/attendance_report/attendance_report_view.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/mis_order/mis_order_view.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/mis_outstanding/mis_outstanding_view.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/mis_sales_invoice/sales_invoice_view.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/pending_shipping/pending_shipping_view.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/print_report/print_report_view.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/stock_report/stock_report_view.dart';
// import 'package:digitalerp/screen/ui/home/order/order_view.dart';
// import 'package:digitalerp/shipMangement/shipping_details_view.dart';
// import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation.dart';
// import 'package:digitalerp/task%20management/task_list_view.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // 
// // ROUTE MAP   add ONE entry per new menu item, nothing else needed
// // 
// final Map<int, WidgetBuilder> _routeMap = {
//   2409: (_) => OrderView(),
//   2410: (_) => ShippingDetailsView(),
//   2388: (_) => ManagerLeaveHistoryView(),
//   2389: (_) => const ApprovalList(),
//   2405: (_) => TaskListView(),
//   2406: (_) => AssignTaskView(),
//   2401: (_) => DownloadDocumentsView(),
//   2402: (_) => OrderFollowupView(),
//   2403: (_) => PaymentFollowupView(),
//   2415: (_) => AttendanceReportView(),
//   2497: (_) => StockReconciliation(),
//   2416: (_) => MisOrderView(),
//   2417: (_) => PendingShippingView(),
//   2515: (_) => SalarySleep(),
//   2516: (_) => SalesInvoiceView(),
//   2418: (_) => StockReportView(),
//   2393: (_) => CollectionView(),
//   2394: (_) => ReceiptEntryView(),
//   2395: (_) => PaymentEntryView(isPayment: true, title: 'Payment Entry'),
//   2396: (_) => JournalEntryView(),
//   2397: (_) => ContraView(),
//   2407: (_) => ExpensesView(),
//   2398: (_) => OutstandingView(),
//   2399: (_) => PrintReportView(reportType: ReportType.dayBook),
//   2400: (_) => PrintReportView(reportType: ReportType.accountRegister),
//   2408: (_) => PartyTransactionsView(),
//   2411: (_) => MisOutstandingView(),
//   2412: (_) => PrintReportView(reportType: ReportType.balanceSheet),
//   2413: (_) => PrintReportView(reportType: ReportType.profitAndLoss),
//   2414: (_) => PrintReportView(reportType: ReportType.trialBalance),
//   // 2756: (_) => TaskFollowupScreen(taskId: ''),   // uncomment when ready
// };
//
// // 
// // ICON MAP   fallback: Icons.widgets_outlined
// // 
// const Map<int, IconData> _menuIcons = {
//   2409: Icons.shopping_cart_outlined,
//   2410: Icons.local_shipping_outlined,
//   2388: Icons.event_available_outlined,
//   2389: Icons.approval_outlined,
//   2405: Icons.checklist_outlined,
//   2406: Icons.assignment_ind_outlined,
//   2401: Icons.download_outlined,
//   2402: Icons.follow_the_signs_outlined,
//   2403: Icons.payments_outlined,
//   2415: Icons.bar_chart_outlined,
//   2497: Icons.sync_alt_outlined,
//   2416: Icons.receipt_long_outlined,
//   2417: Icons.pending_actions_outlined,
//   2515: Icons.account_balance_wallet_outlined,
//   2516: Icons.description_outlined,
//   2418: Icons.inventory_2_outlined,
//   2393: Icons.account_balance_outlined,
//   2394: Icons.receipt_outlined,
//   2395: Icons.payment_outlined,
//   2396: Icons.book_outlined,
//   2397: Icons.compare_arrows_outlined,
//   2407: Icons.money_off_outlined,
//   2398: Icons.account_box_outlined,
//   2399: Icons.calendar_today_outlined,
//   2400: Icons.menu_book_outlined,
//   2408: Icons.swap_horiz_outlined,
//   2411: Icons.pending_outlined,
//   2412: Icons.balance_outlined,
//   2413: Icons.trending_up_outlined,
//   2414: Icons.format_list_bulleted_outlined,
//   2756: Icons.forward_to_inbox_outlined,
// };
//
// // 
// // MenuDefaultScreen
// // 
// class MenuDefaultScreen extends StatefulWidget {
//   final int menuID;
//   const MenuDefaultScreen({super.key, required this.menuID});
//
//   @override
//   State<MenuDefaultScreen> createState() => _MenuDefaultScreenState();
// }
//
// class _MenuDefaultScreenState extends State<MenuDefaultScreen>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _fabAnimCtrl;
//   late final Animation<double> _fadeAnim;
//   bool _fabOpen = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fabAnimCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 260),
//     );
//     _fadeAnim =
//         CurvedAnimation(parent: _fabAnimCtrl, curve: Curves.easeInOut);
//   }
//
//   @override
//   void dispose() {
//     _fabAnimCtrl.dispose();
//     super.dispose();
//   }
//
//   void _toggleFab() {
//     setState(() => _fabOpen = !_fabOpen);
//     _fabOpen ? _fabAnimCtrl.forward() : _fabAnimCtrl.reverse();
//   }
//
//   void _closeFab() {
//     if (!_fabOpen) return;
//     setState(() => _fabOpen = false);
//     _fabAnimCtrl.reverse();
//   }
//
//   //  Tap handler 
//   void _handleTap(MenuNewData item, MenuDefaultController controller) {
//     _closeFab();
//     final id = item.menuid;
//     if (id == null) return;
//
//     final builder = _routeMap[id];
//     if (builder != null) {
//       // Leaf node → go directly to destination
//       // Do NOT call getNewSubList here — no wasted API call
//       Get.to(() => builder(context));
//     } else {
//       // Parent node → drill into sub-menu
//       controller.pushMenu(id);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MenuDefaultController>(
//       // Use Get.put so a fresh controller is scoped to this screen
//       init: MenuDefaultController(),
//       initState: (_) {
//         Get.put(MenuDefaultController()).initMenu(widget.menuID);
//       },
//       builder: (controller) {
//         return PopScope(
//           canPop: false,
//           onPopInvokedWithResult: (didPop, _) {
//             if (didPop) return;
//             if (_fabOpen) {
//               _closeFab();
//               return;
//             }
//             final handled = controller.popMenu();
//             if (!handled) Navigator.of(context).pop();
//           },
//           child: Scaffold(
//             backgroundColor: const Color(0xFFF5F5F7),
//             appBar: _buildAppBar(controller),
//             body: Stack(
//               children: [
//                 _buildBody(controller),
//
//                 // Dark overlay when FAB is open
//                 if (_fabOpen)
//                   FadeTransition(
//                     opacity: _fadeAnim,
//                     child: GestureDetector(
//                       onTap: _closeFab,
//                       child: Container(
//                         color: Colors.black.withValues(alpha: 0.45),
//                       ),
//                     ),
//                   ),
//
//                 // Floating panel
//                 if (controller.menuSubData.isNotEmpty)
//                   _FloatingMenuPanel(
//                     items: controller.menuSubData,
//                     isOpen: _fabOpen,
//                     onItemTap: (item) => _handleTap(item, controller),
//                     fadeAnim: _fadeAnim,
//                   ),
//               ],
//             ),
//             floatingActionButton: controller.menuSubData.isNotEmpty
//                 ? _FabButton(isOpen: _fabOpen, onTap: _toggleFab)
//                 : null,
//           ),
//         );
//       },
//     );
//   }
//
//   AppBar _buildAppBar(MenuDefaultController controller) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 3,
//       shadowColor: const Color(0x12000000),
//       surfaceTintColor: Colors.white,
//       centerTitle: false,
//       leading: GestureDetector(
//         onTap: () {
//           final handled = controller.popMenu();
//           if (!handled) Get.back();
//         },
//         child: const Icon(
//           Icons.arrow_back_ios_new_rounded,
//           color: newTextPrimary,
//           size: 20,
//         ),
//       ),
//       title: Text(
//         controller.currentTitle.isEmpty ? 'Menu' : controller.currentTitle,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w700,
//           color: newTextPrimary,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBody(MenuDefaultController controller) {
//     if (controller.isBusy) {
//       return Center(child: showLoader(color: newBlueColor));
//     }
//
//     if (controller.menuSubData.isEmpty) {
//       return SizedBox(
//         height: Get.height * .4,
//         child: centerText('No Menu Available'),
//       );
//     }
//
//     return GridView.builder(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
//       itemCount: controller.menuSubData.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: 0.95,
//       ),
//       itemBuilder: (context, index) {
//         final item = controller.menuSubData.elementAt(index);
//         return _MenuCard(
//           item: item,
//           onTap: () => _handleTap(item, controller),
//         );
//       },
//     );
//   }
// }
//
// // 
// // _MenuCard
// // 
// class _MenuCard extends StatelessWidget {
//   final MenuNewData item;
//   final VoidCallback onTap;
//   const _MenuCard({required this.item, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final icon = _menuIcons[item.menuid] ?? Icons.widgets_outlined;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: newBorderColor),
//           boxShadow: [
//             BoxShadow(
//               color: purpleColor.withValues(alpha: 0.10),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: purpleColor.withValues(alpha: 0.10),
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Icon(icon, color: purpleColor, size: 22),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Text(
//                 item.menuname ?? '',
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w500,
//                   color: newTextPrimary,
//                   height: 1.35,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 
// // _FabButton
// // 
// class _FabButton extends StatelessWidget {
//   final bool isOpen;
//   final VoidCallback onTap;
//   const _FabButton({required this.isOpen, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: onTap,
//       backgroundColor: isOpen ? Colors.red.shade700 : purpleColor,
//       elevation: 6,
//       shape: const CircleBorder(),
//       child: AnimatedRotation(
//         turns: isOpen ? 0.125 : 0,
//         duration: const Duration(milliseconds: 260),
//         child: Icon(
//           isOpen ? Icons.close_rounded : Icons.grid_view_rounded,
//           color: Colors.white,
//           size: 24,
//         ),
//       ),
//     );
//   }
// }
//
// // 
// // _FloatingMenuPanel  — dynamically renders whatever the API returns
// // 
// class _FloatingMenuPanel extends StatelessWidget {
//   final List<MenuNewData> items;
//   final bool isOpen;
//   final void Function(MenuNewData) onItemTap;
//   final Animation<double> fadeAnim;
//
//   const _FloatingMenuPanel({
//     required this.items,
//     required this.isOpen,
//     required this.onItemTap,
//     required this.fadeAnim,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (!isOpen) return const SizedBox.shrink();
//
//     return Positioned(
//       bottom: 80,
//       right: 16,
//       child: FadeTransition(
//         opacity: fadeAnim,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             constraints: const BoxConstraints(maxWidth: 260, maxHeight: 460),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.18),
//                   blurRadius: 24,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: ListView.separated(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: items.length,
//                 separatorBuilder: (_, __) => Divider(
//                   height: 1,
//                   thickness: 0.5,
//                   indent: 56,
//                   endIndent: 16,
//                   color: Colors.grey.shade100,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   final icon =
//                       _menuIcons[item.menuid] ?? Icons.widgets_outlined;
//                   return _AnimatedPanelRow(
//                     index: index,
//                     child: InkWell(
//                       onTap: () => onItemTap(item),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 11),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 36,
//                               height: 36,
//                               decoration: BoxDecoration(
//                                 color: purpleColor.withValues(alpha: 0.10),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child:
//                               Icon(icon, color: purpleColor, size: 18),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Text(
//                                 item.menuname ?? '',
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500,
//                                   color: newTextPrimary,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             Icon(
//                               Icons.chevron_right_rounded,
//                               color: Colors.grey.shade400,
//                               size: 18,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // 
// // _AnimatedPanelRow  — staggered slide-in per row
// // 
// class _AnimatedPanelRow extends StatefulWidget {
//   final int index;
//   final Widget child;
//   const _AnimatedPanelRow({required this.index, required this.child});
//
//   @override
//   State<_AnimatedPanelRow> createState() => _AnimatedPanelRowState();
// }
//
// class _AnimatedPanelRowState extends State<_AnimatedPanelRow>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _ctrl;
//   late final Animation<Offset> _slide;
//   late final Animation<double> _fade;
//
//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//     _slide = Tween<Offset>(begin: const Offset(0.12, 0), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
//     _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
//
//     Future.delayed(Duration(milliseconds: widget.index * 28), () {
//       if (mounted) _ctrl.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _fade,
//       child: SlideTransition(position: _slide, child: widget.child),
//     );
//   }
// }
// new_menu_defalut_screen.dart
// 
// Simplified. The old grid of cards is removed.
// Tapping a PARENT menu now opens MenuGroupScreen (clean screen + FAB).
// Tapping a LEAF menu navigates directly to the destination screen + FAB.
// 

// new_menu_defalut_screen.dart
// 
// When a parent menu is tapped (e.g. MIS):
//   1. Fetches children from API
//   2. Opens the FIRST child screen directly (e.g. Attendance Report)
//   3. That screen has MenuFab(parentMenuId: ...) so FAB shows all siblings
//
// The old grid of cards is completely removed.
// 

import 'package:digitalerp/Menu_new_list_responce.dart';
import 'package:digitalerp/menu_default_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/account_module/account_module_view.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDefaultScreen extends StatefulWidget {
  final int menuID;
  final String title;

  const MenuDefaultScreen({
    super.key,
    required this.menuID,
    this.title = 'Menu',
  });

  @override
  State<MenuDefaultScreen> createState() => _MenuDefaultScreenState();
}

class _MenuDefaultScreenState extends State<MenuDefaultScreen> {
  bool _navigated = false; // guard so we only auto-navigate once

  @override
  void initState() {
    super.initState();
    _openFirstChild();
  }

  Future<void> _openFirstChild() async {
    try {
      // Use a unique tag per instance
      final tag = 'mds_${widget.menuID}';
      final ctrl = Get.put(MenuDefaultController(), tag: tag);
      await ctrl.getNewSubList(widget.menuID);

      if (!mounted || _navigated) return;

      final children = ctrl.menuSubData;

      if (children.isEmpty) {
        // Nothing to navigate to — stay on the fallback screen
        return;
      }

      // Find the first child that has a known route (leaf node)
      final firstLeaf = children.firstWhereOrNull(
            (item) => item.menuid != null && menuRouteMap.containsKey(item.menuid),
      );

      //if (firstLeaf == null) return;
      if (firstLeaf == null) {
        // ✅ Instead of returning blank, navigate to AccountModuleView directly
        _navigated = true;
        Get.off(() => const AccountModuleView());
        return;
      }

      _navigated = true;

      // Replace this intermediate screen with the first child screen.
      // The child screen MUST have MenuFab(parentMenuId: widget.menuID)
      // in its Scaffold to get the FAB with all siblings.
      //
      // We pass parentMenuId via Get.arguments so screens can read it.
      // ✅ AFTER — no argument, just call the builder
      Get.off(
            () => menuRouteMap[firstLeaf.menuid!]!(),
        arguments: {'parentMenuId': widget.menuID, 'title': widget.title},
      );

      // Clean up controller
      try {
        Get.delete<MenuDefaultController>(tag: tag);
      } catch (_) {}
    } catch (e) {
      // On error stay on the fallback screen — user sees "No Menu Available"
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fallback screen shown only during the brief fetch or on error.
    // In normal flow user never sees this — they jump directly to the child.
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: const Color(0x12000000),
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: newTextPrimary,
            size: 20,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: newTextPrimary,
          ),
        ),
      ),
      body: Center(child: showLoader(color: newBlueColor)),
    );
  }
}