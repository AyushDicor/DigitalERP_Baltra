// import 'package:digitalerp/screen/ui/home/Grn_module/Grn_entry_view.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../Grn_controller/Grn_list_controller.dart';
// import '../Grn_response/Grn_models.dart';
//
// class GrnListScreen extends StatefulWidget {
//   const GrnListScreen({super.key});
//
//   @override
//   State<GrnListScreen> createState() => _GrnListScreenState();
// }
//
// class _GrnListScreenState extends State<GrnListScreen> {
//   late GrnListController ctrl;
//   @override
//   void initState() {
//     super.initState();
//     // ✅ Delete any stale instance, then create fresh
//     Get.delete<GrnListController>(force: true);
//     ctrl = Get.put(GrnListController());
//   }
//
//   @override
//   void dispose() {
//     Get.delete<GrnListController>(force: true);
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GrnListController>(
//       builder: (ctrl) {
//         return Scaffold(
//           backgroundColor: newSurfaceColor,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//               onPressed: () => Get.back(),
//             ),
//             title: const Text('Grn List',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w800,
//                     color: newTextPrimary)),
//             iconTheme: const IconThemeData(color: newTextPrimary),
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(1),
//               child: Container(height: 1, color: newBorderColor),
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               await Get.to(() => const GrnEntryView());
//               ctrl.fetchGrnList();                  // ✅ refresh on return
//             },
//             backgroundColor: newBlueColor,
//             shape: const CircleBorder(
//                 side: BorderSide(color: Colors.white, width: 2)),
//             elevation: 4,
//             child: const Icon(Icons.add, color: Colors.white, size: 32),
//           ),
//           body: Column(children: [
//             _filterBar(context, ctrl),
//             Expanded(
//               child: ctrl.isLoadingList
//                   ? _shimmer()
//                   : ctrl.htmlData.isEmpty
//                   ? _emptyState()
//                   : _GrnWebView(htmlContent: ctrl.htmlData),
//             ),
//           ]),
//         );
//       },
//     );
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return GetBuilder<GrnListController>(
//   //     builder: (ctrl) {
//   //       return Scaffold(
//   //         backgroundColor: newSurfaceColor,
//   //         appBar: AppBar(
//   //           backgroundColor: Colors.white,
//   //           elevation: 0,
//   //           title: const Text('Grn List',
//   //               style: TextStyle(
//   //                   fontSize: 16,
//   //                   fontWeight: FontWeight.w800,
//   //                   color: newTextPrimary)),
//   //           iconTheme: const IconThemeData(color: newTextPrimary),
//   //           bottom: PreferredSize(
//   //             preferredSize: const Size.fromHeight(1),
//   //             child: Container(height: 1, color: newBorderColor),
//   //           ),
//   //         ),
//   //         floatingActionButton: FloatingActionButton.extended(
//   //           onPressed: () async {
//   //             await Get.to(() => const GrnEntryView());
//   //             Get.find<GrnListController>().fetchGrnList(); // ✅ refresh on return
//   //           },
//   //           backgroundColor: newBlueColor,
//   //           icon: const Icon(Icons.add_rounded, color: Colors.white),
//   //           label: const Text('New Grn',
//   //               style: TextStyle(
//   //                   color: Colors.white,
//   //                   fontWeight: FontWeight.w700,
//   //                   fontSize: 13)),
//   //         ),
//   //         body: Column(children: [
//   //           _filterBar(context, ctrl),
//   //           Expanded(
//   //             child: ctrl.isLoadingList
//   //                 ? _shimmer()
//   //                 : ctrl.htmlData.isEmpty
//   //                 ? _emptyState()
//   //                 : _GrnWebView(htmlContent: ctrl.htmlData),
//   //           ),
//   //           // Expanded(
//   //           //   child: ctrl.isLoadingList
//   //           //       ? _shimmer()
//   //           //       : ctrl.GrnItems.isEmpty
//   //           //       ? _emptyState()
//   //           //       : RefreshIndicator(
//   //           //     color: newBlueColor,
//   //           //     onRefresh: ctrl.fetchGrnList,
//   //           //     child: ListView.separated(
//   //           //       physics: const AlwaysScrollableScrollPhysics(),
//   //           //       padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
//   //           //       itemCount: ctrl.GrnItems.length,
//   //           //       separatorBuilder: (_, __) =>
//   //           //       const SizedBox(height: 10),
//   //           //       itemBuilder: (_, i) =>
//   //           //           _GrnCard(item: ctrl.GrnItems[i]),
//   //           //     ),
//   //           //   ),
//   //           // ),
//   //         ]),
//   //       );
//   //     },
//   //   );
//   // }
//
//   Widget _filterBar(BuildContext context, GrnListController ctrl) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
//       child: Row(children: [
//         Expanded(child: _dateField(
//           label: 'From',
//           controller: ctrl.fromDateCtrl,
//           onTap: () => ctrl.pickFromDate(context),
//         )),
//         const SizedBox(width: 10),
//         Expanded(child: _dateField(
//           label: 'To',
//           controller: ctrl.toDateCtrl,
//           onTap: () => ctrl.pickToDate(context),
//         )),
//         const SizedBox(width: 10),
//         GestureDetector(
//           onTap: ctrl.fetchGrnList,
//           child: Container(
//             height: 44, width: 44,
//             decoration: BoxDecoration(
//                 color: newBlueColor,
//                 borderRadius: BorderRadius.circular(10)),
//             alignment: Alignment.center,
//             child: ctrl.isLoadingList
//                 ? const SizedBox(
//                 width: 18, height: 18,
//                 child: CircularProgressIndicator(
//                     color: Colors.white, strokeWidth: 2))
//                 : const Icon(Icons.search_rounded,
//                 color: Colors.white, size: 20),
//           ),
//         ),
//       ]),
//     );
//   }
//
//   Widget _dateField({
//     required String label,
//     required TextEditingController controller,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 44,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           color: newSurfaceColor,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: newBorderColor),
//         ),
//         child: Row(children: [
//           const Icon(Icons.calendar_today_outlined,
//               size: 14, color: newTextSecondary),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(label,
//                       style: const TextStyle(
//                           fontSize: 9,
//                           color: newTextSecondary,
//                           fontWeight: FontWeight.w600)),
//                   Text(controller.text,
//                       style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: newTextPrimary)),
//                 ]),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   Widget _emptyState() => Center(
//     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Icon(Icons.inventory_2_outlined, size: 56, color: newBorderColor),
//       const SizedBox(height: 12),
//       const Text('No Grn records found',
//           style: TextStyle(fontSize: 14,
//               fontWeight: FontWeight.w700, color: newTextSecondary)),
//       const SizedBox(height: 4),
//       const Text('Try adjusting the date range',
//           style: TextStyle(fontSize: 12, color: newTextSecondary)),
//     ]),
//   );
//
//   Widget _shimmer() => ListView.separated(
//     padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
//     itemCount: 5,
//     separatorBuilder: (_, __) => const SizedBox(height: 10),
//     itemBuilder: (_, __) => Container(
//       height: 120,
//       decoration: BoxDecoration(
//           color: newBorderColor,
//           borderRadius: BorderRadius.circular(14)),
//     ),
//   );
// }
//
// class _GrnWebView extends StatefulWidget {
//   final String htmlContent;
//   const _GrnWebView({required this.htmlContent});
//
//   @override
//   State<_GrnWebView> createState() => _GrnWebViewState();
// }
//
// class _GrnWebViewState extends State<_GrnWebView> {
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadHtmlString(_wrapHtml(widget.htmlContent));
//   }
//
//   String _wrapHtml(String body) => '''
// <!DOCTYPE html>
// <html>
// <head>
// <meta name="viewport" content="width=device-width, initial-scale=1.0">
// <style>
//   body { font-family: sans-serif; font-size: 13px; margin: 0; padding: 12px; }
//   table { width: 100%; border-collapse: collapse; }
//   th { background: #EEF4FF; color: #2563EB; font-size: 11px;
//        padding: 8px 6px; text-align: left; border-bottom: 2px solid #BFDBFE; }
//   td { padding: 8px 6px; border-bottom: 1px solid #F1F5F9;
//        color: #1E293B; font-size: 12px; }
//   tr:nth-child(even) { background: #F8FAFC; }
// </style>
// </head>
// <body>$body</body>
// </html>
// ''';
//
//   @override
//   Widget build(BuildContext context) {
//     return WebViewWidget(controller: _controller);
//   }
// }
//
// // ── Grn Card ───────────────────────────────────────────────────────────────────
// class _GrnCard extends StatelessWidget {
//   final GrnListItem item;
//   const _GrnCard({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () => Get.to(
//               () => const GrnEntryView(),
//           arguments: item,   // ✅ pass the GrnListItem as argument
//         ),
//         child: Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: newBorderColor)),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // ── Blue header ──────────────────────────────────────────────────────
//         Container(
//           padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
//           decoration: BoxDecoration(
//               color: newBlueLightColor,
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(13))),
//           child: Row(children: [
//             const Icon(Icons.receipt_long_rounded, size: 15, color: newBlueColor),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(item.GrnNo,
//                   style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w800,
//                       color: newBlueColor,
//                       letterSpacing: .2)),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(6),
//                   border: Border.all(
//                       color: newBlueColor.withValues(alpha: 0.3))),
//               child: Text(item.GrnDate,
//                   style: const TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       color: newBlueColor)),
//             ),
//           ]),
//         ),
//
//         // ── Body ─────────────────────────────────────────────────────────────
//         Padding(
//           padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             // Party
//             Text(item.partyName,
//                 style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: newTextPrimary)),
//             const SizedBox(height: 8),
//
//             // Site + Job Type
//             Row(children: [
//               _pill(Icons.location_on_outlined, item.siteName,
//                   newSurfaceColor, newTextSecondary),
//               const SizedBox(width: 6),
//               if (item.jobType.isNotEmpty)
//                 _pill(Icons.work_outline_rounded, item.jobType,
//                     newOrangeLightColor, newOrangeColor),
//             ]),
//             const SizedBox(height: 10),
//
//             // Bottom row
//             Row(children: [
//               if (item.billNo.isNotEmpty) ...[
//                 const Icon(Icons.receipt_outlined,
//                     size: 12, color: newTextSecondary),
//                 const SizedBox(width: 4),
//                 Text('Bill: ${item.billNo}',
//                     style: const TextStyle(
//                         fontSize: 11, color: newTextSecondary)),
//                 const SizedBox(width: 12),
//               ],
//               const Icon(Icons.inventory_2_outlined,
//                   size: 12, color: newTextSecondary),
//               const SizedBox(width: 4),
//               Text('${item.totalQty.toInt()} items',
//                   style: const TextStyle(
//                       fontSize: 11, color: newTextSecondary)),
//               const Spacer(),
//               Text('₹${_inr(item.totalAmt)}',
//                   style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w800,
//                       color: newTextPrimary)),
//             ]),
//           ]),
//         ),
//       ]),
//         ),
//     );
//   }
//
//   Widget _pill(IconData icon, String label, Color bg, Color fg) =>
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//         decoration: BoxDecoration(
//             color: bg, borderRadius: BorderRadius.circular(6)),
//         child: Row(mainAxisSize: MainAxisSize.min, children: [
//           Icon(icon, size: 11, color: fg),
//           const SizedBox(width: 4),
//           Text(label,
//               style: TextStyle(
//                   fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
//         ]),
//       );
//
//   static String _inr(double v) {
//     if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(2)} Cr';
//     if (v >= 100000) return '${(v / 100000).toStringAsFixed(2)} L';
//     final parts = v.toStringAsFixed(2).split('.');
//     final whole = parts[0];
//     if (whole.length <= 3) return '$whole.${parts[1]}';
//     final last3 = whole.substring(whole.length - 3);
//     final rest = whole.substring(0, whole.length - 3);
//     final buf = StringBuffer();
//     for (int i = 0; i < rest.length; i++) {
//       if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
//       buf.write(rest[i]);
//     }
//     return '$buf,$last3.${parts[1]}';
//   }
// }

