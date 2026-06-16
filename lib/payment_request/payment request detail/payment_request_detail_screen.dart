// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
//
// import '../payment_request_model/payment_request_dropdown_model.dart';
// import 'payment_request_detail_controller.dart';
//
// class PaymentRequestDetailScreen extends StatelessWidget {
//   const PaymentRequestDetailScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PaymentRequestDetailController>(
//       builder: (ctrl) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF5F6FA),
//           appBar: _buildAppBar(ctrl),
//           body: ctrl.isDropdownLoading
//               ? const Center(child: CircularProgressIndicator())
//               : _buildBody(context, ctrl),
//           bottomNavigationBar: ctrl.canEdit ? _buildBottomBar(ctrl) : null,
//         );
//       },
//     );
//   }
//
//   //  AppBar 
//   AppBar _buildAppBar(PaymentRequestDetailController ctrl) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 3,
//       shadowColor: const Color(0x12000000),
//       surfaceTintColor: Colors.white,
//       centerTitle: false,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new,
//             size: 18, color: Colors.black87),
//         onPressed: () => Get.back(),
//       ),
//       title: Column(
//         children: [
//           Text(
//             'Payment Request No. ${ctrl.request.requestNo ?? 'N/A'}',
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87),
//           ),
//           if (ctrl.request.status != null)
//             Text(
//               ctrl.request.status!,
//               style:
//                   TextStyle(fontSize: 12, color: ctrl.request.getStatusColor()),
//             ),
//         ],
//       ),
//       actions: [
//         if (!ctrl.canEdit)
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: Chip(
//               label: Text(ctrl.request.status ?? '',
//                   style: TextStyle(
//                       color: ctrl.request.getStatusColor(), fontSize: 12)),
//               backgroundColor: ctrl.request.getStatusColor().withValues(alpha:0.1),
//               side: BorderSide.none,
//               padding: EdgeInsets.zero,
//             ),
//           ),
//       ],
//     );
//   }
//
//   //  Body 
//   Widget _buildBody(BuildContext context, PaymentRequestDetailController ctrl) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//       child: Column(
//         children: [
//           _SectionCard(
//             title: 'Basic Info',
//             children: [
//               _DateField(ctrl: ctrl, context: context),
//               const SizedBox(height: 14),
//               _DropdownField<PaymentRequestDropdownItem>(
//                 label: 'Party Type',
//                 value: ctrl.selectedPartyType,
//                 items: ctrl.partyTypeList,
//                 itemLabel: (e) => e.name ?? '',
//                 onChanged: ctrl.canEdit ? ctrl.onPartyTypeSelected : null,
//               ),
//               const SizedBox(height: 14),
//               _DropdownField<PaymentRequestDropdownItem>(
//                 label: 'Request Type',
//                 value: ctrl.selectedRequestType,
//                 items: ctrl.requestTypeList,
//                 itemLabel: (e) => e.name ?? '',
//                 onChanged: ctrl.canEdit ? ctrl.onRequestTypeSelected : null,
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           _SectionCard(
//             title: 'Party & Site',
//             children: [
//               _SearchableField(
//                 label: 'Party Name',
//                 controller: ctrl.partySearchCtrl,
//                 suggestions: ctrl.partyList,
//                 itemLabel: (e) => e.name ?? '',
//                 onChanged: ctrl.canEdit ? ctrl.searchParty : null,
//                 onSelected: ctrl.canEdit ? ctrl.onPartySelected : null,
//               ),
//               const SizedBox(height: 14),
//               _SearchableField(
//                 label: 'Site / Branch',
//                 controller: ctrl.siteSearchCtrl,
//                 suggestions: ctrl.siteList,
//                 itemLabel: (e) => e.name ?? '',
//                 onChanged: ctrl.canEdit ? ctrl.searchSite : null,
//                 onSelected: ctrl.canEdit ? ctrl.onSiteSelected : null,
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           _SectionCard(
//             title: 'Request Details',
//             children: [
//               _InputField(
//                 label: 'Amount (₹)',
//                 controller: ctrl.amountController,
//                 keyboardType: TextInputType.number,
//                 enabled: ctrl.canEdit,
//                 prefixIcon: Icons.currency_rupee,
//               ),
//               const SizedBox(height: 14),
//               _InputField(
//                 label: 'Reason / Request For',
//                 controller: ctrl.reasonController,
//                 maxLines: 3,
//                 enabled: ctrl.canEdit,
//                 prefixIcon: Icons.notes,
//               ),
//               // const SizedBox(height: 14),
//               // _InputField(
//               //   label: 'Ref Doc No',
//               //   controller: ctrl.refDocController,
//               //   enabled: ctrl.canEdit,
//               //   prefixIcon: Icons.document_scanner_outlined,
//               // ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           _SectionCard(
//             title: 'Approver',
//             children: [
//               _DropdownField<PaymentRequestDropdownItem>(
//                 label: 'Select Approver',
//                 value: ctrl.selectedApprover,
//                 items: ctrl.approverList,
//                 itemLabel: (e) => e.name ?? '',
//                 onChanged: ctrl.canEdit ? ctrl.onApproverSelected : null,
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           _SectionCard(
//             title: 'Document',
//             children: [
//               _DocumentField(ctrl: ctrl),
//             ],
//           ),
//
//           // Cancel button for pending requests
//           if (ctrl.canEdit) ...[
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton.icon(
//                 onPressed: ctrl.isBusy ? null : () => _confirmCancel(ctrl),
//                 icon: const Icon(Icons.cancel_outlined, color: Colors.red),
//                 label: const Text('Cancel Request',
//                     style: TextStyle(color: Colors.red)),
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Colors.red),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   //  Bottom Save Bar 
//   Widget _buildBottomBar(PaymentRequestDetailController ctrl) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
//       child: SizedBox(
//         width: double.infinity,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: ctrl.isBusy ? null : ctrl.saveRequest,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: purpleColor,
//             foregroundColor: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//           child: ctrl.isBusy
//               ? const SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                       strokeWidth: 2, color: Colors.white))
//               : const Text('Save Changes',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//         ),
//       ),
//     );
//   }
//
//   void _confirmCancel(PaymentRequestDetailController ctrl) {
//     Get.defaultDialog(
//       title: 'Cancel Request',
//       middleText: 'Are you sure you want to cancel this payment request?',
//       textCancel: 'No',
//       textConfirm: 'Yes, Cancel',
//       confirmTextColor: Colors.white,
//       buttonColor: Colors.red,
//       onConfirm: () {
//         Get.back();
//         ctrl.cancelRequest();
//       },
//     );
//   }
// }
//
// //  Reusable Widgets 
//
// class _SectionCard extends StatelessWidget {
//   final String title;
//   final List<Widget> children;
//   const _SectionCard({required this.title, required this.children});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withValues(alpha:0.05),
//               blurRadius: 6,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: purpleColor)),
//           const SizedBox(height: 12),
//           const Divider(height: 1),
//           const SizedBox(height: 12),
//           ...children,
//         ],
//       ),
//     );
//   }
// }
//
// class _InputField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final bool enabled;
//   final int maxLines;
//   final TextInputType keyboardType;
//   final IconData? prefixIcon;
//
//   const _InputField({
//     required this.label,
//     required this.controller,
//     this.enabled = true,
//     this.maxLines = 1,
//     this.keyboardType = TextInputType.text,
//     this.prefixIcon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       enabled: enabled,
//       maxLines: maxLines,
//       keyboardType: keyboardType,
//       style: const TextStyle(fontSize: 14),
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18) : null,
//         filled: true,
//         fillColor: enabled ? Colors.white : const Color(0xFFF8F8F8),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//         disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFFF0F0F0))),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: purpleColor)),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       ),
//     );
//   }
// }
//
// class _DropdownField<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<T> items;
//   final String Function(T) itemLabel;
//   final void Function(T?)? onChanged;
//
//   const _DropdownField({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.itemLabel,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<T>(
//       initialValue: items.contains(value) ? value : null,
//       isExpanded: true,
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: onChanged != null ? Colors.white : const Color(0xFFF8F8F8),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//         disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Color(0xFFF0F0F0))),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: purpleColor)),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       ),
//       items: items
//           .map((e) => DropdownMenuItem<T>(
//               value: e,
//               child: Text(itemLabel(e), style: const TextStyle(fontSize: 14))))
//           .toList(),
//       onChanged: onChanged,
//     );
//   }
// }
//
// class _SearchableField<T> extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final List<T> suggestions;
//   final String Function(T) itemLabel;
//   final void Function(String)? onChanged;
//   final void Function(T)? onSelected;
//
//   const _SearchableField({
//     required this.label,
//     required this.controller,
//     required this.suggestions,
//     required this.itemLabel,
//     required this.onChanged,
//     required this.onSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: controller,
//           enabled: onChanged != null,
//           style: const TextStyle(fontSize: 14),
//           onChanged: onChanged,
//           decoration: InputDecoration(
//             labelText: label,
//             prefixIcon: const Icon(Icons.search, size: 18),
//             suffixIcon: controller.text.isNotEmpty && onChanged != null
//                 ? IconButton(
//                     icon: const Icon(Icons.clear, size: 18),
//                     onPressed: () {
//                       controller.clear();
//                       onChanged?.call('');
//                     },
//                   )
//                 : null,
//             filled: true,
//             fillColor:
//                 onChanged != null ? Colors.white : const Color(0xFFF8F8F8),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//             disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Color(0xFFF0F0F0))),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: purpleColor)),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           ),
//         ),
//         if (suggestions.isNotEmpty)
//           Container(
//             margin: const EdgeInsets.only(top: 2),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: const Color(0xFFE0E0E0)),
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(color: Colors.black.withValues(alpha:0.06), blurRadius: 6)
//               ],
//             ),
//             constraints: const BoxConstraints(maxHeight: 180),
//             child: ListView.separated(
//               shrinkWrap: true,
//               padding: EdgeInsets.zero,
//               itemCount: suggestions.length,
//               separatorBuilder: (_, __) => const Divider(height: 1),
//               itemBuilder: (_, i) => ListTile(
//                 dense: true,
//                 title: Text(itemLabel(suggestions[i]),
//                     style: const TextStyle(fontSize: 13)),
//                 onTap: () => onSelected?.call(suggestions[i]),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class _DateField extends StatelessWidget {
//   final PaymentRequestDetailController ctrl;
//   final BuildContext context;
//   const _DateField({required this.ctrl, required this.context});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ctrl.canEdit ? () => ctrl.pickDate(context) : null,
//       child: AbsorbPointer(
//         child: TextFormField(
//           controller: TextEditingController(
//             text: DateFormat('dd-MM-yyyy').format(ctrl.selectedDate),
//           ),
//           enabled: ctrl.canEdit,
//           style: const TextStyle(fontSize: 14),
//           decoration: InputDecoration(
//             labelText: 'Request Date',
//             prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
//             filled: true,
//             fillColor: ctrl.canEdit ? Colors.white : const Color(0xFFF8F8F8),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
//             disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Color(0xFFF0F0F0))),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _DocumentField extends StatelessWidget {
//   final PaymentRequestDetailController ctrl;
//   const _DocumentField({required this.ctrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final hasFile = ctrl.uploadedFileName.value.isNotEmpty;
//       return Column(
//         children: [
//           if (hasFile)
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE3F2FD),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.insert_drive_file_outlined,
//                       color: purpleColor, size: 20),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(ctrl.uploadedFileName.value,
//                         style: const TextStyle(
//                             fontSize: 13, color: purpleColor),
//                         overflow: TextOverflow.ellipsis),
//                   ),
//                   if (ctrl.canEdit)
//                     IconButton(
//                       icon:
//                           const Icon(Icons.close, size: 16, color: Colors.red),
//                       onPressed: () {
//                         ctrl.uploadedFileName.value = '';
//                         ctrl.selectedImage.value = '';
//                       },
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                     ),
//                 ],
//               ),
//             ),
//           if (ctrl.canEdit) ...[
//             if (hasFile) const SizedBox(height: 10),
//             OutlinedButton.icon(
//               onPressed: () => _showImagePicker(context, ctrl),
//               icon: const Icon(Icons.attach_file, size: 18),
//               label: Text(hasFile ? 'Change Document' : 'Attach Document'),
//               style: OutlinedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 44),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ],
//           if (!ctrl.canEdit && !hasFile)
//             const Text('No document attached',
//                 style: TextStyle(color: Colors.grey, fontSize: 13)),
//         ],
//       );
//     });
//   }
//
//   void _showImagePicker(
//       BuildContext context, PaymentRequestDetailController ctrl) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
//       builder: (_) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt_outlined),
//               title: const Text('Camera'),
//               onTap: () => ctrl.getImage(ImageSource.camera),
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library_outlined),
//               title: const Text('Gallery'),
//               onTap: () => ctrl.getImage(ImageSource.gallery),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'dart:io';import 'package:digitalerp/utils/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io' as dart_io;
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../homeview_new_controller.dart';
import '../payment_request_model/payment_request_dropdown_model.dart';
import 'payment_request_detail_controller.dart';

