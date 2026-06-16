// // import 'dart:convert';
// // import 'dart:developer';
// // import 'dart:io';
// //
// // import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// // import 'package:digitalerp/response/customer_detail_response.dart';
// // import 'package:digitalerp/response/get_approver_name_res_model.dart';
// // import 'package:digitalerp/response/get_branchand_sit_res_model.dart';
// // import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // import '../utils/app_constant_new.dart';
// // import 'payment_request_controller.dart';
// //
// // class PaymentRequestBinding extends Bindings {
// //   @override
// //   void dependencies() {
// //     Get.lazyPut<PaymentRequestController>(
// //           () => PaymentRequestController(),
// //     );
// //   }
// // }
// //
// // class PaymentRequestScreen extends StatelessWidget {
// //   PaymentRequestScreen({super.key});
// //
// //   final partyFocusNode = FocusNode();
// //   final branchFocusNode = FocusNode();
// //   final approverFocusNode = FocusNode();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<PaymentRequestController>(
// //       initState: (state) {
// //         PaymentRequestController.to.clearData();
// //       },
// //       builder: (controller) => Scaffold(
// //         backgroundColor: const Color(0xFFF4F6FB),
// //         appBar: AppBar(
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
// //             onPressed: () => Get.back(),
// //           ),
// //           title: const Text(
// //             'Payment Request',
// //             style: TextStyle(
// //               color: Colors.black,
// //               fontWeight: FontWeight.bold,
// //               fontSize: 18,
// //             ),
// //           ),
// //         ),
// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //
// //               // Party
// //               _sectionLabel('Party Name'),
// //               const SizedBox(height: 8),
// //               _partyDropDown(controller),
// //               const SizedBox(height: 18),
// //
// //               // Party Type
// //               _sectionLabel('Party Type'),
// //               const SizedBox(height: 8),
// //               _partyTypeDropDown(controller),
// //               const SizedBox(height: 18),
// //
// //              // Request Type
// //               _sectionLabel('Request Type'),
// //               const SizedBox(height: 8),
// //               _requestTypeDropDown(controller),
// //               const SizedBox(height: 18),
// //
// //               // Branch / Site
// //               _sectionLabel('Site Name'),
// //               const SizedBox(height: 8),
// //               _branchSiteDropDown(controller),
// //               const SizedBox(height: 18),
// //
// //               // Amount + Ref Doc side by side
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         _sectionLabel('Amount'),
// //                         const SizedBox(height: 8),
// //                         _amountTextField(controller),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         _sectionLabel('Ref Doc Name'),
// //                         const SizedBox(height: 8),
// //                         _refDocnameTextField(controller),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 18),
// //
// //               // Reason / Description
// //               _sectionLabel('Description'),
// //               const SizedBox(height: 8),
// //               _reasonTextField(controller),
// //               const SizedBox(height: 18),
// //
// //               // Approver
// //               _sectionLabel('Approver Name'),
// //               const SizedBox(height: 8),
// //               _approverNameDropDown(controller),
// //               const SizedBox(height: 18),
// //
// //               // File Upload
// //               _sectionLabel('Reference File'),
// //               const SizedBox(height: 8),
// //               _uploadDocumentBox(controller),
// //               const SizedBox(height: 28),
// //
// //               // Submit
// //               _submitButton(controller),
// //               const SizedBox(height: 40),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   //  Section label
// //   Widget _sectionLabel(String label) {
// //     return Text(
// //       label,
// //       style: const TextStyle(
// //         fontSize: 14,
// //         fontWeight: FontWeight.w600,
// //         color: Colors.black87,
// //       ),
// //     );
// //   }
// //
// //   //  Shared input decoration
// //   BoxDecoration _inputDecoration() {
// //     return BoxDecoration(
// //       color: Colors.white,
// //       borderRadius: BorderRadius.circular(14),
// //       border: Border.all(color: Colors.grey.shade100),
// //       boxShadow: [
// //         BoxShadow(
// //           color: Colors.black.withValues(alpha:0.06),
// //           blurRadius: 10,
// //           spreadRadius: 0,
// //           offset: const Offset(0, 4),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   InputDecoration _fieldDecoration(String hint) {
// //     return InputDecoration(
// //       hintText: hint,
// //       hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
// //       border: InputBorder.none,
// //       contentPadding:
// //       const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
// //     );
// //   }
// //
// //   //  Party autocomplete
// //   Widget _partyDropDown(PaymentRequestController controller) {
// //     final partyController = TextEditingController(
// //         text: controller.selectPartyList?.partyname ?? '');
// //
// //     partyFocusNode.addListener(() {
// //       if (partyFocusNode.hasFocus) {
// //         partyController.selection = TextSelection(
// //           baseOffset: 0,
// //           extentOffset: partyController.text.length,
// //         );
// //       }
// //     });
// //
// //     return Container(
// //       decoration: _inputDecoration(),
// //       child: AutoCompleteTextField<CustomerListData>(
// //         key: GlobalKey<AutoCompleteTextFieldState<CustomerListData>>(),
// //         controller: partyController,
// //         focusNode: partyFocusNode,
// //         decoration: _fieldDecoration('Select Party').copyWith(
// //           suffixIcon:
// //           Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade400),
// //         ),
// //         clearOnSubmit: false,
// //         suggestions: controller.partyListData,
// //         itemBuilder: (context, suggestion) => ListTile(
// //           dense: true,
// //           title: Text(suggestion.partyname.toString(),
// //               style: const TextStyle(fontSize: 14)),
// //         ),
// //         itemSorter: (a, b) => a.partyname!.compareTo(b.partyname!),
// //         itemFilter: (suggestion, input) => suggestion.partyname!
// //             .toLowerCase()
// //             .contains(input.toLowerCase()),
// //         itemSubmitted: (suggestion) {
// //           controller.setSelectedPartyDropDown(suggestion);
// //           partyController.text = suggestion.partyname ?? '';
// //           partyController.selection = TextSelection.fromPosition(
// //             TextPosition(offset: partyController.text.length),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   //  Party Type dropdown
// //   Widget _partyTypeDropDown(PaymentRequestController controller) {
// //     return Container(
// //       decoration: _inputDecoration(),
// //       padding: const EdgeInsets.symmetric(horizontal: 14),
// //       child: DropdownButtonHideUnderline(
// //         child: DropdownButton<String>(
// //           value: controller.selectedPartyType,
// //           hint: Text('Select Party Type',
// //               style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
// //           isExpanded: true,
// //           icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade400),
// //           items: controller.partyTypeOptions
// //               .map((type) => DropdownMenuItem(
// //             value: type,
// //             child: Text(type, style: const TextStyle(fontSize: 14)),
// //           ))
// //               .toList(),
// //           onChanged: controller.setSelectedPartyType,
// //         ),
// //       ),
// //     );
// //   }
// //
// // //  Request Type dropdown
// //   Widget _requestTypeDropDown(PaymentRequestController controller) {
// //     return Container(
// //       decoration: _inputDecoration(),
// //       padding: const EdgeInsets.symmetric(horizontal: 14),
// //       child: DropdownButtonHideUnderline(
// //         child: DropdownButton<String>(
// //           value: controller.selectedRequestType,
// //           hint: Text('Select Request Type',
// //               style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
// //           isExpanded: true,
// //           icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade400),
// //           items: controller.requestTypeOptions
// //               .map((type) => DropdownMenuItem(
// //             value: type,
// //             child: Text(type, style: const TextStyle(fontSize: 14)),
// //           ))
// //               .toList(),
// //           onChanged: controller.setSelectedRequestType,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   //  Branch/Site autocomplete
// //   Widget _branchSiteDropDown(PaymentRequestController controller) {
// //     final branchSiteController = TextEditingController(
// //         text: controller.selectBranchandSit?.branchname ?? '');
// //
// //     branchFocusNode.addListener(() {
// //       if (branchFocusNode.hasFocus) {
// //         branchSiteController.selection = TextSelection(
// //           baseOffset: 0,
// //           extentOffset: branchSiteController.text.length,
// //         );
// //       }
// //     });
// //
// //     return Container(
// //       decoration: _inputDecoration(),
// //       child: AutoCompleteTextField<BranchandSit>(
// //         key: GlobalKey<AutoCompleteTextFieldState<BranchandSit>>(),
// //         controller: branchSiteController,
// //         focusNode: branchFocusNode,
// //         decoration: _fieldDecoration('Enter site name').copyWith(
// //           suffixIcon:
// //           Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade400),
// //         ),
// //         clearOnSubmit: false,
// //         suggestions: controller.branchandSit,
// //         itemBuilder: (context, suggestion) => ListTile(
// //           dense: true,
// //           title: Text(suggestion.branchname.toString(),
// //               style: const TextStyle(fontSize: 14)),
// //         ),
// //         itemSorter: (a, b) => a.branchname!.compareTo(b.branchname!),
// //         itemFilter: (suggestion, input) => suggestion.branchname!
// //             .toLowerCase()
// //             .contains(input.toLowerCase()),
// //         itemSubmitted: (suggestion) {
// //           controller.setSelectedBranchandDropDown(suggestion);
// //           branchSiteController.text = suggestion.branchname ?? '';
// //           branchSiteController.selection = TextSelection.fromPosition(
// //             TextPosition(offset: branchSiteController.text.length),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   //  Approver autocomplete
// //   Widget _approverNameDropDown(PaymentRequestController controller) {
// //     final approverNameController = TextEditingController(
// //         text: controller.selectApproverNameData?.approvername ?? '');
// //
// //     approverFocusNode.addListener(() {
// //       if (approverFocusNode.hasFocus) {
// //         approverNameController.selection = TextSelection(
// //           baseOffset: 0,
// //           extentOffset: approverNameController.text.length,
// //         );
// //       }
// //     });
// //
// //     return Container(
// //       decoration: _inputDecoration(),
// //       child: AutoCompleteTextField<ApproverNameData>(
// //         key: GlobalKey<AutoCompleteTextFieldState<ApproverNameData>>(),
// //         controller: approverNameController,
// //         focusNode: approverFocusNode,
// //         decoration: _fieldDecoration('Approver Name').copyWith(
// //           suffixIcon:
// //           Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade400),
// //         ),
// //         clearOnSubmit: false,
// //         suggestions: controller.approverNameData,
// //         itemBuilder: (context, suggestion) => ListTile(
// //           dense: true,
// //           title: Text(suggestion.approvername.toString(),
// //               style: const TextStyle(fontSize: 14)),
// //         ),
// //         itemSorter: (a, b) => a.approvername!.compareTo(b.approvername!),
// //         itemFilter: (suggestion, input) => suggestion.approvername!
// //             .toLowerCase()
// //             .contains(input.toLowerCase()),
// //         itemSubmitted: (suggestion) {
// //           controller.setSelectedApproverNameDataDropDown(suggestion);
// //           approverNameController.text = suggestion.approvername ?? '';
// //           approverNameController.selection = TextSelection.fromPosition(
// //             TextPosition(offset: approverNameController.text.length),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   //  Amount field
// //   Widget _amountTextField(PaymentRequestController controller) {
// //     return Container(
// //       decoration: _inputDecoration(),
// //       child: TextField(
// //         controller: controller.amountController,
// //         focusNode: controller.amountFocus,
// //         keyboardType: TextInputType.number,
// //         decoration: _fieldDecoration('₹0').copyWith(
// //           prefixText: '₹ ',
// //           prefixStyle: const TextStyle(
// //               color: Colors.black87, fontWeight: FontWeight.w600),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   //  Reason / description field
// //   Widget _reasonTextField(PaymentRequestController controller) {
// //     return Container(
// //       decoration: _inputDecoration(),
// //       child: TextField(
// //         controller: controller.reasonController,
// //         focusNode: controller.reasonFocus,
// //         maxLines: 4,
// //         decoration: _fieldDecoration('Description'),
// //       ),
// //     );
// //   }
// //
// //   //  Ref doc field
// //   Widget _refDocnameTextField(PaymentRequestController controller) {
// //     return Container(
// //       decoration: _inputDecoration(),
// //       child: TextField(
// //         controller: controller.refDocController,
// //         focusNode: controller.refDocFocus,
// //         decoration: _fieldDecoration('Bill No.'),
// //       ),
// //     );
// //   }
// //
// //   //  Upload document box
// //   Widget _uploadDocumentBox(PaymentRequestController controller) {
// //     return GetBuilder<PaymentRequestController>(
// //       builder: (ctrl) => Column(
// //         children: [
// //           GestureDetector(
// //             onTap: _showImageDialog,
// //             child: Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.symmetric(vertical: 28),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(14),
// //                 border: Border.all(color: Colors.grey.shade100),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withValues(alpha:0.06),
// //                     blurRadius: 10,
// //                     spreadRadius: 0,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 children: [
// //                   Icon(Icons.cloud_upload_outlined,
// //                       size: 40, color: Colors.grey.shade400),
// //                   const SizedBox(height: 10),
// //                   RichText(
// //                     text: TextSpan(
// //                       style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
// //                       children: [
// //                         const TextSpan(text: 'Drag & drop files or '),
// //                         TextSpan(
// //                           text: 'Browse',
// //                           style: TextStyle(
// //                             color: purpleColor,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     'Supported formats: PDF, JPG, JPEG, PNG',
// //                     style:
// //                     TextStyle(fontSize: 11, color: Colors.grey.shade400),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //
// //           // Preview selected image
// //           if (ctrl.selectedImage.isNotEmpty)
// //             Container(
// //               width: double.infinity,
// //               height: 200,
// //               margin: const EdgeInsets.only(top: 12),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(14),
// //                 image: DecorationImage(
// //                   image: FileImage(File(ctrl.selectedImage.value)),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //               alignment: Alignment.topRight,
// //               padding: const EdgeInsets.all(8),
// //               child: GestureDetector(
// //                 onTap: () => ctrl.setSelectedImage(''),
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: Colors.black54,
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   padding: const EdgeInsets.all(4),
// //                   child: const Icon(Icons.close, color: Colors.white, size: 16),
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   //  Submit button
// //   Widget _submitButton(PaymentRequestController controller) {
// //     return Obx(
// //           () => SizedBox(
// //         width: double.infinity,
// //         child: ElevatedButton(
// //           onPressed: controller.isLoading.value
// //               ? null
// //               : () => controller.submitButton(),
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: purpleColor,
// //             disabledBackgroundColor: purpleLight,
// //             padding: const EdgeInsets.symmetric(vertical: 16),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(14),
// //             ),
// //             elevation: 0,
// //             shadowColor: Colors.indigo.withValues(alpha:0.4),
// //           ).copyWith(
// //             elevation: WidgetStateProperty.resolveWith((states) {
// //               if (states.contains(WidgetState.pressed)) return 2;
// //               return 6;
// //             }),
// //             shadowColor: WidgetStateProperty.all(
// //               Colors.indigo.withValues(alpha: 0.35),
// //             ),
// //           ),
// //           child: controller.isLoading.value
// //               ? const SizedBox(
// //             height: 20,
// //             width: 20,
// //             child: CircularProgressIndicator(
// //               color: Colors.white,
// //               strokeWidth: 2,
// //             ),
// //           )
// //               : const Text(
// //             'Submit',
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.w600,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   //  Image picker dialog
// //   void _showImageDialog() {
// //     Get.bottomSheet(
// //       Container(
// //         padding: const EdgeInsets.all(24),
// //         decoration: const BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //         ),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               height: 4,
// //               width: 40,
// //               decoration: BoxDecoration(
// //                 color: Colors.grey.shade300,
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               'Choose Option',
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 20),
// //             ListTile(
// //               leading: Container(
// //                 width: 40,
// //                 height: 40,
// //                 decoration: BoxDecoration(
// //                   color: Colors.indigo.shade50,
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child:
// //                 Icon(Icons.photo_library_outlined, color: purpleColor),
// //               ),
// //               title: const Text('Select from Gallery'),
// //               onTap: () =>
// //                   PaymentRequestController.to.getImage(ImageSource.gallery),
// //             ),
// //             const SizedBox(height: 8),
// //             ListTile(
// //               leading: Container(
// //                 width: 40,
// //                 height: 40,
// //                 decoration: BoxDecoration(
// //                   color: Colors.indigo.shade50,
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: Icon(Icons.camera_alt_outlined,
// //                     color: purpleColor),
// //               ),
// //               title: const Text('Take a Photo'),
// //               onTap: () =>
// //                   PaymentRequestController.to.getImage(ImageSource.camera),
// //             ),
// //             const SizedBox(height: 10),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:digitalerp/payment_request/payment_request_controller.dart';
// import 'package:digitalerp/payment_request/payment_request_model/payment_request_dropdown_model.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class PaymentRequestBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<PaymentRequestController>(
//           () => PaymentRequestController(),
//       fenix: true,        // ← This is the line
//     );
//   }
// }
//
// class PaymentRequestScreen extends StatelessWidget {
//   const PaymentRequestScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PaymentRequestController>(
//       //initState: (_) => PaymentRequestController.to.clearData(),
//       builder: (controller) => Scaffold(
//         backgroundColor: const Color(0xFFF4F6FB),
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//             onPressed: () => Get.back(),
//           ),
//           title: const Text('Payment Request',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18)),
//         ),
//         body: controller.isDropdownLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Party Type
//               _label('Party Type'),
//               const SizedBox(height: 8),
//               _dropdownBox<PaymentRequestDropdownItem>(
//                 hint: 'Select Party Type',
//                 value: controller.selectedPartyType,
//                 items: controller.partyTypeList,
//                 itemLabel: (e) => e.name ?? '',
//                 onChanged: controller.onPartyTypeSelected,
//               ),
//               const SizedBox(height: 18),
//
//               // Request Type  (depends on PartyType)
//               _label('Request Type'),
//               const SizedBox(height: 8),
//               _dropdownBox<PaymentRequestDropdownItem>(
//                 hint: controller.selectedPartyType == null
//                     ? 'Select Party Type first'
//                     : 'Select Request Type',
//                 value: controller.selectedRequestType,
//                 items: controller.requestTypeList,
//                 itemLabel: (e) => e.name ?? '',
//                 onChanged: controller.selectedPartyType == null
//                     ? null
//                     : controller.onRequestTypeSelected,
//               ),
//               const SizedBox(height: 18),
//
//               // Party  (autocomplete search)
//               _label('Party Name'),
//               const SizedBox(height: 8),
//               _autocompleteSearch(
//                 ctrl: controller.partySearchCtrl,
//                 hint: 'Type to search party...',
//                 suggestions: controller.partyList,
//                 itemLabel: (e) => e.name ?? '',
//                 onSearch: controller.searchParty,
//                 onSelect: controller.onPartySelected,
//               ),
//               const SizedBox(height: 18),
//
//               // Site  (autocomplete search)
//               _label('Site Name'),
//               const SizedBox(height: 8),
//               _autocompleteSearch(
//                 ctrl: controller.siteSearchCtrl,
//                 hint: 'Type to search site...',
//                 suggestions: controller.siteList,
//                 itemLabel: (e) => e.name ?? '',
//                 onSearch: controller.searchSite,
//                 onSelect: controller.onSiteSelected,
//               ),
//               const SizedBox(height: 18),
//
//               // Amount + Ref Doc
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _label('Amount'),
//                         const SizedBox(height: 8),
//                         _inputBox(
//                           controller: controller.amountController,
//                           focusNode: controller.amountFocus,
//                           hint: '₹ 0',
//                           keyboardType: TextInputType.number,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _label('Ref Doc No.'),
//                         const SizedBox(height: 8),
//                         _inputBox(
//                           controller: controller.refDocController,
//                           focusNode: controller.refDocFocus,
//                           hint: 'Bill No.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 18),
//
//               // Description
//               _label('Description'),
//               const SizedBox(height: 8),
//               _inputBox(
//                 controller: controller.reasonController,
//                 focusNode: controller.reasonFocus,
//                 hint: 'Describe the payment request...',
//                 maxLines: 4,
//               ),
//               const SizedBox(height: 18),
//
//               // Approver
//               _label('Approver'),
//               const SizedBox(height: 8),
//               _dropdownBox<PaymentRequestDropdownItem>(
//                 hint: 'Select Approver',
//                 value: controller.selectedApprover,
//                 items: controller.approverList,
//                 itemLabel: (e) => e.name ?? ',',
//                 onChanged: controller.onApproverSelected,
//               ),
//               const SizedBox(height: 18),
//
//               // File upload
//               _label('Reference File'),
//               const SizedBox(height: 8),
//               _uploadBox(controller),
//               const SizedBox(height: 28),
//
//               // Submit
//               _submitButton(controller),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   //  Shared label
//   Widget _label(String text) => Text(text,
//       style: const TextStyle(
//           fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87));
//
//   //  Shared card decoration
//   BoxDecoration _cardDeco() => BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(14),
//     border: Border.all(color: Colors.grey.shade100),
//     boxShadow: [
//       BoxShadow(
//           color: Colors.black.withValues(alpha: 0.06),
//           blurRadius: 10,
//           offset: const Offset(0, 4))
//     ],
//   );
//
//   //  Dropdown widget
//   Widget _dropdownBox<T>({
//     required String hint,
//     required T? value,
//     required List<T> items,
//     required String Function(T) itemLabel,
//     required void Function(T?)? onChanged,
//   }) {
//     return Container(
//       decoration: _cardDeco(),
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<T>(
//           value: value,
//           isExpanded: true,
//           hint: Text(hint,
//               style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
//           icon: Icon(Icons.keyboard_arrow_down_rounded,
//               color: Colors.grey.shade400),
//           items: items
//               .map((e) => DropdownMenuItem<T>(
//               value: e,
//               child: Text(itemLabel(e),
//                   style: const TextStyle(fontSize: 14))))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
//
//   //  Autocomplete search field
//   Widget _autocompleteSearch<T>({
//     required TextEditingController ctrl,
//     required String hint,
//     required List<T> suggestions,
//     required String Function(T) itemLabel,
//     required Future<void> Function(String) onSearch,
//     required void Function(T) onSelect,
//   }) {
//     return GetBuilder<PaymentRequestController>(
//       builder: (_) => Column(
//         children: [
//           Container(
//             decoration: _cardDeco(),
//             child: TextField(
//               controller: ctrl,
//               onChanged: onSearch,
//               decoration: InputDecoration(
//                 hintText: hint,
//                 hintStyle:
//                 TextStyle(color: Colors.grey.shade400, fontSize: 14),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 14, vertical: 14),
//                 suffixIcon: ctrl.text.isNotEmpty
//                     ? IconButton(
//                     icon: const Icon(Icons.clear, size: 18),
//                     onPressed: () {
//                       ctrl.clear();
//                       onSearch('');
//                     })
//                     : Icon(Icons.search,
//                     color: Colors.grey.shade400),
//               ),
//             ),
//           ),
//           if (suggestions.isNotEmpty)
//             Container(
//               margin: const EdgeInsets.only(top: 4),
//               decoration: _cardDeco(),
//               constraints: const BoxConstraints(maxHeight: 200),
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                 itemCount: suggestions.length,
//                 separatorBuilder: (_, __) =>
//                     Divider(height: 1, color: Colors.grey.shade100),
//                 itemBuilder: (context, index) {
//                   final item = suggestions[index];
//                   return ListTile(
//                     dense: true,
//                     title: Text(itemLabel(item),
//                         style: const TextStyle(fontSize: 14)),
//                     onTap: () => onSelect(item),
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   //  Text input
//   Widget _inputBox({
//     required TextEditingController controller,
//     required FocusNode focusNode,
//     required String hint,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//   }) {
//     return Container(
//       decoration: _cardDeco(),
//       child: TextField(
//         controller: controller,
//         focusNode: focusNode,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
//           border: InputBorder.none,
//           contentPadding:
//           const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         ),
//       ),
//     );
//   }
//
//   //  Upload box
//   Widget _uploadBox(PaymentRequestController controller) {
//     return Obx(() => Column(
//       children: [
//         GestureDetector(
//           onTap: () => _showImageDialog(),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 28),
//             decoration: _cardDeco(),
//             child: Column(
//               children: [
//                 Icon(Icons.cloud_upload_outlined,
//                     size: 40, color: Colors.grey.shade400),
//                 const SizedBox(height: 10),
//                 RichText(
//                   text: TextSpan(
//                     style: TextStyle(
//                         fontSize: 14, color: Colors.grey.shade600),
//                     children: [
//                       const TextSpan(text: 'Drag & drop or '),
//                       TextSpan(
//                         text: 'Browse',
//                         style: TextStyle(
//                             color: purpleColor,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 // Text('PDF, JPG, PNG',
//                 //     style: TextStyle(
//                 //         fontSize: 11, color: Colors.grey.shade400)),
//                 // Show upload status
//                 if (controller.uploadedFileName.isNotEmpty) ...[
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.check_circle,
//                           color: Colors.green, size: 16),
//                       const SizedBox(width: 4),
//                       Text(
//                         controller.uploadedFileName.value,
//                         style: const TextStyle(
//                             fontSize: 11, color: Colors.green),
//                       ),
//                     ],
//                   )
//                 ],
//               ],
//             ),
//           ),
//         ),
//         if (controller.selectedImage.isNotEmpty)
//           Container(
//             width: double.infinity,
//             height: 180,
//             margin: const EdgeInsets.only(top: 12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               image: DecorationImage(
//                 image: FileImage(File(controller.selectedImage.value)),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             alignment: Alignment.topRight,
//             padding: const EdgeInsets.all(8),
//             child: GestureDetector(
//               onTap: () {
//                 controller.selectedImage.value    = '';
//                 controller.uploadedFileName.value = '';
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.black54,
//                     borderRadius: BorderRadius.circular(20)),
//                 padding: const EdgeInsets.all(4),
//                 child: const Icon(Icons.close,
//                     color: Colors.white, size: 16),
//               ),
//             ),
//           ),
//       ],
//     ));
//   }
//
//   //  Submit button
//   Widget _submitButton(PaymentRequestController controller) {
//     return Obx(() => SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: controller.isLoading.value
//             ? null
//             : controller.submitButton,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: purpleColor,
//           disabledBackgroundColor: purpleLight,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14)),
//           elevation: 6,
//         ),
//         child: controller.isLoading.value
//             ? const SizedBox(
//             height: 20,
//             width: 20,
//             child: CircularProgressIndicator(
//                 color: Colors.white, strokeWidth: 2))
//             : const Text('Submit',
//             style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white)),
//       ),
//     ));
//   }
//
//   //  Image picker bottom sheet
//   void _showImageDialog() {
//     Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(24),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               height: 4, width: 40,
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(10)),
//             ),
//             const SizedBox(height: 20),
//             const Text('Choose Option',
//                 style:
//                 TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             _pickerTile(
//                 icon: Icons.photo_library_outlined,
//                 label: 'Select from Gallery',
//                 onTap: () => PaymentRequestController.to
//                     .getImage(ImageSource.gallery)),
//             const SizedBox(height: 8),
//             _pickerTile(
//                 icon: Icons.camera_alt_outlined,
//                 label: 'Take a Photo',
//                 onTap: () => PaymentRequestController.to
//                     .getImage(ImageSource.camera)),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _pickerTile(
//       {required IconData icon,
//         required String label,
//         required VoidCallback onTap}) {
//     return ListTile(
//       leading: Container(
//         width: 40, height: 40,
//         decoration: BoxDecoration(
//             color: Colors.indigo.shade50,
//             borderRadius: BorderRadius.circular(10)),
//         child: Icon(icon, color: purpleColor),
//       ),
//       title: Text(label),
//       onTap: onTap,
//     );
//   }
// }

import 'package:digitalerp/payment_request/payment_request_controller.dart';
import 'package:digitalerp/payment_request/payment_request_model/payment_request_dropdown_model.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class PaymentRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentRequestController>(
      () => PaymentRequestController(),
    );
  }
}