import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/show_message.dart';
import '../grn_controller/grn_list_contoller.dart';
import '../grn_entry_view.dart';
import '../grn_filter/grn_filter_sheet.dart';
import '../grn_response/grn_models.dart';

class GrnListScreen extends StatefulWidget {
  const GrnListScreen({super.key});

  @override
  State<GrnListScreen> createState() => _GrnListScreenState();
}

class _GrnListScreenState extends State<GrnListScreen> {
  late GrnListController ctrl;

  @override
  void initState() {
    super.initState();
    Get.delete<GrnListController>(force: true);
    ctrl = Get.put(GrnListController());
  }

  @override
  void dispose() {
    Get.delete<GrnListController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GrnListController>(
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: newSurfaceColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: const Text('GRN List',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: newTextPrimary)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: newBorderColor),
            ),

            actions: [
              GestureDetector(
                onTap: () => _showFilterSheet(context, ctrl),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: purpleLightest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Center(
                        child: Icon(Icons.filter_list_rounded,
                            color: purpleColor, size: 20),
                      ),
                      if (ctrl.hasActiveFilter)
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: newOrangeColor, shape: BoxShape.circle),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Get.to(() => const GrnEntryView());
              ctrl.fetchGrnList();
            },
            backgroundColor: newBlueColor,
            shape: const CircleBorder(
                side: BorderSide(color: Colors.white, width: 2)),
            elevation: 4,
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
          body: Column(children: [
            _filterBar(context, ctrl),
            if (!ctrl.isLoadingList && ctrl.filteredItems.isNotEmpty)
           //   _summaryBar(ctrl),
            Expanded(
              child: ctrl.isLoadingList
                  ? _shimmer()
                  : ctrl.filteredItems.isEmpty
                  ? _emptyState()
                  : RefreshIndicator(
                color: newBlueColor,
                onRefresh: ctrl.fetchGrnList,
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
                  itemCount: ctrl.filteredItems.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 10),
                  itemBuilder: (_, i) =>
                      _GrnCard(item: ctrl.filteredItems[i]),
                ),
              ),
            ),
          ]),
          // body: Column(children: [
          //   _filterBar(context, ctrl),
          //   // ── Summary bar ──────────────────────────────────────────────
          //   if (!ctrl.isLoadingList && ctrl.GrnItems.isNotEmpty)
          //     _summaryBar(ctrl),
          //   Expanded(
          //     child: ctrl.isLoadingList
          //         ? _shimmer()
          //         : ctrl.GrnItems.isEmpty
          //         ? _emptyState()
          //         : _GrnTable(items: ctrl.GrnItems),
          //   ),
          // ]),
        );
      },
    );
  }

  // Widget _summaryBar(GrnListController ctrl) {
  //   final totalAmt = ctrl.GrnItems.fold(0.0, (s, i) => s + i.totalAmt);
  //   final totalQty = ctrl.GrnItems.fold(0.0, (s, i) => s + i.totalQty);
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
  //     child: Row(children: [
  //       _summaryChip(Icons.receipt_long_rounded,
  //           '${ctrl.GrnItems.length} Records', newBlueLightColor, newBlueColor),
  //       const SizedBox(width: 8),
  //       _summaryChip(Icons.inventory_2_outlined,
  //           '${totalQty.toInt()} Items', newGreenLightColor, newGreenColor),
  //       const SizedBox(width: 8),
  //       _summaryChip(Icons.currency_rupee_rounded,
  //           _inr(totalAmt), newOrangeLightColor, newOrangeColor),
  //     ]),
  //   );
  // }

  // Widget _summaryChip(IconData icon, String label, Color bg, Color fg) {
  //   return Expanded(
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
  //       decoration: BoxDecoration(
  //           color: bg, borderRadius: BorderRadius.circular(8)),
  //       child: Row(mainAxisSize: MainAxisSize.min, children: [
  //         Icon(icon, size: 13, color: fg),
  //         const SizedBox(width: 5),
  //         Flexible(
  //           child: Text(label,
  //               style: TextStyle(
  //                   fontSize: 11, fontWeight: FontWeight.w700, color: fg),
  //               overflow: TextOverflow.ellipsis),
  //         ),
  //       ]),
  //     ),
  //   );
  // }

  Widget _summaryBar(GrnListController ctrl) {
    final totalAmt = ctrl.GrnItems.fold(0.0, (s, i) => s + i.totalAmt);
    final totalQty = ctrl.GrnItems.fold(0.0, (s, i) => s + i.totalQty);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      child: Row(children: [
        _chip(Icons.receipt_long_rounded, '${ctrl.GrnItems.length} Records',
            newBlueLightColor, newBlueColor),
        const SizedBox(width: 8),
        _chip(Icons.inventory_2_outlined, '${totalQty.toInt()} Items',
            newGreenLightColor, newGreenColor),
        const SizedBox(width: 8),
        _chip(Icons.currency_rupee_rounded, _inr(totalAmt), newOrangeLightColor,
            newOrangeColor),
      ]),
    );
  }

  Widget _chip(IconData icon, String label, Color bg, Color fg) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 13, color: fg),
        const SizedBox(width: 5),
        Flexible(
            child: Text(label,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w700, color: fg),
                overflow: TextOverflow.ellipsis)),
      ]),
    ),
  );

  static String _inr(double v) {
    if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
    return '₹${v.toStringAsFixed(0)}';
  }

  Widget _filterBar(BuildContext context, GrnListController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(children: [
        Expanded(
            child: _dateField(
                label: 'From',
                controller: ctrl.fromDateCtrl,
                onTap: () => ctrl.pickFromDate(context))),
        const SizedBox(width: 10),
        Expanded(
            child: _dateField(
                label: 'To',
                controller: ctrl.toDateCtrl,
                onTap: () => ctrl.pickToDate(context))),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: ctrl.fetchGrnList,
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
                color: newBlueColor, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: ctrl.isLoadingList
                ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.search_rounded,
                color: Colors.white, size: 20),
          ),
        ),
      ]),
    );
  }

  Widget _dateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: Row(children: [
          const Icon(Icons.calendar_today_outlined,
              size: 14, color: newTextSecondary),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 9,
                          color: newTextSecondary,
                          fontWeight: FontWeight.w600)),
                  Text(controller.text,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: newTextPrimary)),
                ]),
          ),
        ]),
      ),
    );
  }

  Widget _emptyState() => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.inventory_2_outlined, size: 56, color: newBorderColor),
      const SizedBox(height: 12),
      const Text('No Grn records found',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: newTextSecondary)),
      const SizedBox(height: 4),
      const Text('Try adjusting the date range',
          style: TextStyle(fontSize: 12, color: newTextSecondary)),
    ]),
  );

  Widget _shimmer() => ListView.separated(
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
    itemCount: 5,
    separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (_, __) => Container(
      height: 60,
      decoration: BoxDecoration(
          color: newBorderColor, borderRadius: BorderRadius.circular(10)),
    ),
  );

  void _showFilterSheet(BuildContext context, GrnListController ctrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MrnGrnFilterSheet.forGrn(
        items: ctrl.GrnItems,
        activeFilter: ctrl.activeFilter,
        onApply: ctrl.applyFilter,
        onReset: ctrl.resetFilter,
        partyName: (e) => e.partyName,
        siteName: (e) => e.siteName,
        jobType: (e) => e.jobType,
        totalAmt: (e) => e.totalAmt,
      ),
    );
  }
}

