// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../../../utils/show_message.dart';
// import '../grn_controller/additional_charge_model.dart';
// import '../grn_controller/grn_controller.dart';
// import '../grn_response/grn_models.dart';
// import '../grn_widgets.dart';
// import 'grn_direct_item_form.dart';
//
// class GrnItemsScreen extends StatelessWidget {
//   const GrnItemsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GrnController>(builder: (ctrl) {
//       return Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: SafeArea(
//           child: Column(children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 keyboardDismissBehavior:
//                 ScrollViewKeyboardDismissBehavior.onDrag,
//                 padding: EdgeInsets.fromLTRB(
//                   14,
//                   14,
//                   14,
//                   MediaQuery.of(context).viewInsets.bottom + 110,
//                 ),
//                 child: Column(children: [
//                   // ── Direct purchase — show entry form ──────────────────
//                   if (ctrl.selectedSource == GrnSourceType.grn)
//                     const GrnDirectItemForm(),
//
//                   _AttachmentsCard(ctrl: ctrl, context: context),
//                   const SizedBox(height: 14),
//
//                   _AdditionalChargesCard(ctrl: ctrl),
//
//                  // _AdditionalChargesCard(ctrl: ctrl),
//
//                 ]),
//               ),
//             ),
//
//            // _AttachmentsCard(ctrl: ctrl, context: context),
//
//             // ── Bottom CTA ───────────────────────────────────────────────
//             if (MediaQuery.of(context).viewInsets.bottom == 0) _bottomBar(ctrl),
//           ]),
//         ),
//       );
//     });
//   }
//
//   // ── Totals footer ──────────────────────────────────────────────────────────
//   Widget _totalsFooter(GrnController ctrl) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: const BoxDecoration(
//           color: newSurfaceColor,
//           border: Border(top: BorderSide(color: newBorderColor))),
//       child: Column(children: [
//         _totalRow('Subtotal', GrnUtils.inr(ctrl.subtotal)),
//         const SizedBox(height: 6),
//         _totalRow('Total GST', GrnUtils.inr(ctrl.totalGst)),
//         const Divider(height: 16, color: newBorderColor),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Grand Total',
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w800,
//                     color: newTextPrimary)),
//             Text(GrnUtils.inr(ctrl.grandTotal),
//                 style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w800,
//                     color: newBlueColor)),
//           ],
//         ),
//       ]),
//     );
//   }
//
//   Widget _totalRow(String label, String val) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label,
//             style: const TextStyle(fontSize: 12, color: newTextSecondary)),
//         Text(val,
//             style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w700,
//                 color: newTextPrimary)),
//       ],
//     );
//   }
//
//   // ── Bottom bar ─────────────────────────────────────────────────────────────
//   Widget _bottomBar(GrnController ctrl) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: newBorderColor))),
//       child: SafeArea(
//         top: false,
//         child: GrnPrimaryBtn(
//           label: 'Review & Submit →',
//           icon: Icons.arrow_forward_rounded,
//           onTap: () {
//             if (ctrl.itemLines.isEmpty) {
//               ShowMessage.showSnackBar(
//                 'No Items',
//                 ctrl.selectedSource == GrnSourceType.grn
//                     ? 'Please select and process a GRN'
//                     : 'Please add at least one item', // covers both Direct and GRN
//               );
//               return;
//             }
//             if (ctrl.itemLines.any((i) => i.receiveNowQty <= 0)) {
//               ShowMessage.showSnackBar(
//                   'Invalid Qty', 'All items must have received qty > 0');
//               return;
//             }
//             ctrl.nextStep();
//           },
//         ),
//       ),
//     );
//   }
//
//   // ── Shimmer placeholders ───────────────────────────────────────────────────
//   Widget _poShimmer() => Column(
//     children: List.generate(
//         3,
//             (i) => Container(
//           height: 60,
//           margin: const EdgeInsets.only(bottom: 8),
//           decoration: BoxDecoration(
//               color: newBorderColor,
//               borderRadius: BorderRadius.circular(12)),
//         )),
//   );
//
//   Widget _itemsShimmer() => Column(
//     children: List.generate(
//         3,
//             (i) => Container(
//           height: 70,
//           margin: const EdgeInsets.only(bottom: 8),
//           decoration: BoxDecoration(
//               color: newBorderColor,
//               borderRadius: BorderRadius.circular(10)),
//         )),
//   );
//
//   Widget _emptyState(String msg, IconData icon) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 20),
//     child: Column(children: [
//       Icon(icon, size: 36, color: newBorderColor),
//       const SizedBox(height: 8),
//       Text(msg,
//           style: const TextStyle(fontSize: 13, color: newTextSecondary)),
//     ]),
//   );
//
//   Widget _countBadge(int count, String label) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
//     decoration: BoxDecoration(
//         color: newBlueLightColor, borderRadius: BorderRadius.circular(20)),
//     child: Text('$count $label',
//         style: const TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.w700,
//             color: newBlueColor)),
//   );
//
//   // ── REMOVE this entire broken _inr ────────────────────────────────────────
//   // ✅ Fixed Indian number formatter
//   static String _inr(double v) {
//     if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(2)} Cr';
//     if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(2)} L';
//
//     final parts = v.toStringAsFixed(2).split('.');
//     final whole = parts[0];
//     final decimal = parts[1];
//
//     if (whole.length <= 3) return '₹$whole.$decimal';
//
//     // Indian format: last 3 digits, then groups of 2 from right
//     final last3 = whole.substring(whole.length - 3);
//     final rest = whole.substring(0, whole.length - 3);
//     final buf = StringBuffer();
//     for (int i = 0; i < rest.length; i++) {
//       if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
//       buf.write(rest[i]);
//     }
//     return '₹$buf,$last3.$decimal';
//   }
// }
//
//
//
// class _AdditionalChargesCard extends StatelessWidget {
//   final GrnController ctrl;
//   const _AdditionalChargesCard({super.key, required this.ctrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return GrnCard(
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // ── Header row ──────────────────────────────────────────────────────
//         Row(children: [
//           const Expanded(
//             child: GrnSectionHead('Other Details / Additional Charges'),
//           ),
//           GestureDetector(
//             onTap: ctrl.addAdditionalCharge,
//             child: Container(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//               decoration: BoxDecoration(
//                 color: newBlueColor,
//                 borderRadius: BorderRadius.circular(9),
//               ),
//               child: const Row(mainAxisSize: MainAxisSize.min, children: [
//                 Icon(Icons.add_rounded, size: 14, color: Colors.white),
//                 SizedBox(width: 5),
//                 Text('Add Row',
//                     style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white)),
//               ]),
//             ),
//           ),
//         ]),
//         const SizedBox(height: 4),
//
//         // ── Subtitle ────────────────────────────────────────────────────────
//         const Text(
//           'Add freight, taxes, discounts or any other adjustments. '
//               'Each row is applied sequentially to compute the final total.',
//           style: TextStyle(fontSize: 11, color: newTextSecondary),
//         ),
//         const SizedBox(height: 14),
//
//         // ── Empty state ─────────────────────────────────────────────────────
//         if (ctrl.additionalCharges.isEmpty)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 22),
//             decoration: BoxDecoration(
//               color: newSurfaceColor,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: newBorderColor),
//             ),
//             child: Column(children: [
//               Icon(Icons.receipt_long_outlined,
//                   size: 32, color: newBorderColor),
//               const SizedBox(height: 8),
//               const Text('No additional charges added.',
//                   style: TextStyle(fontSize: 12, color: newTextSecondary)),
//               const SizedBox(height: 4),
//               const Text('Tap "Add Row" to add freight, taxes, discounts…',
//                   style: TextStyle(fontSize: 11, color: newTextHint)),
//             ]),
//           )
//         else ...[
//           // ── Column header ──────────────────────────────────────────────
//           _tableHeader(),
//           const SizedBox(height: 4),
//
//           // ── Charge rows ────────────────────────────────────────────────
//           ...ctrl.additionalCharges.asMap().entries.map((e) =>
//               _ChargeRow(
//                 key: ValueKey(e.value.localId),
//                 charge: e.value,
//                 index: e.key,
//                 ctrl: ctrl,
//               )),
//
//           const SizedBox(height: 10),
//
//           // ── Totals summary ─────────────────────────────────────────────
//           _chargeSummary(),
//         ],
//       ]),
//     );
//   }
//
//   // ── Column header ──────────────────────────────────────────────────────────
//   Widget _tableHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//       decoration: BoxDecoration(
//         color: newBlueLightColor,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: newBlueColor.withValues(alpha: 0.25)),
//       ),
//       child: const Row(children: [
//         SizedBox(width: 26), // index
//         SizedBox(width: 8),
//         Expanded(
//             flex: 3,
//             child: Text('Head',
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w800,
//                     color: newBlueColor))),
//         SizedBox(
//             width: 46,
//             child: Text('Nature',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w800,
//                     color: newBlueColor))),
//         SizedBox(width: 6),
//         SizedBox(
//             width: 56,
//             child: Text('Value',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w800,
//                     color: newBlueColor))),
//         SizedBox(width: 6),
//         SizedBox(
//             width: 64,
//             child: Text('Amount',
//                 textAlign: TextAlign.right,
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w800,
//                     color: newBlueColor))),
//         SizedBox(width: 8),
//         SizedBox(
//             width: 48,
//             child: Text('Actions',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w800,
//                     color: newBlueColor))),
//       ]),
//     );
//   }
//
//   // ── Charges net summary ────────────────────────────────────────────────────
//   Widget _chargeSummary() {
//     final gross = ctrl.additionalChargesGross;
//     final deduct = ctrl.additionalChargesDeduct;
//     final net = ctrl.additionalChargesTotal;
//     final isNetPositive = net >= 0;
//
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: newSurfaceColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: newBorderColor),
//       ),
//       child: Column(children: [
//         _summaryRow(
//             Icons.add_circle_outline_rounded,
//             newGreenColor,
//             'Total Additions',
//             '+${_inr(gross)}'),
//         const SizedBox(height: 6),
//         _summaryRow(
//             Icons.remove_circle_outline_rounded,
//             newRedColor,
//             'Total Deductions',
//             '-${_inr(deduct)}'),
//         const Divider(height: 14, color: newBorderColor),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Net Adjustment',
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w800,
//                     color: newTextPrimary)),
//             Text(
//               '${isNetPositive ? "+" : ""}${_inr(net)}',
//               style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w800,
//                   color: isNetPositive ? newGreenColor : newRedColor),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
//
//   Widget _summaryRow(IconData icon, Color color, String label, String val) =>
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(children: [
//             Icon(icon, size: 13, color: color),
//             const SizedBox(width: 5),
//             Text(label,
//                 style:
//                 const TextStyle(fontSize: 11, color: newTextSecondary)),
//           ]),
//           Text(val,
//               style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700,
//                   color: color)),
//         ],
//       );
//
//   static String _inr(double v) {
//     if (v < 0) return '-${_inr(-v)}';
//     if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(2)} Cr';
//     if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(2)} L';
//     final parts = v.toStringAsFixed(2).split('.');
//     final whole = parts[0];
//     final decimal = parts[1];
//     if (whole.length <= 3) return '₹$whole.$decimal';
//     final last3 = whole.substring(whole.length - 3);
//     final rest = whole.substring(0, whole.length - 3);
//     final buf = StringBuffer();
//     for (int i = 0; i < rest.length; i++) {
//       if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
//       buf.write(rest[i]);
//     }
//     return '₹$buf,$last3.$decimal';
//   }
// }
//
// // ═══════════════════════════════════════════════════════════════════════════════
// // Single charge row widget
// // ═══════════════════════════════════════════════════════════════════════════════
// class _ChargeRow extends StatelessWidget {
//   final AdditionalCharge charge;
//   final int index;
//   final GrnController ctrl;
//
//   const _ChargeRow({
//     super.key,
//     required this.charge,
//     required this.index,
//     required this.ctrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isPlus = charge.nature == ChargeNature.plus;
//     final amt = charge.calculatedAmount;
//     final hasHead = charge.head != null;
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 4),
//       decoration: BoxDecoration(
//         color: hasHead ? Colors.white : newSurfaceColor,
//         borderRadius: BorderRadius.circular(9),
//         border: Border.all(
//           color: hasHead ? newBorderColor : newBorderColor.withValues(alpha: 0.5),
//         ),
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // ── Compact summary row ──────────────────────────────────────────────
//         Padding(
//           padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//           child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Index bubble
//                 Container(
//                   width: 26,
//                   height: 26,
//                   decoration: BoxDecoration(
//                       color: newBlueLightColor,
//                       borderRadius: BorderRadius.circular(7)),
//                   alignment: Alignment.center,
//                   child: Text('${index + 1}',
//                       style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w800,
//                           color: newBlueColor)),
//                 ),
//                 const SizedBox(width: 8),
//
//                 // Head name (or placeholder)
//                 Expanded(
//                   flex: 3,
//                   child: GestureDetector(
//                     onTap: () => _showEditSheet(context),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             charge.head?.label ?? '— Tap to configure —',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700,
//                                 color: hasHead ? newTextPrimary : newTextHint),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           if (charge.dependsOnLabel != null) ...[
//                             const SizedBox(height: 2),
//                             Row(children: [
//                               const Icon(Icons.link_rounded,
//                                   size: 10, color: newTextSecondary),
//                               const SizedBox(width: 3),
//                               Flexible(
//                                 child: Text(
//                                   'On: ${charge.dependsOnLabel}',
//                                   style: const TextStyle(
//                                       fontSize: 9, color: newTextSecondary),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ]),
//                           ],
//                         ]),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//
//                 // Nature badge
//                 SizedBox(
//                   width: 46,
//                   child: Center(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: isPlus ? newGreenLightColor : newRedLightColor,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         isPlus ? '+ADD' : '−LESS',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 9,
//                             fontWeight: FontWeight.w800,
//                             color: isPlus ? newGreenColor : newRedColor),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//
//                 // Value display
//                 SizedBox(
//                   width: 56,
//                   child: Text(
//                     charge.calcType == ChargeCalcType.percentage
//                         ? '${charge.value.toStringAsFixed(1)}%'
//                         : '₹${charge.value.toStringAsFixed(2)}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w700,
//                         color: newTextPrimary),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//
//                 // Computed amount
//                 SizedBox(
//                   width: 64,
//                   child: Text(
//                     '${isPlus ? "+" : "−"}₹${amt.toStringAsFixed(2)}',
//                     textAlign: TextAlign.right,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: isPlus ? newGreenColor : newRedColor),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//
//                 // Action buttons
//                 SizedBox(
//                   width: 48,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () => _showEditSheet(context),
//                         child: Container(
//                           width: 22,
//                           height: 26,
//                           decoration: BoxDecoration(
//                               color: newBlueLightColor,
//                               borderRadius: BorderRadius.circular(6)),
//                           alignment: Alignment.center,
//                           child: const Icon(Icons.edit_rounded,
//                               size: 12, color: newBlueColor),
//                         ),
//                       ),
//                       const SizedBox(width: 3),
//                       GestureDetector(
//                         onTap: () => ctrl.removeAdditionalCharge(charge.localId),
//                         child: Container(
//                           width: 22,
//                           height: 26,
//                           decoration: BoxDecoration(
//                               color: newRedLightColor,
//                               borderRadius: BorderRadius.circular(6)),
//                           alignment: Alignment.center,
//                           child: const Icon(Icons.delete_outline_rounded,
//                               size: 12, color: newRedColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//         ),
//       ]),
//     );
//   }
//
//   void _showEditSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => _ChargeEditSheet(
//         ctrl: ctrl,
//         charge: charge,
//       ),
//     );
//   }
// }
//
// // ═══════════════════════════════════════════════════════════════════════════════
// // Bottom sheet for adding / editing a charge row
// // ═══════════════════════════════════════════════════════════════════════════════
// class _ChargeEditSheet extends StatefulWidget {
//   final GrnController ctrl;
//   final AdditionalCharge charge;
//
//   const _ChargeEditSheet({required this.ctrl, required this.charge});
//
//   @override
//   State<_ChargeEditSheet> createState() => _ChargeEditSheetState();
// }
//
// class _ChargeEditSheetState extends State<_ChargeEditSheet> {
//   late AdditionalChargeHead? _head;
//   late ChargeNature _nature;
//   late ChargeCalcType _calcType;
//   late String? _dependsOnLocalId;
//   late String? _dependsOnLabel;
//
//   final TextEditingController _valuCtrl = TextEditingController();
//   String _headSearch = '';
//
//   @override
//   void initState() {
//     super.initState();
//     final c = widget.charge;
//     _head = c.head;
//     _nature = c.nature;
//     _calcType = c.calcType;
//     _dependsOnLocalId = c.dependsOnLocalId;
//     _dependsOnLabel = c.dependsOnLabel;
//     _valuCtrl.text =
//     c.value > 0 ? c.value.toStringAsFixed(2) : '';
//   }
//
//   @override
//   void dispose() {
//     _valuCtrl.dispose();
//     super.dispose();
//   }
//
//   void _save() {
//     final val = double.tryParse(_valuCtrl.text) ?? 0.0;
//     final updated = widget.charge.copyWith(
//       head: _head,
//       nature: _nature,
//       calcType: _calcType,
//       value: val,
//       dependsOnLocalId: _dependsOnLocalId,
//       dependsOnLabel: _dependsOnLabel,
//     );
//     widget.ctrl.updateAdditionalCharge(updated);
//     Get.back();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       initialChildSize: 0.88,
//       minChildSize: 0.5,
//       maxChildSize: 0.95,
//       builder: (_, scrollCtrl) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(children: [
//             // Handle
//             const SizedBox(height: 10),
//             Container(
//               width: 38,
//               height: 4,
//               decoration: BoxDecoration(
//                   color: newBorderColor,
//                   borderRadius: BorderRadius.circular(2)),
//             ),
//             const SizedBox(height: 14),
//             // Title
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(children: [
//                 const Expanded(
//                   child: Text('Configure Charge',
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w800,
//                           color: newTextPrimary)),
//                 ),
//                 GestureDetector(
//                   onTap: Get.back,
//                   child: const Icon(Icons.close_rounded,
//                       size: 20, color: newTextSecondary),
//                 ),
//               ]),
//             ),
//             const Divider(height: 18, color: newBorderColor),
//
//             Expanded(
//               child: ListView(
//                 controller: scrollCtrl,
//                 padding: EdgeInsets.fromLTRB(
//                   16,
//                   0,
//                   16,
//                   MediaQuery.of(context).viewInsets.bottom + 16,
//                 ),
//                 children: [
//                   // ── Step 1: Select charge head ─────────────────────────
//                   _sectionLabel('1. Charge Head'),
//                   const SizedBox(height: 6),
//                   _headSelector(),
//                   const SizedBox(height: 16),
//
//                   // ── Step 2: Nature ──────────────────────────────────────
//                   _sectionLabel('2. Nature'),
//                   const SizedBox(height: 6),
//                   _natureToggle(),
//                   const SizedBox(height: 16),
//
//                   // ── Step 3: Calculation type ────────────────────────────
//                   _sectionLabel('3. Calculation Type'),
//                   const SizedBox(height: 6),
//                   _calcTypeToggle(),
//                   const SizedBox(height: 16),
//
//                   // ── Step 4: Value ───────────────────────────────────────
//                   _sectionLabel(
//                     _calcType == ChargeCalcType.percentage
//                         ? '4. Percentage (%)'
//                         : '4. Fixed Amount (₹)',
//                   ),
//                   const SizedBox(height: 6),
//                   _valueField(),
//                   const SizedBox(height: 16),
//
//                   // ── Step 5: Depends On (only for %) ────────────────────
//                   if (_calcType == ChargeCalcType.percentage) ...[
//                     _sectionLabel('5. Apply % On (Depends On)'),
//                     const SizedBox(height: 6),
//                     _dependsOnSelector(),
//                     const SizedBox(height: 16),
//                   ],
//
//                   // ── Preview ─────────────────────────────────────────────
//                   _previewCard(),
//                   const SizedBox(height: 20),
//
//                   // ── Save ────────────────────────────────────────────────
//                   GestureDetector(
//                     onTap: _save,
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       decoration: BoxDecoration(
//                         color: newBlueColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       alignment: Alignment.center,
//                       child: const Text('Save Charge',
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w800,
//                               color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ]),
//         );
//       },
//     );
//   }
//
//   // ── Head selector ──────────────────────────────────────────────────────────
//   Widget _headSelector() {
//     if (widget.ctrl.isLoadingChargeHeads) {
//       return const Center(
//           child: SizedBox(
//               width: 20,
//               height: 20,
//               child: CircularProgressIndicator(
//                   strokeWidth: 1.5, color: newBlueColor)));
//     }
//
//     final filtered = widget.ctrl.chargeHeadList
//         .where((h) =>
//         h.label.toLowerCase().contains(_headSearch.toLowerCase()))
//         .toList();
//
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       // Search
//       TextField(
//         onChanged: (v) => setState(() => _headSearch = v),
//         decoration: InputDecoration(
//           hintText: 'Search charge head…',
//           hintStyle: const TextStyle(fontSize: 13, color: newTextHint),
//           prefixIcon:
//           const Icon(Icons.search, size: 18, color: newTextSecondary),
//           filled: true,
//           fillColor: newSurfaceColor,
//           contentPadding: const EdgeInsets.symmetric(vertical: 10),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: newBorderColor)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: newBorderColor)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//               const BorderSide(color: newBlueColor, width: 1.5)),
//         ),
//       ),
//       const SizedBox(height: 8),
//       // Head list
//       Container(
//         decoration: BoxDecoration(
//           color: newSurfaceColor,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: newBorderColor),
//         ),
//         child: Column(
//           children: filtered.asMap().entries.map((e) {
//             final h = e.value;
//             final isSelected = _head?.id == h.id;
//             return Column(children: [
//               if (e.key > 0)
//                 const Divider(height: 1, color: newBorderColor),
//               InkWell(
//                 onTap: () => setState(() => _head = h),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 12, vertical: 10),
//                   child: Row(children: [
//                     Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                           color: isSelected
//                               ? newBlueLightColor
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: newBorderColor)),
//                       alignment: Alignment.center,
//                       child: Text(
//                         h.id.padLeft(2, '0'),
//                         style: TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w700,
//                             color: isSelected
//                                 ? newBlueColor
//                                 : newTextSecondary),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Text(h.label,
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: isSelected
//                                   ? FontWeight.w700
//                                   : FontWeight.w500,
//                               color: isSelected
//                                   ? newBlueColor
//                                   : newTextPrimary)),
//                     ),
//                     if (isSelected)
//                       const Icon(Icons.check_circle_rounded,
//                           size: 18, color: newBlueColor),
//                   ]),
//                 ),
//               ),
//             ]);
//           }).toList(),
//         ),
//       ),
//     ]);
//   }
//
//   // ── Nature toggle ──────────────────────────────────────────────────────────
//   Widget _natureToggle() {
//     return Row(children: [
//       _toggleOption(
//         label: '+ Add (Plus)',
//         icon: Icons.add_circle_outline_rounded,
//         selected: _nature == ChargeNature.plus,
//         selectedColor: newGreenColor,
//         selectedBg: newGreenLightColor,
//         onTap: () => setState(() => _nature = ChargeNature.plus),
//       ),
//       const SizedBox(width: 10),
//       _toggleOption(
//         label: '− Less (Deduct)',
//         icon: Icons.remove_circle_outline_rounded,
//         selected: _nature == ChargeNature.less,
//         selectedColor: newRedColor,
//         selectedBg: newRedLightColor,
//         onTap: () => setState(() => _nature = ChargeNature.less),
//       ),
//     ]);
//   }
//
//   // ── Calc type toggle ───────────────────────────────────────────────────────
//   Widget _calcTypeToggle() {
//     return Row(children: [
//       _toggleOption(
//         label: 'Fixed Amount',
//         icon: Icons.currency_rupee_rounded,
//         selected: _calcType == ChargeCalcType.fixed,
//         selectedColor: newBlueColor,
//         selectedBg: newBlueLightColor,
//         onTap: () => setState(() {
//           _calcType = ChargeCalcType.fixed;
//           _dependsOnLocalId = null;
//           _dependsOnLabel = null;
//         }),
//       ),
//       const SizedBox(width: 10),
//       _toggleOption(
//         label: 'Percentage (%)',
//         icon: Icons.percent_rounded,
//         selected: _calcType == ChargeCalcType.percentage,
//         selectedColor: newOrangeColor,
//         selectedBg: newOrangeLightColor,
//         onTap: () => setState(() => _calcType = ChargeCalcType.percentage),
//       ),
//     ]);
//   }
//
//   Widget _toggleOption({
//     required String label,
//     required IconData icon,
//     required bool selected,
//     required Color selectedColor,
//     required Color selectedBg,
//     required VoidCallback onTap,
//   }) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 150),
//           padding:
//           const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           decoration: BoxDecoration(
//             color: selected ? selectedBg : newSurfaceColor,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: selected
//                   ? selectedColor
//                   : newBorderColor,
//               width: selected ? 1.5 : 1,
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon,
//                   size: 16,
//                   color: selected ? selectedColor : newTextSecondary),
//               const SizedBox(width: 6),
//               Flexible(
//                 child: Text(label,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: selected
//                             ? selectedColor
//                             : newTextSecondary)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ── Value field ────────────────────────────────────────────────────────────
//   Widget _valueField() {
//     return TextField(
//       controller: _valuCtrl,
//       keyboardType:
//       const TextInputType.numberWithOptions(decimal: true),
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
//       ],
//       onChanged: (_) => setState(() {}),
//       decoration: InputDecoration(
//         hintText: _calcType == ChargeCalcType.percentage
//             ? 'e.g. 2.5  (for 2.5%)'
//             : 'e.g. 100  (for ₹100)',
//         hintStyle:
//         const TextStyle(fontSize: 13, color: newTextHint),
//         prefixIcon: Icon(
//           _calcType == ChargeCalcType.percentage
//               ? Icons.percent_rounded
//               : Icons.currency_rupee_rounded,
//           size: 18,
//           color: newTextSecondary,
//         ),
//         filled: true,
//         fillColor: newSurfaceColor,
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: newBorderColor)),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: newBorderColor)),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:
//             const BorderSide(color: newBlueColor, width: 1.5)),
//       ),
//     );
//   }
//
//   // ── Depends On selector (only for %) ──────────────────────────────────────
//   Widget _dependsOnSelector() {
//     // Build available bases: item subtotal + all previously added charges
//     final prevCharges = widget.ctrl.additionalCharges
//         .where((c) => c.localId != widget.charge.localId && c.head != null)
//         .toList();
//
//     return Container(
//       decoration: BoxDecoration(
//         color: newSurfaceColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: newBorderColor),
//       ),
//       child: Column(children: [
//         // Option: Item Subtotal
//         _dependsOption(
//           id: null,
//           label: 'Item Subtotal (Base)',
//           subtitle: '₹${widget.ctrl.subtotal.toStringAsFixed(2)}',
//           icon: Icons.inventory_2_outlined,
//           color: newBlueColor,
//         ),
//         if (prevCharges.isNotEmpty) ...[
//           const Divider(height: 1, color: newBorderColor),
//           // Previously added charges
//           ...prevCharges.asMap().entries.map((e) {
//             final c = e.value;
//             final isPlus = c.nature == ChargeNature.plus;
//             return Column(children: [
//               if (e.key > 0)
//                 const Divider(height: 1, color: newBorderColor),
//               _dependsOption(
//                 id: c.localId,
//                 label: c.head?.label ?? '—',
//                 subtitle:
//                 '${isPlus ? "+" : "−"}₹${c.calculatedAmount.toStringAsFixed(2)}',
//                 icon: isPlus
//                     ? Icons.add_circle_outline_rounded
//                     : Icons.remove_circle_outline_rounded,
//                 color: isPlus ? newGreenColor : newRedColor,
//               ),
//             ]);
//           }),
//         ],
//       ]),
//     );
//   }
//
//   Widget _dependsOption({
//     required String? id,
//     required String label,
//     required String subtitle,
//     required IconData icon,
//     required Color color,
//   }) {
//     final isSelected = _dependsOnLocalId == id;
//     return InkWell(
//       onTap: () => setState(() {
//         _dependsOnLocalId = id;
//         _dependsOnLabel = id == null ? 'Item Subtotal' : label;
//       }),
//       child: Padding(
//         padding:
//         const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         child: Row(children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//                 color: isSelected ? color.withValues(alpha: 0.12) : Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                     color:
//                     isSelected ? color : newBorderColor)),
//             alignment: Alignment.center,
//             child: Icon(icon, size: 16, color: color),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(label,
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: isSelected
//                               ? FontWeight.w700
//                               : FontWeight.w500,
//                           color: isSelected ? color : newTextPrimary)),
//                   Text(subtitle,
//                       style: const TextStyle(
//                           fontSize: 10, color: newTextSecondary)),
//                 ]),
//           ),
//           if (isSelected)
//             Icon(Icons.check_circle_rounded, size: 18, color: color),
//         ]),
//       ),
//     );
//   }
//
//   // ── Preview card ───────────────────────────────────────────────────────────
//   Widget _previewCard() {
//     final val = double.tryParse(_valuCtrl.text) ?? 0.0;
//
//     // Compute preview amount.
//     double base = widget.ctrl.subtotal;
//     if (_calcType == ChargeCalcType.percentage && _dependsOnLocalId != null) {
//       final dep = widget.ctrl.additionalCharges
//           .firstWhereOrNull((c) => c.localId == _dependsOnLocalId);
//       if (dep != null) base = dep.calculatedAmount;
//     }
//     final computed = _calcType == ChargeCalcType.percentage
//         ? (val / 100.0) * base
//         : val;
//     final isPlus = _nature == ChargeNature.plus;
//
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isPlus ? newGreenLightColor : newRedLightColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: isPlus
//               ? newGreenColor.withValues(alpha: 0.4)
//               : newRedColor.withValues(alpha: 0.4),
//         ),
//       ),
//       child: Row(children: [
//         Icon(
//           isPlus
//               ? Icons.add_circle_rounded
//               : Icons.remove_circle_rounded,
//           color: isPlus ? newGreenColor : newRedColor,
//           size: 24,
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   _head?.label ?? 'Preview',
//                   style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: isPlus ? newGreenColor : newRedColor),
//                 ),
//                 if (_calcType == ChargeCalcType.percentage)
//                   Text(
//                     '$val% of ₹${base.toStringAsFixed(2)} = ₹${computed.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                         fontSize: 10, color: newTextSecondary),
//                   ),
//               ]),
//         ),
//         Text(
//           '${isPlus ? "+" : "−"}₹${computed.toStringAsFixed(2)}',
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w800,
//               color: isPlus ? newGreenColor : newRedColor),
//         ),
//       ]),
//     );
//   }
//
//   // ── Helper ─────────────────────────────────────────────────────────────────
//   Widget _sectionLabel(String text) => Text(
//     text,
//     style: const TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.w800,
//         color: newTextPrimary),
//   );
// }
//
//
//
//
// // ═══════════════════════════════════════════════════════════════════════════════
// // Attachments card — shown in BOTH PO and Direct modes
// // ═══════════════════════════════════════════════════════════════════════════════
// class _AttachmentsCard extends StatelessWidget {
//   final GrnController ctrl;
//   final BuildContext context;
//   const _AttachmentsCard({required this.ctrl, required this.context});
//
//   @override
//   Widget build(BuildContext context) {
//     return GrnCard(
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const GrnSectionHead('Attachments'),
//
//         // Attachment Type checklist
//         _attachmentTypeChecklist(ctrl),
//         const SizedBox(height: 12),
//
//         // Bill Attachment
//         ...ctrl.documentTypeList.expand((docType) {
//           final isSelected = ctrl.selectedDocumentTypeIds.contains(docType.id);
//           if (!isSelected) return <Widget>[];
//
//           // Map doc type to the right attachments/callbacks
//           final isBillType = docType.label.toLowerCase().contains('invoice') ||
//               docType.label.toLowerCase().contains('bill');
//           // For simplicity: first doc type → bill slot, second → challan slot
//           // Or match by name:
//           final docs = isBillType ? ctrl.billAttachments : ctrl.challanAttachments;
//           final existingUrls = isBillType ? ctrl.existingBillFiles : ctrl.existingDcFiles;
//           final onCamera = isBillType ? ctrl.pickBillFromCamera : ctrl.pickChallanFromCamera;
//           final onGallery = isBillType ? ctrl.pickBillFromGallery : ctrl.pickChallanFromGallery;
//           final onFile = isBillType ? ctrl.pickBillFile : ctrl.pickChallanFile;
//           final onRemove = isBillType ? ctrl.removeBillAttachment : ctrl.removeChallanAttachment;
//           final onRemoveExisting = isBillType ? ctrl.removeExistingBillFile : ctrl.removeExistingDcFile;
//
//           return [
//             _attachmentSection(
//               context: context,
//               label: '${docType.label} Attachment',
//               docs: docs,
//               existingUrls: existingUrls,
//               onCamera: onCamera,
//               onGallery: onGallery,
//               onFile: onFile,
//               onRemove: onRemove,
//               onRemoveExisting: onRemoveExisting,
//             ),
//             const SizedBox(height: 12),
//           ];
//         }).toList(),
//
//         // Reason for N/A
//         if (ctrl.billAttachments.isEmpty &&
//             ctrl.challanAttachments.isEmpty &&
//             ctrl.existingBillFiles.isEmpty &&
//             ctrl.existingDcFiles.isEmpty) ...[
//           GrnField(
//             label: 'Reason for N/A Attachment',
//             controller: ctrl.reasonNACtrl,
//             hint: 'Explain why no attachment is available…',
//             minLines: 3,
//           ),
//         ],
//       ]),
//     );
//   }
//
//   // ── Checklist ──────────────────────────────────────────────────────────────
//   Widget _attachmentTypeChecklist(GrnController ctrl) {
//     if (ctrl.isLoadingDocumentTypes) {
//       return const SizedBox(
//         height: 40,
//         child: Center(
//           child: SizedBox(
//             width: 16, height: 16,
//             child: CircularProgressIndicator(strokeWidth: 1.5, color: newBlueColor),
//           ),
//         ),
//       );
//     }
//
//     if (ctrl.documentTypeList.isEmpty) return const SizedBox.shrink();
//
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       const Text('Document Type',
//           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: newTextPrimary)),
//       const SizedBox(height: 5),
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         decoration: BoxDecoration(
//           color: newSurfaceColor,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: newBorderColor),
//         ),
//         child: Column(
//           children: ctrl.documentTypeList.asMap().entries.map((entry) {
//             final i = entry.key;
//             final doc = entry.value;
//             final checked = ctrl.selectedDocumentTypeIds.contains(doc.id);
//             return Column(children: [
//               if (i > 0) const Divider(height: 1, color: newBorderColor),
//               _checkItem(
//                 label: doc.label,
//                 checked: checked,
//                 onTap: () => ctrl.toggleDocumentType(doc.id),
//               ),
//             ]);
//           }).toList(),
//         ),
//       ),
//     ]);
//   }
//
//   Widget _checkItem(
//       {required String label,
//         required bool checked,
//         required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Row(children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 150),
//             width: 18,
//             height: 18,
//             decoration: BoxDecoration(
//               color: checked ? newBlueColor : Colors.white,
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(
//                 color: checked ? newBlueColor : newBorderColor,
//                 width: 1.5,
//               ),
//             ),
//             alignment: Alignment.center,
//             child: checked
//                 ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
//                 : null,
//           ),
//           const SizedBox(width: 10),
//           Text(label,
//               style: const TextStyle(fontSize: 13, color: newTextPrimary)),
//         ]),
//       ),
//     );
//   }
//
//   // ── Attachment section (upload row + file chips) ───────────────────────────
//   Widget _attachmentSection({
//     required BuildContext context,
//     required String label,
//     required List<GrnDocument> docs,
//     required List<String> existingUrls,
//     required VoidCallback onCamera,
//     required VoidCallback onGallery,
//     required VoidCallback onFile,
//     required void Function(String id) onRemove,
//     required void Function(int index) onRemoveExisting,
//   }) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Text(label,
//           style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//               color: newTextPrimary)),
//       const SizedBox(height: 6),
//
//       // Existing server files
//       if (existingUrls.isNotEmpty) ...[
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: newGreenLightColor,
//             borderRadius: BorderRadius.circular(7),
//           ),
//           child: Row(children: [
//             const Icon(Icons.cloud_done_rounded,
//                 size: 12, color: newGreenColor),
//             const SizedBox(width: 5),
//             Text('${existingUrls.length} file(s) already on server',
//                 style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: newGreenColor)),
//           ]),
//         ),
//         const SizedBox(height: 6),
//         ...existingUrls.asMap().entries.map((e) => _ExistingFileChip(
//           url: e.value,
//           onRemove: () => onRemoveExisting(e.key),
//         )),
//         const SizedBox(height: 6),
//       ],
//
//       // Upload buttons
//       Row(children: [
//         _uploadBtn(Icons.camera_alt_outlined, 'Camera', onCamera),
//         const SizedBox(width: 8),
//         _uploadBtn(Icons.photo_library_outlined, 'Gallery', onGallery),
//         const SizedBox(width: 8),
//         _uploadBtn(Icons.attach_file_rounded, 'File', onFile),
//       ]),
//
//       // New local files
//       if (docs.isNotEmpty) ...[
//         const SizedBox(height: 8),
//         ...docs.map((doc) => _fileChip(doc, onRemove)),
//       ],
//     ]);
//   }
//
//   Widget _uploadBtn(IconData icon, String label, VoidCallback onTap) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 9),
//           decoration: BoxDecoration(
//             color: newBlueLightColor,
//             borderRadius: BorderRadius.circular(9),
//             border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
//           ),
//           child: Column(children: [
//             Icon(icon, size: 18, color: newBlueColor),
//             const SizedBox(height: 3),
//             Text(label,
//                 style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: newBlueColor)),
//           ]),
//         ),
//       ),
//     );
//   }
//
//   Widget _fileChip(GrnDocument doc, void Function(String) onRemove) {
//     final isPdf = doc.fileType == 'pdf';
//     return Container(
//       margin: const EdgeInsets.only(bottom: 6),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: newSurfaceColor,
//         borderRadius: BorderRadius.circular(9),
//         border: Border.all(color: newBorderColor),
//       ),
//       child: Row(children: [
//         Icon(
//           isPdf ? Icons.picture_as_pdf_outlined : Icons.image_outlined,
//           size: 18,
//           color: isPdf ? Colors.redAccent : newBlueColor,
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child:
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(doc.fileName,
//                 style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: newTextPrimary),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis),
//             Text(doc.fileSize,
//                 style: const TextStyle(fontSize: 10, color: newTextSecondary)),
//           ]),
//         ),
//         GestureDetector(
//           onTap: () => onRemove(doc.id),
//           child: const Icon(Icons.close_rounded,
//               size: 16, color: newTextSecondary),
//         ),
//       ]),
//     );
//   }
// }
//
// // ── Existing server attachment chip ────────────────────────────────────────
// class _ExistingFileChip extends StatelessWidget {
//   final String url;
//   final VoidCallback onRemove;
//
//   const _ExistingFileChip({required this.url, required this.onRemove});
//
//   Future<void> _openFile() async {
//     String fullUrl = url.trim();
//
//     // If it's just a filename or relative path, prepend the base
//     if (!fullUrl.startsWith('http://') && !fullUrl.startsWith('https://')) {
//       fullUrl = 'https://supportapi.digitalerp.biz/Images/$fullUrl';
//     }
//
//     final uri = Uri.tryParse(fullUrl);
//     if (uri == null) return;
//
//     try {
//       final launched = await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//       if (!launched) {
//         debugPrint('❌ Could not launch: $fullUrl');
//       }
//     } catch (e) {
//       debugPrint('❌ launchUrl error: $e — url: $fullUrl');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final fileName = url.split('/').last;
//     final isPdf = fileName.toLowerCase().endsWith('.pdf');
//     final isImage = ['jpg', 'jpeg', 'png', 'webp']
//         .any((ext) => fileName.toLowerCase().endsWith(ext));
//
//     return GestureDetector(               // ← wrap entire chip
//       onTap: _openFile,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 6),
//         decoration: BoxDecoration(
//           color: newGreenLightColor,
//           borderRadius: BorderRadius.circular(9),
//           border: Border.all(color: newGreenColor.withValues(alpha: 0.4)),
//         ),
//         child: Column(children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
//             child: Row(children: [
//               Container(
//                 width: 34,
//                 height: 34,
//                 decoration: BoxDecoration(
//                     color: newGreenColor.withValues(alpha: 0.15),
//                     borderRadius: BorderRadius.circular(8)),
//                 alignment: Alignment.center,
//                 child: Icon(
//                   isPdf
//                       ? Icons.picture_as_pdf_outlined
//                       : isImage
//                       ? Icons.image_outlined
//                       : Icons.attach_file_rounded,
//                   size: 18,
//                   color: newGreenColor,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         fileName.length > 30
//                             ? '${fileName.substring(0, 27)}…'
//                             : fileName,
//                         style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: newTextPrimary),
//                       ),
//                       Row(children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 2),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 6, vertical: 1),
//                           decoration: BoxDecoration(
//                               color: newGreenColor,
//                               borderRadius: BorderRadius.circular(4)),
//                           child: const Text('SERVER',
//                               style: TextStyle(
//                                   fontSize: 8,
//                                   fontWeight: FontWeight.w800,
//                                   color: Colors.white)),
//                         ),
//                         const SizedBox(width: 5),         // ← new
//                         const Icon(Icons.open_in_new_rounded,  // ← new
//                             size: 10, color: newTextSecondary),
//                         const SizedBox(width: 3),         // ← new
//                         const Text('Tap to open',         // ← new
//                             style: TextStyle(
//                                 fontSize: 9,
//                                 color: newTextSecondary)),
//                       ]),
//                     ]),
//               ),
//               // ── Delete button stops propagation ──────────────────────
//               GestureDetector(
//                 onTap: onRemove,           // does NOT bubble up to _openFile
//                 behavior: HitTestBehavior.opaque,
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                       color: newRedLightColor,
//                       borderRadius: BorderRadius.circular(7),
//                       border: Border.all(
//                           color: newRedColor.withValues(alpha: 0.3))),
//                   child: const Icon(Icons.delete_outline_rounded,
//                       size: 14, color: newRedColor),
//                 ),
//               ),
//             ]),
//           ),
//           if (isImage && url.startsWith('http'))
//             GestureDetector(
//               onTap: _openFile,            // image preview also tappable
//               child: ClipRRect(
//                 borderRadius:
//                 const BorderRadius.vertical(bottom: Radius.circular(8)),
//                 child: Image.network(
//                   url,
//                   height: 120,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     height: 60,
//                     color: newSurfaceColor,
//                     alignment: Alignment.center,
//                     child: const Text('Preview unavailable',
//                         style:
//                         TextStyle(fontSize: 11, color: newTextSecondary)),
//                   ),
//                 ),
//               ),
//             ),
//         ]),
//       ),
//     );
//   }
// }
//
//
// // ═══════════════════════════════════════════════════════════════════════════════
// // Individual item card
// // ═══════════════════════════════════════════════════════════════════════════════
// class _ItemCard extends StatelessWidget {
//   final GrnController ctrl;
//   final GrnItemLine item;
//   final int index;
//
//   const _ItemCard(
//       {required this.ctrl, required this.item, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     final isOverReceived = item.receiveNowQty > item.maxReceivable;
//
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 220),
//       color: isOverReceived
//           ? newRedLightColor
//           : item.isExpanded
//           ? newBlueLightColor.withValues(alpha: 0.4)
//           : Colors.white,
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // ── Compact summary row (always visible) ─────────────────────────────
//         Padding(
//           padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             // Index bubble
//             Container(
//               width: 26,
//               height: 26,
//               decoration: BoxDecoration(
//                   color: newBlueLightColor,
//                   borderRadius: BorderRadius.circular(8)),
//               alignment: Alignment.center,
//               child: Text('${index + 1}',
//                   style: const TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w800,
//                       color: newBlueColor)),
//             ),
//             const SizedBox(width: 10),
//
//             // Item info + godown inline
//             Expanded(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(item.itemName,
//                         style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w700,
//                             color: newTextPrimary)),
//                     const SizedBox(height: 3),
//                     Row(children: [
//                       _pill(item.itemCode, newSurfaceColor, newTextSecondary),
//                       const SizedBox(width: 5),
//                       _pill(item.unit, newSurfaceColor, newTextSecondary),
//                       const SizedBox(width: 5),
//                       _pill('PO: ${item.poQty.toInt()}', newBlueLightColor,
//                           newBlueColor),
//                     ]),
//                     const SizedBox(height: 6),
//
//                     // ── Inline godown selector ────────────────────────────────
//                     _InlineGodownSelector(ctrl: ctrl, item: item),
//                   ]),
//             ),
//             const SizedBox(width: 8),
//
//             // Qty stepper
//             _QtyField(ctrl: ctrl, item: item),
//
//             // Expand toggle
//             const SizedBox(width: 6),
//             GestureDetector(
//               onTap: () => ctrl.toggleItemExpanded(item),
//               child: AnimatedRotation(
//                 turns: item.isExpanded ? 0.5 : 0,
//                 duration: const Duration(milliseconds: 220),
//                 child: const Icon(Icons.keyboard_arrow_down_rounded,
//                     size: 22, color: newTextSecondary),
//               ),
//             ),
//           ]),
//         ),
//
//         const SizedBox(height: 10),
//
//         // ── Expanded detail panel ─────────────────────────────────────────────
//         AnimatedCrossFade(
//           firstChild: const SizedBox.shrink(),
//           secondChild: _expandedPanel(context),
//           crossFadeState: item.isExpanded
//               ? CrossFadeState.showSecond
//               : CrossFadeState.showFirst,
//           duration: const Duration(milliseconds: 220),
//         ),
//
//         // ── Qty warning strip ─────────────────────────────────────────────────
//         if (isOverReceived)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//             color: newRedLightColor,
//             child: Row(children: [
//               const Icon(Icons.warning_amber_rounded,
//                   size: 13, color: newRedColor),
//               const SizedBox(width: 5),
//               Text(
//                 'Exceeds PO balance. Max: ${item.maxReceivable.toInt()} ${item.unit}',
//                 style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: newRedColor),
//               ),
//             ]),
//           )
//         else
//           const SizedBox(height: 10),
//       ]),
//     );
//   }
//
//   // ── Expanded detail panel ──────────────────────────────────────────────────
//   Widget _expandedPanel(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const Divider(height: 1, color: newBorderColor),
//         const SizedBox(height: 12),
//
//         // ── Financial grid (read-only) ──────────────────────────────────────
//         Container(
//           decoration: BoxDecoration(
//             color: newSurfaceColor,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: newBorderColor),
//           ),
//           child: Column(children: [
//             // Header
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: newBlueLightColor,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(9), topRight: Radius.circular(9)),
//               ),
//               child: Row(children: [
//                 const Icon(Icons.calculate_outlined,
//                     size: 13, color: newBlueColor),
//                 const SizedBox(width: 5),
//                 const Text('Financial Details',
//                     style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w800,
//                         color: newBlueColor,
//                         letterSpacing: .3)),
//                 const Spacer(),
//                 Container(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//                   decoration: BoxDecoration(
//                       color: newBlueColor,
//                       borderRadius: BorderRadius.circular(4)),
//                   child: const Text('READ ONLY',
//                       style: TextStyle(
//                           fontSize: 8,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.white,
//                           letterSpacing: .5)),
//                 ),
//               ]),
//             ),
//             _finRow('Order No', item.orderNo, mono: true),
//             _finRow('Rate', '₹${item.rate.toStringAsFixed(2)}'),
//             _finRow('Discount',
//                 '${item.discountPercent.toStringAsFixed(1)}%  (₹${item.discountAmount.toStringAsFixed(2)})'),
//             _finRow('Amount', '₹${item.amount.toStringAsFixed(2)}'),
//             _finRow('GST %', '${item.gstPercent.toStringAsFixed(1)}%'),
//             _finRow('GST Amount', '₹${item.gstAmount.toStringAsFixed(2)}'),
//             _finRowTotal(
//                 'Total Amount', '₹${item.totalAmount.toStringAsFixed(2)}'),
//           ]),
//         ),
//
//         const SizedBox(height: 12),
//
//
//         const SizedBox(height: 12),
//
//         // ── Remarks ─────────────────────────────────────────────────────────
//         GrnField(
//           label: 'Remarks',
//           hint: 'Optional delivery note for this item…',
//           controller: TextEditingController(text: item.remarks)
//             ..selection = TextSelection.collapsed(offset: item.remarks.length),
//           minLines: 2,
//           onChanged: (v) => ctrl.setItemRemarks(item, v),
//         ),
//
//         const SizedBox(height: 10),
//
//         // ── Remove item ──────────────────────────────────────────────────────
//         GestureDetector(
//           onTap: () => ctrl.removeItem(item),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
//             decoration: BoxDecoration(
//                 color: newRedLightColor,
//                 borderRadius: BorderRadius.circular(9),
//                 border: Border.all(color: newRedColor.withValues(alpha: 0.3))),
//             child: const Row(mainAxisSize: MainAxisSize.min, children: [
//               Icon(Icons.remove_circle_outline_rounded,
//                   size: 14, color: newRedColor),
//               SizedBox(width: 6),
//               Text('Remove this item',
//                   style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w700,
//                       color: newRedColor)),
//             ]),
//           ),
//         ),
//       ]),
//     );
//   }
//
//   // ── Financial row helpers ──────────────────────────────────────────────────
//   Widget _finRow(String label, String val, {bool mono = false}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
//       decoration: const BoxDecoration(
//           border: Border(top: BorderSide(color: newBorderColor))),
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Text(label,
//             style: const TextStyle(fontSize: 11, color: newTextSecondary)),
//         Text(val,
//             style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w700,
//                 color: newTextPrimary,
//                 fontFamily: mono ? 'monospace' : null)),
//       ]),
//     );
//   }
//
//   Widget _finRowTotal(String label, String val) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//           color: newBlueLightColor,
//           border: const Border(top: BorderSide(color: newBlueColor)),
//           borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(9), bottomRight: Radius.circular(9))),
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Text(label,
//             style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w800,
//                 color: newBlueColor)),
//         Text(val,
//             style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w800,
//                 color: newBlueColor)),
//       ]),
//     );
//   }
//
//
//   Widget _pill(String text, Color bg, Color fg) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//       decoration:
//       BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5)),
//       child: Text(text,
//           style:
//           TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: fg)),
//     );
//   }
// }
//
// // ═══════════════════════════════════════════════════════════════════════════════
// // Inline Godown Selector (compact row — always visible)
// // ═══════════════════════════════════════════════════════════════════════════════
// class _InlineGodownSelector extends StatelessWidget {
//   final GrnController ctrl;
//   final GrnItemLine item;
//
//   const _InlineGodownSelector({required this.ctrl, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     // Resolved godown: item override > header godown > fallback text
//     final resolvedGodown = item.selectedGodownId != null
//         ? ctrl.godownList.firstWhereOrNull((g) => g.id == item.selectedGodownId)
//         : ctrl.selectedGodown;
//
//     final label = resolvedGodown?.label ?? '— Select Godown —';
//     final isOverridden = item.selectedGodownId != null &&
//         item.selectedGodownId != ctrl.selectedGodown?.id;
//
//     return GestureDetector(
//       onTap: () => _showGodownSheet(context),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           color: isOverridden ? newOrangeLightColor : newSurfaceColor,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isOverridden ? newOrangeColor : newBorderColor,
//             width: isOverridden ? 1.2 : 1,
//           ),
//         ),
//         child: Row(mainAxisSize: MainAxisSize.min, children: [
//           Icon(
//             Icons.warehouse_outlined,
//             size: 12,
//             color: isOverridden ? newOrangeColor : newTextSecondary,
//           ),
//           const SizedBox(width: 5),
//           Flexible(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w600,
//                 color: isOverridden ? newOrangeColor : newTextSecondary,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           const SizedBox(width: 4),
//           Icon(
//             Icons.arrow_drop_down_rounded,
//             size: 16,
//             color: isOverridden ? newOrangeColor : newTextSecondary,
//           ),
//         ]),
//       ),
//     );
//   }
//
//   void _showGodownSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//       builder: (_) => _GodownPickerSheet(ctrl: ctrl, item: item),
//     );
//   }
// }
//
// // ── Godown picker bottom sheet ──────────────────────────────────────────────
// class _GodownPickerSheet extends StatefulWidget {
//   final GrnController ctrl;
//   final GrnItemLine item;
//   const _GodownPickerSheet({required this.ctrl, required this.item});
//
//   @override
//   State<_GodownPickerSheet> createState() => _GodownPickerSheetState();
// }
//
// class _GodownPickerSheetState extends State<_GodownPickerSheet> {
//   String _query = '';
//
//   @override
//   Widget build(BuildContext context) {
//     final filtered = widget.ctrl.godownList
//         .where((g) => g.label.toLowerCase().contains(_query.toLowerCase()))
//         .toList();
//     final currentId =
//         widget.item.selectedGodownId ?? widget.ctrl.selectedGodown?.id;
//
//     return Padding(
//       padding:
//       EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Column(mainAxisSize: MainAxisSize.min, children: [
//         // Handle
//         const SizedBox(height: 10),
//         Container(
//           width: 38,
//           height: 4,
//           decoration: BoxDecoration(
//               color: newBorderColor, borderRadius: BorderRadius.circular(2)),
//         ),
//         const SizedBox(height: 14),
//         // Title
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text('Select Godown',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w800,
//                     color: newTextPrimary)),
//           ),
//         ),
//         const SizedBox(height: 10),
//         // Search field
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: TextField(
//             autofocus: true,
//             onChanged: (v) => setState(() => _query = v),
//             decoration: InputDecoration(
//               hintText: 'Search godown…',
//               hintStyle: const TextStyle(fontSize: 13, color: newTextHint),
//               prefixIcon:
//               const Icon(Icons.search, size: 18, color: newTextSecondary),
//               filled: true,
//               fillColor: newSurfaceColor,
//               contentPadding: const EdgeInsets.symmetric(vertical: 10),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: newBorderColor)),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: newBorderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide:
//                   const BorderSide(color: newBlueColor, width: 1.5)),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         // "Use header godown" option
//         if (widget.ctrl.selectedGodown != null)
//           _godownTile(
//             godown: widget.ctrl.selectedGodown!,
//             currentId: currentId,
//             isDefault: true,
//           ),
//         // List
//         ConstrainedBox(
//           constraints: const BoxConstraints(maxHeight: 260),
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: filtered.length,
//             itemBuilder: (_, i) {
//               final g = filtered[i];
//               // Skip if same as header (already shown above)
//               if (widget.ctrl.selectedGodown?.id == g.id) {
//                 return const SizedBox.shrink();
//               }
//               return _godownTile(
//                 godown: g,
//                 currentId: currentId,
//                 isDefault: false,
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 16),
//       ]),
//     );
//   }
//
//   Widget _godownTile({
//     required GrnDropdownOption godown,
//     required String? currentId,
//     required bool isDefault,
//   }) {
//     final isSelected = godown.id == currentId;
//     return ListTile(
//       dense: true,
//       onTap: () {
//         // If tapping the header godown, clear item-level override
//         if (isDefault) {
//           widget.ctrl.setItemGodown(widget.item, null);
//         } else {
//           widget.ctrl.setItemGodown(widget.item, godown);
//         }
//         Get.back();
//       },
//       leading: Container(
//         width: 32,
//         height: 32,
//         decoration: BoxDecoration(
//             color: isSelected ? newBlueLightColor : newSurfaceColor,
//             borderRadius: BorderRadius.circular(8)),
//         alignment: Alignment.center,
//         child: Icon(Icons.warehouse_outlined,
//             size: 16, color: isSelected ? newBlueColor : newTextSecondary),
//       ),
//       title: Row(children: [
//         Text(godown.label,
//             style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
//                 color: isSelected ? newBlueColor : newTextPrimary)),
//         if (isDefault) ...[
//           const SizedBox(width: 6),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//             decoration: BoxDecoration(
//                 color: newBlueLightColor,
//                 borderRadius: BorderRadius.circular(4)),
//             child: const Text('Default',
//                 style: TextStyle(
//                     fontSize: 9,
//                     fontWeight: FontWeight.w700,
//                     color: newBlueColor)),
//           ),
//         ],
//       ]),
//       trailing: isSelected
//           ? const Icon(Icons.check_circle_rounded,
//           size: 18, color: newBlueColor)
//           : null,
//     );
//   }
// }
//
// // ═══════════════════════════════════════════════════════════════════════════════
// // Qty stepper field
// // ═══════════════════════════════════════════════════════════════════════════════
// class _QtyField extends StatefulWidget {
//   final GrnController ctrl;
//   final GrnItemLine item;
//   const _QtyField({required this.ctrl, required this.item});
//
//   @override
//   State<_QtyField> createState() => _QtyFieldState();
// }
//
// class _QtyFieldState extends State<_QtyField> {
//   late final TextEditingController _tc;
//
//   @override
//   void initState() {
//     super.initState();
//     _tc = TextEditingController(
//         text: widget.item.receiveNowQty.toInt().toString());
//   }
//
//   @override
//   void dispose() {
//     _tc.dispose();
//     super.dispose();
//   }
//
//   void _sync() {
//     final newVal = widget.item.receiveNowQty.toInt().toString();
//     if (_tc.text != newVal) {
//       _tc.value = _tc.value.copyWith(
//         text: newVal,
//         selection: TextSelection.collapsed(offset: newVal.length),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _sync();
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: newBorderColor),
//         borderRadius: BorderRadius.circular(9),
//       ),
//       child: Row(mainAxisSize: MainAxisSize.min, children: [
//         // Minus
//         GestureDetector(
//           onTap: () {
//             widget.ctrl.decreaseQty(widget.item);
//             _sync();
//           },
//           child: Container(
//             width: 30,
//             height: 34,
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8),
//                     bottomLeft: Radius.circular(8))),
//             alignment: Alignment.center,
//             child: const Icon(Icons.remove, size: 14, color: newBlueColor),
//           ),
//         ),
//         // Text input
//         SizedBox(
//           width: 40,
//           child: TextField(
//             controller: _tc,
//             textAlign: TextAlign.center,
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w800,
//                 color: newTextPrimary),
//             decoration: const InputDecoration(
//                 border: InputBorder.none, contentPadding: EdgeInsets.zero),
//             onChanged: (v) {
//               final parsed = double.tryParse(v) ?? 0;
//               widget.ctrl.setReceivedQty(widget.item, parsed);
//             },
//           ),
//         ),
//         // Plus
//         GestureDetector(
//           onTap: () {
//             widget.ctrl.increaseQty(widget.item);
//             _sync();
//           },
//           child: Container(
//             width: 30,
//             height: 34,
//             decoration: const BoxDecoration(
//                 color: newBlueColor,
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(8),
//                     bottomRight: Radius.circular(8))),
//             alignment: Alignment.center,
//             child: const Icon(Icons.add, size: 14, color: Colors.white),
//           ),
//         ),
//       ]),
//     );
//   }
// }
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/show_message.dart';
import '../grn_response/additional_charge_model.dart';
import '../grn_controller/grn_controller.dart';
import '../grn_response/grn_models.dart';
import '../grn_widgets.dart';
import 'grn_direct_item_form.dart';

class GrnItemsScreen extends StatelessWidget {
  const GrnItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GrnController>(builder: (ctrl) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  14,
                  14,
                  14,
                  MediaQuery.of(context).viewInsets.bottom + 110,
                ),
                child: Column(children: [
                  if (ctrl.selectedSource == GrnSourceType.grn)
                    const GrnDirectItemForm(),
                  _AttachmentsCard(ctrl: ctrl, context: context),
                  const SizedBox(height: 14),
                  _AdditionalChargesCard(ctrl: ctrl),
                ]),
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0) _bottomBar(ctrl),
          ]),
        ),
      );
    });
  }

  Widget _bottomBar(GrnController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: newBorderColor))),
      child: SafeArea(
        top: false,
        child: GrnPrimaryBtn(
          label: 'Review & Submit →',
          icon: Icons.arrow_forward_rounded,
          onTap: () {
            if (ctrl.itemLines.isEmpty) {
              ShowMessage.showSnackBar(
                'No Items',
                ctrl.selectedSource == GrnSourceType.grn
                    ? 'Please select and process a GRN'
                    : 'Please add at least one item',
              );
              return;
            }
            if (ctrl.itemLines.any((i) => i.receiveNowQty <= 0)) {
              ShowMessage.showSnackBar(
                  'Invalid Qty', 'All items must have received qty > 0');
              return;
            }
            ctrl.nextStep();
          },
        ),
      ),
    );
  }

  static String _inr(double v) {
    if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(2)} Cr';
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(2)} L';
    final parts = v.toStringAsFixed(2).split('.');
    final whole = parts[0];
    final decimal = parts[1];
    if (whole.length <= 3) return '₹$whole.$decimal';
    final last3 = whole.substring(whole.length - 3);
    final rest = whole.substring(0, whole.length - 3);
    final buf = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return '₹$buf,$last3.$decimal';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Additional Charges Card
