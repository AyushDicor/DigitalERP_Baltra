// menu_fab.dart
// 
// TWO WAYS TO USE — pick based on whether your screen already has a FAB:
//
//  CASE 1: Screen has NO existing floatingActionButton 
//   Scaffold(
//     appBar: ...,
//     body: ...,
//     floatingActionButton: MenuFab(parentMenuId: 2383),
//   );
//
//  CASE 2: Screen ALREADY has a floatingActionButton (e.g. Add button) 
//   Keep your existing FAB as-is. Wrap only the body with MenuFabBody:
//
//   Scaffold(
//     appBar: ...,
//     floatingActionButton: GradientIconButton(...),   // your existing FAB — untouched
//     body: MenuFabBody(
//       parentMenuId: 2383,
//       child: YourExistingBodyWidget(),
//     ),
//   );
//
//   MenuFabBody pins the menu FAB at bottom-left so it never overlaps
//   the add button which sits at bottom-right by default.
// 
// menu_fab.dart
// 
// FIX: Navigation from bottom sheet was broken because:
//   1. `context` inside sheet builder was the sheet's own context,
//      not the app navigator context — Get.off() couldn't find the right route.
//   2. Fixed by closing the sheet first with Get.back(), then navigating
//      using Get.offNamed / Get.off AFTER the sheet is fully dismissed,
//      using a post-frame callback to guarantee correct timing.
// 

import 'package:digitalerp/Menu_new_list_responce.dart';
import 'package:digitalerp/download_document_management/download_documents_view.dart';
import 'package:digitalerp/menu_default_controller.dart';
import 'package:digitalerp/orderfollowup/order_followup_view.dart';
import 'package:digitalerp/paymenfollow%20up/payment_followup_view.dart';
import 'package:digitalerp/salary_sleep/salary_sleep.dart';
import 'package:digitalerp/screen/ui/home/account_module/collection/collection_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/contra/contra_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/expenses/expsenes_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/journal_entry/journal_entry_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/outstanding/outstanding_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/party_ledger/party_transactions_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/payment_entry/payment_entry_view.dart';
import 'package:digitalerp/screen/ui/home/account_module/receipt_entry/receipt_entry_view.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_Screen.dart';
import 'package:digitalerp/screen/ui/home/approval_management/approval_hub_screens/approval_hub_dashboard.dart';
import 'package:digitalerp/screen/ui/home/manager_leave_history_view/manager_leave_history_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/attendance_report/attendance_report_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/mis_order/mis_order_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/mis_outstanding/mis_outstanding_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/mis_sales_invoice/sales_invoice_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/pending_shipping/pending_shipping_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/print_report/print_report_view.dart';
import 'package:digitalerp/screen/ui/home/mis_module/stock_report/stock_report_view.dart';
import 'package:digitalerp/screen/ui/home/order/order_view.dart';
import 'package:digitalerp/shipMangement/shipping_details_view.dart';
import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation.dart';
import 'package:digitalerp/task%20management/create_task/create_task_screen.dart';
import 'package:digitalerp/task%20management/task_list_view.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../home/account_module/account_module_view.dart';
import '../home/approval_management/approval_hub_screens/approval_hub_list.dart';

// 
// ROUTE MAP — add ONE line per new menu item. Nothing else changes.
// 
final Map<int, Widget Function()> menuRouteMap = {
  // ✅ FIXED: builders are now `Widget Function()` with NO context parameter.
  //    This avoids stale/wrong context being captured from inside the sheet.
  2409: () => OrderView(),
  2410: () => ShippingDetailsView(),
  2389: () => ApprovalHubDashboard(),
  2388: () => ManagerLeaveHistoryView(),
  2405: () => TaskListView(),
  2406: () => CreateTaskScreen(),
  2401: () => DownloadDocumentsView(),
  2402: () => OrderFollowupView(),
  2403: () => PaymentFollowupView(),
  2415: () => AttendanceReportView(),
  2497: () => StockReconciliation(),
  2416: () => MisOrderView(),
  2417: () => PendingShippingView(),
  2515: () => SalarySleep(),
  2516: () => SalesInvoiceView(),
  2418: () => StockReportView(),
  2393: () => CollectionView(),
  2394: () => ReceiptEntryView(),
  2395: () => PaymentEntryView(isPayment: true, title: 'Payment Entry'),
  2396: () => JournalEntryView(),
  2397: () => ContraView(),
  2407: () => ExpensesView(),
  2398: () => OutstandingView(),
  2399: () => PrintReportView(reportType: ReportType.dayBook),
  2400: () => PrintReportView(reportType: ReportType.accountRegister),
  2408: () => PartyTransactionsView(),
  2411: () => MisOutstandingView(),
  2412: () => PrintReportView(reportType: ReportType.balanceSheet),
  2413: () => PrintReportView(reportType: ReportType.profitAndLoss),
  2414: () => PrintReportView(reportType: ReportType.trialBalance),
  2384: () => ApprovalHubDashboard(),
  // 2756: () => TaskFollowupScreen(taskId: ''),
};