class _GrnCard extends StatelessWidget {
  final GrnListItem item;
  const _GrnCard({required this.item});

  // ── Open URL in browser ──────────────────────────────────────────────────
  // Future<void> _openUrl(String url) async {
  //   if (url.isEmpty) return;
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     ShowMessage.showSnackBar('Error', 'Could not open URL');
  //   }
  // }
  Future<void> _openUrl(String url) async {
    if (url.isEmpty) return;
    try {
      final uri = Uri.parse(url);
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        ShowMessage.showSnackBar('Error', 'Could not open document');
      }
    } catch (e) {
      if (kDebugMode) print('URL launch error: $e');
      ShowMessage.showSnackBar('Error', 'Invalid URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
            () => const GrnEntryView(),
        arguments: item,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: newBorderColor)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Blue header ────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            decoration: BoxDecoration(
                color: newBlueLightColor,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(13))),
            child: Row(children: [
              const Icon(Icons.receipt_long_rounded,
                  size: 15, color: newBlueColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.GrnNo,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: newBlueColor,
                        letterSpacing: .2)),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: newBlueColor.withValues(alpha: 0.3))),
                child: Text(item.GrnDate,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: newBlueColor)),
              ),
            ]),
          ),

          // ── Body ──────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Party
              Text(item.partyName,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary)),
              const SizedBox(height: 8),

              // Site + Job Type
              Row(children: [
                _pill(Icons.location_on_outlined, item.siteName,
                    newSurfaceColor, newTextSecondary),
                const SizedBox(width: 6),
                if (item.jobType.isNotEmpty)
                  _pill(Icons.work_outline_rounded, item.jobType,
                      newOrangeLightColor, newOrangeColor),
              ]),
              const SizedBox(height: 10),

              // Qty + Amount row
              Row(children: [
                if (item.billNo.isNotEmpty) ...[
                  const Icon(Icons.receipt_outlined,
                      size: 12, color: newTextSecondary),
                  const SizedBox(width: 4),
                  Text('Bill: ${item.billNo}',
                      style: const TextStyle(
                          fontSize: 11, color: newTextSecondary)),
                  const SizedBox(width: 12),
                ],
                const Icon(Icons.inventory_2_outlined,
                    size: 12, color: newTextSecondary),
                const SizedBox(width: 4),
                Text('${item.totalQty.toInt()} items',
                    style: const TextStyle(
                        fontSize: 11, color: newTextSecondary)),
                const Spacer(),
                Text('₹${_inr(item.totalAmt)}',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: newTextPrimary)),
              ]),
            ]),
          ),

          // ── Print buttons row ──────────────────────────────────────────────
          if (item.withRateUrl.isNotEmpty || item.withoutRateUrl.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: newBorderColor))),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Row(children: [
                // With Rate
                if (item.withRateUrl.isNotEmpty)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openUrl(item.withRateUrl),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: newBlueLightColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: newBlueColor.withValues(alpha: 0.3))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.print_rounded,
                                size: 13, color: newBlueColor),
                            SizedBox(width: 5),
                            Text('With Rate',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: newBlueColor)),
                          ],
                        ),
                      ),
                    ),
                  ),

                if (item.withRateUrl.isNotEmpty &&
                    item.withoutRateUrl.isNotEmpty)
                  const SizedBox(width: 8),

                // Without Rate
                if (item.withoutRateUrl.isNotEmpty)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openUrl(item.withoutRateUrl),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: newGreenLightColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: newGreenColor.withValues(alpha: 0.3))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.print_outlined,
                                size: 13, color: newGreenColor),
                            SizedBox(width: 5),
                            Text('Without Rate',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: newGreenColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
        ]),
      ),
    );
  }

  Widget _pill(IconData icon, String label, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration:
    BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: fg),
      const SizedBox(width: 4),
      Text(label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    ]),
  );

  static String _inr(double v) {
    if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(2)} Cr';
    if (v >= 100000) return '${(v / 100000).toStringAsFixed(2)} L';
    final parts = v.toStringAsFixed(2).split('.');
    final whole = parts[0];
    if (whole.length <= 3) return '$whole.${parts[1]}';
    final last3 = whole.substring(whole.length - 3);
    final rest = whole.substring(0, whole.length - 3);
    final buf = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return '$buf,$last3.${parts[1]}';
  }
}

