// // import 'dart:io';
// // import 'package:digitalerp/model/get_expense_list_new_response_model.dart';
// // import 'package:digitalerp/screen/ui/home/reimbursements/controller/reimbursement_controller.dart';
// // import 'package:digitalerp/utils/app_constant_new.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// //
// // //  Design tokens
// // const Color _kCard = Colors.white;
// // const Color _kBlue = purpleColor;
// // const Color _kLabel = Color(0xFF1A1A2E);
// // const Color _kSub = Color(0xFF888888);
// // const Color _kBorder = Color(0xFFE8E8E8);
// //
// // class ReimbursementDetailScreen extends StatefulWidget {
// //   /// Pass the list-card data so we can show status/amounts immediately,
// //   /// even before the detail API responds.
// //   final ExpenseData listItem;
// //
// //   const ReimbursementDetailScreen({
// //     Key? key,
// //     required this.listItem,
// //   }) : super(key: key);
// //
// //   @override
// //   State<ReimbursementDetailScreen> createState() =>
// //       _ReimbursementDetailScreenState();
// // }
// //
// // class _ReimbursementDetailScreenState extends State<ReimbursementDetailScreen> {
// //   late final ReimbursementController ctrl;
// //
// //   bool _isEditMode = false; // ← New
// //   final TextEditingController _descriptionController = TextEditingController();
// //   final TextEditingController _notesController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     ctrl = Get.find<ReimbursementController>();
// //
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (widget.listItem.expenseId != null) {
// //         ctrl.getExpenseDetail(widget.listItem.expenseId!);
// //       }
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _descriptionController.dispose();
// //     _notesController.dispose();
// //     super.dispose();
// //   }
// //
// //   // Toggle between view and edit mode
// //   void _toggleEditMode() {
// //     final header = ctrl.getExpenseDetailResponseModel?.data?.header;
// //     if (header == null) return;
// //
// //     setState(() {
// //       _isEditMode = !_isEditMode;
// //
// //       if (_isEditMode) {
// //         _descriptionController.text = header.expenseDescription ?? '';
// //         _notesController.text = header.additionalNotes ?? '';
// //       }
// //     });
// //   }
// //
// //   // // Save changes (you'll call your update API here)
// //   // Future<void> _saveChanges() async {
// //   //   final header = ctrl.getExpenseDetailResponseModel?.data?.header;
// //   //   if (header == null) return;
// //   //
// //   //   // TODO: Call your update API here with:
// //   //   // expenseId, new description, new notes, etc.
// //   //
// //   //   // For now, just show success and exit edit mode
// //   //   Get.snackbar("Success", "Changes saved successfully",
// //   //       backgroundColor: Colors.green, colorText: Colors.white);
// //   //
// //   //   setState(() => _isEditMode = false);
// //   // }
// //   // Future<void> _saveReimbursementChanges() async {
// //   //   final header = ctrl.getExpenseDetailResponseModel?.data?.header;
// //   //   if (header == null) return;
// //   //
// //   //   final requestData = {
// //   //     "compid": ctrl.homeController.currentUserData?.compId ?? 111,
// //   //     "branchid": ctrl.homeController.currentUserData?.branchId ?? 201,
// //   //     "userid": ctrl.homeController.currentUserData?.userid ?? 748937,
// //   //
// //   //     "expenseid": header.expenseId,           // Important for editing
// //   //     "expensedate": header.expenseDate ?? widget.listItem.expenseDate,
// //   //     "expensedescription": _descriptionController.text.trim(),
// //   //     "additionalnotes": _notesController.text.trim(),
// //   //     "amount": header.totalAmount ?? widget.listItem.amount,   // or allow editing amount too
// //   //     // Add other fields as per final API
// //   //   };
// //   //
// //   //   try {
// //   //     // Call the same method that will be used for Add Expense
// //   //     final result = await ReimbursementRepo.submitReimbursementMethod(requestData);
// //   //
// //   //     if (result.statusCode == 200 && result.data?['success'] == true) {
// //   //       Get.snackbar(
// //   //         "Success",
// //   //         result.data?['message'] ?? "Expense updated successfully",
// //   //         backgroundColor: Colors.green,
// //   //         colorText: Colors.white,
// //   //       );
// //   //
// //   //       setState(() => _isEditMode = false);
// //   //
// //   //       // Refresh detail after save
// //   //       ctrl.getExpenseDetail(header.expenseId!);
// //   //     } else {
// //   //       Get.snackbar(
// //   //         "Error",
// //   //         result.data?['message'] ?? "Failed to update expense",
// //   //         backgroundColor: Colors.red,
// //   //         colorText: Colors.white,
// //   //       );
// //   //     }
// //   //   } catch (e) {
// //   //     Get.snackbar("Error", "Something went wrong while saving");
// //   //   }
// //   // }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F6FA),
// //       body: Column(children: [
// //         _appBar(context),
// //         Expanded(child: Obx(() => _body())),
// //       ]),
// //     );
// //   }
// //
// //   //  App bar
// //   Widget _appBar(BuildContext context) => Container(
// //         color: _kCard,
// //         padding: EdgeInsets.only(
// //           top: MediaQuery.of(context).padding.top + 4,
// //           bottom: 14,
// //           left: 16,
// //           right: 16,
// //         ),
// //         child: Row(children: [
// //           IconButton(
// //             onPressed: () => Get.back(),
// //             icon:
// //                 const Icon(Icons.arrow_back_ios_new, color: _kLabel, size: 20),
// //           ),
// //           Expanded(
// //             child:
// //                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //               Text("Expense Details",
// //                   style: GoogleFonts.dmSans(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w700,
// //                       color: _kLabel)),
// //               if ((widget.listItem.expenseNo ?? '').isNotEmpty)
// //                 Text(widget.listItem.expenseNo!,
// //                     style: GoogleFonts.dmSans(fontSize: 13, color: _kSub)),
// //             ]),
// //           ),
// //         ]),
// //       );
// //
// //   //  Body
// //   Widget _body() {
// //     if (ctrl.isLoading.value) {
// //       return const Center(child: CircularProgressIndicator(color: purpleColor));
// //     }
// //
// //     final header =
// //         ctrl.getExpenseDetailResponseModel?.data?.header; // ← Use .value
// //     final items = ctrl.getExpenseDetailResponseModel?.data?.items ?? [];
// //
// //     final listItem = widget.listItem;
// //
// //     final bool canEdit = header?.isEditable == 1;
// //
// //     return SingleChildScrollView(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Status Banner
// //           _statusBanner(listItem.approvalStatus),
// //           const SizedBox(height: 16),
// //
// //           // Basic Info from List
// //           _sectionCard("Expense Information", [
// //             _row("Expense No", listItem.expenseNo ?? "—", Icons.tag_outlined,
// //                 _kBlue),
// //             _divider(),
// //             _row("Date", listItem.expenseDate ?? "—",
// //                 Icons.calendar_today_outlined, const Color(0xFF7B61FF)),
// //             _divider(),
// //             _row("Employee", listItem.employeeName ?? "—", Icons.person_outline,
// //                 const Color(0xFF00897B)),
// //             _divider(),
// //             _row("Site", listItem.site ?? "—", Icons.location_on_outlined,
// //                 const Color(0xFFE65100)),
// //             if ((listItem.entryFlag ?? '').isNotEmpty) ...[
// //               _divider(),
// //               _row("Entry Flag", listItem.entryFlag!, Icons.flag_outlined,
// //                   const Color(0xFF1976D2)),
// //             ],
// //           ]),
// //           const SizedBox(height: 12),
// //
// //           // Detailed Info + Edit Button
// //           // Detailed Info from GetExpenseDetail API
// //           if (header != null) ...[
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text("Reimbursement Info",
// //                     style: GoogleFonts.dmSans(
// //                         fontSize: 13,
// //                         fontWeight: FontWeight.w700,
// //                         color: _kSub)),
// //                 if (header.isEditable == 1)
// //                   TextButton.icon(
// //                     onPressed: _toggleEditMode,
// //                     icon: Icon(_isEditMode ? Icons.save : Icons.edit, size: 18),
// //                     label: Text(_isEditMode ? "Save" : "Edit"),
// //                     style: TextButton.styleFrom(foregroundColor: purpleColor),
// //                   ),
// //               ],
// //             ),
// //             const SizedBox(height: 8),
// //
// //             _sectionCard("", [
// //               _row("Requested By", header.requestedBy ?? "—",
// //                   Icons.person_outline, _kBlue),
// //               _divider(),
// //               _row("Site", header.siteName ?? "—", Icons.location_on_outlined,
// //                   _kBlue),
// //               _divider(),
// //               _row("Status", header.approvalStatus ?? "—", Icons.info_outline,
// //                   _getStatusColor(header.approvalStatus)),
// //               _divider(),
// //               _row(
// //                   "Total Amount",
// //                   "₹ ${header.totalAmount?.toStringAsFixed(2) ?? "0.00"}",
// //                   Icons.currency_rupee_outlined,
// //                   Colors.green),
// //
// //               // Editable Description
// //               _divider(),
// //               _isEditMode
// //                   ? _editableRow("Description", _descriptionController,
// //                       Icons.description_outlined)
// //                   : _row(
// //                       "Description",
// //                       header.expenseDescription?.isNotEmpty == true
// //                           ? header.expenseDescription!
// //                           : "—",
// //                       Icons.description_outlined,
// //                       const Color(0xFF6D4C41)),
// //
// //               // Editable Additional Notes
// //               if (_isEditMode ||
// //                   (header.additionalNotes?.isNotEmpty ?? false)) ...[
// //                 _divider(),
// //                 _isEditMode
// //                     ? _editableRow("Additional Notes", _notesController,
// //                         Icons.note_alt_outlined)
// //                     : _row("Additional Notes", header.additionalNotes!,
// //                         Icons.note_alt_outlined, _kSub),
// //               ],
// //
// //               if ((header.reason ?? '').isNotEmpty && !_isEditMode) ...[
// //                 _divider(),
// //                 _row("Reason", header.reason!, Icons.report_problem_outlined,
// //                     Colors.orange),
// //               ],
// //             ]),
// //
// //             const SizedBox(height: 16),
// //
// //             // Items Section (for now read-only)
// //             if (items.isNotEmpty)
// //               _sectionCard("Expense Items (${items.length})", [
// //                 ...items.map((item) => Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         _row("Item", item.expenseLedger ?? "—", Icons.list_alt,
// //                             _kBlue),
// //                         _row("Description", item.description ?? "—",
// //                             Icons.text_fields, _kSub),
// //                         _row("Group", item.expenseGroup ?? "—", Icons.category,
// //                             _kSub),
// //                         _row(
// //                             "Amount",
// //                             "₹ ${item.amount?.toStringAsFixed(2) ?? "0.00"}",
// //                             Icons.currency_rupee,
// //                             Colors.green),
// //                         if ((item.referenceFile?.isNotEmpty ?? false) ||
// //                             (item.receiptFile?.isNotEmpty ?? false))
// //                           _row(
// //                               "Documents",
// //                               "Ref: ${item.hasReferenceFile == 1 ? '✓' : '✗'} | Receipt: ${item.hasReceiptFile == 1 ? '✓' : '✗'}",
// //                               Icons.attach_file,
// //                               Colors.blueGrey),
// //                         if (items.indexOf(item) != items.length - 1) _divider(),
// //                       ],
// //                     )),
// //               ])
// //             else
// //               const Padding(
// //                 padding: EdgeInsets.symmetric(vertical: 20),
// //                 child: Center(child: Text("No expense items found")),
// //               ),
// //           ] else ...[
// //             const Padding(
// //               padding: EdgeInsets.symmetric(vertical: 40),
// //               child: Center(
// //                   child: Text("Failed to load detailed information",
// //                       style: TextStyle(color: Colors.grey))),
// //             ),
// //           ],
// //
// //           const SizedBox(height: 12),
// //           _amountCard(listItem),
// //           const SizedBox(height: 32),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   //  Status banner (uses ExpenseData.approvalStatus)
// //   Widget _statusBanner(String? status) {
// //     final label = (status ?? '').trim().isEmpty ? "Pending" : status!.trim();
// //
// //     Color bg, fg;
// //     IconData icon;
// //     switch (label.toLowerCase()) {
// //       case 'approved':
// //         bg = newGreenLightColor;
// //         fg = newGreenColor;
// //         icon = Icons.check_circle_outline;
// //         break;
// //       case 'rejected':
// //         bg = newRedLightColor;
// //         fg = newRedColor;
// //         icon = Icons.cancel_outlined;
// //         break;
// //       default:
// //         bg = newOrangeLightColor;
// //         fg = newOrangeColor;
// //         icon = Icons.hourglass_top_outlined;
// //     }
// //
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       decoration:
// //           BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
// //       child: Row(children: [
// //         Icon(icon, color: fg, size: 24),
// //         const SizedBox(width: 12),
// //         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //           Text("Approval Status",
// //               style: GoogleFonts.dmSans(
// //                   fontSize: 12, color: fg.withValues(alpha: 0.8))),
// //           Text(label,
// //               style: GoogleFonts.dmSans(
// //                   fontSize: 16, fontWeight: FontWeight.w700, color: fg)),
// //         ]),
// //       ]),
// //     );
// //   }
// //
// //   //  Amount card (uses ExpenseData amounts)
// //   Widget _amountCard(ExpenseData item) => Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: BoxDecoration(
// //           gradient: const LinearGradient(
// //               colors: [purpleColor, Color(0xFF9575CD)],
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight),
// //           borderRadius: BorderRadius.circular(14),
// //           boxShadow: [
// //             BoxShadow(
// //                 color: purpleColor.withValues(alpha: 0.3),
// //                 blurRadius: 8,
// //                 offset: const Offset(0, 4))
// //           ],
// //         ),
// //         child:
// //             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
// //           // Left — claimed amount
// //           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //             Text("Claimed Amount",
// //                 style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white70)),
// //             const SizedBox(height: 4),
// //             Text("₹${item.amount ?? 0}",
// //                 style: GoogleFonts.dmSans(
// //                     fontSize: 26,
// //                     fontWeight: FontWeight.w800,
// //                     color: Colors.white)),
// //           ]),
// //           // Right — approved / balance
// //           Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
// //             _miniAmt("Approved", item.approvedAmt),
// //             const SizedBox(height: 4),
// //             _miniAmt("Balance", item.balanceAmt),
// //           ]),
// //         ]),
// //       );
// //
// //   Widget _miniAmt(String label, num? amt) => Column(
// //         crossAxisAlignment: CrossAxisAlignment.end,
// //         children: [
// //           Text(label,
// //               style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white60)),
// //           Text("₹${amt ?? 0}",
// //               style: GoogleFonts.dmSans(
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.w700,
// //                   color: Colors.white)),
// //         ],
// //       );
// //
// //   //  Section card
// //   Widget _sectionCard(String title, List<Widget> children) => Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(title,
// //               style: GoogleFonts.dmSans(
// //                   fontSize: 13, fontWeight: FontWeight.w700, color: _kSub)),
// //           const SizedBox(height: 8),
// //           Container(
// //             decoration: BoxDecoration(
// //               color: _kCard,
// //               borderRadius: BorderRadius.circular(14),
// //               border: Border.all(color: _kBorder),
// //               boxShadow: [
// //                 BoxShadow(
// //                     color: Colors.black.withValues(alpha: 0.03),
// //                     blurRadius: 6,
// //                     offset: const Offset(0, 2))
// //               ],
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(children: children),
// //             ),
// //           ),
// //         ],
// //       );
// //
// //   Widget _row(String title, String value, IconData icon, Color color) =>
// //       Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 6),
// //         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //           Container(
// //             padding: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(
// //                 color: color.withValues(alpha: 0.1),
// //                 borderRadius: BorderRadius.circular(8)),
// //             child: Icon(icon, color: color, size: 18),
// //           ),
// //           const SizedBox(width: 12),
// //           Expanded(
// //               child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                 Text(title,
// //                     style: GoogleFonts.dmSans(fontSize: 12, color: _kSub)),
// //                 const SizedBox(height: 2),
// //                 Text(value,
// //                     style: GoogleFonts.dmSans(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w600,
// //                         color: _kLabel)),
// //               ])),
// //         ]),
// //       );
// //
// //   Widget _divider() => const Padding(
// //         padding: EdgeInsets.symmetric(vertical: 2),
// //         child: Divider(height: 1, color: _kBorder),
// //       );
// //
// //   //  Attachments
// //   Widget _attachmentsSection(List<String> docs) => Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text("Attachments (${docs.length})",
// //               style: GoogleFonts.dmSans(
// //                   fontSize: 13, fontWeight: FontWeight.w700, color: _kSub)),
// //           const SizedBox(height: 8),
// //           ...docs.map((p) => _attachmentTile(p)),
// //         ],
// //       );
// //
// //   Widget _attachmentTile(String filePath) {
// //     final name = filePath.split('/').last;
// //     final isImage = RegExp(r'\.(jpg|jpeg|png|webp)$', caseSensitive: false)
// //         .hasMatch(filePath);
// //
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 8),
// //       decoration: BoxDecoration(
// //           color: _kCard,
// //           borderRadius: BorderRadius.circular(12),
// //           border: Border.all(color: _kBorder)),
// //       child: ListTile(
// //         contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
// //         leading: Container(
// //           width: 42,
// //           height: 42,
// //           decoration: BoxDecoration(
// //               color: const Color(0xFFEEF2FF),
// //               borderRadius: BorderRadius.circular(10)),
// //           child: Icon(
// //               isImage ? Icons.image_outlined : Icons.attach_file_outlined,
// //               color: _kBlue,
// //               size: 20),
// //         ),
// //         title: Text(name,
// //             overflow: TextOverflow.ellipsis,
// //             style:
// //                 GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500)),
// //         trailing: Container(
// //           padding: const EdgeInsets.all(6),
// //           decoration: BoxDecoration(
// //               color: const Color(0xFFEEF2FF),
// //               borderRadius: BorderRadius.circular(8)),
// //           child: const Icon(Icons.remove_red_eye_outlined,
// //               color: _kBlue, size: 18),
// //         ),
// //         onTap: () => _viewAttachment(filePath, isImage),
// //       ),
// //     );
// //   }
// //
// //   void _viewAttachment(String filePath, bool isImage) {
// //     if (!isImage) {
// //       showDialog(
// //         context: context,
// //         builder: (_) => AlertDialog(
// //           title: Text("Attachment",
// //               style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
// //           content: Text(filePath.split('/').last, style: GoogleFonts.dmSans()),
// //           actions: [
// //             TextButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 child: const Text("Close")),
// //           ],
// //         ),
// //       );
// //       return;
// //     }
// //
// //     showDialog(
// //       context: context,
// //       barrierColor: Colors.black87,
// //       builder: (_) => Dialog(
// //         backgroundColor: Colors.transparent,
// //         insetPadding: const EdgeInsets.all(12),
// //         child: Column(mainAxisSize: MainAxisSize.min, children: [
// //           Align(
// //             alignment: Alignment.topRight,
// //             child: GestureDetector(
// //               onTap: () => Navigator.pop(context),
// //               child: Container(
// //                 margin: const EdgeInsets.only(bottom: 8),
// //                 padding: const EdgeInsets.all(6),
// //                 decoration: BoxDecoration(
// //                     color: Colors.white.withValues(alpha: 0.2),
// //                     shape: BoxShape.circle),
// //                 child: const Icon(Icons.close, color: Colors.white, size: 20),
// //               ),
// //             ),
// //           ),
// //           ClipRRect(
// //             borderRadius: BorderRadius.circular(14),
// //             child: InteractiveViewer(
// //               child: filePath.startsWith('http')
// //                   ? Image.network(filePath,
// //                       fit: BoxFit.contain,
// //                       loadingBuilder: (_, child, p) => p == null
// //                           ? child
// //                           : const Center(
// //                               child: CircularProgressIndicator(
// //                                   color: Colors.white)),
// //                       errorBuilder: (_, __, ___) => _brokenImg())
// //                   : Image.file(File(filePath),
// //                       fit: BoxFit.contain,
// //                       errorBuilder: (_, __, ___) => _brokenImg()),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.only(top: 8),
// //             child: Text(filePath.split('/').last,
// //                 style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 12),
// //                 overflow: TextOverflow.ellipsis),
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// //
// //   Widget _brokenImg() => Container(
// //         height: 200,
// //         color: Colors.grey.shade800,
// //         child: const Center(
// //           child: Icon(Icons.broken_image_outlined,
// //               color: Colors.white54, size: 48),
// //         ),
// //       );
// //   Color _getStatusColor(String? status) {
// //     switch (status?.toLowerCase()) {
// //       case 'pending':
// //         return Colors.orange;
// //       case 'approved':
// //         return Colors.green;
// //       case 'rejected':
// //         return Colors.red;
// //       default:
// //         return _kBlue;
// //     }
// //   }
// //
// //   Widget _editableRow(
// //       String title, TextEditingController controller, IconData icon) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(title, style: GoogleFonts.dmSans(fontSize: 12, color: _kSub)),
// //           const SizedBox(height: 4),
// //           TextField(
// //             controller: controller,
// //             maxLines: title.contains("Notes") ? 3 : 2,
// //             decoration: InputDecoration(
// //               border:
// //                   OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
// //               contentPadding:
// //                   const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'dart:io';
// import 'package:digitalerp/model/get_expense_detail_response_model.dart';
// import 'package:digitalerp/model/get_expense_list_new_response_model.dart';
// import 'package:digitalerp/screen/ui/home/reimbursements/controller/reimbursement_controller.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// //  Design tokens
// const Color _kCard = Colors.white;
// const Color _kBlue = purpleColor;
// const Color _kLabel = Color(0xFF1A1A2E);
// const Color _kSub = Color(0xFF888888);
// const Color _kBorder = Color(0xFFE8E8E8);
//
// class ReimbursementDetailScreen extends StatefulWidget {
//   final ExpenseData listItem;
//   final bool openInEditMode; // ← add this
//
//   const ReimbursementDetailScreen({
//     Key? key,
//     required this.listItem,
//     this.openInEditMode = false, // ← default false
//   }) : super(key: key);
//
//   @override
//   State<ReimbursementDetailScreen> createState() =>
//       _ReimbursementDetailScreenState();
// }
//
// class _ReimbursementDetailScreenState extends State<ReimbursementDetailScreen> {
//   late final ReimbursementController ctrl;
//
//   bool _isEditMode = false;
//
//   //  Header edit controllers
//   final _descCtrl = TextEditingController();
//   final _notesCtrl = TextEditingController();
//   DateTime? _editDate;
//   final _dateDisplayCtrl = TextEditingController();
//
//   //  Per-item edit state (index → controllers)
//   // We keep a parallel list that mirrors detail items during edit
//   List<_EditableItem> _editItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     ctrl = Get.find<ReimbursementController>();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       if (widget.listItem.expenseId != null) {
//         await ctrl.getExpenseDetail(widget.listItem.expenseId!);
//       }
//       // Auto-enter edit mode if opened from edit button
//       if (widget.openInEditMode && mounted) {
//         _enterEditMode();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _descCtrl.dispose();
//     _notesCtrl.dispose();
//     _dateDisplayCtrl.dispose();
//     for (final e in _editItems) e.dispose();
//     super.dispose();
//   }
//
//   //  Enter edit mode — pre-fill all controllers
//   void _enterEditMode() {
//     final data = ctrl.getExpenseDetailResponseModel?.data;
//     final header = data?.header;
//     if (header == null) return;
//
//     // Parse date from header (dd-MM-yyyy or yyyy-MM-dd)
//     DateTime? parsedDate;
//     final rawDate = header.expenseDate ?? '';
//     try {
//       parsedDate = DateFormat('dd-MM-yyyy').parse(rawDate);
//     } catch (_) {
//       try {
//         parsedDate = DateFormat('yyyy-MM-dd').parse(rawDate);
//       } catch (_) {}
//     }
//
//     // Build editable items
//     final items = data?.items ?? [];
//     for (final e in _editItems) e.dispose();
//     _editItems = items.map((item) => _EditableItem.fromDetail(item)).toList();
//
//     setState(() {
//       _isEditMode = true;
//       _editDate = parsedDate;
//       _dateDisplayCtrl.text = parsedDate != null
//           ? DateFormat('dd MMM yyyy').format(parsedDate)
//           : rawDate;
//       _descCtrl.text = header.expenseDescription ?? '';
//       _notesCtrl.text = header.additionalNotes ?? '';
//     });
//   }
//
//   void _cancelEditMode() {
//     setState(() => _isEditMode = false);
//   }
//
//   //  Save
//   Future<void> _saveChanges() async {
//     final header = ctrl.getExpenseDetailResponseModel?.data?.header;
//     if (header == null) return;
//
//     // Validate
//     if (_editDate == null) {
//       ctrl.showError("Please select expense date");
//       return;
//     }
//     if (_editItems.isEmpty) {
//       ctrl.showError("At least one expense item is required");
//       return;
//     }
//     for (int i = 0; i < _editItems.length; i++) {
//       final e = _editItems[i];
//       if ((double.tryParse(e.amountCtrl.text) ?? 0) <= 0) {
//         ctrl.showError("Item ${i + 1}: Amount must be greater than 0");
//         return;
//       }
//     }
//
//     // Build items array — existing items keep their transId/parentId/status
//     final itemsJson = _editItems.asMap().entries.map((entry) {
//       final i = entry.key;
//       final item = entry.value;
//       return {
//         "sno": i + 1,
//         "parentid": item.parentId, // original parentId or 0 for new
//         "expenseledgerid": item.expenseLedgerId,
//         "description": item.descCtrl.text.trim(),
//         "amount": double.tryParse(item.amountCtrl.text) ?? 0.0,
//         "referencefile": item.referenceFileName ?? "",
//         "receiptfile": item.receiptFileName ?? "",
//         "status": item.status, // original status for existing, "P" for new
//         "transid": item.transId, // original transId or 0 for new
//       };
//     }).toList();
//
//     final success = await ctrl.updateReimbursement(
//       expenseId: header.expenseId!,
//       seriesId: header.seriesId ?? 0,
//       expenseNo: header.expenseNo ?? '',
//       expenseDate: DateFormat('yyyy-MM-dd').format(_editDate!),
//       siteId: header.siteId ?? 0,
//       reqId: header.reqId ?? 0,
//       items: itemsJson,
//     );
//
//     if (success) {
//       setState(() => _isEditMode = false);
//       // Refresh detail
//       ctrl.getExpenseDetail(header.expenseId!);
//     }
//   }
//
//   //  Date picker
//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _editDate ?? DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _editDate = picked;
//         _dateDisplayCtrl.text = DateFormat('dd MMM yyyy').format(picked);
//       });
//     }
//   }
//
//   // ════════════════════════════════════════════════════════════════════════
//   // BUILD
//   // ════════════════════════════════════════════════════════════════════════
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       body: Column(children: [
//         _appBar(context),
//         Expanded(child: Obx(() => _body())),
//       ]),
//     );
//   }
//
//   //  App bar
//   Widget _appBar(BuildContext context) => Container(
//         color: _kCard,
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).padding.top + 4,
//           bottom: 14,
//           left: 16,
//           right: 16,
//         ),
//         child: Row(children: [
//           IconButton(
//             onPressed: () => _isEditMode ? _cancelEditMode() : Get.back(),
//             icon: Icon(
//               _isEditMode ? Icons.close : Icons.arrow_back_ios_new,
//               color: _kLabel,
//               size: 20,
//             ),
//           ),
//           Expanded(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(
//                 _isEditMode ? "Edit Expense" : "Expense Details",
//                 style: GoogleFonts.dmSans(
//                     fontSize: 18, fontWeight: FontWeight.w700, color: _kLabel),
//               ),
//               if ((widget.listItem.expenseNo ?? '').isNotEmpty)
//                 Text(widget.listItem.expenseNo!,
//                     style: GoogleFonts.dmSans(fontSize: 13, color: _kSub)),
//             ]),
//           ),
//           // Save button in app bar when editing
//           if (_isEditMode)
//             Obx(() => ctrl.isLoading.value
//                 ? const Padding(
//                     padding: EdgeInsets.all(12),
//                     child: SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                           strokeWidth: 2, color: purpleColor),
//                     ))
//                 : TextButton(
//                     onPressed: _saveChanges,
//                     child: Text("Save",
//                         style: GoogleFonts.dmSans(
//                             color: purpleColor,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 15)),
//                   )),
//         ]),
//       );
//
//   //  Body
//   Widget _body() {
//     if (ctrl.isLoading.value && !_isEditMode) {
//       return const Center(child: CircularProgressIndicator(color: purpleColor));
//     }
//
//     final header = ctrl.getExpenseDetailResponseModel?.data?.header;
//     final items = ctrl.getExpenseDetailResponseModel?.data?.items ?? [];
//
//     return _isEditMode ? _editBody(header, items) : _viewBody(header, items);
//   }
//
//   // ════════════════════════════════════════════════════════════════════════
//   // VIEW MODE
//   // ════════════════════════════════════════════════════════════════════════
//
//   Widget _viewBody(GetExpenseHeader? header, List<GetExpenseItem> items) {
//     final listItem = widget.listItem;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         _statusBanner(listItem.approvalStatus),
//         const SizedBox(height: 16),
//
//         // Basic info
//         _sectionCard("Expense Information", [
//           _row("Expense No", listItem.expenseNo ?? "—", Icons.tag_outlined,
//               _kBlue),
//           _divider(),
//           _row("Date", listItem.expenseDate ?? "—",
//               Icons.calendar_today_outlined, const Color(0xFF7B61FF)),
//           _divider(),
//           _row("Employee", listItem.employeeName ?? "—", Icons.person_outline,
//               const Color(0xFF00897B)),
//           _divider(),
//           _row("Site", listItem.site ?? "—", Icons.location_on_outlined,
//               const Color(0xFFE65100)),
//           if ((listItem.entryFlag ?? '').isNotEmpty) ...[
//             _divider(),
//             _row("Entry Flag", listItem.entryFlag!, Icons.flag_outlined,
//                 const Color(0xFF1976D2)),
//           ],
//         ]),
//         const SizedBox(height: 12),
//
//         if (header != null) ...[
//           // Edit button row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Reimbursement Info",
//                   style: GoogleFonts.dmSans(
//                       fontSize: 13, fontWeight: FontWeight.w700, color: _kSub)),
//               if (header.isEditable == 1)
//                 TextButton.icon(
//                   onPressed: _enterEditMode,
//                   icon: const Icon(Icons.edit, size: 16, color: purpleColor),
//                   label: Text("Edit",
//                       style: GoogleFonts.dmSans(
//                           color: purpleColor, fontWeight: FontWeight.w600)),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//
//           _sectionCard("", [
//             _row("Requested By", header.requestedBy ?? "—",
//                 Icons.person_outline, _kBlue),
//             _divider(),
//             _row("Site", header.siteName ?? "—", Icons.location_on_outlined,
//                 _kBlue),
//             _divider(),
//             _row("Status", header.approvalStatus ?? "—", Icons.info_outline,
//                 _getStatusColor(header.approvalStatus)),
//             _divider(),
//             _row(
//                 "Total Amount",
//                 "₹ ${header.totalAmount?.toStringAsFixed(2) ?? "0.00"}",
//                 Icons.currency_rupee_outlined,
//                 Colors.green),
//             if ((header.expenseDescription ?? '').isNotEmpty) ...[
//               _divider(),
//               _row("Description", header.expenseDescription!,
//                   Icons.description_outlined, const Color(0xFF6D4C41)),
//             ],
//             if ((header.additionalNotes ?? '').isNotEmpty) ...[
//               _divider(),
//               _row("Additional Notes", header.additionalNotes!,
//                   Icons.note_alt_outlined, _kSub),
//             ],
//             if ((header.reason ?? '').isNotEmpty) ...[
//               _divider(),
//               _row("Reason", header.reason!, Icons.report_problem_outlined,
//                   Colors.orange),
//             ],
//           ]),
//           const SizedBox(height: 16),
//
//           // Items
//           if (items.isNotEmpty)
//             _sectionCard("Expense Items (${items.length})", [
//               ...items.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final i = entry.key;
//                 final item = entry.value;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _row("Item", item.expenseLedger ?? "—", Icons.list_alt,
//                         _kBlue),
//                     _row("Description", item.description ?? "—",
//                         Icons.text_fields, _kSub),
//                     _row("Group", item.expenseGroup ?? "—", Icons.category,
//                         _kSub),
//                     _row(
//                         "Amount",
//                         "₹ ${item.amount?.toStringAsFixed(2) ?? "0.00"}",
//                         Icons.currency_rupee,
//                         Colors.green),
//                     // ✅ ADD THIS
//                     if (item.referenceFile?.isNotEmpty ?? false)
//                       _base64AttachmentTile(
//                         label:      "Reference File",
//                         base64Data: item.referenceFile!,
//                         fileName:   "ref_${item.transId ?? index}.jpg",
//                         icon:       Icons.file_present_outlined,
//                       ),
//                     if (item.receiptFile?.isNotEmpty ?? false)
//                       _base64AttachmentTile(
//                         label:      "Receipt File",
//                         base64Data: item.receiptFile!,
//                         fileName:   "receipt_${item.transId ?? index}.jpg",
//                         icon:       Icons.receipt_long_outlined,
//                       ),
//                     if (i != items.length - 1) _divider(),
//                   ],
//                 );
//               }),
//             ])
//           else
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Center(child: Text("No expense items found")),
//             ),
//         ] else ...[
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 40),
//             child: Center(
//                 child: Text("Failed to load detailed information",
//                     style: TextStyle(color: Colors.grey))),
//           ),
//         ],
//
//         const SizedBox(height: 12),
//         _amountCard(listItem),
//         const SizedBox(height: 32),
//       ]),
//     );
//   }
//
//   // ════════════════════════════════════════════════════════════════════════
//   // EDIT MODE
//   // ════════════════════════════════════════════════════════════════════════
//
//   Widget _editBody(GetExpenseHeader? header, List<GetExpenseItem> items) {
//     if (header == null) {
//       return const Center(child: Text("Cannot load edit form"));
//     }
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         //  Header fields
//         _editSectionCard(
//             "Header Details",
//             Column(children: [
//               // Date
//               _editLabel("Expense Date"),
//               const SizedBox(height: 6),
//               GestureDetector(
//                 onTap: _pickDate,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: _kBorder),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(children: [
//                     const Icon(Icons.calendar_today_outlined,
//                         size: 18, color: purpleColor),
//                     const SizedBox(width: 10),
//                     Text(
//                       _dateDisplayCtrl.text.isEmpty
//                           ? "Select Date"
//                           : _dateDisplayCtrl.text,
//                       style: GoogleFonts.dmSans(
//                           fontSize: 14,
//                           color: _dateDisplayCtrl.text.isEmpty
//                               ? Colors.grey.shade400
//                               : _kLabel),
//                     ),
//                   ]),
//                 ),
//               ),
//               const SizedBox(height: 14),
//
//               // Read-only fields (site/employee come from header, not editable here)
//               _readOnlyField(
//                   "Site", header.siteName ?? "—", Icons.location_on_outlined),
//               const SizedBox(height: 14),
//               _readOnlyField("Requested By", header.requestedBy ?? "—",
//                   Icons.person_outline),
//               const SizedBox(height: 14),
//
//               // Description
//               // _editLabel("Description"),
//               // const SizedBox(height: 6),
//               // _textField(_descCtrl, "Enter description", maxLines: 2),
//               // const SizedBox(height: 14),
//               //
//               // // Additional notes
//               // _editLabel("Additional Notes"),
//               // const SizedBox(height: 6),
//               // _textField(_notesCtrl, "Enter notes", maxLines: 3),
//             ])),
//
//         const SizedBox(height: 16),
//
//         //  Items
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Expense Items",
//                 style: GoogleFonts.dmSans(
//                     fontSize: 16, fontWeight: FontWeight.w700, color: _kLabel)),
//             TextButton.icon(
//               onPressed: _addNewItem,
//               icon: const Icon(Icons.add_circle_outline,
//                   color: purpleColor, size: 18),
//               label: Text("Add Item",
//                   style: GoogleFonts.dmSans(
//                       color: purpleColor, fontWeight: FontWeight.w600)),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//
//         ..._editItems
//             .asMap()
//             .entries
//             .map((entry) => _editItemCard(entry.key, entry.value)),
//
//         const SizedBox(height: 16),
//
//         // Total
//         if (_editItems.isNotEmpty)
//           StatefulBuilder(
//             builder: (_, setS) => Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: purpleLightest,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: purpleColor.withValues(alpha: 0.3)),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Total Amount",
//                       style: GoogleFonts.dmSans(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: _kLabel)),
//                   Text(
//                     "₹${_computeTotal().toStringAsFixed(2)}",
//                     style: GoogleFonts.dmSans(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w800,
//                         color: purpleColor),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//         const SizedBox(height: 24),
//
//         // Submit button
//         Obx(() => SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: ctrl.isLoading.value ? null : _saveChanges,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: purpleColor,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14)),
//                 ),
//                 child: ctrl.isLoading.value
//                     ? const SizedBox(
//                         width: 22,
//                         height: 22,
//                         child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation(Colors.white)))
//                     : Text("Update Reimbursement",
//                         style: GoogleFonts.dmSans(
//                             fontSize: 15, fontWeight: FontWeight.w700)),
//               ),
//             )),
//       ]),
//     );
//   }
//
//   //  Edit item card
//   Widget _editItemCard(int index, _EditableItem item) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: _kCard,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: _kBorder),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withValues(alpha: 0.03),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         // Header row
//         Row(children: [
//           Container(
//             width: 28,
//             height: 28,
//             decoration: BoxDecoration(
//                 color: purpleLightest, borderRadius: BorderRadius.circular(8)),
//             alignment: Alignment.center,
//             child: Text("${index + 1}",
//                 style: GoogleFonts.dmSans(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: purpleColor)),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               item.isNew
//                   ? "New Item"
//                   : (item.ledgerName ?? "Item ${index + 1}"),
//               style: GoogleFonts.dmSans(
//                   fontSize: 14, fontWeight: FontWeight.w700, color: _kLabel),
//             ),
//           ),
//           // Only allow deleting new items or if more than 1 item
//           if (item.isNew || _editItems.length > 1)
//             GestureDetector(
//               onTap: () => setState(() => _editItems.removeAt(index)),
//               child: const Icon(Icons.delete_outline,
//                   color: Colors.redAccent, size: 20),
//             ),
//         ]),
//         const Divider(height: 20, color: _kBorder),
//
//         // Ledger name (read-only for existing, editable display for new)
//         if (!item.isNew) ...[
//           _readOnlyField(
//               "Expense Ledger", item.ledgerName ?? "—", Icons.list_alt),
//           const SizedBox(height: 12),
//         ],
//
//         // Description
//         _editLabel("Description"),
//         const SizedBox(height: 6),
//         _textField(item.descCtrl, "Enter description",
//             maxLines: 2, onChanged: (_) => setState(() {})),
//         const SizedBox(height: 12),
//
//         // Amount
//         _editLabel("Amount"),
//         const SizedBox(height: 6),
//         _textField(
//           item.amountCtrl,
//           "0.00",
//           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
//           ],
//           onChanged: (_) => setState(() {}), // recompute total
//         ),
//         const SizedBox(height: 12),
//
//         // File info (read-only display for existing files)
//         if (!item.isNew &&
//             ((item.referenceFileName?.isNotEmpty ?? false) ||
//                 (item.receiptFileName?.isNotEmpty ?? false)))
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF8F9FF),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: _kBorder),
//             ),
//             child: Row(children: [
//               const Icon(Icons.attach_file, size: 16, color: _kSub),
//               const SizedBox(width: 6),
//               Expanded(
//                 child: Text(
//                   "Ref: ${(item.referenceFileName?.isNotEmpty ?? false) ? '✓ Attached' : '—'} | "
//                   "Receipt: ${(item.receiptFileName?.isNotEmpty ?? false) ? '✓ Attached' : '—'}",
//                   style: GoogleFonts.dmSans(fontSize: 12, color: _kSub),
//                 ),
//               ),
//             ]),
//           ),
//       ]),
//     );
//   }
//
//   void _addNewItem() {
//     setState(() {
//       _editItems.add(_EditableItem.newEmpty(_editItems.length + 1));
//     });
//   }
//
//   double _computeTotal() => _editItems.fold(
//       0.0, (sum, e) => sum + (double.tryParse(e.amountCtrl.text) ?? 0.0));
//
//   // ════════════════════════════════════════════════════════════════════════
//   // SHARED WIDGETS
//   // ════════════════════════════════════════════════════════════════════════
//
//   Widget _editSectionCard(String title, Widget child) => Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: _kCard,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: _kBorder),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.04),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(title,
//               style: GoogleFonts.dmSans(
//                   fontSize: 15, fontWeight: FontWeight.w700, color: _kLabel)),
//           const SizedBox(height: 14),
//           const Divider(height: 1, color: _kBorder),
//           const SizedBox(height: 14),
//           child,
//         ]),
//       );
//
//   Widget _editLabel(String text) => Text(text,
//       style: GoogleFonts.dmSans(
//           fontSize: 13, fontWeight: FontWeight.w600, color: _kSub));
//
//   Widget _textField(
//     TextEditingController ctrl,
//     String hint, {
//     int maxLines = 1,
//     TextInputType? keyboardType,
//     List<TextInputFormatter>? inputFormatters,
//     ValueChanged<String>? onChanged,
//   }) =>
//       TextField(
//         controller: ctrl,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         inputFormatters: inputFormatters,
//         onChanged: onChanged,
//         style: GoogleFonts.dmSans(fontSize: 14),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle:
//               GoogleFonts.dmSans(fontSize: 13, color: Colors.grey.shade400),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: _kBorder)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: _kBorder)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: purpleColor)),
//           filled: true,
//           fillColor: Colors.white,
//         ),
//       );
//
//   Widget _readOnlyField(String label, String value, IconData icon) => Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF8F9FF),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: _kBorder),
//         ),
//         child: Row(children: [
//           Icon(icon, size: 16, color: _kSub),
//           const SizedBox(width: 8),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: _kSub)),
//             Text(value,
//                 style: GoogleFonts.dmSans(
//                     fontSize: 13, fontWeight: FontWeight.w600, color: _kLabel)),
//           ]),
//         ]),
//       );
//
//   // ════════════════════════════════════════════════════════════════════════
//   // VIEW MODE WIDGETS (unchanged from original)
//   // ════════════════════════════════════════════════════════════════════════
//
//   Widget _statusBanner(String? status) {
//     final label = (status ?? '').trim().isEmpty ? "Pending" : status!.trim();
//     Color bg, fg;
//     IconData icon;
//     switch (label.toLowerCase()) {
//       case 'approved':
//         bg = newGreenLightColor;
//         fg = newGreenColor;
//         icon = Icons.check_circle_outline;
//         break;
//       case 'rejected':
//         bg = newRedLightColor;
//         fg = newRedColor;
//         icon = Icons.cancel_outlined;
//         break;
//       default:
//         bg = newOrangeLightColor;
//         fg = newOrangeColor;
//         icon = Icons.hourglass_top_outlined;
//     }
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration:
//           BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
//       child: Row(children: [
//         Icon(icon, color: fg, size: 24),
//         const SizedBox(width: 12),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text("Approval Status",
//               style: GoogleFonts.dmSans(
//                   fontSize: 12, color: fg.withValues(alpha: 0.8))),
//           Text(label,
//               style: GoogleFonts.dmSans(
//                   fontSize: 16, fontWeight: FontWeight.w700, color: fg)),
//         ]),
//       ]),
//     );
//   }
//
//   Widget _amountCard(ExpenseData item) => Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//               colors: [purpleColor, Color(0xFF9575CD)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight),
//           borderRadius: BorderRadius.circular(14),
//           boxShadow: [
//             BoxShadow(
//                 color: purpleColor.withValues(alpha: 0.3),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4))
//           ],
//         ),
//         child:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text("Claimed Amount",
//                 style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white70)),
//             const SizedBox(height: 4),
//             Text("₹${item.amount ?? 0}",
//                 style: GoogleFonts.dmSans(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.white)),
//           ]),
//           Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//             _miniAmt("Approved", item.approvedAmt),
//             const SizedBox(height: 4),
//             _miniAmt("Balance", item.balanceAmt),
//           ]),
//         ]),
//       );
//
//   Widget _miniAmt(String label, num? amt) => Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(label,
//               style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white60)),
//           Text("₹${amt ?? 0}",
//               style: GoogleFonts.dmSans(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white)),
//         ],
//       );
//
//   Widget _sectionCard(String title, List<Widget> children) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title.isNotEmpty)
//             Text(title,
//                 style: GoogleFonts.dmSans(
//                     fontSize: 13, fontWeight: FontWeight.w700, color: _kSub)),
//           if (title.isNotEmpty) const SizedBox(height: 8),
//           Container(
//             decoration: BoxDecoration(
//               color: _kCard,
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(color: _kBorder),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.03),
//                     blurRadius: 6,
//                     offset: const Offset(0, 2))
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(children: children),
//             ),
//           ),
//         ],
//       );
//
//   Widget _row(String title, String value, IconData icon, Color color) =>
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 color: color.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(8)),
//             child: Icon(icon, color: color, size: 18),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(title,
//                   style: GoogleFonts.dmSans(fontSize: 12, color: _kSub)),
//               const SizedBox(height: 2),
//               Text(value,
//                   style: GoogleFonts.dmSans(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: _kLabel)),
//             ]),
//           ),
//         ]),
//       );
//
//   Widget _divider() => const Padding(
//         padding: EdgeInsets.symmetric(vertical: 2),
//         child: Divider(height: 1, color: _kBorder),
//       );
//
//   Color _getStatusColor(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;
//       case 'approved':
//         return Colors.green;
//       case 'rejected':
//         return Colors.red;
//       default:
//         return _kBlue;
//     }
//   }
//   Widget _base64AttachmentTile({
//     required String label,
//     required String base64Data,
//     required String fileName,
//     required IconData icon,
//   }) {
//     final fileType = _detectFileType(base64Data, fileName: fileName);
//     final isImage  = fileType == 'image';
//
//     return Container(
//       margin: const EdgeInsets.only(top: 8),
//       decoration: BoxDecoration(
//         color: _kCard,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _kBorder),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//         leading: Container(
//           width: 42, height: 42,
//           decoration: BoxDecoration(
//             color: isImage
//                 ? const Color(0xFFEEF2FF)
//                 : Colors.red.shade50,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             isImage ? Icons.image_outlined : Icons.picture_as_pdf_outlined,
//             color: isImage ? _kBlue : Colors.red,
//             size: 20,
//           ),
//         ),
//         title: Text(label,
//             style: GoogleFonts.dmSans(
//                 fontSize: 13, fontWeight: FontWeight.w500)),
//         subtitle: Text(
//           isImage ? "Tap to preview" : "Tap to open",
//           style: GoogleFonts.dmSans(fontSize: 11, color: _kSub),
//         ),
//         trailing: Container(
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: const Color(0xFFEEF2FF),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             isImage ? Icons.remove_red_eye_outlined : Icons.open_in_new,
//             color: _kBlue, size: 18,
//           ),
//         ),
//         onTap: () => isImage
//             ? _previewBase64Image(base64Data, label)
//             : _openBase64File(base64Data, fileName),
//       ),
//     );
//   }
//
//   /// Returns 'image', 'pdf', or 'unknown'
//   String _detectFileType(String base64Str, {String? fileName}) {
//     // Check data URI prefix first  e.g. "data:image/png;base64,..."
//     if (base64Str.startsWith('data:image')) return 'image';
//     if (base64Str.startsWith('data:application/pdf')) return 'pdf';
//
//     // Fall back to filename extension
//     final ext = (fileName ?? '').split('.').last.toLowerCase();
//     if (['jpg', 'jpeg', 'png', 'webp', 'gif'].contains(ext)) return 'image';
//     if (ext == 'pdf') return 'pdf';
//
//     // Peek at raw bytes — PDF magic bytes are "%PDF"
//     try {
//       final clean = base64Str.contains(',') ? base64Str.split(',').last : base64Str;
//       final bytes = base64Decode(clean.substring(0, 8.clamp(0, clean.length)));
//       if (bytes.length >= 4 &&
//           bytes[0] == 0x25 && bytes[1] == 0x50 &&
//           bytes[2] == 0x44 && bytes[3] == 0x46) return 'pdf';
//     } catch (_) {}
//
//     return 'unknown';
//   }
//
//
//   // void _previewBase64Image(String base64Data, String label) {
//   //   try {
//   //     // Debug — print first 100 chars to see what format it is
//   //     debugPrint('BASE64 PREFIX: ${base64Data.substring(0, base64Data.length.clamp(0, 100))}');
//   //
//   //     String clean = base64Data;
//   //
//   //     // Strip data URI prefix
//   //     if (clean.contains(',')) {
//   //       clean = clean.split(',').last;
//   //     }
//   //
//   //     // Remove any whitespace/newlines that break base64 decoding
//   //     clean = clean.replaceAll(RegExp(r'\s'), '');
//   //
//   //     // Add padding if missing
//   //     while (clean.length % 4 != 0) {
//   //       clean += '=';
//   //     }
//   //
//   //     final bytes = base64Decode(clean);
//   //     debugPrint('DECODED BYTES LENGTH: ${bytes.length}');
//   //
//   //     showDialog(
//   //       context: context,
//   //       barrierColor: Colors.black87,
//   //       builder: (_) => Dialog(
//   //         backgroundColor: Colors.transparent,
//   //         insetPadding: const EdgeInsets.all(12),
//   //         child: Column(mainAxisSize: MainAxisSize.min, children: [
//   //           // Close button
//   //           Align(
//   //             alignment: Alignment.topRight,
//   //             child: GestureDetector(
//   //               onTap: () => Navigator.pop(context),
//   //               child: Container(
//   //                 margin: const EdgeInsets.only(bottom: 8),
//   //                 padding: const EdgeInsets.all(6),
//   //                 decoration: BoxDecoration(
//   //                   color: Colors.white.withValues(alpha:0.2),
//   //                   shape: BoxShape.circle,
//   //                 ),
//   //                 child: const Icon(Icons.close, color: Colors.white, size: 20),
//   //               ),
//   //             ),
//   //           ),
//   //           // Zoomable image from bytes
//   //           ClipRRect(
//   //             borderRadius: BorderRadius.circular(14),
//   //             child: InteractiveViewer(
//   //               child: Image.memory(
//   //                 bytes,
//   //                 fit: BoxFit.contain,
//   //                 errorBuilder: (_, __, ___) => _brokenImg(),
//   //               ),
//   //             ),
//   //           ),
//   //           Padding(
//   //             padding: const EdgeInsets.only(top: 8),
//   //             child: Text(label,
//   //                 style: GoogleFonts.dmSans(
//   //                     color: Colors.white70, fontSize: 12)),
//   //           ),
//   //         ]),
//   //       ),
//   //     );
//   //   } catch (e) {
//   //     Get.snackbar("Error", "Could not decode image",
//   //         backgroundColor: Colors.red, colorText: Colors.white);
//   //   }
//   // }
//
//   void _previewBase64Image(String fileName, String label) {
//     // 👇 TEST WITH EACH URL PATTERN ABOVE
//     final fileUrl = fileName;
//
//     showDialog(
//       context: context,
//       barrierColor: Colors.black87,
//       builder: (_) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: const EdgeInsets.all(12),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha:0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.close, color: Colors.white, size: 20),
//               ),
//             ),
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: InteractiveViewer(
//               child: Image.network(
//                 fileUrl,
//                 fit: BoxFit.contain,
//                 loadingBuilder: (_, child, p) => p == null
//                     ? child
//                     : const Center(child: CircularProgressIndicator(color: purpleColor)),
//                 errorBuilder: (_, __, ___) {
//                   debugPrint('IMAGE LOAD FAILED: $fileUrl'); // 👈 check this log
//                   return _brokenImg();
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Text(label,
//                 style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 12)),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   // Future<void> _openBase64File(String fileName, String fileUrl) async {
//   //   final url = "http://supportapi.digitalerp.biz/ExpenseFiles/$fileName";
//   //   try {
//   //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//   //   } catch (e) {
//   //     Get.snackbar("Error", "Could not open file",
//   //         backgroundColor: Colors.red, colorText: Colors.white);
//   //   }
//   // }
//
//
//
//   Future<void> _openBase64File(String base64Data, String fileName) async {
//     try {
//       // Show loading
//       Get.dialog(
//         const Center(child: CircularProgressIndicator(color: purpleColor)),
//         barrierDismissible: false,
//       );
//
//       final filePath = await _saveBase64ToTempFile(base64Data, fileName);
//       Get.back(); // dismiss loading
//
//       if (filePath == null) {
//         Get.snackbar("Error", "Could not prepare file",
//             backgroundColor: Colors.red, colorText: Colors.white);
//         return;
//       }
//
//       final result = await OpenFilex.open(filePath);
//
//       if (result.type != ResultType.done) {
//         Get.snackbar("Error", "No app found to open this file",
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.back(); // dismiss loading if still shown
//       Get.snackbar("Error", "Failed to open file: $e",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//   Future<String?> _saveBase64ToTempFile(String base64Str, String fileName) async {
//     try {
//       // Strip data URI prefix if present: "data:image/jpeg;base64,/9j/..."
//       final cleanBase64 = base64Str.contains(',')
//           ? base64Str.split(',').last
//           : base64Str;
//
//       final bytes = base64Decode(cleanBase64);
//       final dir   = await getTemporaryDirectory();
//       final file  = File('${dir.path}/$fileName');
//       await file.writeAsBytes(bytes);
//       return file.path;
//     } catch (e) {
//       debugPrint('Base64 decode error: $e');
//       return null;
//     }
//   }
//
//   Widget _brokenImg() => Container(
//     height: 200,
//     color: Colors.grey.shade800,
//     child: const Center(
//       child: Icon(Icons.broken_image_outlined, color: Colors.white54, size: 48),
//     ),
//   );
//
// }
//
// // ══
// // Helper class — holds edit state for one line item
// // ══
//
// class _EditableItem {
//   final bool isNew;
//   final int parentId;
//   final int transId;
//   final int expenseLedgerId;
//   final String? ledgerName;
//   final String status;
//   final String? referenceFileName;
//   final String? receiptFileName;
//
//   final TextEditingController descCtrl;
//   final TextEditingController amountCtrl;
//
//   _EditableItem({
//     required this.isNew,
//     required this.parentId,
//     required this.transId,
//     required this.expenseLedgerId,
//     required this.ledgerName,
//     required this.status,
//     required this.referenceFileName,
//     required this.receiptFileName,
//     required this.descCtrl,
//     required this.amountCtrl,
//   });
//
//   /// Build from existing API detail item — preserves transId, parentId, status
//   factory _EditableItem.fromDetail(GetExpenseItem item) => _EditableItem(
//         isNew: false,
//         parentId: item.parentId ?? 0,
//         transId: item.transId ?? 0,
//         expenseLedgerId: item.expenseLedgerId ?? 0,
//         ledgerName: item.expenseLedger,
//         status: item.status ?? 'P',
//         referenceFileName: item.referenceFile,
//         receiptFileName: item.receiptFile,
//         descCtrl: TextEditingController(text: item.description ?? ''),
//         amountCtrl: TextEditingController(
//             text: item.amount != null ? item.amount!.toStringAsFixed(2) : ''),
//       );
//
//   /// Brand-new empty item added by user during edit
//   factory _EditableItem.newEmpty(int sno) => _EditableItem(
//         isNew: true,
//         parentId: 0,
//         transId: 0,
//         expenseLedgerId: 0,
//         ledgerName: null,
//         status: 'P', // always "P" for new items
//         referenceFileName: '',
//         receiptFileName: '',
//         descCtrl: TextEditingController(),
//         amountCtrl: TextEditingController(),
//       );
//
//   void dispose() {
//     descCtrl.dispose();
//     amountCtrl.dispose();
//   }
// }


import 'dart:io';
import 'package:digitalerp/model/get_expense_detail_response_model.dart';
import 'package:digitalerp/model/get_expense_list_new_response_model.dart';
import 'package:digitalerp/screen/ui/home/reimbursements/controller/reimbursement_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

// ─── Design tokens (matching Payment Request screen) ─────────────────────────
const Color _kBg        = Color(0xFFF4F6FA);
const Color _kCard      = Colors.white;
const Color _kPrimary   = purpleColor;           // your existing purpleColor
const Color _kLabel     = Color(0xFF1A1A2E);
const Color _kSub       = Color(0xFF6B7280);
const Color _kBorder    = Color(0xFFE8ECF0);
const Color _kSection   = Color(0xFF3B5BDB);     // blue section headers

// ─────────────────────────────────────────────────────────────────────────────

class ReimbursementDetailScreen extends StatefulWidget {
  final ExpenseData listItem;
  final bool openInEditMode;

  const ReimbursementDetailScreen({
    Key? key,
    required this.listItem,
    this.openInEditMode = false,
  }) : super(key: key);

  @override
  State<ReimbursementDetailScreen> createState() =>
      _ReimbursementDetailScreenState();
}

class _ReimbursementDetailScreenState
    extends State<ReimbursementDetailScreen> {
  late final ReimbursementController ctrl;

  // ── One-time load guard (fixes "have to go back and re-enter" bug) ─────────
  bool _loaded        = false;
  bool _isEditMode    = false;
  bool get _canEdit {
    final status = (widget.listItem.approvalStatus ?? '').trim().toLowerCase();
    final isApproved = status == 'approved' || status == 'approve';
    final isVerified = (widget.listItem.verifiedAmt ?? 0) > 0;
    return !isApproved && !isVerified;
  }
  // ── Header edit controllers ────────────────────────────────────────────────
  final _descCtrl        = TextEditingController();
  final _notesCtrl       = TextEditingController();
  final _dateDisplayCtrl = TextEditingController();
  DateTime? _editDate;

  // ── Per-item edit state ────────────────────────────────────────────────────
  List<_EditableItem> _editItems = [];

  // ── Header-level new attachments (edit mode) ───────────────────────────────
  final List<_NewAttachment> _headerAttachments = [];

  @override
  void initState() {
    super.initState();
    ctrl = Get.find<ReimbursementController>();
  }

  // FIX: Use didChangeDependencies with a guard — fires once after first build,
  // so the widget tree is fully mounted before the async API call runs.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (widget.listItem.expenseId != null) {
      await ctrl.getExpenseDetail(widget.listItem.expenseId!);
    }
    // ✅ Only auto-enter edit if actually allowed
    if (widget.openInEditMode && mounted && _canEdit) {
      _enterEditMode();
    }
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _notesCtrl.dispose();
    _dateDisplayCtrl.dispose();
    for (final e in _editItems) e.dispose();
    super.dispose();
  }

  // ── Edit mode ──────────────────────────────────────────────────────────────

  void _enterEditMode() {
    if (!_canEdit) {
      Get.snackbar(
        'Cannot Edit',
        _isApprovedStatus()
            ? 'Approved reimbursements cannot be edited'
            : 'Verified reimbursements cannot be edited',
        backgroundColor: Colors.orange.shade50,
        colorText: Colors.orange.shade800,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    final data   = ctrl.getExpenseDetailResponseModel?.data;
    final header = data?.header;
    if (header == null) return;

    DateTime? parsedDate;
    final raw = header.expenseDate ?? '';
    for (final fmt in ['dd-MM-yyyy', 'yyyy-MM-dd', 'MM/dd/yyyy']) {
      try { parsedDate = DateFormat(fmt).parse(raw); break; } catch (_) {}
    }

    for (final e in _editItems) e.dispose();
    _editItems = (data?.items ?? [])
        .map((i) => _EditableItem.fromDetail(i))
        .toList();

    setState(() {
      _isEditMode        = true;
      _editDate          = parsedDate;
      _dateDisplayCtrl.text = parsedDate != null
          ? DateFormat('dd MMM yyyy').format(parsedDate)
          : raw;
      _descCtrl.text  = header.expenseDescription ?? '';
      _notesCtrl.text = header.additionalNotes ?? '';
    });
  }
  bool _isApprovedStatus() {
    final s = (widget.listItem.approvalStatus ?? '').trim().toLowerCase();
    return s == 'approved' || s == 'approve';
  }

  void _cancelEdit() => setState(() => _isEditMode = false);

  Future<void> _saveChanges() async {
    final header = ctrl.getExpenseDetailResponseModel?.data?.header;
    if (header == null) return;

    if (_editDate == null) {
      _snack('Validation', 'Please select an expense date');
      return;
    }
    for (int i = 0; i < _editItems.length; i++) {
      if ((double.tryParse(_editItems[i].amountCtrl.text) ?? 0) <= 0) {
        _snack('Validation', 'Item ${i + 1}: amount must be > 0');
        return;
      }
    }

    // ✅ Step 1: upload any new attachments first, before building JSON
    for (final item in _editItems) {
      if (item.newAttachments.isEmpty) continue;

      for (final attachment in item.newAttachments) {
        if (attachment.uploadedName != null) continue; // already uploaded

        final serverName = await ctrl.uploadSingleFile(attachment.path);
        if (serverName.isNotEmpty) {
          attachment.uploadedName = serverName; // ✅ store server filename
          log('✅ Uploaded attachment: $serverName');
        } else {
          _snack('Upload Failed', 'Could not upload ${attachment.name}');
          return; // ✅ stop — don't save with missing files
        }
      }
    }

    // ✅ Step 2: build JSON using server filenames, not local paths
    final itemsJson = _editItems.asMap().entries.map((e) {
      final item = e.value;

      // ✅ All newly uploaded server filenames for this item
      final newUploadedNames = item.newAttachments
          .where((a) => a.uploadedName != null && a.uploadedName!.isNotEmpty)
          .map((a) => a.uploadedName!)
          .toList();

      // ✅ Existing files already on server (comma-separated string → list)
      final existingFiles = (item.referenceFileUrl ?? '')
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      // ✅ Merge existing + new → join back with comma
      final referenceFile = [...existingFiles, ...newUploadedNames].join(',');

      return {
        "sno"            : e.key + 1,
        "parentid"       : item.parentId,
        "expenseledgerid": item.expenseLedgerId,
        "description"    : item.descCtrl.text.trim(),
        "amount"         : double.tryParse(item.amountCtrl.text) ?? 0.0,
        "referencefile"  : referenceFile, // ✅ "oldfile.jpg,newfile1.jpg,newfile2.jpg"
        "receiptfile"    : item.receiptFileUrl ?? '',
        "status"         : item.status,
        "transid"        : item.transId,
      };
    }).toList();

    final success = await ctrl.updateReimbursement(
      expenseId  : header.expenseId!,
      seriesId   : header.seriesId ?? 0,
      expenseNo  : header.expenseNo ?? '',
      expenseDate: DateFormat('yyyy-MM-dd').format(_editDate!),
      siteId     : header.siteId ?? 0,
      reqId      : header.reqId ?? 0,
      items      : itemsJson,
    );

    if (success) {
      setState(() => _isEditMode = false);
      ctrl.getExpenseDetail(header.expenseId!);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context   : context,
      initialDate: _editDate ?? DateTime.now(),
      firstDate : DateTime(2020),
      lastDate  : DateTime.now(),
      builder   : (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: _kPrimary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _editDate             = picked;
        _dateDisplayCtrl.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  // ── File picking helpers ───────────────────────────────────────────────────

  Future<void> _pickFilesForItem(int index) async {
    final choice = await _showPickerSheet();
    if (choice == null) return;

    List<_NewAttachment> picked = [];

    if (choice == 'gallery') {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img != null) picked.add(_NewAttachment(path: img.path, name: img.name));
    } else if (choice == 'camera') {
      final img = await ImagePicker().pickImage(source: ImageSource.camera);
      if (img != null) picked.add(_NewAttachment(path: img.path, name: img.name));
    } else {
      final res = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (res != null) {
        picked = res.files
            .where((f) => f.path != null)
            .map((f) => _NewAttachment(path: f.path!, name: f.name))
            .toList();
      }
    }

    if (picked.isNotEmpty) {
      setState(() => _editItems[index].newAttachments.addAll(picked));
    }
  }

  Future<void> _pickHeaderFiles() async {
    final choice = await _showPickerSheet();
    if (choice == null) return;

    List<_NewAttachment> picked = [];

    if (choice == 'gallery') {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img != null) picked.add(_NewAttachment(path: img.path, name: img.name));
    } else if (choice == 'camera') {
      final img = await ImagePicker().pickImage(source: ImageSource.camera);
      if (img != null) picked.add(_NewAttachment(path: img.path, name: img.name));
    } else {
      final res = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (res != null) {
        picked = res.files
            .where((f) => f.path != null)
            .map((f) => _NewAttachment(path: f.path!, name: f.name))
            .toList();
      }
    }

    if (picked.isNotEmpty) {
      setState(() => _headerAttachments.addAll(picked));
    }
  }

  Future<String?> _showPickerSheet() => showModalBottomSheet<String>(
    context       : context,
    shape         : const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 6),
          width: 40, height: 4,
          decoration: BoxDecoration(
            color: _kBorder,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text('Add Attachment',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _kLabel)),
        ),
        _sheetTile(Icons.photo_library_outlined, 'Choose from Gallery', 'gallery'),
        _sheetTile(Icons.camera_alt_outlined,    'Take a Photo',        'camera'),
        _sheetTile(Icons.attach_file_rounded,    'Pick a File (PDF/Doc)', 'file'),
        const SizedBox(height: 12),
      ]),
    ),
  );

  ListTile _sheetTile(IconData icon, String label, String value) => ListTile(
    leading: Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: _kPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: _kPrimary, size: 20),
    ),
    title: Text(label,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: _kLabel)),
    onTap: () => Navigator.pop(context, value),
  );

  // ── Open URL ───────────────────────────────────────────────────────────────
  Future<void> _openUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Error', 'Could not open file',
            backgroundColor: Colors.red.shade50,
            colorText: Colors.red.shade700);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to open: $e',
          backgroundColor: Colors.red.shade50,
          colorText: Colors.red.shade700);
    }
  }
  // Future<void> _openUrl(String url) async {
  //   if (url.isEmpty) return;
  //   final uri = Uri.tryParse(url);
  //   if (uri == null) return;
  //   final isImage = RegExp(r'\.(jpg|jpeg|png|webp|gif)$', caseSensitive: false)
  //       .hasMatch(url.split('?').first);
  //   if (isImage) {
  //     _previewNetworkImage(url);
  //   } else {
  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri, mode: LaunchMode.externalApplication);
  //     }
  //   }
  // }

  void _previewNetworkImage(String url) {
    showDialog(
      context     : context,
      barrierColor: Colors.black87,
      builder     : (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding   : const EdgeInsets.all(12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin : const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: InteractiveViewer(
              child: Image.network(
                url,
                fit           : BoxFit.contain,
                loadingBuilder: (_, child, p) => p == null
                    ? child
                    : const SizedBox(
                    height: 200,
                    child: Center(
                        child: CircularProgressIndicator(color: _kPrimary))),
                errorBuilder : (_, __, ___) => Container(
                  height: 200,
                  color : Colors.grey.shade800,
                  child : const Icon(Icons.broken_image_outlined,
                      color: Colors.white54, size: 48),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _snack(String title, String msg) =>
      Get.snackbar(title, msg,
          backgroundColor: Colors.red.shade50,
          colorText       : Colors.red.shade700);

  double get _editTotal => _editItems.fold(
      0.0, (s, e) => s + (double.tryParse(e.amountCtrl.text) ?? 0.0));

  // ══
  // BUILD
  // ══

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(children: [
        _AppBarWidget(
          docNo      : widget.listItem.expenseNo ?? '',
          isEditMode : _isEditMode,
          onBack     : () => _isEditMode ? _cancelEdit() : Get.back(),
          onSave     : _isEditMode ? _saveChanges : null,
          ctrl       : ctrl,
        ),
        Expanded(
          child: Obx(() {
            // FIX: Show spinner while loading, but only on first load (not during edit)
            if (ctrl.isExpenseLoading.value && !_isEditMode) {   // ← was isLoading
              return const Center(
                  child: CircularProgressIndicator(color: _kPrimary));
            }
            final header = ctrl.getExpenseDetailResponseModel?.data?.header;
            final items  = ctrl.getExpenseDetailResponseModel?.data?.items ?? [];
            return _isEditMode
                ? _EditBody(
              state    : this,
              header   : header,
              items    : items,
            )
                : _ViewBody(
              state   : this,
              header  : header,
              items   : items,
              listItem: widget.listItem,
            );
          }),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  APP BAR
// ─────────────────────────────────────────────────────────────────────────────

class _AppBarWidget extends StatelessWidget {
  final String docNo;
  final bool isEditMode;
  final VoidCallback onBack;
  final Future<void> Function()? onSave;
  final ReimbursementController ctrl;

  const _AppBarWidget({
    required this.docNo,
    required this.isEditMode,
    required this.onBack,
    required this.onSave,
    required this.ctrl,
  });

  @override
  Widget build(BuildContext context) => Container(
    color: _kCard,
    padding: EdgeInsets.only(
      top   : MediaQuery.of(context).padding.top + 4,
      bottom: 14,
      left  : 8,
      right : 16,
    ),
    child: Row(children: [
      IconButton(
        onPressed: onBack,
        icon: Icon(
          isEditMode ? Icons.close : Icons.arrow_back_ios_new_rounded,
          color: _kLabel, size: 19,
        ),
      ),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            isEditMode ? 'Edit Expense' : 'Expense Details',
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: _kLabel),
          ),
          if (docNo.isNotEmpty)
            Text(docNo,
                style: const TextStyle(fontSize: 11, color: _kSub)),
        ]),
      ),
      if (isEditMode)
        Obx(() => ctrl.isLoading.value
            ? const SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: _kPrimary))
            : TextButton(
          onPressed: onSave,
          style: TextButton.styleFrom(
            backgroundColor: _kPrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 18, vertical: 9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Save',
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700)),
        )),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  VIEW BODY
// ─────────────────────────────────────────────────────────────────────────────

class _ViewBody extends StatelessWidget {
  final _ReimbursementDetailScreenState state;
  final GetExpenseHeader? header;
  final List<GetExpenseItem> items;
  final ExpenseData listItem;

  const _ViewBody({
    required this.state,
    required this.header,
    required this.items,
    required this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    final status = listItem.approvalStatus ?? '';
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Status banner ────────────────────────────────────────────────────
        _StatusBanner(status: status),
        const SizedBox(height: 14),

        // ── Basic Info ───────────────────────────────────────────────────────
        _SectionCard(
          icon : Icons.info_outline_rounded,
          color: _kSection,
          title: 'BASIC INFO',
          trailing: (header?.isEditable == 1 && state._canEdit)
              ? GestureDetector(
            onTap: state._enterEditMode,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _kPrimary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.edit_rounded, size: 13, color: _kPrimary),
                SizedBox(width: 4),
                Text('Edit',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _kPrimary)),
              ]),
            ),
          )
              : (header?.isEditable != 1 && !state._canEdit)
              ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.lock_outline_rounded, size: 13, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text('Locked',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500)),
            ]),
          )
              : null,
          child: Column(children: [
            _ViewRow('Expense No', listItem.expenseNo  ?? '—', Icons.tag_rounded),
            _divider(),
            _ViewRow('Date',       listItem.expenseDate ?? '—', Icons.calendar_today_rounded),
            _divider(),
            _ViewRow('Employee',   listItem.employeeName ?? '—', Icons.person_outline_rounded),
            _divider(),
            _ViewRow('Site',       listItem.site ?? '—', Icons.location_on_outlined),
            if ((listItem.entryFlag ?? '').isNotEmpty) ...[
              _divider(),
              _ViewRow('Entry Flag', listItem.entryFlag!, Icons.flag_outlined),
            ],
          ]),
        ),

        if (header != null) ...[
          // Non-nullable local — Dart can't narrow fields inside widget constructors
          // ignore: unused_local_variable (used via closure capture)
          const SizedBox(height: 10),

          // ── Request Details ──────────────────────────────────────────────
          _SectionCard(
            icon : Icons.receipt_long_rounded,
            color: const Color(0xFF0891B2),
            title: 'REQUEST DETAILS',
            child: _RequestDetailsSection(header: header!),
          ),
          const SizedBox(height: 10),

          // ── Party & Site ─────────────────────────────────────────────────
          _SectionCard(
            icon : Icons.people_outline_rounded,
            color: const Color(0xFF7C3AED),
            title: 'PARTY & SITE',
            child: _PartySection(header: header!),
          ),
          const SizedBox(height: 10),

          // ── Expense Items ────────────────────────────────────────────────
          if (items.isNotEmpty) ...[
            _SectionCard(
              icon : Icons.list_alt_rounded,
              color: const Color(0xFF059669),
              title: 'EXPENSE ITEMS (${items.length})',
              child: Column(
                children: items.asMap().entries.map((entry) {
                  final idx  = entry.key;
                  final item = entry.value;
                  return _ExpenseItemTile(
                    item   : item,
                    index  : idx,
                    isLast : idx == items.length - 1,
                    onOpenUrl: state._openUrl,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
          ],

          // ── Amount summary card ──────────────────────────────────────────
          _AmountGradientCard(listItem: listItem),
        ] else ...[
          const SizedBox(height: 40),
          const Center(
            child: Text('Failed to load detailed information',
                style: TextStyle(color: _kSub)),
          ),
        ],
        const SizedBox(height: 20),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  EDIT BODY
// ─────────────────────────────────────────────────────────────────────────────

class _EditBody extends StatelessWidget {
  final _ReimbursementDetailScreenState state;
  final GetExpenseHeader? header;
  final List<GetExpenseItem> items;

  const _EditBody({
    required this.state,
    required this.header,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (header == null) {
      return const Center(child: Text('Cannot load edit form'));
    }
    // Non-nullable local — Dart can't narrow fields through widget closures
    final h = header!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 120),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Edit mode banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          margin : const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color : _kPrimary.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: _kPrimary.withValues(alpha: 0.25)),
          ),
          child: const Row(children: [
            Icon(Icons.edit_note_rounded, color: _kPrimary, size: 18),
            SizedBox(width: 8),
            Text('Edit mode — tap Save when done.',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _kPrimary)),
          ]),
        ),

        // ── Header fields ────────────────────────────────────────────────────
        _SectionCard(
          icon : Icons.info_outline_rounded,
          color: _kSection,
          title: 'BASIC INFO',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date picker
              _EditLabel('Expense Date'),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: state._pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 13),
                  decoration: BoxDecoration(
                    color : Colors.white,
                    border: Border.all(color: _kBorder),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const Icon(Icons.calendar_today_rounded,
                        size: 17, color: _kPrimary),
                    const SizedBox(width: 10),
                    Text(
                      state._dateDisplayCtrl.text.isEmpty
                          ? 'Select Date'
                          : state._dateDisplayCtrl.text,
                      style: TextStyle(
                          fontSize: 14,
                          color: state._dateDisplayCtrl.text.isEmpty
                              ? Colors.grey.shade400
                              : _kLabel),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 12),

              // Read-only: site + employee
              _ReadOnlyRow('Site', h.siteName ?? '—',
                  Icons.location_on_outlined),
              const SizedBox(height: 10),
              _ReadOnlyRow('Requested By', h.requestedBy ?? '—',
                  Icons.person_outline_rounded),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // ── Expense Items ────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('EXPENSE ITEMS',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: _kSub,
                    letterSpacing: .6)),
            GestureDetector(
              onTap: () {
                state.setState(() {
                  state._editItems.add(
                      _EditableItem.newEmpty(state._editItems.length + 1));
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: _kPrimary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.add_rounded, size: 15, color: _kPrimary),
                  SizedBox(width: 4),
                  Text('Add Item',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _kPrimary)),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Item cards
        ...state._editItems.asMap().entries.map(
              (e) => _EditItemCard(
            index: e.key,
            item : e.value,
            state: state,
          ),
        ),

        // ── Total ────────────────────────────────────────────────────────────
        if (state._editItems.isNotEmpty) ...[
          const SizedBox(height: 4),
          StatefulBuilder(
            builder: (_, ss) => Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color : _kPrimary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: _kPrimary.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Amount',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _kLabel)),
                  Text(
                    '₹ ${state._editTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _kPrimary),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),

        // ── Save button ──────────────────────────────────────────────────────
        Obx(() => SizedBox(
          width : double.infinity,
          height: 52,
          child : ElevatedButton(
            onPressed: state.ctrl.isLoading.value
                ? null
                : state._saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: _kPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: state.ctrl.isLoading.value
                ? const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white)))
                : const Text('Update Reimbursement',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700)),
          ),
        )),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  EDIT ITEM CARD
// ─────────────────────────────────────────────────────────────────────────────

class _EditItemCard extends StatefulWidget {
  final int index;
  final _EditableItem item;
  final _ReimbursementDetailScreenState state;
  const _EditItemCard(
      {required this.index, required this.item, required this.state});

  @override
  State<_EditItemCard> createState() => _EditItemCardState();
}

class _EditItemCardState extends State<_EditItemCard> {
  @override
  Widget build(BuildContext context) {
    final item  = widget.item;
    final index = widget.index;
    final state = widget.state;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color : _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
              color    : Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset   : const Offset(0, 2))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Card header ───────────────────────────────────────────────────
        Row(children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: _kPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text('${index + 1}',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _kPrimary)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.isNew ? 'New Item' : (item.ledgerName ?? 'Item ${index + 1}'),
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: _kLabel),
            ),
          ),
          if (item.isNew || state._editItems.length > 1)
            GestureDetector(
              onTap: () => state.setState(
                      () => state._editItems.removeAt(index)),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.delete_outline_rounded,
                    color: Colors.redAccent, size: 17),
              ),
            ),
        ]),

        const Divider(height: 18, color: _kBorder),

        // Ledger (read-only for existing)
        if (!item.isNew) ...[
          _ReadOnlyRow('Expense Ledger',
              item.ledgerName ?? '—', Icons.list_alt_rounded),
          const SizedBox(height: 12),
        ],

        // Description
        _EditLabel('Description'),
        const SizedBox(height: 6),
        _TextField(
          ctrl     : item.descCtrl,
          hint     : 'Enter description',
          maxLines : 2,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),

        // Amount
        _EditLabel('Amount (₹)'),
        const SizedBox(height: 6),
        _TextField(
          ctrl    : item.amountCtrl,
          hint    : '0.00',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
          ],
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),

        // Existing file links (full URL from backend)
        // In _EditItemCard build():
        if ((item.referenceFileUrl ?? '').isNotEmpty)
          ..._parseUrls(item.referenceFileUrl!).asMap().entries.map((e) =>
              _UrlFileTile(
                label: 'Reference ${e.key + 1}',
                url  : e.value,
                icon : Icons.file_present_rounded,
                color: _kPrimary,
                onTap: () => state._openUrl(e.value),
              )
          ),

        if ((item.receiptFileUrl ?? '').isNotEmpty)
          ..._parseUrls(item.receiptFileUrl!).asMap().entries.map((e) =>
              _UrlFileTile(
                label: 'Receipt ${e.key + 1}',
                url  : e.value,
                icon : Icons.receipt_long_rounded,
                color: const Color(0xFF059669),
                onTap: () => state._openUrl(e.value),
              )
          ),

        // New attachments picked for this item
        if (item.newAttachments.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...item.newAttachments.asMap().entries.map((e) => _LocalFileTile(
            attach : e.value,
            onRemove: () =>
                setState(() => item.newAttachments.removeAt(e.key)),
          )),
        ],

        // Attach button
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            await state._pickFilesForItem(index);
            setState(() {});
          },
          child: Container(
            width  : double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color : const Color(0xFFF8F9FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: _kPrimary.withValues(alpha: 0.3),
                  style: BorderStyle.solid),
            ),
            alignment: Alignment.center,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.attach_file_rounded,
                    size: 16, color: _kPrimary),
                SizedBox(width: 6),
                Text('Attach File',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _kPrimary)),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  /// Splits a comma-separated URL string into individual valid URLs
  List<String> _parseUrls(String raw) {
    return raw
        .split(',')
        .map((u) => u.trim())
        .where((u) => u.startsWith('http'))
        .toList();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHARED VIEW WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Section header row
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(7),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 15, color: color),
          ),
          const SizedBox(width: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: .6)),
          const Spacer(),
          if (trailing != null) trailing!,
        ]),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder),
          boxShadow: [
            BoxShadow(
                color    : Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset   : const Offset(0, 2))
          ],
        ),
        child: child,
      ),
    ],
  );
}