// ═══════════════════════════════════════════════════════════════════════════════
class _AdditionalChargesCard extends StatelessWidget {
  final GrnController ctrl;
  const _AdditionalChargesCard({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return GrnCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Header ───────────────────────────────────────────────────────────
        Row(children: [
          const Expanded(
              child: GrnSectionHead('Other Details / Additional Charges')),
          GestureDetector(
            onTap: ctrl.addAdditionalCharge,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                  color: newBlueColor, borderRadius: BorderRadius.circular(9)),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.add_rounded, size: 14, color: Colors.white),
                SizedBox(width: 5),
                Text('Add Row',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ]),
            ),
          ),
        ]),
        const SizedBox(height: 4),

        const Text(
          'Add freight, taxes, discounts or any other adjustments. '
          'Each row is applied sequentially to compute the final total.',
          style: TextStyle(fontSize: 11, color: newTextSecondary),
        ),
        const SizedBox(height: 14),

        // ── Empty state ───────────────────────────────────────────────────
        if (ctrl.additionalCharges.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 22),
            decoration: BoxDecoration(
              color: newSurfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: newBorderColor),
            ),
            child: Column(children: [
              Icon(Icons.receipt_long_outlined,
                  size: 32, color: newBorderColor),
              const SizedBox(height: 8),
              const Text('No additional charges added.',
                  style: TextStyle(fontSize: 12, color: newTextSecondary)),
              const SizedBox(height: 4),
              const Text('Tap "Add Row" to add freight, taxes, discounts…',
                  style: TextStyle(fontSize: 11, color: newTextHint)),
            ]),
          )
        else ...[
          _tableHeader(),
          const SizedBox(height: 4),
          ...ctrl.additionalCharges.asMap().entries.map((e) => _ChargeRow(
                key: ValueKey(e.value.localId),
                charge: e.value,
                index: e.key,
                ctrl: ctrl,
              )),
          const SizedBox(height: 10),
          _chargeSummary(),
        ],
      ]),
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: newBlueLightColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: newBlueColor.withValues(alpha: 0.25)),
      ),
      child: const Row(children: [
        SizedBox(width: 26),
        SizedBox(width: 8),
        Expanded(
            flex: 3,
            child: Text('Head',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor))),
        SizedBox(
            width: 42,
            child: Text('Nature',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor))),
        SizedBox(width: 4),
        SizedBox(
            width: 52,
            child: Text('Value',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor))),
        SizedBox(width: 4),
        SizedBox(
            width: 64,
            child: Text('Amount',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor))),
        SizedBox(width: 6),
        SizedBox(
            width: 48,
            child: Text('Actions',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor))),
      ]),
    );
  }

  Widget _chargeSummary() {
    final gross = ctrl.additionalChargesGross;
    final deduct = ctrl.additionalChargesDeduct;
    final net = ctrl.additionalChargesTotal;
    final isNetPositive = net >= 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(children: [
        _summaryRow(Icons.add_circle_outline_rounded, newGreenColor,
            'Total Additions', '+${_inr(gross)}'),
        const SizedBox(height: 6),
        _summaryRow(Icons.remove_circle_outline_rounded, newRedColor,
            'Total Deductions', '-${_inr(deduct)}'),
        const Divider(height: 14, color: newBorderColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Net Adjustment',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: newTextPrimary)),
            Text(
              '${isNetPositive ? "+" : ""}${_inr(net)}',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isNetPositive ? newGreenColor : newRedColor),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _summaryRow(IconData icon, Color color, String label, String val) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 5),
            Text(label,
                style: const TextStyle(fontSize: 11, color: newTextSecondary)),
          ]),
          Text(val,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: color)),
        ],
      );

  static String _inr(double v) {
    if (v < 0) return '-${_inr(-v)}';
    if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(2)} Cr';
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(2)} L';
    final parts = v.toStringAsFixed(2).split('.');
    final whole = parts[0];
    final decimal = parts[1];
    if (whole.length <= 3) return '₹$whole.$decimal';
    final last3 = whole.substring(whole.length - 3);
    final rest = whole.substring(0, whole.length - 3);
    final buf = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return '₹$buf,$last3.$decimal';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Single charge row widget