class _DynamicGrnTable extends StatefulWidget {
  final List<String> columns;
  final List<GrnListRawRow> rows;
  final List<GrnListItem> items;

  const _DynamicGrnTable({
    required this.columns,
    required this.rows,
    required this.items,
  });

  @override
  State<_DynamicGrnTable> createState() => _DynamicGrnTableState();
}

class _DynamicGrnTableState extends State<_DynamicGrnTable> {
  int? _sortCol;
  bool _sortAsc = true;
  late List<int> _order; // indices into widget.rows

  // Columns to hide from display (internal IDs etc.)
  static const _hiddenCols = {'ID', 'id', 'stockid'};

  @override
  void initState() {
    super.initState();
    _order = List.generate(widget.rows.length, (i) => i);
  }

  @override
  void didUpdateWidget(_DynamicGrnTable old) {
    super.didUpdateWidget(old);
    if (old.rows != widget.rows) {
      _order = List.generate(widget.rows.length, (i) => i);
      _sortCol = null;
    }
  }

  List<String> get _visibleCols =>
      widget.columns.where((c) => !_hiddenCols.contains(c)).toList();

  void _sortBy(int visibleIdx) {
    final col = _visibleCols[visibleIdx];
    setState(() {
      if (_sortCol == visibleIdx) {
        _sortAsc = !_sortAsc;
      } else {
        _sortCol = visibleIdx;
        _sortAsc = true;
      }
      _order.sort((a, b) {
        final va = widget.rows[a].data[col]?.toString() ?? '';
        final vb = widget.rows[b].data[col]?.toString() ?? '';
        // Try numeric sort first
        final na = double.tryParse(va);
        final nb = double.tryParse(vb);
        int cmp;
        if (na != null && nb != null) {
          cmp = na.compareTo(nb);
        } else {
          cmp = va.compareTo(vb);
        }
        return _sortAsc ? cmp : -cmp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cols = _visibleCols;

    return RefreshIndicator(
      color: newBlueColor,
      onRefresh: () => Get.find<GrnListController>().fetchGrnList(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: newBorderColor),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 28),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: _columnWidths(cols, context),
                  children: [
                    // ── Header row ──────────────────────────────────────
                    TableRow(
                      decoration: BoxDecoration(color: newBlueLightColor),
                      children: [
                        // # column
                        _headerCell('#', null, null),
                        ...cols.asMap().entries.map((e) => _headerCell(
                            _formatHeader(e.value),
                            e.key,
                                () => _sortBy(e.key))),
                      ],
                    ),
                    // ── Data rows ────────────────────────────────────────
                    ..._order.asMap().entries.map((entry) {
                      final displayIdx = entry.key;
                      final rowIdx = entry.value;
                      final row = widget.rows[rowIdx];
                      final item = rowIdx < widget.items.length
                          ? widget.items[rowIdx]
                          : null;
                      final isEven = displayIdx % 2 == 0;

                      return TableRow(
                        decoration: BoxDecoration(
                          color:
                          isEven ? Colors.white : const Color(0xFFF8FAFC),
                          border: const Border(
                              top: BorderSide(color: newBorderColor)),
                        ),
                        children: [
                          // # cell
                          _indexCell(displayIdx + 1, item),
                          // Dynamic cells
                          ...cols.map(
                                  (col) => _dataCell(col, row.data[col], item)),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Column widths — smart based on header name ─────────────────────────
  Map<int, TableColumnWidth> _columnWidths(
      List<String> cols, BuildContext ctx) {
    final Map<int, TableColumnWidth> widths = {
      0: const FixedColumnWidth(40), // # column
    };
    for (int i = 0; i < cols.length; i++) {
      final col = cols[i].toLowerCase();
      double w;
      if (col.contains('no') || col.contains('date')) {
        w = 110;
      } else if (col.contains('name') || col.contains('party')) {
        w = 150;
      } else if (col.contains('amt') ||
          col.contains('amount') ||
          col.contains('total')) {
        w = 100;
      } else if (col.contains('qty') || col.contains('quantity')) {
        w = 60;
      } else {
        w = 100;
      }
      widths[i + 1] = FixedColumnWidth(w);
    }
    return widths;
  }

  // ── Header cell ────────────────────────────────────────────────────────
  Widget _headerCell(String label, int? colIdx, VoidCallback? onTap) {
    final isSorted = colIdx != null && _sortCol == colIdx;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Flexible(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor),
                overflow: TextOverflow.ellipsis),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 3),
            Icon(
              isSorted
                  ? (_sortAsc
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded)
                  : Icons.unfold_more_rounded,
              size: 12,
              color: isSorted ? newBlueColor : newTextSecondary,
            ),
          ],
        ]),
      ),
    );
  }

  // ── Index cell (row number + tap to edit) ──────────────────────────────
  Widget _indexCell(int n, GrnListItem? item) {
    return GestureDetector(
      onTap: item == null
          ? null
          : () => Get.to(() => const GrnEntryView(), arguments: item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
        alignment: Alignment.center,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
              color: newBlueLightColor, borderRadius: BorderRadius.circular(7)),
          alignment: Alignment.center,
          child: Text('$n',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: newBlueColor)),
        ),
      ),
    );
  }