// 
// ICON MAP
// 
const Map<int, IconData> menuIconMap = {
  2409: Icons.shopping_cart_outlined,
  2410: Icons.local_shipping_outlined,
  2388: Icons.event_available_outlined,
  2389: Icons.approval_outlined,
  2405: Icons.checklist_outlined,
  2406: Icons.assignment_ind_outlined,
  2401: Icons.download_outlined,
  2402: Icons.follow_the_signs_outlined,
  2403: Icons.payments_outlined,
  2415: Icons.bar_chart_outlined,
  2497: Icons.sync_alt_outlined,
  2416: Icons.receipt_long_outlined,
  2417: Icons.pending_actions_outlined,
  2515: Icons.account_balance_wallet_outlined,
  2516: Icons.description_outlined,
  2418: Icons.inventory_2_outlined,
  2393: Icons.account_balance_outlined,
  2394: Icons.receipt_outlined,
  2395: Icons.payment_outlined,
  2396: Icons.book_outlined,
  2397: Icons.compare_arrows_outlined,
  2407: Icons.money_off_outlined,
  2398: Icons.account_box_outlined,
  2399: Icons.calendar_today_outlined,
  2400: Icons.menu_book_outlined,
  2408: Icons.swap_horiz_outlined,
  2411: Icons.pending_outlined,
  2412: Icons.balance_outlined,
  2413: Icons.trending_up_outlined,
  2414: Icons.format_list_bulleted_outlined,
  2756: Icons.forward_to_inbox_outlined,
};

// 
// SHARED FETCH MIXIN — reused by MenuFab and MenuFabBody
// 
mixin _MenuFabFetch<T extends StatefulWidget> on State<T> {
  List<MenuNewData> menuChildren = [];
  bool menuLoading = true;
  late String fabTag;

  void fetchMenuChildren(int parentMenuId) {
    fabTag = 'menufab_${parentMenuId}_$hashCode';
    _load(parentMenuId);
  }

  Future<void> _load(int parentMenuId) async {
    try {
      final ctrl = Get.put(MenuDefaultController(), tag: fabTag);
      await ctrl.getNewSubList(parentMenuId);
      if (mounted) {
        setState(() {
          menuChildren = List.from(ctrl.menuSubData);

// 🔥 Force 2388 to be first
//           menuChildren.sort((a, b) {
//             if (a.menuid == 2388) return -1;
//             if (b.menuid == 2388) return 1;
//             return 0;
//           });
          menuLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => menuLoading = false);
    } finally {
      try {
        Get.delete<MenuDefaultController>(tag: fabTag);
      } catch (_) {}
    }
  }

  void openMenuSheet() {
    if (menuChildren.isEmpty) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,   // ← this must match the pop above
      builder: (_) => _MenuNavSheet(children: menuChildren),
    );
  }

  @override
  void dispose() {
    try {
      Get.delete<MenuDefaultController>(tag: fabTag);
    } catch (_) {}
    super.dispose();
  }
}

// 
// MenuFab
// CASE 1 — screen has NO existing floatingActionButton
//
//   Scaffold(
//     body: ...,
//     floatingActionButton: MenuFab(parentMenuId: 2383),
//   );
// 
class MenuFab extends StatefulWidget {
  final int parentMenuId;
  const MenuFab({super.key, required this.parentMenuId});

  @override
  State<MenuFab> createState() => _MenuFabWidgetState();
}

class _MenuFabWidgetState extends State<MenuFab> with _MenuFabFetch {
  @override
  void initState() {
    super.initState();
    fetchMenuChildren(widget.parentMenuId);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Hide FAB if loading, empty, or only 1 child
    if (menuLoading || menuChildren.length <= 1) return const SizedBox.shrink();

    return FloatingActionButton(
      heroTag: 'menufab_solo_${widget.parentMenuId}',
      onPressed: openMenuSheet,
      backgroundColor: purpleColor,
      elevation: 4,
      shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
      tooltip: 'Quick navigation',
      child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 22),
    );
  }
}

