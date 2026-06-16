// // lib/screens/mrn/mrn_detail_screen.dart
// import 'package:flutter/material.dart';
// import '../model/mrn_models.dart';
// import '../widgets/app_theme.dart';
//
// // Local helpers
// String _fmtDate(DateTime d) =>
//     '${d.day.toString().padLeft(2, '0')}/'
//         '${d.month.toString().padLeft(2, '0')}/${d.year}';
//
// String _fmtDateTime(DateTime d) =>
//     '${_fmtDate(d)}  '
//         '${d.hour.toString().padLeft(2, '0')}:'
//         '${d.minute.toString().padLeft(2, '0')}';
//
// String _fmtCurrency(double v) =>
//     '₹${v.toStringAsFixed(2).replaceAllMapped(
//       RegExp(r'(\d)(?=(\d{3})+\.)'),
//           (m) => '${m[1]},',
//     )}';
//
// Future<bool> _showConfirmDialog({
//   required BuildContext context,
//   required String title,
//   required String message,
//   required String confirmLabel,
//   bool isDanger = false,
// }) async {
//   final result = await showDialog<bool>(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       shape:
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: Text(title),
//       content: Text(message),
//       actions: [
//         TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: const Text('Cancel')),
//         ElevatedButton(
//           onPressed: () => Navigator.pop(ctx, true),
//           style: ElevatedButton.styleFrom(
//             backgroundColor:
//             isDanger ? AppColors.error : AppColors.purple,
//             foregroundColor: Colors.white,
//           ),
//           child: Text(confirmLabel),
//         ),
//       ],
//     ),
//   );
//   return result ?? false;
// }
//
// //
// class MRNDetailScreen extends StatefulWidget {
//   final String mrnId;
//   const MRNDetailScreen({super.key, required this.mrnId});
//   @override
//   State<MRNDetailScreen> createState() => _MRNDetailScreenState();
// }
//
// class _MRNDetailScreenState extends State<MRNDetailScreen> {
//   MRN? _mrn;
//
//   // Flip to false to test executive (resubmit) flow
//   final bool _isManager = true;
//
//   @override
//   void initState() {
//     super.initState();
//     try {
//       _mrn = MRNDummyData.mrns
//           .firstWhere((m) => m.mrnId == widget.mrnId);
//     } catch (_) {
//       _mrn = null;
//     }
//   }
//
//   Future<void> _changeStatus() async {
//     final mrn = _mrn;
//     if (mrn == null) return;
//
//     final options = _isManager
//         ? [
//       {'label': 'Approve', 'id': 3, 'color': AppColors.success},
//       {'label': 'Reject',  'id': 4, 'color': AppColors.error},
//     ]
//         : mrn.statusId == 4
//         ? [{'label': 'Resubmit', 'id': 2, 'color': AppColors.info}]
//         : <Map<String, dynamic>>[];
//
//     if (options.isEmpty) return;
//
//     final remarksCtrl = TextEditingController();
//     int? selectedId;
//
//     await showDialog(
//       context: context,
//       builder: (ctx) => StatefulBuilder(
//         builder: (ctx, setS) => AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16)),
//           title: Text('Update Status', style: AppTextStyles.h3),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ...options.map((o) => RadioListTile<int>(
//                 value: o['id'] as int,
//                 groupValue: selectedId,
//                 activeColor: o['color'] as Color,
//                 title: Text(o['label'] as String,
//                     style: AppTextStyles.body),
//                 onChanged: (v) => setS(() => selectedId = v),
//               )),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: remarksCtrl,
//                 decoration: const InputDecoration(
//                   hintText: 'Remarks (optional)',
//                   contentPadding: EdgeInsets.symmetric(
//                       horizontal: 12, vertical: 10),
//                 ),
//                 maxLines: 2,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(ctx),
//                 child: const Text('Cancel')),
//             ElevatedButton(
//               onPressed:
//               selectedId == null ? null : () => Navigator.pop(ctx),
//               child: const Text('Update'),
//             ),
//           ],
//         ),
//       ),
//     );
//
//     if (selectedId != null && mounted) {
//       const statusLabels = {
//         1: 'Draft',
//         2: 'Submitted',
//         3: 'Approved',
//         4: 'Rejected',
//       };
//       setState(() {
//         _mrn = MRN(
//           mrnId:           mrn.mrnId,
//           mrnNumber:       mrn.mrnNumber,
//           mrnDate:         mrn.mrnDate,
//           statusId:        selectedId!,
//           status:          statusLabels[selectedId] ?? mrn.status,
//           supplierName:    mrn.supplierName,
//           siteName:        mrn.siteName,
//           warehouseName:   mrn.warehouseName,
//           customerPO:      mrn.customerPO,
//           billNo:          mrn.billNo,
//           billDate:        mrn.billDate,
//           paidByName:      mrn.paidByName,
//           createdByName:   mrn.createdByName,
//           createdAt:       mrn.createdAt,
//           remarks:         remarksCtrl.text.trim().isEmpty
//               ? mrn.remarks
//               : remarksCtrl.text.trim(),
//           itemCount:       mrn.itemCount,
//           items:           mrn.items,
//           attachments:     mrn.attachments,
//           subTotal:        mrn.subTotal,
//           taxAmount:       mrn.taxAmount,
//           deliveryCharges: mrn.deliveryCharges,
//           totalAmount:     mrn.totalAmount,
//         );
//       });
//     }
//   }
//
//   Future<void> _delete() async {
//     final mrn = _mrn;
//     if (mrn == null) return;
//     final ok = await _showConfirmDialog(
//       context: context,
//       title: 'Delete MRN',
//       message: 'Delete ${mrn.mrnNumber}? This cannot be undone.',
//       confirmLabel: 'Delete',
//       isDanger: true,
//     );
//     if (ok && mounted) Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mrn = _mrn;
//     final canDelete =
//         mrn != null && (mrn.statusId == 1 || mrn.statusId == 2);
//     final canUpdateStatus = mrn != null &&
//         (_isManager ? mrn.statusId == 2 : mrn.statusId == 4);
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(mrn?.mrnNumber ?? 'MRN Detail'),
//         actions: [
//           if (canDelete) ...[
//             GestureDetector(
//               onTap: _delete,
//               child: Container(
//                 width: 36,
//                 height: 36,
//                 margin: const EdgeInsets.only(right: 4),
//                 decoration: BoxDecoration(
//                   color: AppColors.errorLight,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(Icons.delete_outline_rounded,
//                     size: 18, color: AppColors.error),
//               ),
//             ),
//             const SizedBox(width: 8),
//           ],
//         ],
//       ),
//
//       body: mrn == null
//           ? Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('MRN not found', style: AppTextStyles.h3),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () => setState(() {}),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       )
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _MRNHeader(
//               mrn: mrn,
//               canUpdate: canUpdateStatus,
//               onStatusTap: _changeStatus,
//             ),
//             const SizedBox(height: 16),
//
//             _MRNInfoCard(mrn: mrn),
//             const SizedBox(height: 16),
//
//             Text('Line Items (${mrn.itemCount})',
//                 style: AppTextStyles.h3),
//             const SizedBox(height: 12),
//
//             mrn.items.isEmpty
//                 ? Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(color: AppColors.border),
//               ),
//               child: Center(
//                 child: Text(
//                   'No item details available.\n'
//                       'Total items: ${mrn.itemCount}',
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.body.copyWith(
//                       color: AppColors.textSecondary),
//                 ),
//               ),
//             )
//                 : _MRNItemsTable(items: mrn.items),
//
//             const SizedBox(height: 16),
//             _TotalsCard(mrn: mrn),
//
//             if (mrn.remarks != null && mrn.remarks!.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppColors.warningLight,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Remarks',
//                         style: AppTextStyles.label(
//                             color: AppColors.warning,
//                             weight: FontWeight.w600)),
//                     const SizedBox(height: 4),
//                     Text(mrn.remarks!,
//                         style: AppTextStyles.body
//                             .copyWith(color: AppColors.warning)),
//                   ],
//                 ),
//               ),
//             ],
//
//             if (mrn.attachments.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               Text('Attachments (${mrn.attachments.length})',
//                   style: AppTextStyles.h3),
//               const SizedBox(height: 12),
//               _AttachmentsCard(attachments: mrn.attachments),
//             ],
//
//             if (canUpdateStatus) ...[
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton.icon(
//                   onPressed: _changeStatus,
//                   icon: const Icon(Icons.update_rounded, size: 20),
//                   label: const Text('Update Status'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.purple,
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18)),
//                   ),
//                 ),
//               ),
//             ],
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Header card
// class _MRNHeader extends StatelessWidget {
//   final MRN mrn;
//   final bool canUpdate;
//   final VoidCallback onStatusTap;
//   const _MRNHeader(
//       {required this.mrn,
//         required this.canUpdate,
//         required this.onStatusTap});
//
//   Color get _statusColor {
//     switch (mrn.statusId) {
//       case 3:  return AppColors.success;
//       case 4:  return AppColors.error;
//       case 2:  return AppColors.info;
//       default: return AppColors.orange;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             Expanded(
//               child: Text(mrn.mrnNumber,
//                   style: AppTextStyles.h3
//                       .copyWith(fontWeight: FontWeight.bold)),
//             ),
//             GestureDetector(
//               onTap: canUpdate ? onStatusTap : null,
//               child: Row(children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: _statusColor.withValues(alpha: 0.12),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(mrn.status,
//                       style: TextStyle(
//                           color: _statusColor,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 12)),
//                 ),
//                 if (canUpdate) ...[
//                   const SizedBox(width: 4),
//                   const Icon(Icons.arrow_drop_down_rounded,
//                       size: 18, color: AppColors.textSecondary),
//                 ],
//               ]),
//             ),
//           ]),
//           const SizedBox(height: 8),
//           Text(
//             mrn.supplierName?.isNotEmpty == true
//                 ? mrn.supplierName!
//                 : 'No Supplier',
//             style: AppTextStyles.body
//                 .copyWith(color: AppColors.textSecondary),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  Info card
// class _MRNInfoCard extends StatelessWidget {
//   final MRN mrn;
//   const _MRNInfoCard({required this.mrn});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(children: [
//         _InfoRow(label: 'MRN Date',  value: _fmtDate(mrn.mrnDate)),
//         const Divider(),
//         _InfoRow(label: 'Site',
//             value: mrn.siteName?.isNotEmpty == true ? mrn.siteName! : '—'),
//         const Divider(),
//         _InfoRow(label: 'Godown / Warehouse',
//             value: mrn.warehouseName?.isNotEmpty == true
//                 ? mrn.warehouseName!
//                 : '—'),
//         if (mrn.customerPO?.isNotEmpty == true) ...[
//           const Divider(),
//           _InfoRow(label: 'Customer PO', value: mrn.customerPO!),
//         ],
//         if (mrn.billNo?.isNotEmpty == true) ...[
//           const Divider(),
//           _InfoRow(label: 'Bill No.', value: mrn.billNo!),
//         ],
//         if (mrn.billDate != null) ...[
//           const Divider(),
//           _InfoRow(label: 'Bill Date', value: _fmtDate(mrn.billDate!)),
//         ],
//         if (mrn.paidByName?.isNotEmpty == true) ...[
//           const Divider(),
//           _InfoRow(label: 'Paid By', value: mrn.paidByName!),
//         ],
//         const Divider(),
//         _InfoRow(label: 'Created By', value: mrn.createdByName),
//         const Divider(),
//         _InfoRow(label: 'Created At', value: _fmtDateTime(mrn.createdAt)),
//       ]),
//     );
//   }
// }
//
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//   const _InfoRow({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 140,
//             child: Text(label,
//                 style: AppTextStyles.body
//                     .copyWith(color: AppColors.textSecondary)),
//           ),
//           Expanded(
//             child: Text(value,
//                 style: AppTextStyles.body
//                     .copyWith(fontWeight: FontWeight.w500)),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  Items table
// class _MRNItemsTable extends StatelessWidget {
//   final List<MRNItem> items;
//   const _MRNItemsTable({required this.items});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(children: [
//         Container(
//           padding:
//           const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//           decoration: const BoxDecoration(
//             color: AppColors.background,
//             borderRadius:
//             BorderRadius.vertical(top: Radius.circular(11)),
//           ),
//           child: Row(children: [
//             Expanded(
//                 flex: 3,
//                 child: Text('Item', style: AppTextStyles.label())),
//             Expanded(
//                 child: Text('Qty',
//                     style: AppTextStyles.label(),
//                     textAlign: TextAlign.center)),
//             Expanded(
//                 child: Text('Rate',
//                     style: AppTextStyles.label(),
//                     textAlign: TextAlign.right)),
//             Expanded(
//                 child: Text('Net',
//                     style: AppTextStyles.label(),
//                     textAlign: TextAlign.right)),
//           ]),
//         ),
//         const Divider(height: 1),
//         ...items.asMap().entries.map((e) {
//           final i    = e.key;
//           final item = e.value;
//           return Column(children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 14, vertical: 12),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.itemName.isNotEmpty
//                               ? item.itemName
//                               : 'Item #${item.erpItemId}',
//                           style: AppTextStyles.body
//                               .copyWith(fontWeight: FontWeight.w500),
//                         ),
//                         if (item.itemCode?.isNotEmpty == true)
//                           Text(item.itemCode!,
//                               style: AppTextStyles.label(
//                                   color: AppColors.textTertiary)),
//                         Text(item.unit,
//                             style: AppTextStyles.label(
//                                 color: AppColors.textTertiary)),
//                         if (item.taxAmount > 0)
//                           Text(
//                             'Tax: ₹${item.taxAmount.toStringAsFixed(2)}'
//                                 ' (S:${item.sgstPercent}%'
//                                 ' C:${item.cgstPercent}%'
//                                 ' I:${item.igstPercent}%)',
//                             style: AppTextStyles.label(
//                                 color: AppColors.textSecondary),
//                           ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       item.quantity % 1 == 0
//                           ? item.quantity.toInt().toString()
//                           : item.quantity.toString(),
//                       style: AppTextStyles.body,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       '₹${item.unitPrice.toStringAsFixed(2)}',
//                       style: AppTextStyles.body,
//                       textAlign: TextAlign.right,
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       '₹${item.totalPrice.toStringAsFixed(2)}',
//                       style: AppTextStyles.body
//                           .copyWith(fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.right,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (i < items.length - 1) const Divider(height: 1),
//           ]);
//         }),
//       ]),
//     );
//   }
// }
//
// //  Totals card
// class _TotalsCard extends StatelessWidget {
//   final MRN mrn;
//   const _TotalsCard({required this.mrn});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: AppColors.purpleLight,
//         borderRadius: BorderRadius.circular(10),
//         border:
//         Border.all(color: AppColors.purple.withValues(alpha: 0.2)),
//       ),
//       child: Column(children: [
//         _TotalRow(
//             label: 'Sub Total',
//             value: '₹${mrn.subTotal.toStringAsFixed(2)}'),
//         const SizedBox(height: 4),
//         _TotalRow(
//             label: 'Tax Amount',
//             value: '₹${mrn.taxAmount.toStringAsFixed(2)}'),
//         const SizedBox(height: 4),
//         _TotalRow(
//             label: 'Delivery Charges',
//             value: '₹${mrn.deliveryCharges.toStringAsFixed(2)}'),
//         const Divider(height: 16),
//         _TotalRow(
//           label: 'Total Amount',
//           value: _fmtCurrency(mrn.totalAmount),
//           isTotal: true,
//         ),
//       ]),
//     );
//   }
// }
//
// class _TotalRow extends StatelessWidget {
//   final String label;
//   final String value;
//   final bool   isTotal;
//   const _TotalRow(
//       {required this.label, required this.value, this.isTotal = false});
//
//   @override
//   Widget build(BuildContext context) => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(label,
//           style: isTotal
//               ? AppTextStyles.body
//               .copyWith(fontWeight: FontWeight.w600)
//               : AppTextStyles.body
//               .copyWith(color: AppColors.textSecondary)),
//       Text(value,
//           style: isTotal
//               ? AppTextStyles.h3.copyWith(
//               color: AppColors.purple,
//               fontWeight: FontWeight.bold)
//               : AppTextStyles.body
//               .copyWith(fontWeight: FontWeight.w500)),
//     ],
//   );
// }
//
// // -Attachments card
// class _AttachmentsCard extends StatelessWidget {
//   final List<MRNAttachment> attachments;
//   const _AttachmentsCard({required this.attachments});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: attachments.asMap().entries.map((e) {
//           final i   = e.key;
//           final att = e.value;
//           return Column(children: [
//             ListTile(
//               leading: Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: AppColors.errorLight,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(Icons.picture_as_pdf_rounded,
//                     size: 18, color: AppColors.error),
//               ),
//               title: Text(att.fileName,
//                   style: AppTextStyles.body
//                       .copyWith(fontWeight: FontWeight.w500)),
//               subtitle: Text(
//                 '${att.category} • ${_fmtDate(att.uploadedAt)}',
//                 style: AppTextStyles.label(
//                     color: AppColors.textTertiary),
//               ),
//               trailing: const Icon(Icons.open_in_new_rounded,
//                   size: 16, color: AppColors.textSecondary),
//               onTap: () {/* TODO: open att.filePath */},
//             ),
//             if (i < attachments.length - 1) const Divider(height: 1),
//           ]);
//         }).toList(),
//       ),
//     );
//   }
// }