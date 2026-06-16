// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:digitalerp/download_document_management/dawnload_documents_controller.dart';
// import 'package:digitalerp/download_document_management/download_document-list_responce.dart';
// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class DownloadDocumentsView extends StatelessWidget {
//   DownloadDocumentsView({Key? key}) : super(key: key);
//   final partyFocusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DownloadDocumentController>(
//         init: DownloadDocumentController(),
//         builder: (controller) {
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: Center(
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/dashboard_bg.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       child: SafeArea(
//                         child: MyAppBar(
//                           title: 'Download Documents',
//                           onBackTap: () => Get.back(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       right: 0,
//                       left: 0,
//                       bottom: 0,
//                       top: Get.height * 0.450,
//                       child: SingleChildScrollView(
//                         child: Column(children: [
//                           ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: controller.downloadDocumentListData.length,
//                             itemBuilder: (context, index) => _dDocumentDetails(controller.downloadDocumentListData.elementAt(index)),
//                           ),
//                         ]),
//                       )),
//                   Positioned(
//                     right: 0,
//                     left: 0,
//                     bottom: 0,
//                     top: Get.height * 0.150,
//                     child: Column(
//                       children: [
//                         selectedDocumentType(controller),
//                         SizedBox(
//                           height: Get.height * 0.0100,
//                         ),
//                         _partyDropDown(controller),
//                         SizedBox(
//                           height: Get.height * 0.0100,
//                         ),
//                         _dateColumn(controller, context),
//                         SizedBox(
//                           height: Get.height * 0.0100,
//                         ),
//                         SolidAppButton(
//                           onPressed: () {
//                             if (controller.selectDocument == null || controller.selectDocument!.documentname!.isEmpty) {
//                               ShowMessage.showSnackBar('', 'Please Select Document Type');
//                             } else if (controller.selectPartyList == null || controller.selectPartyList!.partyname!.isEmpty) {
//                               ShowMessage.showSnackBar('', 'Please Select Party');
//                             } else {
//                               controller.getDownloadDocumentListApi();
//                             }
//                           },
//                           name: 'Search',
//                           topColor: orangeColor,
//                           bottomColor: red2Color,
//                           textSize: 16,
//                           hPadding: 30,
//                         ),
//                         SizedBox(
//                           height: Get.height * 0.0100,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   _dDocumentDetails(DownloadDocumentListData data) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Column(
//         children: [
//           Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: Container(
//               width: Get.width,
//               // height: Get.height * 0.270,
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 3))]),
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: Get.width * 0.35,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Document No.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange.shade400)),
//                             Text(data.documentno ?? '',
//                                 // 'N/A',
//                                 style: const TextStyle().xstyle),
//                             const SizedBox(
//                               height: 7,
//                             ),
//                             Text("Party Name", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange.shade400)),
//                             Text(data.partyname ?? '',
//                                 // 'N/A',
//                                 style: TextStyle().xstyle),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text("Grand Total", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange.shade400)),
//                             Text(data.grandtotal ?? '',
//                                 // 'N/A',
//                                 style: TextStyle().xstyle),
//                             const SizedBox(
//                               height: 7,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         width: Get.width * 0.35,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Document Date", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange.shade400)),
//                             Text(data.documentdate ?? '',
//                                 // 'N/A',
//                                 style: TextStyle().xstyle),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text("Contact No.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange.shade400)),
//                             Text(data.contactno ?? '',
//                                 // 'N/A',
//                                 style: TextStyle().xstyle),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text("Total Qty", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange.shade400)),
//                             Text(data.totalqty ?? '',
//                                 // 'N/A',
//                                 style: TextStyle().xstyle),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 255,
//                           top: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   ' PDF',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     final link = await Get.put<DownloadDocumentController>(DownloadDocumentController()).getDownloadDocumentPrintApi(data.documentid.toString());
//                     print("Link = $link");
//                     launchUrl(Uri.parse("$link"),mode: LaunchMode.externalApplication );
//                   },
//                   child: Image(
//                     image: const AssetImage('assets/images/pdf.png'),
//                     height: Get.height * 0.0310,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: Get.height * 0.0100,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget selectedDocumentType(DownloadDocumentController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: Get.height * 0.0550,
//         buttonWidth: Get.width * 0.900,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [grBottomColor.withValues(alpha:0.2), grTopColor.withValues(alpha:0.2)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text("Document Type", style: TextStyle().normal.copyWith(fontSize: 14, color: Colors.black)
//
//             // overflow: TextOverflow.ellipsis,
//             ),
//         // value: controller.selectedDocument,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         value: controller.selectDocument?.did,
//         items: controller.downloadDocumentData.map(
//           (items) {
//             return DropdownMenuItem(
//               value: items.did,
//               child: Text(
//                 items.documentname.toString(),
//                 style: TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//               ),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) => controller.setSelectDocumentTypeDropdown(controller.downloadDocumentData.firstWhere((element) => element.did == newValue)),
//       ),
//     );
//   }
//
//   // Widget _partyDropDown(DownloadDocumentController controller) {
//   //   return DropdownButtonHideUnderline(
//   //     child: DropdownButton2(
//   //       buttonHeight: Get.height * 0.0550,
//   //       buttonWidth: Get.width * 0.900,
//   //       buttonPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//   //       dropdownDecoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(15),
//   //         color: dropdownBoxColor,
//   //       ),
//   //       dropdownMaxHeight: 200,
//   //       buttonDecoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(10),
//   //         color: dropdownBoxColor,
//   //         gradient: LinearGradient(
//   //           colors: [
//   //             grBottomColor.withValues(alpha:0.2),
//   //             grTopColor.withValues(alpha:0.2)
//   //           ],
//   //           begin: Alignment.topCenter,
//   //           end: Alignment.bottomCenter,
//   //         ),
//   //       ),
//   //       isExpanded: true,
//   //       hint: Text(
//   //         "Select Party",
//   //         style: const TextStyle().newstyle.copyWith(
//   //           color: Colors.black,
//   //         ),
//   //         // overflow: TextOverflow.ellipsis,
//   //       ),
//   //       // value: controller.selectedDocument,
//   //       icon: Image.asset(
//   //         AppAssets.dropdownIcon,
//   //         width: 15,
//   //         height: 15,
//   //       ),
//   //       value: controller.selectPartyList?.partyid,
//   //       items: controller.partyListData.map(
//   //             (items) {
//   //           return DropdownMenuItem(
//   //             value: items.partyid,
//   //             child: Text(
//   //               items.partyname.toString(),
//   //               style: TextStyle().newstyle.copyWith(color: Colors.black),
//   //             ),
//   //           );
//   //         },
//   //       ).toList(),
//   //       onChanged: (newValue) => controller.setSelectedPartyDropDown(
//   //           controller.partyListData
//   //               .firstWhere((element) => element.partyid == newValue)),
//   //       // items: controller.filterDocumentData.map(
//   //       //       (items) {
//   //       //     return DropdownMenuItem(
//   //       //       value: items,
//   //       //       child: Text(
//   //       //         items.documentname ?? '',
//   //       //       ),
//   //       //     );
//   //       //   },
//   //       // ).toList(),
//   //       // onChanged: (newValue){
//   //       //   controller.onChangedDocumentDataValue(newValue);
//   //       //   controller.update();
//   //       // },
//   //     ),
//   //   );
//   // }
//
//   _partyDropDown(DownloadDocumentController controller) {
//     final partyController = TextEditingController(text: controller.selectPartyList?.partyname ?? "");
//
//     partyFocusNode.addListener(() {
//       if (partyFocusNode.hasFocus) {
//         partyController.selection = TextSelection(
//           baseOffset: 0,
//           extentOffset: partyController.text.length,
//         );
//       }
//     });
//
//     return Container(
//       height: Get.height / 18,
//       width: Get.width * 0.900,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(7),
//         color: dropdownBoxColor,
//         gradient: blueDropdownGr,
//       ),
//       child: AutoCompleteTextField<CustomerListData>(
//         key: GlobalKey<AutoCompleteTextFieldState<CustomerListData>>(),
//         controller: partyController,
//         focusNode: partyFocusNode,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(top: 10, left: 7),
//           hintText: 'Select Party',
//           hintStyle: TextStyle().normal.copyWith(fontSize: 14, color: Colors.black),
//           border: InputBorder.none,
//           suffixIcon: Icon(
//             Icons.search,
//             color: Colors.deepOrangeAccent,
//           ),
//         ),
//         clearOnSubmit: false,
//         suggestions: controller.partyListData.toList() ?? [],
//         itemBuilder: (context, suggestion) {
//           return ListTile(
//             style: ListTileStyle.list,
//             tileColor: dropdownBoxColor,
//             title: Text(suggestion.partyname.toString()),
//             subtitle: Text(suggestion.mobileno.toString()),
//           );
//         },
//         itemSorter: (a, b) {
//           return a.partyname!.compareTo(b.partyname!);
//         },
//         itemFilter: (suggestion, input) {
//           return suggestion.partyname!.toLowerCase().contains(input.toLowerCase()) ||
//               suggestion.address!.toLowerCase().contains(input.toLowerCase()) ||
//               suggestion.mobileno!.toLowerCase().contains(input.toLowerCase());
//         },
//         itemSubmitted: (suggestion) {
//           controller.setSelectedPartyDropDown(suggestion);
//           partyController.text = suggestion.partyname ?? '';
//           partyController.selection = TextSelection.fromPosition(
//             TextPosition(offset: partyController.text.length),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _dateColumn(
//     DownloadDocumentController controller,
//     BuildContext context,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         // mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'FromDate',
//                 style: const TextStyle().bold.copyWith(
//                       fontSize: 15,
//                       color: red2Color,
//                     ),
//               ),
//               const SizedBox(width: 160),
//               Text(
//                 'To Date',
//                 style: const TextStyle().bold.copyWith(
//                       fontSize: 15,
//                       color: red2Color,
//                     ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _dateView(controller.firstDownloadDate, Get.width * .31, true, controller, context),
//               _dateView(controller.lastDownloadDate, Get.width * .31, false, controller, context),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _dateView(
//     String value,
//     double width,
//     bool isFirst,
//     DownloadDocumentController controller,
//     BuildContext context,
//   ) {
//     int currentYear = int.parse(
//       controller.homeController.currentUserData?.yearId?.split('-').first ?? '0',
//     );
//     String date = isFirst ? controller.firstDownloadDate : controller.lastDownloadDate;
//     DateTime initDate = date != AppString.dateTimeEmpty
//         ? DateTime.parse(
//             formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd),
//           )
//         : DateTime.now();
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: initDate,
//           firstDate: DateTime(currentYear),
//           lastDate: DateTime.now(),
//         );
//
//         if (pickedDate != null) {
//           String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           if (isFirst) {
//             controller.setDownloadDate(formattedDate, true);
//             controller.setDateByDownloadDate(pickedDate, true);
//           } else {
//             controller.setDownloadDate(formattedDate, false);
//             controller.setDateByDownloadDate(pickedDate, false);
//           }
//         } else {
//           if (kDebugMode) {
//             print('Date is not selected');
//           }
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   // Format the displayed date in ddmmyyyy format
//                   DateFormat(AppString.ddMMyyyy).format(initDate),
//                   style: const TextStyle().medium,
//                 ),
//                 const SizedBox(width: 10),
//                 Image.asset(
//                   AppAssets.calendarIcon,
//                   width: 18,
//                   height: 18,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: Get.width * .31,
//             child: const Divider(
//               color: purpleColor,
//               thickness: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:digitalerp/download_document_management/dawnload_documents_controller.dart';
import 'package:digitalerp/download_document_management/download_document-list_responce.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