class _ViewRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _ViewRow(this.label, this.value, this.icon, {this.valueColor});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Label column — fixed width so values align
      SizedBox(
        width: 120,
        child: Row(children: [
          Icon(icon, size: 15, color: _kSub),
          const SizedBox(width: 6),
          Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 12, color: _kSub)),
          ),
        ]),
      ),
      Expanded(
        child: Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? _kLabel)),
      ),
    ]),
  );
}

class _ExpenseItemTile extends StatelessWidget {
  final GetExpenseItem item;
  final int index;
  final bool isLast;
  final Future<void> Function(String) onOpenUrl;

  const _ExpenseItemTile({
    required this.item,
    required this.index,
    required this.isLast,
    required this.onOpenUrl,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Item header
      Row(children: [
        Container(
          width: 22, height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFF059669).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text('${index + 1}',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF059669))),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(item.expenseLedger ?? '—',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kLabel)),
        ),
        Text(
          '₹ ${item.amount?.toStringAsFixed(2) ?? "0.00"}',
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF059669)),
        ),
      ]),
      if ((item.expenseGroup ?? '').isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 3, left: 30),
          child: Text(item.expenseGroup!,
              style: const TextStyle(fontSize: 11, color: _kSub)),
        ),
      if ((item.description ?? '').isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 3, left: 30, bottom: 6),
          child: Text(item.description!,
              style: const TextStyle(fontSize: 12, color: _kSub),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
        ),

      // File links (full URL)
      // ✅ Fix — split and show each file separately
      if ((item.referenceFile ?? '').isNotEmpty)
        ..._parseUrls(item.referenceFile!).asMap().entries.map((e) =>
            _UrlFileTile(
              label: 'File ${e.key + 1}',
              url  : e.value,
              icon : Icons.file_present_rounded,
              color: _kPrimary,
              onTap: () => onOpenUrl(e.value),
            )
        ),

      if ((item.receiptFile ?? '').isNotEmpty)
        ..._parseUrls(item.receiptFile!).asMap().entries.map((e) =>
            _UrlFileTile(
              label: 'Receipt ${e.key + 1}',
              url  : e.value,
              icon : Icons.receipt_long_rounded,
              color: const Color(0xFF059669),
              onTap: () => onOpenUrl(e.value),
            )
        ),
      if (!isLast)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(height: 1, color: _kBorder),
        ),
    ],
  );

  /// Splits a comma-separated URL string into individual valid URLs
  List<String> _parseUrls(String raw) {
    return raw
        .split(',')
        .map((u) => u.trim())
        .where((u) => u.startsWith('http'))
        .toList();
  }
}