class PaymentRequestScreen extends StatelessWidget {
  const PaymentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentRequestController>(
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text('Payment Request',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ),
        body: controller.isDropdownLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Party Type
                    _label('Party Type'),
                    const SizedBox(height: 8),
                    _dropdownBox<PaymentRequestDropdownItem>(
                      hint: 'Select Party Type',
                      value: controller.selectedPartyType,
                      items: controller.partyTypeList,
                      itemLabel: (e) => e.name ?? '',
                      onChanged: controller.onPartyTypeSelected,
                    ),
                    const SizedBox(height: 18),

                    // Request Type
                    _label('Request Type'),
                    const SizedBox(height: 8),
                    _dropdownBox<PaymentRequestDropdownItem>(
                      hint: controller.selectedPartyType == null
                          ? 'Select Party Type first'
                          : 'Select Request Type',
                      value: controller.selectedRequestType,
                      items: controller.requestTypeList,
                      itemLabel: (e) => e.name ?? '',
                      onChanged: controller.selectedPartyType == null
                          ? null
                          : controller.onRequestTypeSelected,
                    ),
                    const SizedBox(height: 18),

                    // Party Name
                    _label('Party Name'),
                    const SizedBox(height: 8),
                    _autocompleteSearch(
                      ctrl: controller.partySearchCtrl,
                      hint: 'Type to search party...',
                      suggestions: controller.partyList,
                      itemLabel: (e) => e.name ?? '',
                      onSearch: controller.searchParty,
                      onSelect: controller.onPartySelected,
                    ),
                    const SizedBox(height: 18),

                    // Site Name
                    _label('Site Name'),
                    const SizedBox(height: 8),
                    _autocompleteSearch(
                      ctrl: controller.siteSearchCtrl,
                      hint: 'Type to search site...',
                      suggestions: controller.siteList,
                      itemLabel: (e) => e.name ?? '',
                      onSearch: controller.searchSite,
                      onSelect: controller.onSiteSelected,
                    ),
                    const SizedBox(height: 18),

                    // Amount
                    _label('Amount'),
                    const SizedBox(height: 8),
                    _inputBox(
                      controller: controller.amountController,
                      focusNode: controller.amountFocus,
                      hint: '₹ 0',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 18),

                    // Description
                    _label('Description'),
                    const SizedBox(height: 8),
                    _inputBox(
                      controller: controller.reasonController,
                      focusNode: controller.reasonFocus,
                      hint: 'Describe the payment request...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 18),

                    // Approver
                    _label('Approver'),
                    const SizedBox(height: 8),
                    _dropdownBox<PaymentRequestDropdownItem>(
                      hint: 'Select Approver',
                      value: controller.selectedApprover,
                      items: controller.approverList,
                      itemLabel: (e) => e.name ?? '',
                      onChanged: controller.onApproverSelected,
                    ),
                    const SizedBox(height: 18),

                    // Reference Files (multiple)
                    _label('Reference Files'),
                    const SizedBox(height: 8),
                    _multiUploadBox(controller),
                    const SizedBox(height: 28),

                    // Submit
                    _submitButton(controller),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }

  //  Label
  Widget _label(String text) => Text(text,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87));