// ═══════════════════════════════════════════════════════════════════════════════
class _ChargeRow extends StatelessWidget {
  final AdditionalCharge charge;
  final int index;
  final GrnController ctrl;

  const _ChargeRow({
    super.key,
    required this.charge,
    required this.index,
    required this.ctrl,
  });

  @override
  Widget build(BuildContext context) {
    final isPlus = charge.nature == ChargeNature.plus;
    final amt = charge.calculatedAmount;
    final hasHead = charge.head != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: hasHead ? Colors.white : newSurfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: hasHead ? newBorderColor : newBorderColor.withValues(alpha: 0.5),
        ),
      ),
      child: GestureDetector(
        onTap: () => _showEditSheet(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // ── Index bubble ─────────────────────────────────────────────
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                  color: newBlueLightColor,
                  borderRadius: BorderRadius.circular(7)),
              alignment: Alignment.center,
              child: Text('${index + 1}',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: newBlueColor)),
            ),
            const SizedBox(width: 10),

            // ── Head name + depends on — takes all available space ────────
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      charge.head?.label ?? '— Tap to configure —',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: hasHead ? newTextPrimary : newTextHint),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    // ── Second line: nature badge + value + amount ────────
                    Row(children: [
                      // Nature badge — fixed, no wrapping
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isPlus ? newGreenLightColor : newRedLightColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          isPlus ? '+ADD' : '−LESS',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: isPlus ? newGreenColor : newRedColor),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Value
                      Text(
                        charge.calcType == ChargeCalcType.percentage
                            ? '${charge.value.toStringAsFixed(1)}%'
                            : '₹${charge.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: newTextSecondary),
                      ),
                      const SizedBox(width: 6),
                      const Text('→',
                          style: TextStyle(
                              fontSize: 10, color: newTextSecondary)),
                      const SizedBox(width: 6),
                      // Computed amount
                      Text(
                        '${isPlus ? "+" : "−"}₹${amt.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: isPlus ? newGreenColor : newRedColor),
                      ),
                    ]),
                    // Depends-on label if present
                    if (charge.dependsOnLabel != null) ...[
                      const SizedBox(height: 2),
                      Row(children: [
                        const Icon(Icons.link_rounded,
                            size: 10, color: newTextSecondary),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            'On: ${charge.dependsOnLabel}',
                            style: const TextStyle(
                                fontSize: 9, color: newTextSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                    ],
                  ]),
            ),
            const SizedBox(width: 8),

            // ── Action buttons ───────────────────────────────────────────
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _showEditSheet(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: newBlueLightColor,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: const Icon(Icons.edit_rounded,
                        size: 14, color: newBlueColor),
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => ctrl.removeAdditionalCharge(charge.localId),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: newRedLightColor,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: const Icon(Icons.delete_outline_rounded,
                        size: 14, color: newRedColor),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _showEditSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ChargeEditSheet(
        ctrl: ctrl,
        charge: charge,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Bottom sheet for adding / editing a charge row
// ═══════════════════════════════════════════════════════════════════════════════
class _ChargeEditSheet extends StatefulWidget {
  final GrnController ctrl;
  final AdditionalCharge charge;

  const _ChargeEditSheet({required this.ctrl, required this.charge});

  @override
  State<_ChargeEditSheet> createState() => _ChargeEditSheetState();
}

class _ChargeEditSheetState extends State<_ChargeEditSheet> {
  late AdditionalChargeHead? _head;
  late ChargeNature _nature;
  late ChargeCalcType _calcType;
  late String? _dependsOnLocalId;
  late String? _dependsOnLabel;
  double _lockedPercentage = 0;
  double _lockedDiscount = 0;

  final TextEditingController _valueCtrl = TextEditingController();
  String _headSearch = '';

  @override
  void initState() {
    super.initState();
    final c = widget.charge;
    _head = c.head;
    _nature = c.nature;
    _calcType = c.calcType;
    _dependsOnLocalId = c.dependsOnLocalId;
    _dependsOnLabel = c.dependsOnLabel;
    _valueCtrl.text = c.value > 0 ? c.value.toStringAsFixed(2) : '';
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    super.dispose();
  }

  // ── When a head is selected, auto-apply lock rules ─────────────────────────
  Future<void> _onHeadSelected(AdditionalChargeHead h) async {
    setState(() {
      _head = h;
    });

    final percentage = await widget.ctrl.fetchChargeHeadPercentage(h.id);

    if (percentage == null || percentage <= 0) return;

    final isDiscount = h.label.toLowerCase().contains('discount');

    setState(() {
      if (isDiscount) {
        _calcType = ChargeCalcType.fixed;
      } else {
        _calcType = ChargeCalcType.percentage;
      }

      _valueCtrl.text = percentage.toStringAsFixed(2);
    });
  }

  bool get _isPercentLocked =>
      _head != null &&
      _head!.label.toLowerCase().contains('tax') &&
      (double.tryParse(_valueCtrl.text) ?? 0) > 0 &&
      _calcType == ChargeCalcType.percentage;

  bool get _isFixedLocked =>
      _head != null &&
      _head!.label.toLowerCase().contains('discount') &&
      (double.tryParse(_valueCtrl.text) ?? 0) > 0 &&
      _calcType == ChargeCalcType.fixed;

  bool get _isApiValueLocked =>
      _head != null && (double.tryParse(_valueCtrl.text) ?? 0) > 0;
  bool _isApiFixedLocked = false;

  void _save() {
    final val = double.tryParse(_valueCtrl.text) ?? 0.0;

    // Resolve accountid of the charge this row depends on
    String? resolvedDependsOnAccountId;
    if (_dependsOnLocalId != null) {
      final depCharge = widget.ctrl.additionalCharges
          .firstWhereOrNull((c) => c.localId == _dependsOnLocalId);
      resolvedDependsOnAccountId = depCharge?.head?.id;
    }

    final updated = widget.charge.copyWith(
      head               : _head,
      nature             : _nature,
      calcType           : _calcType,
      value              : val,
      dependsOnLocalId   : _dependsOnLocalId,
      dependsOnLabel     : _dependsOnLabel,
      dependsOnAccountId : resolvedDependsOnAccountId,  // ← was bare 'dependsOnAccountId'
    );
    widget.ctrl.updateAdditionalCharge(updated);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollCtrl) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(children: [
            const SizedBox(height: 10),
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                  color: newBorderColor,
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                const Expanded(
                  child: Text('Configure Charge',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: newTextPrimary)),
                ),
                GestureDetector(
                  onTap: Get.back,
                  child: const Icon(Icons.close_rounded,
                      size: 20, color: newTextSecondary),
                ),
              ]),
            ),
            const Divider(height: 18, color: newBorderColor),
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  MediaQuery.of(context).viewInsets.bottom +
                      MediaQuery.of(context).padding.bottom +
                      80, // extra breathing room for the Save button
                ),
                children: [
                  // ── Step 1: Charge Head ──────────────────────────────────
                  _sectionLabel('1. Charge Head'),
                  const SizedBox(height: 6),
                  _headSelector(),
                  const SizedBox(height: 16),

                  // ── Step 2: Nature ───────────────────────────────────────
                  _sectionLabel('2. Nature'),
                  const SizedBox(height: 6),
                  _natureToggle(),
                  const SizedBox(height: 16),

                  // ── Step 3: Calculation type (hidden when % locked) ──────
                  if (!_isPercentLocked && !_isFixedLocked) ...[
                    _sectionLabel('3. Calculation Type'),
                    const SizedBox(height: 6),
                    _calcTypeToggle(),
                    const SizedBox(height: 16),
                  ] else ...[
                    // Show locked badge instead of toggle
                    _lockedCalcTypeBanner(),
                    const SizedBox(height: 16),
                  ],

                  // ── Step 4: Value ────────────────────────────────────────
                  _sectionLabel(
                    _calcType == ChargeCalcType.percentage
                        ? '4. Percentage (%)${_isPercentLocked ? " — Locked by head" : ""}'
                        : '4. Fixed Amount (₹)',
                  ),
                  const SizedBox(height: 6),
                  _valueField(),
                  const SizedBox(height: 16),

                  // ── Step 5: Depends On (for BOTH % and Fixed) ───────────
                  _sectionLabel(
                    _calcType == ChargeCalcType.percentage
                        ? '5. Apply % On (Depends On)'
                        : '5. Add Fixed Amount On Top Of (Depends On)',
                  ),
                  const SizedBox(height: 4),
                  // Explanation text differs by calc type
                  Text(
                    _calcType == ChargeCalcType.percentage
                        ? 'Choose which base to apply the percentage on. '
                            'Defaults to item subtotal.'
                        : 'Optionally stack this fixed amount on top of another '
                            'charge. Leave as "Subtotal" if standalone.',
                    style:
                        const TextStyle(fontSize: 11, color: newTextSecondary),
                  ),
                  const SizedBox(height: 8),
                  _dependsOnSelector(),
                  const SizedBox(height: 16),

                  // ── Preview ──────────────────────────────────────────────
                  _previewCard(),
                  const SizedBox(height: 20),

                  // ── Save ─────────────────────────────────────────────────
                  GestureDetector(
                    onTap: _save,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: newBlueColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Save Charge',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }

  // ── Head selector ──────────────────────────────────────────────────────────
  Widget _headSelector() {
    if (widget.ctrl.isLoadingChargeHeads) {
      return const Center(
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 1.5, color: newBlueColor)));
    }

    final filtered = widget.ctrl.chargeHeadList
        .where((h) => h.label.toLowerCase().contains(_headSearch.toLowerCase()))
        .toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(
        onChanged: (v) => setState(() => _headSearch = v),
        decoration: InputDecoration(
          hintText: 'Search charge head…',
          hintStyle: const TextStyle(fontSize: 13, color: newTextHint),
          prefixIcon:
              const Icon(Icons.search, size: 18, color: newTextSecondary),
          filled: true,
          fillColor: newSurfaceColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
        ),
      ),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: Column(
          children: filtered.asMap().entries.map((e) {
            final h = e.value;
            final isSelected = _head?.id == h.id;
            final hasLockedPct = h.taxPercent > 0;
            return Column(children: [
              if (e.key > 0) const Divider(height: 1, color: newBorderColor),
              InkWell(
                onTap: () async {
                  setState(() {
                    _head = h;
                    _isApiFixedLocked = false;
                    _valueCtrl.clear();
                  });

                  final percentage =
                      await widget.ctrl.fetchChargeHeadPercentage(h.id);

                  final isDiscount = h.label.toLowerCase().contains('discount');

                  setState(() {
                    if (isDiscount) {
                      _calcType = ChargeCalcType.fixed;

                      if (percentage != null && percentage > 0) {
                        _valueCtrl.text = percentage.toStringAsFixed(2);
                        _isApiFixedLocked = true;
                      }
                    } else {
                      _calcType = ChargeCalcType.percentage;

                      if (percentage != null) {
                        _valueCtrl.text = percentage.toStringAsFixed(2);
                      }
                    }
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(children: [
                    Container(
                      constraints:
                          const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                          color: isSelected ? newBlueLightColor : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: newBorderColor)),
                      alignment: Alignment.center,
                      child: Text(
                        h.id, // ← remove padLeft entirely, show raw ID
                        style: TextStyle(
                            fontSize: 9, // ← slightly smaller to fit long IDs
                            fontWeight: FontWeight.w700,
                            color:
                                isSelected ? newBlueColor : newTextSecondary),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(h.label,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? newBlueColor
                                        : newTextPrimary)),
                            // Show locked % hint on each head that has it
                            if (hasLockedPct) ...[
                              const SizedBox(height: 2),
                              Row(children: [
                                const Icon(Icons.lock_rounded,
                                    size: 9, color: newOrangeColor),
                                const SizedBox(width: 3),
                                Text(
                                  '${h.taxPercent.toStringAsFixed(1)}% fixed by system',
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: newOrangeColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ],
                          ]),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle_rounded,
                          size: 18, color: newBlueColor),
                  ]),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    ]);
  }

  // ── Nature toggle ──────────────────────────────────────────────────────────
  Widget _natureToggle() {
    return Row(children: [
      _toggleOption(
        label: '+ Add (Plus)',
        icon: Icons.add_circle_outline_rounded,
        selected: _nature == ChargeNature.plus,
        selectedColor: newGreenColor,
        selectedBg: newGreenLightColor,
        onTap: () => setState(() => _nature = ChargeNature.plus),
      ),
      const SizedBox(width: 10),
      _toggleOption(
        label: '− Less (Deduct)',
        icon: Icons.remove_circle_outline_rounded,
        selected: _nature == ChargeNature.less,
        selectedColor: newRedColor,
        selectedBg: newRedLightColor,
        onTap: () => setState(() => _nature = ChargeNature.less),
      ),
    ]);
  }

  // ── Calc type toggle (only shown when NOT locked) ──────────────────────────
  Widget _calcTypeToggle() {
    final isLocked = _isApiValueLocked;
    if (isLocked) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: Text(
          _calcType == ChargeCalcType.percentage
              ? 'Percentage auto-filled from charge head'
              : 'Fixed amount auto-filled from discount charge head',
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    return Row(children: [
      _toggleOption(
        label: 'Fixed Amount',
        icon: Icons.currency_rupee_rounded,
        selected: _calcType == ChargeCalcType.fixed,
        selectedColor: newBlueColor,
        selectedBg: newBlueLightColor,
        onTap: () => setState(() {
          _calcType = ChargeCalcType.fixed;
          // Keep dependsOnLocalId — user may want fixed-on-top-of behaviour
        }),
      ),
      const SizedBox(width: 10),
      _toggleOption(
        label: 'Percentage (%)',
        icon: Icons.percent_rounded,
        selected: _calcType == ChargeCalcType.percentage,
        selectedColor: newOrangeColor,
        selectedBg: newOrangeLightColor,
        onTap: () => setState(() => _calcType = ChargeCalcType.percentage),
      ),
    ]);
  }

  // ── Locked calc type banner ────────────────────────────────────────────────
  Widget _lockedCalcTypeBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: newOrangeLightColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: newOrangeColor.withValues(alpha: 0.4)),
      ),
      child: Row(children: [
        const Icon(Icons.lock_rounded, size: 14, color: newOrangeColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Calculation type is locked to Percentage '
            '(${_head?.taxPercent.toStringAsFixed(1)}%) by the system for '
            '"${_head?.label ?? "this head"}". '
            'You cannot change it.',
            style: const TextStyle(fontSize: 11, color: newOrangeColor),
          ),
        ),
      ]),
    );
  }

  Widget _toggleOption({
    required String label,
    required IconData icon,
    required bool selected,
    required Color selectedColor,
    required Color selectedBg,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? selectedBg : newSurfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? selectedColor : newBorderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16, color: selected ? selectedColor : newTextSecondary),
              const SizedBox(width: 6),
              Flexible(
                child: Text(label,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: selected ? selectedColor : newTextSecondary)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Value field ────────────────────────────────────────────────────────────
  Widget _valueField() {
    // Locked when: percentage mode AND head has taxPercent > 0
    final isLocked =
        _calcType == ChargeCalcType.percentage || _isApiFixedLocked;

    return Stack(
      children: [
        TextField(
          controller: _valueCtrl,
          readOnly: isLocked,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
          ],
          onChanged: isLocked ? null : (_) => setState(() {}),
          style: TextStyle(
            fontSize: 13,
            color: isLocked ? newTextSecondary : newTextPrimary,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: _calcType == ChargeCalcType.percentage
                ? 'e.g. 2.5  (for 2.5%)'
                : 'e.g. 100  (for ₹100)',
            hintStyle: const TextStyle(fontSize: 13, color: newTextHint),
            prefixIcon: Icon(
              _calcType == ChargeCalcType.percentage
                  ? Icons.percent_rounded
                  : Icons.currency_rupee_rounded,
              size: 18,
              color: isLocked ? newOrangeColor : newTextSecondary,
            ),
            suffixIcon: isLocked
                ? const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.lock_rounded,
                        size: 16, color: newOrangeColor),
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(),
            filled: true,
            fillColor: isLocked ? newOrangeLightColor : newSurfaceColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: isLocked ? newOrangeColor : newBorderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: isLocked ? newOrangeColor : newBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: isLocked ? newOrangeColor : newBlueColor,
                    width: 1.5)),
          ),
        ),
      ],
    );
  }

  // ── Depends On selector (shown for BOTH % and Fixed) ──────────────────────
  Widget _dependsOnSelector() {
    final prevCharges = widget.ctrl.additionalCharges
        .where((c) => c.localId != widget.charge.localId && c.head != null)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(children: [
        // Option: item subtotal (no dependency — standalone)
        _dependsOption(
          id: null,
          label: _calcType == ChargeCalcType.percentage
              ? 'Item Subtotal (Base)'
              : 'No dependency — standalone amount',
          subtitle: _calcType == ChargeCalcType.percentage
              ? '₹${widget.ctrl.subtotal.toStringAsFixed(2)}'
              : 'Amount = ₹${double.tryParse(_valueCtrl.text)?.toStringAsFixed(2) ?? "0.00"}',
          icon: _calcType == ChargeCalcType.percentage
              ? Icons.inventory_2_outlined
              : Icons.radio_button_unchecked_rounded,
          color: newBlueColor,
        ),
        if (prevCharges.isNotEmpty) ...[
          const Divider(height: 1, color: newBorderColor),
          ...prevCharges.asMap().entries.map((e) {
            final c = e.value;
            final isPlus = c.nature == ChargeNature.plus;
            final depAmt = c.calculatedAmount;
            final previewForFixed =
                (double.tryParse(_valueCtrl.text) ?? 0) + depAmt;
            return Column(children: [
              if (e.key > 0) const Divider(height: 1, color: newBorderColor),
              _dependsOption(
                id: c.localId,
                label: c.head?.label ?? '—',
                subtitle: _calcType == ChargeCalcType.percentage
                    ? '${isPlus ? "+" : "−"}₹${depAmt.toStringAsFixed(2)}'
                    : 'Amount = ₹${double.tryParse(_valueCtrl.text)?.toStringAsFixed(2) ?? "0.00"} + ₹${depAmt.toStringAsFixed(2)} = ₹${previewForFixed.toStringAsFixed(2)}',
                icon: isPlus
                    ? Icons.add_circle_outline_rounded
                    : Icons.remove_circle_outline_rounded,
                color: isPlus ? newGreenColor : newRedColor,
              ),
            ]);
          }),
        ],
      ]),
    );
  }

  Widget _dependsOption({
    required String? id,
    required String label,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _dependsOnLocalId == id;
    return InkWell(
      onTap: () => setState(() {
        _dependsOnLocalId = id;
        _dependsOnLabel = id == null ? null : label;
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color:
                    isSelected ? color.withValues(alpha: 0.12) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? color : newBorderColor)),
            alignment: Alignment.center,
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? color : newTextPrimary)),
              Text(subtitle,
                  style:
                      const TextStyle(fontSize: 10, color: newTextSecondary)),
            ]),
          ),
          if (isSelected)
            Icon(Icons.check_circle_rounded, size: 18, color: color),
        ]),
      ),
    );
  }

  // ── Preview card ───────────────────────────────────────────────────────────
  Widget _previewCard() {
    final val = double.tryParse(_valueCtrl.text) ?? 0.0;
    final isPlus = _nature == ChargeNature.plus;

    // Compute preview amount matching recalculation engine logic
    double base = widget.ctrl.subtotal;
    if (_dependsOnLocalId != null) {
      final dep = widget.ctrl.additionalCharges
          .firstWhereOrNull((c) => c.localId == _dependsOnLocalId);
      if (dep != null) base = dep.calculatedAmount.abs();
    }

    double computed;
    if (_calcType == ChargeCalcType.percentage) {
      computed = (val / 100.0) * base;
    } else {
      // Fixed
      computed = val;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPlus ? newGreenLightColor : newRedLightColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isPlus
              ? newGreenColor.withValues(alpha: 0.4)
              : newRedColor.withValues(alpha: 0.4),
        ),
      ),
      child: Row(children: [
        Icon(
          isPlus ? Icons.add_circle_rounded : Icons.remove_circle_rounded,
          color: isPlus ? newGreenColor : newRedColor,
          size: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              _head?.label ?? 'Preview',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isPlus ? newGreenColor : newRedColor),
            ),
            if (_calcType == ChargeCalcType.percentage)
              Text(
                '$val% of ₹${base.toStringAsFixed(2)} = ₹${computed.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 10, color: newTextSecondary),
              )
            else if (_dependsOnLocalId != null)
              Text(
                '₹${val.toStringAsFixed(2)} + ₹${base.toStringAsFixed(2)} = ₹${computed.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 10, color: newTextSecondary),
              ),
          ]),
        ),
        Text(
          '${isPlus ? "+" : "−"}₹${computed.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: isPlus ? newGreenColor : newRedColor),
        ),
      ]),
    );
  }

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w800, color: newTextPrimary),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// Attachments card — unchanged, kept in full
// ═══════════════════════════════════════════════════════════════════════════════
class _AttachmentsCard extends StatelessWidget {
  final GrnController ctrl;
  final BuildContext context;
  const _AttachmentsCard({required this.ctrl, required this.context});