//  Shared design tokens 
const Color _kBg          = Color(0xFFF5F6FA);
const Color _kWhite       = Colors.white;
const Color _kBlue        = purpleColor;
final Color _kBlueBg      = purpleLightest;
const Color _kBorder      = Color(0xFFE2E8F0);
const Color _kTextPrimary = Color(0xFF0F172A);
const Color _kTextSub     = Color(0xFF64748B);
const Color _kTextHint    = Color(0xFF94A3B8);
const Color _kDivider     = Color(0xFFEFF2F7);

//  Shared helpers 
Widget _appBar(String title, {VoidCallback? onFilter}) {
  return Container(
    color: _kWhite,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new, color: _kTextPrimary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _kTextPrimary)),
        ),
        if (onFilter != null)
          GestureDetector(
            onTap: onFilter,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: _kBlueBg,
                  borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.filter_list_sharp, color: _kBlue, size: 20),
            ),
          ),
      ],
    ),
  );
}

Widget _styledDropdown({required Widget child}) => Container(
  decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorder)),
  child: child,
);

Widget _sectionLabel(String label) => Text(label,
    style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: _kTextPrimary));


class DownloadDocumentsView extends StatelessWidget {
  DownloadDocumentsView({Key? key}) : super(key: key);
  final partyFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloadDocumentController>(
      init: DownloadDocumentController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              // App Bar
              _appBar('Download Documents'),

              // Body
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom:
                    MediaQuery.of(context).viewInsets.bottom > 0 ? 200 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document Type
                      _sectionLabel('Document Type'),
                      const SizedBox(height: 8),
                      _styledDropdown(
                          child: _documentTypeDropdown(controller)),
                      const SizedBox(height: 14),

                      // Party (autocomplete)
                      _sectionLabel('Party'),
                      const SizedBox(height: 8),
                      _partyField(controller),
                      const SizedBox(height: 14),

                      // Date range
                      _sectionLabel('Date Range'),
                      const SizedBox(height: 8),
                      _dateRow(controller, context),
                      const SizedBox(height: 20),

                      // Search button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.selectDocument == null ||
                                (controller.selectDocument!.documentname
                                    ?.isEmpty ??
                                    true)) {
                              ShowMessage.showSnackBar(
                                  '', 'Please Select Document Type');
                            } else if (controller.selectPartyList == null ||
                                (controller.selectPartyList!.partyname
                                    ?.isEmpty ??
                                    true)) {
                              ShowMessage.showSnackBar('', 'Please Select Party');
                            } else {
                              controller.getDownloadDocumentListApi();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _kBlue,
                            foregroundColor: _kWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text('Search',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Results list
                      if (controller.downloadDocumentListData.isNotEmpty) ...[
                        _sectionLabel('Results'),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                          controller.downloadDocumentListData.length,
                          itemBuilder: (context, index) => _documentCard(
                              controller.downloadDocumentListData
                                  .elementAt(index)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Document Type dropdown 
  Widget _documentTypeDropdown(DownloadDocumentController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: _kWhite),
        dropdownMaxHeight: 200,
        buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.transparent),
        isExpanded: true,
        hint: const Text('Document Type',
            style: TextStyle(fontSize: 14, color: _kTextHint)),
        value: controller.selectDocument?.did,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: _kTextSub, size: 22),
        items: controller.downloadDocumentData.map((items) {
          return DropdownMenuItem(
            value: items.did,
            child: Text(items.documentname.toString(),
                style: const TextStyle(fontSize: 14, color: _kTextPrimary)),
          );
        }).toList(),
        onChanged: (newValue) => controller.setSelectDocumentTypeDropdown(
            controller.downloadDocumentData
                .firstWhere((e) => e.did == newValue)),
      ),
    );
  }

  //  Party autocomplete 
  Widget _partyField(DownloadDocumentController controller) {
    final partyController = TextEditingController(
        text: controller.selectPartyList?.partyname ?? '');
    partyFocusNode.addListener(() {
      if (partyFocusNode.hasFocus) {
        partyController.selection = TextSelection(
            baseOffset: 0, extentOffset: partyController.text.length);
      }
    });

    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kBorder)),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: AutoCompleteTextField<CustomerListData>(
        key: GlobalKey<AutoCompleteTextFieldState<CustomerListData>>(),
        controller: partyController,
        focusNode: partyFocusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Party',
          hintStyle: TextStyle(color: _kTextHint, fontSize: 14),
          suffixIcon: Icon(Icons.search, color: _kTextSub, size: 18),
          contentPadding: EdgeInsets.only(top: 14),
        ),
        clearOnSubmit: false,
        suggestions: controller.partyListData.toList(),
        itemBuilder: (context, suggestion) => ListTile(
          tileColor: _kWhite,
          title: Text(suggestion.partyname.toString(),
              style:
              const TextStyle(fontSize: 14, color: _kTextPrimary)),
          subtitle: Text(suggestion.mobileno.toString(),
              style: const TextStyle(fontSize: 12, color: _kTextSub)),
        ),
        itemSorter: (a, b) => a.partyname!.compareTo(b.partyname!),
        itemFilter: (suggestion, input) =>
        suggestion.partyname!
            .toLowerCase()
            .contains(input.toLowerCase()) ||
            suggestion.address!
                .toLowerCase()
                .contains(input.toLowerCase()) ||
            suggestion.mobileno!
                .toLowerCase()
                .contains(input.toLowerCase()),
        itemSubmitted: (suggestion) {
          controller.setSelectedPartyDropDown(suggestion);
          partyController.text = suggestion.partyname ?? '';
          partyController.selection = TextSelection.fromPosition(
              TextPosition(offset: partyController.text.length));
        },
      ),
    );
  }

  //  Date row 
  Widget _dateRow(
      DownloadDocumentController controller, BuildContext context) {
    return Row(
      children: [
        Expanded(child: _datePicker(controller, context, isFirst: true)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('to',
              style: TextStyle(fontSize: 14, color: _kTextSub)),
        ),
        Expanded(child: _datePicker(controller, context, isFirst: false)),
      ],
    );
  }

  Widget _datePicker(DownloadDocumentController controller,
      BuildContext context,
      {required bool isFirst}) {
    final int currentYear = int.parse(
        controller.homeController.currentUserData?.yearId?.split('-').first ??
            '2024');
    final String date =
    isFirst ? controller.firstDownloadDate : controller.lastDownloadDate;
    final DateTime initDate = date != AppString.dateTimeEmpty
        ? DateTime.parse(
        formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: DateTime(currentYear),
          lastDate: DateTime.now(),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: _kBlue, onPrimary: Colors.white),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          final fmt = DateFormat(AppString.ddMMyyyy).format(picked);
          controller.setDownloadDate(fmt, isFirst);
          controller.setDateByDownloadDate(picked, isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _kBorder)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                date == AppString.dateTimeEmpty
                    ? 'DD/MM/YYYY'
                    : DateFormat(AppString.ddMMyyyy).format(initDate),
                style: TextStyle(
                    fontSize: 13,
                    color: date == AppString.dateTimeEmpty
                        ? _kTextHint
                        : _kTextPrimary),
              ),
            ),
            const Icon(Icons.calendar_today_outlined,
                size: 15, color: _kTextSub),
          ],
        ),
      ),
    );
  }

  //  Document result card 
  Widget _documentCard(DownloadDocumentListData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          //  Header 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Document No.',
                      style: TextStyle(
                          fontSize: 11,
                          color: _kTextSub,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 2),
                  Text(data.documentno ?? '—',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _kTextPrimary)),
                ]),
                const Spacer(),
                // PDF icon
                GestureDetector(
                  onTap: () async {
                    final link = await Get.put<DownloadDocumentController>(
                        DownloadDocumentController())
                        .getDownloadDocumentPrintApi(
                        data.documentid.toString());
                    launchUrl(Uri.parse('$link'),
                        mode: LaunchMode.externalApplication);
                  },
                  child: Image.asset('assets/iconsnew/pdfIcon.png',
                      width: 28, height: 28),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: _kDivider),

          //  Fields grid 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              children: [
                Row(children: [
                  _infoBox('Party Name', data.partyname ?? '—'),
                  const SizedBox(width: 10),
                  _infoBox('Document Date', data.documentdate ?? '—'),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  _infoBox('Grand Total', data.grandtotal ?? '—'),
                  const SizedBox(width: 10),
                  _infoBox('Contact No.', data.contactno ?? '—'),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  _infoBox('Total Qty', data.totalqty ?? '—'),
                  const Expanded(child: SizedBox()),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _kBlueBg,
        borderRadius: BorderRadius.circular(8),
        border: const Border(left: BorderSide(color: _kBlue, width: 3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: _kTextSub)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _kTextPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ]),
    ),
  );
}