  //  Card decoration
  BoxDecoration _cardDeco() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      );

  //  Dropdown
  Widget _dropdownBox<T>({
    required String hint,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required void Function(T?)? onChanged,
  }) {
    return Container(
      decoration: _cardDeco(),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(hint,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.grey.shade400),
          items: items
              .map((e) => DropdownMenuItem<T>(
                  value: e,
                  child:
                      Text(itemLabel(e), style: const TextStyle(fontSize: 14))))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  //  Autocomplete search
  Widget _autocompleteSearch<T>({
    required TextEditingController ctrl,
    required String hint,
    required List<T> suggestions,
    required String Function(T) itemLabel,
    required Future<void> Function(String) onSearch,
    required void Function(T) onSelect,
  }) {
    return GetBuilder<PaymentRequestController>(
      builder: (_) => Column(
        children: [
          Container(
            decoration: _cardDeco(),
            child: TextField(
              controller: ctrl,
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                suffixIcon: ctrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          ctrl.clear();
                          onSearch('');
                        })
                    : Icon(Icons.search, color: Colors.grey.shade400),
              ),
            ),
          ),
          if (suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: _cardDeco(),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: suggestions.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade100),
                itemBuilder: (context, index) {
                  final item = suggestions[index];
                  return ListTile(
                    dense: true,
                    title: Text(itemLabel(item),
                        style: const TextStyle(fontSize: 14)),
                    onTap: () => onSelect(item),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  //  Text input
  Widget _inputBox({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: _cardDeco(),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }

  //  Multi-file upload box
  Widget _multiUploadBox(PaymentRequestController controller) {
    return Obx(() {
      final files = controller.selectedFiles; // RxList<SelectedFileItem>
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // File list
          if (files.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: _cardDeco(),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: files.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade100),
                itemBuilder: (context, index) {
                  final file = files[index];
                  final isImage = file.type == FileType.image;
                  return ListTile(
                    dense: true,
                    leading: isImage
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              File(file.path),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(Icons.picture_as_pdf,
                                color: Colors.red.shade400, size: 22),
                          ),
                    title: Text(
                      file.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      file.sizeLabel,
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                    trailing: IconButton(
                      icon:
                          const Icon(Icons.close, size: 18, color: Colors.red),
                      onPressed: () => controller.removeFile(index),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  );
                },
              ),
            ),

          // Add files button
          GestureDetector(
            onTap: () => _showFilePickerSheet(controller),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: files.isNotEmpty
                      ? purpleColor.withValues(alpha: 0.4)
                      : Colors.grey.shade200,
                  width: files.isNotEmpty ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    files.isNotEmpty
                        ? Icons.add_circle_outline
                        : Icons.cloud_upload_outlined,
                    size: 36,
                    color:
                        files.isNotEmpty ? purpleColor : Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  files.isNotEmpty
                      ? Text(
                          'Add more files (${files.length} selected)',
                          style: const TextStyle(
                              fontSize: 13,
                              color: purpleColor,
                              fontWeight: FontWeight.w500),
                        )
                      : RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                            children: [
                              const TextSpan(text: 'Tap to '),
                              TextSpan(
                                text: 'Browse',
                                style: TextStyle(
                                    color: purpleColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const TextSpan(text: ' or take a photo'),
                            ],
                          ),
                        ),
                  const SizedBox(height: 4),
                  Text('Supports JPG, PNG, PDF',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  //  File picker bottom sheet
  void _showFilePickerSheet(PaymentRequestController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 20),
            const Text('Add File',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _pickerTile(
              icon: Icons.photo_library_outlined,
              label: 'Select from Gallery',
              subtitle: 'Choose one or more images',
              onTap: () {
                Get.back();
                controller.pickMultipleImages(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 8),
            _pickerTile(
              icon: Icons.camera_alt_outlined,
              label: 'Take a Photo',
              subtitle: 'Use camera',
              onTap: () {
                Get.back();
                controller.pickMultipleImages(ImageSource.camera);
              },
            ),
            const SizedBox(height: 8),
            _pickerTile(
              icon: Icons.picture_as_pdf_outlined,
              label: 'Choose PDF',
              subtitle: 'Select PDF document',
              onTap: () {
                Get.back();
                controller.pickPdfFiles();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _pickerTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: purpleColor, size: 22),
      ),
      title: Text(label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      subtitle: Text(subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  //  Submit
  Widget _submitButton(PaymentRequestController controller) {
    return Obx(() => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                controller.isLoading.value ? null : controller.submitButton,
            style: ElevatedButton.styleFrom(
              backgroundColor: purpleColor,
              disabledBackgroundColor: purpleLight,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 6,
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                : const Text('Submit',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
          ),
        ));
  }
}