class PaymentRequestDetailScreen extends StatelessWidget {
  const PaymentRequestDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentRequestDetailController>(
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: const Color(0xFFF0F2F8),
          appBar: _buildAppBar(ctrl),
          body: ctrl.isDropdownLoading
              ? const Center(
                  child: CircularProgressIndicator(color: purpleColor))
              : _buildBody(context, ctrl),
          bottomNavigationBar:
              (ctrl.canEdit && ctrl.isEditMode) ? _buildBottomBar(ctrl) : null,
        );
      },
    );
  }

  //  AppBar 
  AppBar _buildAppBar(PaymentRequestDetailController ctrl) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xFFEEEEEE), height: 1),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new,
            size: 18, color: Colors.black87),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Request #${ctrl.request.requestNo ?? 'N/A'}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
          ),
          if (ctrl.request.status != null)
            _StatusBadge(
                status: ctrl.request.status!,
                color: ctrl.request.getStatusColor()),
        ],
      ),
      actions: [
        if (ctrl.canEdit)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ctrl.isEditMode
                ? TextButton(
                    onPressed: ctrl.exitEditMode,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  )
                : FilledButton.icon(
                    onPressed: ctrl.enterEditMode,
                    icon: const Icon(Icons.edit_outlined, size: 15),
                    label: const Text('Edit',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    style: FilledButton.styleFrom(
                      backgroundColor: purpleColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
          ),
        if (!ctrl.canEdit)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _StatusBadge(
              status: ctrl.request.status ?? '',
              color: ctrl.request.getStatusColor(),
              filled: true,
            ),
          ),
      ],
    );
  }

  //  Body 
  Widget _buildBody(BuildContext context, PaymentRequestDetailController ctrl) {
    final bool editing = ctrl.canEdit && ctrl.isEditMode;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Edit mode banner
          if (editing) ...[
            _EditBanner(),
            const SizedBox(height: 16),
          ],

          //  Basic Info 
          _sectionHeader('Basic Info', Icons.info_outline_rounded),
          const SizedBox(height: 8),
          _Card(
            children: [
              _DetailRow(
                icon: Icons.calendar_today_outlined,
                label: 'Date',
                child: editing
                    ? _TapToPickDate(ctrl: ctrl)
                    : _ValueText(
                        DateFormat('dd MMM yyyy').format(ctrl.selectedDate)),
              ),
              _divider(),
              _DetailRow(
                icon: Icons.category_outlined,
                label: 'Party Type',
                child: editing
                    ? _InlineDropdown<PaymentRequestDropdownItem>(
                        value: ctrl.selectedPartyType,
                        items: ctrl.partyTypeList,
                        itemLabel: (e) => e.name ?? '',
                        hint: 'Select',
                        onChanged: ctrl.onPartyTypeSelected,
                      )
                    : _ValueText(ctrl.request.partyType ?? '—'),

              ),
              _divider(),
              _DetailRow(
                icon: Icons.receipt_long_outlined,
                label: 'Request Type',
                child: editing
                    ? _InlineDropdown<PaymentRequestDropdownItem>(
                        value: ctrl.selectedRequestType,
                        items: ctrl.requestTypeList,
                        itemLabel: (e) => e.name ?? '',
                        hint: 'Select',
                        onChanged: ctrl.onRequestTypeSelected,
                      )
                    : _ValueText(ctrl.request.requestType ?? '—'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          //  Party & Site 
          _sectionHeader('Party & Site', Icons.people_outline_rounded),
          const SizedBox(height: 8),
          _Card(
            children: [
              _DetailRow(
                icon: Icons.person_outline_rounded,
                label: 'Party',
                child: editing
                    ? _InlineSearch<PaymentRequestDropdownItem>(
                        controller: ctrl.partySearchCtrl,
                        suggestions: ctrl.partyList,
                        itemLabel: (e) => e.name ?? '',
                        hint: 'Search party...',
                        onChanged: ctrl.searchParty,
                        onSelected: ctrl.onPartySelected,
                      )
                    : _ValueText(ctrl.partySearchCtrl.text.isEmpty
                        ? '—'
                        : ctrl.partySearchCtrl.text),
              ),
              _divider(),
              _DetailRow(
                icon: Icons.location_on_outlined,
                label: 'Site',
                child: editing
                    ? _InlineSearch<PaymentRequestDropdownItem>(
                        controller: ctrl.siteSearchCtrl,
                        suggestions: ctrl.siteList,
                        itemLabel: (e) => e.name ?? '',
                        hint: 'Search site...',
                        onChanged: ctrl.searchSite,
                        onSelected: ctrl.onSiteSelected,
                      )
                    : _ValueText(ctrl.siteSearchCtrl.text.isEmpty
                        ? '—'
                        : ctrl.siteSearchCtrl.text),
              ),
            ],
          ),
          const SizedBox(height: 20),

          //  Request Details 
          _sectionHeader('Request Details', Icons.description_outlined),
          const SizedBox(height: 8),
          _Card(
            children: [
              _DetailRow(
                icon: Icons.currency_rupee_rounded,
                label: 'Amount',
                child: editing
                    ? _InlineTextField(
                        controller: ctrl.amountController,
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                      )
                    : _ValueText(
                        ctrl.amountController.text.isEmpty
                            ? '—'
                            : '₹ ${ctrl.amountController.text}',
                        bold: true),
              ),
              _divider(),
              _DetailRow(
                icon: Icons.notes_rounded,
                label: 'Reason',
                crossAxisAlignment: CrossAxisAlignment.start,
                child: editing
                    ? _InlineTextField(
                        controller: ctrl.reasonController,
                        hint: 'Enter reason...',
                        maxLines: 3,
                      )
                    : _ValueText(
                        ctrl.reasonController.text.isEmpty
                            ? '—'
                            : ctrl.reasonController.text,
                        multiline: true),
              ),
            ],
          ),
          const SizedBox(height: 20),

          //  Approver 
          _sectionHeader('Approver', Icons.verified_user_outlined),
          const SizedBox(height: 8),
          _Card(
            children: [
              _DetailRow(
                icon: Icons.person_pin_outlined,
                label: 'Approver',
                child: editing
                    ? _InlineDropdown<PaymentRequestDropdownItem>(
                        value: ctrl.selectedApprover,
                        items: ctrl.approverList,
                        itemLabel: (e) => e.name ?? '',
                        hint: 'Select approver',
                        onChanged: ctrl.onApproverSelected,
                      )
                    : _ValueText(ctrl.selectedApprover?.name ?? '—'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          //  Document 
          _sectionHeader('Document', Icons.attach_file_rounded),
          const SizedBox(height: 8),
          _DocumentSection(ctrl: ctrl, editing: editing),

          // Cancel request button
          if (editing) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: ctrl.isBusy ? null : () => _confirmCancel(ctrl),
                icon: const Icon(Icons.cancel_outlined,
                    color: Colors.red, size: 18),
                label: const Text('Cancel This Request',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: purpleColor),
        const SizedBox(width: 6),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: purpleColor,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _divider() => const Divider(
      height: 1, thickness: 1, color: Color(0xFFF3F3F3), indent: 48);

  //  Bottom Bar 
  Widget _buildBottomBar(PaymentRequestDetailController ctrl) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: ctrl.isBusy ? null : () => _saveAndNavigate(ctrl),
          style: ElevatedButton.styleFrom(
            backgroundColor: purpleColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: ctrl.isBusy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Text('Save Changes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Future<void> _saveAndNavigate(PaymentRequestDetailController ctrl) async {
    // Controller handles everything: validation, save, navigation, refresh
    await ctrl.saveRequest();
  }

  void _confirmCancel(PaymentRequestDetailController ctrl) {
    Get.defaultDialog(
      title: 'Cancel Request',
      middleText: 'Are you sure you want to cancel this payment request?',
      textCancel: 'No',
      textConfirm: 'Yes, Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        ctrl.cancelRequest();
      },
    );
  }
}

// ═════
// REUSABLE WIDGETS
// ═════

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;
  final bool filled;
  const _StatusBadge(
      {required this.status, required this.color, this.filled = false});

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(status,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      );
    }
    return Text(status,
        style:
            TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: color));
  }
}

class _EditBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: purpleColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: purpleColor.withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.edit_note_rounded, size: 18, color: purpleColor),
          SizedBox(width: 8),
          Text('Edit mode — tap Save Changes when done.',
              style: TextStyle(
                  fontSize: 12,
                  color: purpleColor,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final List<Widget> children;
  const _Card({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;
  final CrossAxisAlignment crossAxisAlignment;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.child,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          SizedBox(
            width: 86,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ValueText extends StatelessWidget {
  final String text;
  final bool bold;
  final bool multiline;
  const _ValueText(this.text, {this.bold = false, this.multiline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        color: text == '—' ? Colors.grey.shade400 : Colors.black87,
      ),
      maxLines: multiline ? null : 1,
      overflow: multiline ? null : TextOverflow.ellipsis,
    );
  }
}

class _InlineDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final String hint;
  final void Function(T?)? onChanged;

  const _InlineDropdown({
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // BEFORE: items.contains(value) — fails for object comparison
    // AFTER: match by finding item in list
    final matchedValue = items.firstWhereOrNull((e) => e == value);

    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: matchedValue, // ← use matched value, not raw value
        isExpanded: true,
        isDense: true,
        hint: Text(hint,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            size: 18, color: Colors.grey.shade400),
        items: items
            .map((e) => DropdownMenuItem<T>(
            value: e,
            child: Text(itemLabel(e),
                style: const TextStyle(fontSize: 13))))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _InlineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final int maxLines;

  const _InlineTextField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        filled: true,
        fillColor: const Color(0xFFF8F7FF),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Color(0xFFDDD8FF))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Color(0xFFDDD8FF))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: purpleColor, width: 1.5)),
      ),
    );
  }
}

class _InlineSearch<T> extends StatefulWidget {
  final TextEditingController controller;
  final List<T> suggestions;
  final String Function(T) itemLabel;
  final String hint;
  final void Function(String)? onChanged;
  final void Function(T)? onSelected;

  const _InlineSearch({
    required this.controller,
    required this.suggestions,
    required this.itemLabel,
    required this.hint,
    required this.onChanged,
    required this.onSelected,
  });

  @override
  State<_InlineSearch<T>> createState() => _InlineSearchState<T>();
}

class _InlineSearchState<T> extends State<_InlineSearch<T>> {
  bool _userHasTyped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          onChanged: (val) {
            setState(() => _userHasTyped = true);
            widget.onChanged?.call(val);
          },
          // Reset flag when field loses focus and text is cleared
          onTap: () {
            // Don't show suggestions on tap — only on typing
          },
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            isDense: true,
            prefixIcon: Icon(Icons.search, size: 15, color: Colors.grey.shade400),
            prefixIconConstraints: const BoxConstraints(minWidth: 32),
            suffixIcon: widget.controller.text.isNotEmpty
                ? GestureDetector(
              onTap: () {
                widget.controller.clear();
                setState(() => _userHasTyped = false); // ← reset flag on clear
                widget.onChanged?.call('');
              },
              child: Icon(Icons.close, size: 14, color: Colors.grey.shade400),
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            filled: true,
            fillColor: const Color(0xFFF8F7FF),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFFDDD8FF))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFFDDD8FF))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: purpleColor, width: 1.5)),
          ),
        ),

        // ← Only show suggestions if user has actually typed something
        if (_userHasTyped && widget.suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            constraints: const BoxConstraints(maxHeight: 160),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE8E8E8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4)),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: widget.suggestions.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1, color: Color(0xFFF5F5F5)),
              itemBuilder: (_, i) => InkWell(
                onTap: () {
                  setState(() => _userHasTyped = false); // ← hide list after selection
                  widget.onSelected?.call(widget.suggestions[i]);
                },
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(widget.itemLabel(widget.suggestions[i]),
                      style: const TextStyle(fontSize: 13, color: Colors.black87)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _TapToPickDate extends StatelessWidget {
  final PaymentRequestDetailController ctrl;
  const _TapToPickDate({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ctrl.pickDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F7FF),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFDDD8FF)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('dd MMM yyyy').format(ctrl.selectedDate),
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(width: 6),
            Icon(Icons.edit_calendar_outlined,
                size: 14, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }
}

class _DocumentSection extends StatelessWidget {
  final PaymentRequestDetailController ctrl;
  final bool editing;
  const _DocumentSection({required this.ctrl, required this.editing});

  @override

  Widget build(BuildContext context) {
// Temporarily add this at top of Obx builder to debug
    Text('Files count: ${ctrl.uploadedFiles.length}');
    return Obx(() {
      final files = ctrl.uploadedFiles;
      final isUploading = ctrl.isUploading.value;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //  Uploading indicator 
            if (isUploading)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: purpleColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: purpleColor.withValues(alpha: 0.15)),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 14, height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: purpleColor),
                    ),
                    SizedBox(width: 10),
                    Text('Uploading file...',
                        style: TextStyle(fontSize: 13, color: purpleColor)),
                  ],
                ),
              ),

            //  File list 
            if (files.isNotEmpty)
              ...files.asMap().entries.map((entry) {
                final index = entry.key;
                final filename = entry.value;
                return GestureDetector(                          // ← wrap with GestureDetector
                  onTap: () => _openFile(filename),             // ← add tap to open
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: purpleColor.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: purpleColor.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: purpleColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.insert_drive_file_outlined,
                              color: purpleColor, size: 16),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(                          // ← add hint text below filename
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filename.split('/').last,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Tap to open',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                        if (editing)
                          GestureDetector(
                            onTap: () => ctrl.uploadedFiles.removeAt(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(Icons.close,
                                  size: 14, color: Colors.red),
                            ),
                          )
                        else
                          Icon(Icons.open_in_new_rounded,        // ← open icon when not editing
                              size: 14, color: Colors.grey.shade400),
                      ],
                    ),
                  ),
                );
              })
            else if (!editing && !isUploading)
              Row(
                children: [
                  Icon(Icons.info_outline, size: 15, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Text('No document attached',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
                ],
              ),

            //  Attach button 
            if (editing) ...[
              if (files.isNotEmpty || isUploading) const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  // ← disabled while uploading
                  onPressed: isUploading ? null : () => _showImagePicker(context),
                  icon: isUploading
                      ? const SizedBox(
                      width: 14, height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: purpleColor))
                      : const Icon(Icons.attach_file_rounded, size: 16),
                  label: Text(
                    isUploading
                        ? 'Uploading...'
                        : files.isEmpty
                        ? 'Attach Document'
                        : 'Attach Another',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: purpleColor,
                    side: BorderSide(
                        color: isUploading
                            ? Colors.grey.shade300
                            : purpleColor,
                        width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  void _onFileTap(BuildContext context, String fileUrl) {
    // Show bottom sheet with options
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),

            // Filename display
            Text(
              fileUrl.split('/').last,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Open option
            ListTile(
              leading: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: purpleColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.open_in_new_rounded,
                    color: purpleColor, size: 20),
              ),
              title: const Text('Open / Preview',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              subtitle: const Text('View in browser or app',
                  style: TextStyle(fontSize: 12)),
              onTap: () {
                Get.back();
                _openFile(fileUrl);
              },
            ),
            const SizedBox(height: 8),

            // Download option
            ListTile(
              leading: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.download_rounded,
                    color: Colors.green, size: 20),
              ),
              title: const Text('Download',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              subtitle: const Text('Save to device storage',
                  style: TextStyle(fontSize: 12)),
              onTap: () {
                Get.back();
                _downloadFile(context, fileUrl);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadFile(BuildContext context, String fileUrl) async {
    try {
      // 1. Ask for storage permission
      PermissionStatus permission = await Permission.storage.request();

      // On Android 13+ use photos/videos permission instead
      if (!permission.isGranted) {
        permission = await Permission.manageExternalStorage.request();
      }

      if (!permission.isGranted) {
        Get.snackbar('Permission Denied',
            'Storage permission is required to download files',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade600,
            colorText: Colors.white);
        return;
      }

      // 2. Get download directory
      final dir = Directory('/storage/emulated/0/Download');
      if (!await dir.exists()) await dir.create(recursive: true);

      // 3. Build save path
      final filename = fileUrl.split('/').last;
      final savePath = '${dir.path}/$filename';

      // 4. Show downloading snackbar
      Get.snackbar(
        'Downloading...',
        filename,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: purpleColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 30), // will be dismissed manually
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.white24,
        progressIndicatorValueColor:
        const AlwaysStoppedAnimation<Color>(Colors.white),
        icon: const Icon(Icons.download_rounded, color: Colors.white),
      );

      // 5. Download using Dio
      final dio = Dio();
      await dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final percent = (received / total * 100).toStringAsFixed(0);
            log('Download progress: $percent%');
          }
        },
      );

      // 6. Dismiss downloading snackbar and show success
      Get.closeAllSnackbars();
      Get.snackbar(
        'Downloaded!',
        'Saved to Downloads/$filename',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.check_circle, color: Colors.white),
        mainButton: TextButton(
          onPressed: () => OpenFilex.open(savePath), // ← open after download
          child: const Text('Open',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700)),
        ),
      );

      log('✅ Downloaded to: $savePath');

    } catch (e) {
      Get.closeAllSnackbars();
      Get.snackbar('Download Failed', '$e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white);
      log('❌ Download error: $e');
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 16),
            const Text('Select Document',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _SheetTile(
              icon: Icons.camera_alt_outlined,
              label: 'Take a Photo',
              // ← no Get.back() here, getImage handles it
              onTap: () => ctrl.getImage(ImageSource.camera),
            ),
            const SizedBox(height: 8),
            _SheetTile(
              icon: Icons.photo_library_outlined,
              label: 'Choose from Gallery',
              onTap: () => ctrl.getImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }


  void _openFile(String fileUrl) async {
    final cleanedUrl = _fixUrl(fileUrl);
    log('🔗 Opening: $cleanedUrl');

    try {
      // ← Notify the home controller before opening external app
      if (Get.isRegistered<HomeViewNewController>()) {
        Get.find<HomeViewNewController>().markOpeningExternalFile();
      }

      final uri = Uri.parse(cleanedUrl);
      await Future.delayed(const Duration(milliseconds: 300));

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        Get.snackbar('Error', 'Could not open file',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade600,
            colorText: Colors.white);
      }
    } catch (e) {
      log('❌ Open error: $e');
      Get.snackbar('Error', 'Failed to open: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white);
    }
  }
  String _fixUrl(String url) {
    if (url.isEmpty) return url;

    // Fix double extension
    url = url.replaceAllMapped(
      RegExp(r'\.(jpg|jpeg|png|pdf|gif)\.\1', caseSensitive: false),
          (m) => '.${m.group(1)}',
    );
    url = url.replaceAll(RegExp(r'\.(jpg|jpeg|png|pdf|gif)\.(jpg|jpeg|png|pdf|gif)', caseSensitive: false),
        (url.contains('.jpg.jpg') ? '.jpg' : url.contains('.jpeg.jpeg') ? '.jpeg' : '.png'));

    // Simpler double-extension fix
    url = url
        .replaceAll('.jpg.jpg', '.jpg')
        .replaceAll('.jpeg.jpeg', '.jpeg')
        .replaceAll('.png.png', '.png')
        .replaceAll('.pdf.pdf', '.pdf');

    // Strip accidental wrapper
    final httpIndex = url.indexOf('http', 1);
    if (httpIndex > 0) {
      url = url.substring(httpIndex);
    }

    // Force https for absolute URLs
    if (url.startsWith('http://')) {
      url = url.replaceFirst('http://', 'https://');
    }

    // Already https
    if (url.startsWith('https://')) {
      log('📁 URL is absolute: $url');
      return url;
    }

    // Relative path
    final cleanPath = url.startsWith('/') ? url.substring(1) : url;
    return 'https://supportapi.digitalerp.biz/$cleanPath';
  }
}

// ← Remove Get.back() from _SheetTile entirely
class _SheetTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SheetTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap, // ← no Get.back() here, controller's getImage handles sheet close
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: purpleColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: purpleColor, size: 20),
      ),
      title: Text(label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