class _UrlFileTile extends StatelessWidget {
  final String label, url;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _UrlFileTile({
    required this.label,
    required this.url,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = url.split('/').last.split('?').first;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin : const EdgeInsets.only(top: 7),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color : color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color)),
              Text(fileName,
                  style: const TextStyle(fontSize: 11, color: _kSub),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ]),
          ),
          Icon(Icons.open_in_new_rounded, size: 15, color: color),
        ]),
      ),
    );
  }
}

class _LocalFileTile extends StatelessWidget {
  final _NewAttachment attach;
  final VoidCallback onRemove;
  const _LocalFileTile({required this.attach, required this.onRemove});

  @override
  Widget build(BuildContext context) => Container(
    margin : const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(
      color : Colors.green.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Row(children: [
      const Icon(Icons.attach_file_rounded,
          size: 16, color: Color(0xFF059669)),
      const SizedBox(width: 8),
      Expanded(
        child: Text(attach.name,
            style: const TextStyle(fontSize: 12, color: _kLabel),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
      GestureDetector(
        onTap: onRemove,
        child: const Icon(Icons.close_rounded,
            size: 16, color: Colors.redAccent),
      ),
    ]),
  );
}

class _AmountGradientCard extends StatelessWidget {
  final ExpenseData listItem;
  const _AmountGradientCard({required this.listItem});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
          colors: [_kPrimary, Color(0xFF9575CD)],
          begin: Alignment.topLeft,
          end  : Alignment.bottomRight),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
            color    : _kPrimary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset   : const Offset(0, 4))
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Claimed Amount',
              style: TextStyle(fontSize: 13, color: Colors.white70)),
          const SizedBox(height: 4),
          Text('₹${listItem.amount ?? 0}',
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          _mini('Approved', listItem.approvedAmt),
          const SizedBox(height: 4),
          _mini('Balance', listItem.balanceAmt),
        ]),
      ],
    ),
  );

  Widget _mini(String label, num? amt) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(label,
          style: const TextStyle(fontSize: 11, color: Colors.white60)),
      Text('₹${amt ?? 0}',
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white)),
    ],
  );
}