// 
// MenuFabBody
// CASE 2 — screen ALREADY has a floatingActionButton (add/cart button etc.)
//
//   Scaffold(
//     floatingActionButton: YourExistingFab(),   ← untouched, stays bottom-right
//     body: MenuFabBody(
//       parentMenuId: 2383,
//       child: YourExistingBodyWidget(),
//     ),
//   );
//
// Menu FAB appears at BOTTOM-LEFT — never overlaps the add button.
// 
class MenuFabBody extends StatefulWidget {
  final int parentMenuId;
  final Widget child;

  /// Raise this if your existing FAB has extra bottom padding.
  /// Match it to your Scaffold FAB's bottom offset.
  final double bottomPadding;

  const MenuFabBody({
    super.key,
    required this.parentMenuId,
    required this.child,
    this.bottomPadding = 24,
  });

  @override
  State<MenuFabBody> createState() => _MenuFabBodyState();
}

class _MenuFabBodyState extends State<MenuFabBody> with _MenuFabFetch {
  @override
  void initState() {
    super.initState();
    fetchMenuChildren(widget.parentMenuId);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // ✅ Only show FAB if more than 1 child
        if (!menuLoading && menuChildren.length > 1)
          Positioned(
            left: 20,
            bottom: widget.bottomPadding + MediaQuery.of(context).padding.bottom,
            child: FloatingActionButton(
              heroTag: 'menufab_body_${widget.parentMenuId}',
              onPressed: openMenuSheet,
              backgroundColor: purpleColor,
              shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
              elevation: 4,
              tooltip: 'Quick navigation',
              child: const Icon(
                Icons.grid_view_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
      ],
    );
  }
}

// 
// _MenuNavSheet
// 
class _MenuNavSheet extends StatelessWidget {
  final List<MenuNewData> children;
  const _MenuNavSheet({required this.children});

  // Inside _MenuNavSheet class
  void _navigate(int menuId) {
    print('🟢 _navigate called with menuId: $menuId');
    final builder = menuRouteMap[menuId];
    print('🟢 builder found: ${builder != null}');
    if (builder == null) return;

    Navigator.of(Get.context!, rootNavigator: true).pop();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      print('🟢 navigating now...');
      // ✅ Use Flutter native navigator instead of Get.to
      Navigator.of(Get.context!).push(
        MaterialPageRoute(builder: (_) => builder()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.68,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: purpleColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.grid_view_rounded,
                      color: purpleColor, size: 18),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Go to',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.close_rounded,
                        size: 18, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade100),

          // List
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 6),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: children.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                thickness: 0.5,
                indent: 64,
                endIndent: 18,
                color: Colors.grey.shade100,
              ),
              itemBuilder: (_, i) {
                final item = children[i];
                final icon =
                    menuIconMap[item.menuid] ?? Icons.widgets_outlined;
                final isLeaf = menuRouteMap.containsKey(item.menuid);
                print('🔵 item: ${item.menuname} id:${item.menuid} isLeaf:$isLeaf');

                return InkWell(
                  onTap: () {
                    print('🟡 TAPPED: ${item.menuname} id:${item.menuid} isLeaf:$isLeaf');
                    final id = item.menuid;
                    print('🔴 id is null: ${id == null}');  // ← add this
                    if (id != null) {
                      _navigate(id);  // ← call directly without isLeaf check
                    }
                  },
                  child: Opacity(
                    opacity: isLeaf ? 1.0 : 0.45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 13),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: purpleColor.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(icon, color: purpleColor, size: 18),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              item.menuname ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: newTextPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isLeaf)
                            Icon(Icons.chevron_right_rounded,
                                color: Colors.grey.shade400, size: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
    );
  }
}