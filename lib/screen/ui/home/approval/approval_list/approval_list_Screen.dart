// import 'dart:developer';
//
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_detail/approvel_detail_screen.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter%20screen.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_model.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_list/approvals_list_responce.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ApprovalList extends StatefulWidget {
//   const ApprovalList({super.key});
//
//   @override
//   State<ApprovalList> createState() => _ApprovalListState();
// }
//
// class _ApprovalListState extends State<ApprovalList> {
//   // Track which cards are expanded
//   final Set<int> _expandedCards = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ApprovalListController>(
//       init: ApprovalListController(),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF5F6FA),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 _buildAppBar(controller),
//                 _buildSummaryCards(controller),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'List of document',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: newTextPrimary,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: controller.isBusy
//                       ? showLoader(color: newBlueColor)
//                       : controller.isListLoading
//                           ? showLoader(color: newBlueColor)
//                           : controller.approvalListData.isEmpty
//                               ? SizedBox(
//                                   height: Get.height * .4,
//                                   child: centerText('No Approval Data found'),
//                                 )
//                               : ListView.builder(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 4),
//                                   itemCount: controller.approvalListData.length,
//                                   itemBuilder: (context, index) {
//                                     final item = controller.approvalListData
//                                         .elementAt(index);
//                                     final isExpanded =
//                                         _expandedCards.contains(index);
//                                     return _approvalCard(
//                                         item, index, isExpanded, controller);
//                                   },
//                                 ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildAppBar(ApprovalListController controller) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Get.back(),
//             child:
//                 const Icon(Icons.arrow_back_ios_new, color: newTextPrimary, size: 22),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text(
//               'Approvals',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: newTextPrimary,
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () async {
//               final filterDialog = await Get.dialog(ApprovalFilterScreen());
//               if (filterDialog != null) {
//                 final approvalFilterModels =
//                     filterDialog as ApprovalFilterModels;
//                 Get.find<ApprovalListController>()
//                     .getApprovalList(approvalFilterModels);
//               }
//               log('FILTER DIALOG ==>$filterDialog');
//             },
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: newBlueLightColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(Icons.filter_list_sharp,
//                   color: newBlueColor, size: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryCards(ApprovalListController controller) {
//     // No status field in API — show total + unique doc type counts
//     final total = controller.approvalListData.length;
//     final withAmt = controller.approvalListData
//         .where((e) => (e.totalamount ?? '').isNotEmpty && e.totalamount != '0')
//         .length;
//     final withParty = controller.approvalListData
//         .where((e) => (e.partyname ?? '').isNotEmpty)
//         .length;
//     final withRemark = controller.approvalListData
//         .where((e) => (e.lastremark ?? '').isNotEmpty)
//         .length;
//
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
//       child: Row(
//         children: [
//           _summaryChip(formatCount(total), 'Total\nDocuments',
//               newBlueColor, newBlueLightColor),
//           const SizedBox(width: 10),
//           _summaryChip(formatCount(withParty), 'With\nParty',
//               newGreenColor, newGreenLightColor),
//           const SizedBox(width: 10),
//           _summaryChip(formatCount(withRemark), 'With\nRemarks',
//               newOrangeColor, newOrangeLightColor),
//         ],
//       ),
//     );
//   }
//
//   Widget _summaryChip(String count, String label, Color color, Color bgColor) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: newBorderColor),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               decoration: BoxDecoration(
//                 color: bgColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 count,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: color,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: newTextPrimary,
//                 height: 1.4,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _approvalCard(
//     ApprovalListData data,
//     int index,
//     bool isExpanded,
//     ApprovalListController controller,
//   ) {
//     // Resolve config — backend config or fallback to default
//     final config = controller.cardConfig ?? CardConfig.defaultConfig();
//     final dataMap = data.toMap();
//
//     // Visible field lists (filtered once)
//     final visibleHeader = config.headerFields.where((f) => f.visible).toList();
//     final visibleMain = config.mainFields.where((f) => f.visible).toList();
//     final visibleExpanded =
//         config.expandedFields.where((f) => f.visible).toList();
//
//     return GestureDetector(
//       onTap: () => Get.to(() => const ApprovalDetailScreen(), arguments: data),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: newBorderColor),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             //  Header row
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: newBorderColor, width: 1.5),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//
//                   // Dynamic header fields
//                   ...visibleHeader.map((f) => Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('${f.label}: ',
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: newTextSecondary,
//                                   fontWeight: FontWeight.w400)),
//                           Text(dataMap[f.key] ?? 'N/A',
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700,
//                                   color: newTextPrimary)),
//                         ],
//                       )),
//
//                   const Spacer(),
//
//                   // Status badge
//                   if (config.showStatus)
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 5),
//                       decoration: BoxDecoration(
//                         color: newSurfaceColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Text('N/A',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: newTextSecondary)),
//                     ),
//
//                   const SizedBox(width: 8),
//
//                   // Expand toggle
//                   GestureDetector(
//                     onTap: () => setState(() {
//                       isExpanded
//                           ? _expandedCards.remove(index)
//                           : _expandedCards.add(index);
//                     }),
//                     child: Container(
//                       width: 28,
//                       height: 28,
//                       decoration: BoxDecoration(
//                         color: newBlueLightColor,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         isExpanded
//                             ? Icons.keyboard_arrow_up_rounded
//                             : Icons.keyboard_arrow_down_rounded,
//                         color: newBlueColor,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const Divider(height: 1, color: Color(0xFFEFF2F7)),
//
//             //  Dynamic main fields
//             if (visibleMain.isNotEmpty)
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                 child: _buildDynamicFieldRow(visibleMain, dataMap),
//               ),
//
//             //  Date + PDF
//             Padding(
//               padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12),
//               child: Row(
//                 children: [
//                   if (config.showDate) ...[
//                     const Icon(Icons.calendar_today_outlined,
//                         size: 14, color: newTextSecondary),
//                     const SizedBox(width: 6),
//                     Text('Date : ${data.documentDate ?? 'N/A'}',
//                         style: const TextStyle(
//                             fontSize: 13,
//                             color: newTextSecondary,
//                             fontWeight: FontWeight.w400)),
//                   ],
//                   const Spacer(),
//                   if (config.showPdf)
//                     GestureDetector(
//                       onTap: () async {
//                         final link = await Get.put<ApprovalFilterController>(
//                                 ApprovalFilterController())
//                             .getApprovalDocument(data.approvalid.toString());
//                         launchUrl(Uri.parse('$link'),
//                             mode: LaunchMode.externalApplication);
//                       },
//                       child: Image.asset('assets/iconsnew/pdfIcon.png',
//                           height: 16),
//                     ),
//                 ],
//               ),
//             ),
//
//             //  Expanded section
//             if (isExpanded) ...[
//               const Divider(height: 1, color: Color(0xFFEFF2F7)),
//               if (visibleExpanded.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
//                   child: _buildDynamicFieldRow(visibleExpanded, dataMap),
//                 ),
//               if ((data.lastremark ?? '').isNotEmpty)
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 14, right: 14, bottom: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Last Comment :',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: newTextPrimary)),
//                       const SizedBox(height: 6),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF8FAFC),
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: newBorderColor),
//                         ),
//                         child: Text(data.lastremark ?? '',
//                             style: const TextStyle(
//                                 fontSize: 13,
//                                 color: newTextSecondary,
//                                 height: 1.5)),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Renders fields two-per-row, handles any count cleanly
//   Widget _buildDynamicFieldRow(
//       List<FieldConfig> fields, Map<String, dynamic> dataMap) {
//     final rows = <Widget>[];
//     for (int i = 0; i < fields.length; i += 2) {
//       final first = fields[i];
//       final second = i + 1 < fields.length ? fields[i + 1] : null;
//       rows.add(Row(
//         children: [
//           _infoBlock(first.label, dataMap[first.key] ?? 'N/A'),
//           if (second != null) ...[
//             const SizedBox(width: 10),
//             _infoBlock(second.label, dataMap[second.key] ?? 'N/A'),
//           ] else
//             const Expanded(child: SizedBox()),
//         ],
//       ));
//       if (i + 2 < fields.length) rows.add(const SizedBox(height: 8));
//     }
//     return Column(children: rows);
//   }
//
//   Widget _infoBlock(String label, String value) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: newBlueLightColor,
//           borderRadius: BorderRadius.circular(8),
//           border: Border(
//             left: BorderSide(color: newBlueColor, width: 3),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(label,
//                 style: const TextStyle(
//                     fontSize: 11,
//                     color: newTextSecondary,
//                     fontWeight: FontWeight.w400)),
//             const SizedBox(height: 2),
//             Text(value,
//                 style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: newTextPrimary)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// String formatCount(int value) {
//   if (value > 999) return "999+";
//   return value.toString().padLeft(2, '0');
// }