class _StatusBanner extends StatelessWidget {
  final String status;
  const _StatusBanner({required this.status});

  @override
  Widget build(BuildContext context) {
    final label = status.trim().isEmpty ? 'Pending' : status.trim();
    final color = _statusColor(label);
    final bg    = color.withValues(alpha: 0.1);
    IconData icon;
    switch (label.toLowerCase()) {
      case 'approved':
      case 'approve':    // ✅ add
        icon = Icons.check_circle_outline_rounded; break;
      case 'rejected':
      case 'reject':     // ✅ add
        icon = Icons.cancel_outlined; break;
      default:
        icon = Icons.hourglass_top_rounded;
    }
    return Container(
      width  : double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Approval Status',
              style: TextStyle(
                  fontSize: 11, color: color.withValues(alpha: 0.8))),
          Text(label,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color)),
        ]),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHARED EDIT WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _EditLabel extends StatelessWidget {
  final String text;
  const _EditLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: _kSub));
}

class _TextField extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const _TextField({
    required this.ctrl,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller     : ctrl,
    maxLines       : maxLines,
    keyboardType   : keyboardType,
    inputFormatters: inputFormatters,
    onChanged      : onChanged,
    style          : const TextStyle(fontSize: 14, color: _kLabel),
    decoration: InputDecoration(
      hintText : hint,
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFB0B7C3)),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _kBorder)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _kBorder)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _kPrimary, width: 1.5)),
      filled   : true,
      fillColor: Colors.white,
    ),
  );
}