  // ── Data cell — smart rendering based on value type/content ───────────
  Widget _dataCell(String col, dynamic value, GrnListItem? item) {
    return GestureDetector(
      onTap: item == null
          ? null
          : () => Get.to(() => const GrnEntryView(), arguments: item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: _renderValue(col, value),
      ),
    );
  }

  Widget _renderValue(String col, dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return const Text('—',
          style: TextStyle(color: newTextSecondary, fontSize: 12));
    }

    final str = value.toString();
    final colLower = col.toLowerCase();

    // ── Amount / money columns ─────────────────────────────────────────
    if (colLower.contains('amt') ||
        colLower.contains('amount') ||
        colLower.contains('total') && !colLower.contains('qty')) {
      final num = double.tryParse(str);
      if (num != null) {
        return Text('₹${_inrFull(num)}',
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: newTextPrimary));
      }
    }

    // ── Qty columns ────────────────────────────────────────────────────
    if (colLower.contains('qty') || colLower.contains('quantity')) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: newGreenLightColor, borderRadius: BorderRadius.circular(6)),
        child: Text(str,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: newGreenColor)),
      );
    }

    // ── Date columns ───────────────────────────────────────────────────
    if (colLower.contains('date')) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
            color: newBlueLightColor, borderRadius: BorderRadius.circular(6)),
        child: Text(str,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: newBlueColor)),
      );
    }

    // ── Grn No / Bill No ───────────────────────────────────────────────
    if (colLower.contains('Grnno') || colLower.contains('Grn')) {
      return Text(str,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: newBlueColor,
              letterSpacing: .1));
    }

    // ── Job Type ───────────────────────────────────────────────────────
    if (colLower.contains('job') || colLower.contains('type')) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
            color: newOrangeLightColor, borderRadius: BorderRadius.circular(6)),
        child: Text(str,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: newOrangeColor)),
      );
    }

    // ── Site Name ──────────────────────────────────────────────────────
    if (colLower.contains('site')) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.location_on_outlined,
            size: 11, color: newTextSecondary),
        const SizedBox(width: 3),
        Flexible(
            child: Text(str,
                style: const TextStyle(fontSize: 11, color: newTextSecondary),
                overflow: TextOverflow.ellipsis)),
      ]);
    }

    // ── Default ────────────────────────────────────────────────────────
    return Text(str,
        style: const TextStyle(fontSize: 12, color: newTextPrimary),
        overflow: TextOverflow.ellipsis,
        maxLines: 2);
  }

  // ── Format header: "PartyName" → "Party Name", "TotalAmt" → "Total Amt"
  String _formatHeader(String key) {
    return key
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .replaceAllMapped(
        RegExp(r'([A-Z]+)([A-Z][a-z])'), (m) => '${m[1]} ${m[2]}');
  }

  static String _inrFull(double v) {
    if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(2)} Cr';
    if (v >= 100000) return '${(v / 100000).toStringAsFixed(2)} L';
    final parts = v.toStringAsFixed(2).split('.');
    final whole = parts[0];
    if (whole.length <= 3) return '$whole.${parts[1]}';
    final last3 = whole.substring(whole.length - 3);
    final rest = whole.substring(0, whole.length - 3);
    final buf = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return '$buf,$last3.${parts[1]}';
  }
}