  @override
  Widget build(BuildContext context) {
    return GrnCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const GrnSectionHead('Attachments'),
        _attachmentTypeChecklist(ctrl),
        const SizedBox(height: 12),
        ...ctrl.documentTypeList.expand((docType) {
          final isSelected = ctrl.selectedDocumentTypeIds.contains(docType.id);
          if (!isSelected) return <Widget>[];
          final isBillType = docType.label.toLowerCase().contains('invoice') ||
              docType.label.toLowerCase().contains('bill');
          final docs =
              isBillType ? ctrl.billAttachments : ctrl.challanAttachments;
          final existingUrls =
              isBillType ? ctrl.existingBillFiles : ctrl.existingDcFiles;
          final onCamera =
              isBillType ? ctrl.pickBillFromCamera : ctrl.pickChallanFromCamera;
          final onGallery = isBillType
              ? ctrl.pickBillFromGallery
              : ctrl.pickChallanFromGallery;
          final onFile = isBillType ? ctrl.pickBillFile : ctrl.pickChallanFile;
          final onRemove = isBillType
              ? ctrl.removeBillAttachment
              : ctrl.removeChallanAttachment;
          final onRemoveExisting = isBillType
              ? ctrl.removeExistingBillFile
              : ctrl.removeExistingDcFile;
          return [
            _attachmentSection(
              context: context,
              label: '${docType.label} Attachment',
              docs: docs,
              existingUrls: existingUrls,
              onCamera: onCamera,
              onGallery: onGallery,
              onFile: onFile,
              onRemove: onRemove,
              onRemoveExisting: onRemoveExisting,
            ),
            const SizedBox(height: 12),
          ];
        }).toList(),
        if (ctrl.billAttachments.isEmpty &&
            ctrl.challanAttachments.isEmpty &&
            ctrl.existingBillFiles.isEmpty &&
            ctrl.existingDcFiles.isEmpty) ...[
          GrnField(
            label: 'Reason for N/A Attachment',
            controller: ctrl.reasonNACtrl,
            hint: 'Explain why no attachment is available…',
            minLines: 3,
          ),
        ],
      ]),
    );
  }

  Widget _attachmentTypeChecklist(GrnController ctrl) {
    if (ctrl.isLoadingDocumentTypes) {
      return const SizedBox(
        height: 40,
        child: Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
                strokeWidth: 1.5, color: newBlueColor),
          ),
        ),
      );
    }
    if (ctrl.documentTypeList.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Document Type',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
      const SizedBox(height: 5),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: Column(
          children: ctrl.documentTypeList.asMap().entries.map((entry) {
            final i = entry.key;
            final doc = entry.value;
            final checked = ctrl.selectedDocumentTypeIds.contains(doc.id);
            return Column(children: [
              if (i > 0) const Divider(height: 1, color: newBorderColor),
              _checkItem(
                label: doc.label,
                checked: checked,
                onTap: () => ctrl.toggleDocumentType(doc.id),
              ),
            ]);
          }).toList(),
        ),
      ),
    ]);
  }

  Widget _checkItem(
      {required String label,
      required bool checked,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: checked ? newBlueColor : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: checked ? newBlueColor : newBorderColor,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: checked
                ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(fontSize: 13, color: newTextPrimary)),
        ]),
      ),
    );
  }

  Widget _attachmentSection({
    required BuildContext context,
    required String label,
    required List<GrnDocument> docs,
    required List<String> existingUrls,
    required VoidCallback onCamera,
    required VoidCallback onGallery,
    required VoidCallback onFile,
    required void Function(String id) onRemove,
    required void Function(int index) onRemoveExisting,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
      const SizedBox(height: 6),
      if (existingUrls.isNotEmpty) ...[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: newGreenLightColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(children: [
            const Icon(Icons.cloud_done_rounded,
                size: 12, color: newGreenColor),
            const SizedBox(width: 5),
            Text('${existingUrls.length} file(s) already on server',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: newGreenColor)),
          ]),
        ),
        const SizedBox(height: 6),
        ...existingUrls.asMap().entries.map((e) => _ExistingFileChip(
              url: e.value,
              onRemove: () => onRemoveExisting(e.key),
            )),
        const SizedBox(height: 6),
      ],
      Row(children: [
        _uploadBtn(Icons.camera_alt_outlined, 'Camera', onCamera),
        const SizedBox(width: 8),
        _uploadBtn(Icons.photo_library_outlined, 'Gallery', onGallery),
        const SizedBox(width: 8),
        _uploadBtn(Icons.attach_file_rounded, 'File', onFile),
      ]),
      if (docs.isNotEmpty) ...[
        const SizedBox(height: 8),
        ...docs.map((doc) => _fileChip(doc, onRemove)),
      ],
    ]);
  }

  Widget _uploadBtn(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: newBlueLightColor,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Icon(icon, size: 18, color: newBlueColor),
            const SizedBox(height: 3),
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: newBlueColor)),
          ]),
        ),
      ),
    );
  }

  Widget _fileChip(GrnDocument doc, void Function(String) onRemove) {
    final isPdf = doc.fileType == 'pdf';
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: newBorderColor),
      ),
      child: Row(children: [
        Icon(
          isPdf ? Icons.picture_as_pdf_outlined : Icons.image_outlined,
          size: 18,
          color: isPdf ? Colors.redAccent : newBlueColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(doc.fileName,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(doc.fileSize,
                style: const TextStyle(fontSize: 10, color: newTextSecondary)),
          ]),
        ),
        GestureDetector(
          onTap: () => onRemove(doc.id),
          child: const Icon(Icons.close_rounded,
              size: 16, color: newTextSecondary),
        ),
      ]),
    );
  }
}