class _ReadOnlyRow extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _ReadOnlyRow(this.label, this.value, this.icon);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
    decoration: BoxDecoration(
      color : const Color(0xFFF8F9FF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kBorder),
    ),
    child: Row(children: [
      Icon(icon, size: 15, color: _kSub),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(fontSize: 10, color: _kSub)),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _kLabel)),
      ]),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────────────────────────────────────────

Color _statusColor(String? s) {
  switch (s?.toLowerCase()) {
    case 'approved':
    case 'approve':
      return newGreenColor;
    case 'rejected':
    case 'reject':
      return newRedColor;
    case 'pending':  return newOrangeColor;
    default:         return _kPrimary;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SECTION DETAIL WIDGETS  (take non-nullable header — fixes Dart field narrowing)
// ─────────────────────────────────────────────────────────────────────────────

class _RequestDetailsSection extends StatelessWidget {
  final GetExpenseHeader header;
  const _RequestDetailsSection({required this.header});

  @override
  Widget build(BuildContext context) => Column(children: [
    _ViewRow('Amount',
        '₹ ${header.totalAmount?.toStringAsFixed(2) ?? "0.00"}',
        Icons.currency_rupee_rounded,
        valueColor: newGreenColor),
    if ((header.expenseDescription ?? '').isNotEmpty) ...[
      _divider(),
      _ViewRow('Description', header.expenseDescription ?? '—',
          Icons.description_outlined),
    ],
    if ((header.additionalNotes ?? '').isNotEmpty) ...[
      _divider(),
      _ViewRow('Notes', header.additionalNotes ?? '—',
          Icons.note_alt_outlined),
    ],
    if ((header.reason ?? '').isNotEmpty) ...[
      _divider(),
      _ViewRow('Reason', header.reason ?? '—', Icons.report_outlined,
          valueColor: Colors.orange),
    ],
  ]);
}

class _PartySection extends StatelessWidget {
  final GetExpenseHeader header;
  const _PartySection({required this.header});

  @override
  Widget build(BuildContext context) => Column(children: [
    _ViewRow('Requested By', header.requestedBy ?? '—',
        Icons.person_rounded),
    _divider(),
    _ViewRow('Site', header.siteName ?? '—', Icons.location_on_rounded),
    _divider(),
    _ViewRow('Status', header.approvalStatus ?? '—', Icons.info_rounded,
        valueColor: _statusColor(header.approvalStatus ?? '')),
  ]);
}

Widget _divider() => const Padding(
  padding: EdgeInsets.symmetric(vertical: 4),
  child: Divider(height: 1, color: _kBorder),
);

// ─────────────────────────────────────────────────────────────────────────────
//  DATA MODELS (edit state)
// ─────────────────────────────────────────────────────────────────────────────

class _NewAttachment {
  final String path;
  final String name;
  String? uploadedName; // non-final — can't use const

  _NewAttachment({  // ✅ remove const
    required this.path,
    required this.name,
    this.uploadedName,
  });
}

class _EditableItem {
  final bool isNew;
  final int parentId, transId, expenseLedgerId;
  final String? ledgerName;
  final String status;
  final String? referenceFileUrl;
  final String? receiptFileUrl;
  final List<_NewAttachment> newAttachments = [];

  final TextEditingController descCtrl;
  final TextEditingController amountCtrl;

  _EditableItem({
    required this.isNew,
    required this.parentId,
    required this.transId,
    required this.expenseLedgerId,
    required this.ledgerName,
    required this.status,
    required this.referenceFileUrl,
    required this.receiptFileUrl,
    required this.descCtrl,
    required this.amountCtrl,
  });

  factory _EditableItem.fromDetail(GetExpenseItem item) => _EditableItem(
    isNew           : false,
    parentId        : item.parentId ?? 0,
    transId         : item.transId ?? 0,
    expenseLedgerId : item.expenseLedgerId ?? 0,
    ledgerName      : item.expenseLedger,
    status          : item.status ?? 'P',
    referenceFileUrl: item.referenceFile,
    receiptFileUrl  : item.receiptFile,
    descCtrl        : TextEditingController(text: item.description ?? ''),
    amountCtrl      : TextEditingController(
        text: item.amount != null
            ? item.amount!.toStringAsFixed(2)
            : ''),
  );

  factory _EditableItem.newEmpty(int sno) => _EditableItem(
    isNew           : true,
    parentId        : 0,
    transId         : 0,
    expenseLedgerId : 0,
    ledgerName      : null,
    status          : 'P',
    referenceFileUrl: null,
    receiptFileUrl  : null,
    descCtrl        : TextEditingController(),
    amountCtrl      : TextEditingController(),
  );

  void dispose() {
    descCtrl.dispose();
    amountCtrl.dispose();
  }
}