class _GrnTable extends StatefulWidget {
  final List<GrnListItem> items;
  const _GrnTable({required this.items});

  @override
  State<_GrnTable> createState() => _GrnTableState();
}

class _GrnTableState extends State<_GrnTable> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  late List<GrnListItem> _sorted;

  @override
  void initState() {
    super.initState();
    _sorted = List.from(widget.items);
  }

  @override
  void didUpdateWidget(_GrnTable old) {
    super.didUpdateWidget(old);
    if (old.items != widget.items) {
      _sorted = List.from(widget.items);
      _sortColumnIndex = null;
    }
  }

  void _sort<T>(Comparable<T> Function(GrnListItem i) getField, int colIdx) {
    setState(() {
      if (_sortColumnIndex == colIdx) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnIndex = colIdx;
        _sortAscending = true;
      }
      _sorted.sort((a, b) {
        final cmp = getField(a).compareTo(getField(b) as T);
        return _sortAscending ? cmp : -cmp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: newBlueColor,
      onRefresh: () => Get.find<GrnListController>().fetchGrnList(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: newBorderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 28),
                child: DataTable(
                  headingRowHeight: 44,
                  dataRowMinHeight: 52,
                  dataRowMaxHeight: 72,
                  columnSpacing: 16,
                  horizontalMargin: 14,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  headingRowColor: WidgetStateProperty.all(newBlueLightColor),
                  dividerThickness: 1,
                  border: TableBorder(
                    horizontalInside: BorderSide(color: newBorderColor),
                  ),
                  columns: [
                    _col('#', 0, () => _sort((i) => i.id, 0)),
                    _col('Grn No', 1, () => _sort((i) => i.GrnNo, 1)),
                    _col('Date', 2, () => _sort((i) => i.GrnDate, 2)),
                    _col('Party', 3, () => _sort((i) => i.partyName, 3)),
                    _col('Site', 4, () => _sort((i) => i.siteName, 4)),
                    _col('Job', 5, () => _sort((i) => i.jobType, 5)),
                    _col('Qty', 6, () => _sort((i) => i.totalQty, 6)),
                    _col('Amount', 7, () => _sort((i) => i.totalAmt, 7)),
                  ],
                  rows: _sorted.asMap().entries.map((entry) {
                    final i = entry.key;
                    final item = entry.value;
                    final isEven = i % 2 == 0;
                    return DataRow(
                      color: WidgetStateProperty.all(
                          isEven ? Colors.white : const Color(0xFFF8FAFC)),
                      onSelectChanged: (_) => Get.to(
                            () => const GrnEntryView(),
                        arguments: item,
                      ),
                      cells: [
                        // # (row number)
                        DataCell(Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                              color: newBlueLightColor,
                              borderRadius: BorderRadius.circular(7)),
                          alignment: Alignment.center,
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: newBlueColor)),
                        )),
                        // Grn No
                        DataCell(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.GrnNo,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: newBlueColor,
                                    letterSpacing: .1)),
                            if (item.billNo.isNotEmpty)
                              Text('Bill: ${item.billNo}',
                                  style: const TextStyle(
                                      fontSize: 10, color: newTextSecondary)),
                          ],
                        )),
                        // Date
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                              color: newBlueLightColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(item.GrnDate,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: newBlueColor)),
                        )),
                        // Party
                        DataCell(SizedBox(
                          width: 130,
                          child: Text(item.partyName,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: newTextPrimary),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        )),
                        // Site
                        DataCell(_pill(Icons.location_on_outlined,
                            item.siteName, newSurfaceColor, newTextSecondary)),
                        // Job Type
                        DataCell(item.jobType.isEmpty
                            ? const Text('—',
                            style: TextStyle(color: newTextSecondary))
                            : _pill(Icons.work_outline_rounded, item.jobType,
                            newOrangeLightColor, newOrangeColor)),
                        // Qty
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: newGreenLightColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text('${item.totalQty.toInt()}',
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: newGreenColor)),
                        )),
                        // Amount
                        DataCell(Text(
                          '₹${_inr(item.totalAmt)}',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: newTextPrimary),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataColumn _col(String label, int idx, VoidCallback onSort) {
    return DataColumn(
      onSort: (_, __) => onSort(),
      label: Text(label,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w800, color: newBlueColor)),
    );
  }

  Widget _pill(IconData icon, String label, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration:
    BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 10, color: fg),
      const SizedBox(width: 3),
      Text(label,
          style: TextStyle(
              fontSize: 9, fontWeight: FontWeight.w600, color: fg),
          overflow: TextOverflow.ellipsis),
    ]),
  );

  // static String _inr(double v) {
  //   if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(2)} Cr';
  //   if (v >= 100000) return '${(v / 100000).toStringAsFixed(2)} L';
  //   final parts = v.toStringAsFixed(2).split('.');
  //   final whole = parts[0];
  //   if (whole.length <= 3) return '$whole.${parts[1]}';
  //   final last3 = whole.substring(whole.length - 3);
  //   final rest = whole.substring(0, whole.length - 3);
  //   final buf = StringBuffer();
  //   for (int i = 0; i < rest.length; i++) {
  //     if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
  //     buf.write(rest[i]);
  //   }
  //   return '$buf,$last3.${parts[1]}';
  // }

  static String _inr(double v) {
    if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
    return '₹${v.toStringAsFixed(0)}';
  }
}