class _ExistingFileChip extends StatelessWidget {
  final String url;
  final VoidCallback onRemove;

  const _ExistingFileChip({required this.url, required this.onRemove});

  Future<void> _openFile() async {
    String fullUrl = url.trim();
    if (!fullUrl.startsWith('http://') && !fullUrl.startsWith('https://')) {
      fullUrl = 'https://supportapi.digitalerp.biz/Images/$fullUrl';
    }
    final uri = Uri.tryParse(fullUrl);
    if (uri == null) return;
    try {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) debugPrint('❌ Could not launch: $fullUrl');
    } catch (e) {
      debugPrint('❌ launchUrl error: $e — url: $fullUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = url.split('/').last;
    final isPdf = fileName.toLowerCase().endsWith('.pdf');
    final isImage = ['jpg', 'jpeg', 'png', 'webp']
        .any((ext) => fileName.toLowerCase().endsWith(ext));

    return GestureDetector(
      onTap: _openFile,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: newGreenLightColor,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: newGreenColor.withValues(alpha: 0.4)),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Row(children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: newGreenColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Icon(
                  isPdf
                      ? Icons.picture_as_pdf_outlined
                      : isImage
                          ? Icons.image_outlined
                          : Icons.attach_file_rounded,
                  size: 18,
                  color: newGreenColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName.length > 30
                            ? '${fileName.substring(0, 27)}…'
                            : fileName,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: newTextPrimary),
                      ),
                      Row(children: [
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                              color: newGreenColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text('SERVER',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.open_in_new_rounded,
                            size: 10, color: newTextSecondary),
                        const SizedBox(width: 3),
                        const Text('Tap to open',
                            style: TextStyle(
                                fontSize: 9, color: newTextSecondary)),
                      ]),
                    ]),
              ),
              GestureDetector(
                onTap: onRemove,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: newRedLightColor,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                          color: newRedColor.withValues(alpha: 0.3))),
                  child: const Icon(Icons.delete_outline_rounded,
                      size: 14, color: newRedColor),
                ),
              ),
            ]),
          ),
          if (isImage && url.startsWith('http'))
            GestureDetector(
              onTap: _openFile,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(8)),
                child: Image.network(
                  url,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 60,
                    color: newSurfaceColor,
                    alignment: Alignment.center,
                    child: const Text('Preview unavailable',
                        style:
                            TextStyle(fontSize: 11, color: newTextSecondary)),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
