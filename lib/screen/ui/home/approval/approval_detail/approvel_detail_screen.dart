// // import 'package:digitalerp/screen/base/base_controller.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_detail/approval_details_responce.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
// // import 'package:digitalerp/utils/app_assets.dart';
// // import 'package:digitalerp/utils/app_constant.dart';
// // import 'package:digitalerp/utils/my_app_bar_new.dart';
// // import 'package:digitalerp/utils/solid_app_button.dart';
// // import 'package:dropdown_button2/dropdown_button2.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:url_launcher/url_launcher.dart';
// //
// // class ApprovalDetailScreen extends StatefulWidget {
// //   const ApprovalDetailScreen({super.key});
// //
// //   @override
// //   State<ApprovalDetailScreen> createState() => _ApprovalDetailScreenState();
// // }
// //
// // class _ApprovalDetailScreenState extends State<ApprovalDetailScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<ApprovalFilterController>(
// //         init: ApprovalFilterController(),
// //         builder: (controller) {
// //           return Scaffold(
// //               resizeToAvoidBottomInset: true,
// //               body: Center(
// //                 child: Stack(
// //                   children: [
// //                     Positioned(
// //                       top: 0,
// //                       left: 0,
// //                       right: 0,
// //                       bottom: 0,
// //                       child: Container(
// //                         decoration: const BoxDecoration(
// //                           image: DecorationImage(
// //                             image: AssetImage('assets/images/dashboard_bg.png'),
// //                             fit: BoxFit.fill,
// //                           ),
// //                         ),
// //                         child: SafeArea(
// //                           child: MyAppBar(
// //                             title: 'Approvals',
// //                             onBackTap: () => Get.back(),
// //                             showApprovalIcon: false,
// //                             // onFilterTap: () async {
// //                             //   final filterDialog = await Get.dialog(
// //                             //       ApprovalFilterScreen());
// //                             //   if (filterDialog != null) {
// //                             //     approvalFilterModels = (filterDialog
// //                             //         as ApprovalFilterModels);
// //                             //     setState(() {});
// //                             //   }
// //                             //   log('FILTER DIALOG ==>${filterDialog}');
// //                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>const FilterScreen()));
// //                             // },
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     Positioned(
// //                         right: 0,
// //                         left: 0,
// //                         bottom: 0,
// //                         top: Get.height * 0.135,
// //                         child: controller.isBusy
// //                             ? showLoader()
// //                             : SingleChildScrollView(
// //                                 padding:
// //                                     const EdgeInsets.symmetric(horizontal: 10),
// //                                 child: Column(children: [
// //                                   SizedBox(height: Get.height * 0.02),
// //                                   const SizedBox(height: 5),
// //                                   controller.isListLoading
// //                                       ? showLoader()
// //                                       : controller.approvalDetailsData.isEmpty
// //                                           ? SizedBox(
// //                                               height: Get.height * .4,
// //                                               child: centerText(
// //                                                   'Approval Details Data No found'))
// //                                           : ListView.builder(
// //                                               shrinkWrap: true,
// //                                               padding: EdgeInsets.zero,
// //                                               physics:
// //                                                   const NeverScrollableScrollPhysics(),
// //                                               itemCount: controller
// //                                                   .approvalDetailsData.length,
// //                                               itemBuilder: (context, index) =>
// //                                                   approvalsCard(controller
// //                                                       .approvalDetailsData
// //                                                       .elementAt(index)),
// //                                             ),
// //                                   const SizedBox(
// //                                     height: 5,
// //                                   ),
// //                                   statusDropdown(controller),
// //                                   // Container(
// //                                   //     height: Get.height * 0.0650,
// //                                   //     width: Get.width * 10,
// //                                   //     decoration: BoxDecoration(
// //                                   //       borderRadius: BorderRadius.circular(10),
// //                                   //       color: newColor,
// //                                   //     ),
// //                                   //     child: Row(
// //                                   //       children: [
// //                                   //         Padding(
// //                                   //           padding: const EdgeInsets.only(left: 10),
// //                                   //           child: Text(
// //                                   //             "Status",
// //                                   //             style: TextStyle(
// //                                   //                 fontWeight: FontWeight.bold),
// //                                   //           ),
// //                                   //         ),
// //                                   //         Padding(
// //                                   //           padding: const EdgeInsets.only(left: 230),
// //                                   //           child: InkWell(
// //                                   //             child: Container(
// //                                   //               child: Image.asset(
// //                                   //                 AppAssets.dropdownIcon,
// //                                   //                 scale: 1.5,
// //                                   //               ),
// //                                   //             ),
// //                                   //           ),
// //                                   //         ),
// //                                   //       ],
// //                                   //     )),
// //                                   const SizedBox(
// //                                     height: 10,
// //                                   ),
// //                                   Container(
// //                                       height: Get.height * 0.170,
// //                                       width: Get.width * 10,
// //                                       decoration: BoxDecoration(
// //                                           borderRadius:
// //                                               BorderRadius.circular(10),
// //                                           gradient: LinearGradient(
// //                                             colors: [
// //                                               grBottomColor.withValues(alpha:0.2),
// //                                               grTopColor.withValues(alpha:0.2)
// //                                             ],
// //                                             begin: Alignment.topCenter,
// //                                             end: Alignment.bottomCenter,
// //                                           )),
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: [
// //                                           Padding(
// //                                             padding: const EdgeInsets.only(
// //                                                 left: 20, top: 10),
// //                                             child: Text(
// //                                               'Remarks',
// //                                               style: const TextStyle()
// //                                                   .newstyle
// //                                                   .copyWith(
// //                                                       fontSize: 16,
// //                                                       color: Colors.black),
// //                                             ),
// //                                           ),
// //                                           const SizedBox(
// //                                             height: 10,
// //                                           ),
// //                                           Padding(
// //                                             padding: const EdgeInsets.all(8.0),
// //                                             child: TextFormField(
// //                                               controller:
// //                                                   controller.remarkController,
// //                                               decoration: const InputDecoration(
// //                                                 border: InputBorder.none,
// //                                               ),
// //                                               focusNode: FocusNode(),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       )),
// //                                   const SizedBox(
// //                                     height: 10,
// //                                   ),
// //                                   EscalateDropdown(),
// //                                   const SizedBox(
// //                                     height: 20,
// //                                   ),
// //
// //                                   SolidAppButton(
// //                                     onPressed: () {
// //                                       controller.onSubmit(
// //                                           controller.remarkController.text);
// //                                     },
// //                                     name: 'Submit',
// //                                     topColor: Colors.red,
// //                                     bottomColor: Colors.orange,
// //                                     textSize: 15,
// //                                   ),
// //                                   // Padding(
// //                                   //   padding: const EdgeInsets.only(
// //                                   //       right: 105, left: 110),
// //                                   //   child: InkWell(
// //                                   //     onTap: () {
// //                                   //       // submitBtn();
// //                                   //     },
// //                                   //     child: Container(
// //                                   //       height: 35,
// //                                   //       width: 330,
// //                                   //       decoration: BoxDecoration(
// //                                   //           borderRadius:
// //                                   //               BorderRadius.circular(18),
// //                                   //           gradient: LinearGradient(colors: [
// //                                   //             Colors.red,
// //                                   //             Colors.orange
// //                                   //           ])),
// //                                   //       child: Center(
// //                                   //           child: Text(
// //                                   //         'Submit',
// //                                   //         style: TextStyle(color: Colors.white),
// //                                   //       )),
// //                                   //     ),
// //                                   //   ),
// //                                   // ),
// //
// //                                   const SizedBox(
// //                                     height: 20,
// //                                   ),
// //                                   const Padding(
// //                                     padding: EdgeInsets.only(right: 250),
// //                                     child: Text(
// //                                       "History",
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ),
// //                                   if (controller.approvalDetailsData.isNotEmpty)
// //                                     ListView.builder(
// //                                       shrinkWrap: true,
// //                                       padding: EdgeInsets.zero,
// //                                       physics:
// //                                           const NeverScrollableScrollPhysics(),
// //                                       itemCount: controller.approvalDetailsData
// //                                               .first.details?.length ??
// //                                           0,
// //                                       itemBuilder: (context, index) {
// //                                         return histroryCard(controller
// //                                             .approvalDetailsData
// //                                             .first
// //                                             .details![index]);
// //                                       },
// //                                     ),
// //                                 ]),
// //                               )),
// //                   ],
// //                 ),
// //               ));
// //         });
// //   }
// //
// //   Widget statusDropdown(ApprovalFilterController controller) {
// //     final uniqueStatusById = <num?, StatusListData>{};
// //     for (final status in controller.filterStatusListData) {
// //       uniqueStatusById.putIfAbsent(status.statusid, () => status);
// //     }
// //     final uniqueStatuses = uniqueStatusById.values.toList();
// //     final selectedStatusId = controller.selectedstatus?.statusid;
// //     final hasValidSingleSelection = selectedStatusId == null
// //         ? false
// //         : uniqueStatuses
// //                 .where((StatusListData e) => e.statusid == selectedStatusId)
// //                 .length ==
// //             1;
// //
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 25),
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2<num?>(
// //             buttonHeight: 40,
// //             buttonPadding:
// //                 const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
// //             dropdownDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(15),
// //               color: dropdownBoxColor,
// //             ),
// //             dropdownMaxHeight: 200,
// //             buttonDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               color: dropdownBoxColor,
// //               gradient: LinearGradient(
// //                 colors: [
// //                   grBottomColor.withValues(alpha:0.2),
// //                   grTopColor.withValues(alpha:0.2)
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             isExpanded: true,
// //             hint: Text(
// //               "Status",
// //               style: const TextStyle().newstyle.copyWith(
// //                     // fontSize: 11,
// //                     // fontWeight: FontWeight.normal,
// //                     color: Colors.black,
// //                   ),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             value: hasValidSingleSelection ? selectedStatusId : null,
// //             icon: Image.asset(
// //               AppAssets.dropdownIcon,
// //               width: 25,
// //               height: 20,
// //             ),
// //             items: uniqueStatuses.map(
// //               (StatusListData items) {
// //                 return DropdownMenuItem<num?>(
// //                   value: items.statusid,
// //                   child: Text(
// //                     items.statusname.toString(),
// //                   ),
// //                 );
// //               },
// //             ).toList(),
// //             onChanged: (newValue) {
// //               final matches = uniqueStatuses
// //                   .where((StatusListData element) => element.statusid == newValue);
// //               if (matches.isEmpty) return;
// //               controller.onChangedStatusListValue(matches.first);
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget EscalateDropdown() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 25),
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2(
// //               buttonHeight: 40,
// //               buttonPadding:
// //                   const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
// //               dropdownDecoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(15),
// //                 color: dropdownBoxColor,
// //               ),
// //               dropdownMaxHeight: 200,
// //               buttonDecoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10),
// //                 color: dropdownBoxColor,
// //                 gradient: LinearGradient(
// //                   colors: [
// //                     grBottomColor.withValues(alpha:0.2),
// //                     grTopColor.withValues(alpha:0.2)
// //                   ],
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                 ),
// //               ),
// //               isExpanded: true,
// //               hint: Text(
// //                 "Escalate to",
// //                 style: const TextStyle().newstyle.copyWith(
// //                       // fontSize: 11,
// //                       // fontWeight: FontWeight.normal,
// //                       color: Colors.black,
// //                     ),
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //               value: [],
// //               icon: Image.asset(
// //                 AppAssets.dropdownIcon,
// //                 width: 25,
// //                 height: 20,
// //               ),
// //               items: []
// //               // controller.filterStatusListData.map(
// //               //       (items) {
// //               //     return DropdownMenuItem(
// //               //       value: items.statusid,
// //               //       child: Text(
// //               //         items.statusname.toString(),
// //               //       ),
// //               //     );
// //               //   },
// //               // ).toList(),
// //               // onChanged: (newValue) => controller.onChangedStatusListValue(
// //               //     controller.filterStatusListData
// //               //         .firstWhere((element) => element.statusid == newValue)),
// //               ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget approvalsCard(ApprovalDetailsData approvalDetailsData) {
// //     return Card(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //       color: Colors.white,
// //       child: Container(
// //         width: Get.width,
// //         // height: Get.height * 0.270,
// //         decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(10),
// //             color: Colors.white,
// //             boxShadow: const [
// //               BoxShadow(
// //                   color: Colors.black12, blurRadius: 3, offset: Offset(0, 3))
// //             ]),
// //         padding: const EdgeInsets.only(top: 20, left: 5, right: 7, bottom: 10),
// //         child: Column(
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Container(
// //                   width: Get.width * 0.400,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text("Doc.Name",
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.deepOrange.shade400)),
// //                       Text(approvalDetailsData.documentname ?? 'N/A',
// //                           style: const TextStyle().xstyle),
// //                       const SizedBox(
// //                         height: 7,
// //                       ),
// //                       Text(
// //                         "Date",
// //                         style: const TextStyle().newstyle,
// //                       ),
// //                       Text(
// //                         approvalDetailsData.documentDate ?? 'N/A',
// //                         style: const TextStyle().xstyle,
// //                       ),
// //                       const SizedBox(
// //                         height: 7,
// //                       ),
// //                       Text(
// //                         "Executive Name",
// //                         style: const TextStyle().newstyle,
// //                       ),
// //                       Text(
// //                         approvalDetailsData.execuname ?? 'N/A',
// //                         style: const TextStyle().xstyle,
// //                       ),
// //                       const SizedBox(
// //                         height: 7,
// //                       ),
// //                       Text(
// //                         "Total Amount",
// //                         style: const TextStyle().newstyle,
// //                       ),
// //                       Text(
// //                         approvalDetailsData.totalamount ?? 'N/A',
// //                         style: const TextStyle().xstyle,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Container(
// //                   width: Get.width * 0.350,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text("NO.",
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.deepOrange.shade400)),
// //                       Text(approvalDetailsData.documentno ?? 'N/A',
// //                           style: const TextStyle().xstyle),
// //                       const SizedBox(
// //                         height: 7,
// //                       ),
// //                       Text(
// //                         "Party Name",
// //                         style: const TextStyle().newstyle,
// //                       ),
// //                       Text(
// //                         approvalDetailsData.partyname ?? 'N/A',
// //                         // overflow: TextOverflow.ellipsis,
// //                         // maxLines: 1,
// //                         style: const TextStyle().xstyle,
// //                       ),
// //                       const SizedBox(
// //                         height: 7,
// //                       ),
// //                       Text(
// //                         "Client Name",
// //                         style: const TextStyle().newstyle,
// //                       ),
// //                       Text(
// //                         approvalDetailsData.clintname ?? 'N/A',
// //                         softWrap: true,
// //                         // textScaleFactor: 0.9,
// //                         style: const TextStyle().xstyle,
// //                       ),
// //                       const SizedBox(
// //                         height: 7,
// //                       ),
// //                       Text(
// //                         "Last Remark",
// //                         style: const TextStyle().newstyle,
// //                       ),
// //                       Text(
// //                         approvalDetailsData.lastremark ?? 'N/A',
// //                         style: const TextStyle().xstyle,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Align(
// //               alignment: Alignment.bottomRight,
// //               child: InkWell(
// //                 onTap: () async {
// //                   final link = await Get.find<ApprovalFilterController>()
// //                       .getApprovalDocument(Get.find<ApprovalFilterController>()
// //                           .approvalDetailsData
// //                           .first
// //                           .approvalid
// //                           .toString());
// //                   print('LINK ==>$link');
// //                   launchUrl(Uri.parse("$link"),
// //                       mode: LaunchMode.externalApplication);
// //                 },
// //                 child: Image(
// //                   image: const AssetImage('assets/images/pdf.png'),
// //                   height: Get.height * 0.0380,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget histroryCard(Details details) {
// //     return Card(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //         color: Colors.white,
// //         child: Container(
// //           height: Get.height * 0.070,
// //           decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(10),
// //               boxShadow: const [
// //                 BoxShadow(
// //                     color: Colors.black12, blurRadius: 3, offset: Offset(0, 2)),
// //               ],
// //               border: Border.all(color: Colors.black45)),
// //           child: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 Column(
// //                   children: [
// //                     Text(
// //                       'Date',
// //                       style: const TextStyle().newstyle,
// //                     ),
// //                     const SizedBox(
// //                       height: 5,
// //                     ),
// //                     Text(
// //                       details.date ?? "N/A",
// //                       style: const TextStyle().xstyle,
// //                     ),
// //                   ],
// //                 ),
// //                 Column(
// //                   children: [
// //                     Text(
// //                       "Remarks",
// //                       style: const TextStyle().newstyle,
// //                     ),
// //                     const SizedBox(
// //                       height: 5,
// //                     ),
// //                     Text(
// //                       details.remarks ?? "N/A",
// //                       style: const TextStyle().xstyle,
// //                     )
// //                   ],
// //                 ),
// //                 Column(
// //                   children: [
// //                     Text(
// //                       'User',
// //                       style: const TextStyle().newstyle,
// //                     ),
// //                     const SizedBox(
// //                       height: 5,
// //                     ),
// //                     Text(
// //                       details.user ?? "N/A",
// //                       style: const TextStyle().xstyle,
// //                     )
// //                   ],
// //                 )
// //               ],
// //             ),
// //           ),
// //         ));
// //   }
// // }
// //
// // // Widget  submitBtn() {}
//
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_detail/approval_details_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ApprovalDetailScreen extends StatefulWidget {
//   const ApprovalDetailScreen({super.key});
//
//   @override
//   State<ApprovalDetailScreen> createState() => _ApprovalDetailScreenState();
// }
//
// class _ApprovalDetailScreenState extends State<ApprovalDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ApprovalFilterController>(
//       init: ApprovalFilterController(),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF5F6FA),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 _buildAppBar(),
//                 Expanded(
//                   child: controller.isBusy
//                       ? showLoader(color: newBlueColor)
//                       : SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Detail card(s)
//                         controller.isListLoading
//                             ? showLoader(color: newBlueColor)
//                             : controller.approvalDetailsData.isEmpty
//                             ? SizedBox(
//                           height: Get.height * .3,
//                           child: centerText(
//                               'Approval Details not found'),
//                         )
//                             : ListView.builder(
//                           shrinkWrap: true,
//                           padding: EdgeInsets.zero,
//                           physics:
//                           const NeverScrollableScrollPhysics(),
//                           itemCount: controller
//                               .approvalDetailsData.length,
//                           itemBuilder: (context, index) =>
//                               _detailCard(controller
//                                   .approvalDetailsData
//                                   .elementAt(index)),
//                         ),
//
//                         const SizedBox(height: 16),
//
//                         // Status dropdown
//                         _sectionLabel('Status'),
//                         const SizedBox(height: 8),
//                         _styledDropdown(
//                           child: _statusDropdownWidget(controller),
//                         ),
//
//                         const SizedBox(height: 16),
//
//                         // Remarks
//                         _sectionLabel('Remarks'),
//                         const SizedBox(height: 8),
//                         _remarksField(controller),
//
//                         const SizedBox(height: 16),
//
//                         // Escalate to
//                         _sectionLabel('Escalate to'),
//                         const SizedBox(height: 8),
//                         _styledDropdown(
//                           child: _escalateDropdownWidget(),
//                         ),
//
//                         const SizedBox(height: 24),
//
//                         // Submit button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 52,
//                           child: ElevatedButton(
//                             onPressed: () => controller.onSubmit(
//                                 controller.remarkController.text),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: purpleColor,
//                               foregroundColor: Colors.white,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                             ),
//                             child: const Text(
//                               'Submit',
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 24),
//
//                         // History section
//                         const Text(
//                           'List',
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700,
//                               color: newTextPrimary),
//                         ),
//                         const SizedBox(height: 4),
//                         // Search bar
//                         _searchBar(),
//                         const SizedBox(height: 12),
//
//                         if (controller.approvalDetailsData.isNotEmpty)
//                           ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             physics:
//                             const NeverScrollableScrollPhysics(),
//                             itemCount: controller.approvalDetailsData
//                                 .first.details?.length ??
//                                 0,
//                             itemBuilder: (context, index) =>
//                                 _historyCard(controller
//                                     .approvalDetailsData
//                                     .first
//                                     .details![index]),
//                           ),
//
//                         const SizedBox(height: 24),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildAppBar() {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Get.back(),
//             child: const Icon(Icons.arrow_back_ios_new,
//                 color: newTextPrimary, size: 22),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text(
//               'Approvals',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: newTextPrimary),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _detailCard(ApprovalDetailsData data) {
//     // ApprovalDetailsData has no status field — derive from first history entry
//     final status = data.details?.isNotEmpty == true
//         ? (data.details!.first.status ?? '')
//         : '';
//     final statusColor = _statusColor(status);
//     final statusBg = _statusBgColor(status);
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: newBlueColor.withValues(alpha: 0.4)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             child: Row(
//               children: [
//                 Text('Doc No.: ',
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: newTextSecondary,
//                         fontWeight: FontWeight.w400)),
//                 Text(
//                   data.documentno ?? 'N/A',
//                   style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: newTextPrimary),
//                 ),
//                 const Spacer(),
//                 if (status.isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: statusBg,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(status,
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: statusColor)),
//                   ),
//               ],
//             ),
//           ),
//
//           const Divider(height: 1, color: Color(0xFFEFF2F7)),
//
//           // Party Name + Total Amount
//           Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//             child: Row(
//               children: [
//                 _infoBlock('Party Name', data.partyname ?? 'N/A'),
//                 const SizedBox(width: 10),
//                 _infoBlock('Total Amount', data.totalamount ?? 'N/A'),
//               ],
//             ),
//           ),
//
//           // Date + PDF
//           Padding(
//             padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
//             child: Row(
//               children: [
//                 const Icon(Icons.calendar_today_outlined,
//                     size: 14, color: newTextSecondary),
//                 const SizedBox(width: 6),
//                 Text('Date : ${data.documentDate ?? 'N/A'}',
//                     style: const TextStyle(
//                         fontSize: 13,
//                         color: newTextSecondary,
//                         fontWeight: FontWeight.w400)),
//                 const Spacer(),
//                 GestureDetector(
//                   onTap: () async {
//                     final link =
//                     await Get.find<ApprovalFilterController>()
//                         .getApprovalDocument(
//                         Get.find<ApprovalFilterController>()
//                             .approvalDetailsData
//                             .first
//                             .approvalid
//                             .toString());
//                     launchUrl(Uri.parse('$link'),
//                         mode: LaunchMode.externalApplication);
//                   },
//                   child: Image.asset('assets/iconsnew/pdfIcon.png', height: 16),
//                 ),
//               ],
//             ),
//           ),
//
//           const Divider(height: 1, color: Color(0xFFEFF2F7)),
//
//           // Doc Name, Site Name, Executive Name
//           Padding(
//             padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
//             child: Row(
//               children: [
//                 _miniField('Doc. Name', data.documentname ?? 'N/A'),
//                 _verticalDivider(),
//                 _miniField('Site Name', 'N/A'),
//                 _verticalDivider(),
//                 _miniField('Executive Name', data.execuname ?? 'N/A'),
//               ],
//             ),
//           ),
//
//           // Last Comment
//           if ((data.lastremark ?? '').isNotEmpty) ...[
//             const Divider(height: 1, color: Color(0xFFEFF2F7)),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Last Comment :',
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: newTextPrimary)),
//                   const SizedBox(height: 6),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: newSurfaceColor,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: newBorderColor),
//                     ),
//                     child: Text(
//                       data.lastremark ?? '',
//                       style: const TextStyle(
//                           fontSize: 13,
//                           color: newTextSecondary,
//                           height: 1.5),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionLabel(String label) {
//     return Text(label,
//         style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: newTextPrimary));
//   }
//
//   Widget _styledDropdown({required Widget child}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: newBorderColor),
//       ),
//       child: child,
//     );
//   }
//
//   Widget _statusDropdownWidget(ApprovalFilterController controller) {
//     final uniqueStatusById = <num?, StatusListData>{};
//     for (final status in controller.filterStatusListData) {
//       uniqueStatusById.putIfAbsent(status.statusid, () => status);
//     }
//     final uniqueStatuses = uniqueStatusById.values.toList();
//     final selectedStatusId = controller.selectedstatus?.statusid;
//     final hasValid = selectedStatusId != null &&
//         uniqueStatuses
//             .where((e) => e.statusid == selectedStatusId)
//             .length ==
//             1;
//
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<num?>(
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.white,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.transparent,
//         ),
//         isExpanded: true,
//         hint: const Text('Enter Status',
//             style: TextStyle(fontSize: 14, color: newTextHint)),
//         value: hasValid ? selectedStatusId : null,
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,
//             color: newTextSecondary, size: 22),
//         items: uniqueStatuses.map((e) {
//           return DropdownMenuItem<num?>(
//             value: e.statusid,
//             child: Text(e.statusname ?? '',
//                 style: const TextStyle(
//                     fontSize: 14, color: newTextPrimary)),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           final matches = uniqueStatuses
//               .where((e) => e.statusid == newValue)
//               .toList();
//           if (matches.isEmpty) return;
//           controller.onChangedStatusListValue(matches.first);
//         },
//       ),
//     );
//   }
//
//   Widget _escalateDropdownWidget() {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.white,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.transparent,
//         ),
//         isExpanded: true,
//         hint: const Text('Enter name',
//             style: TextStyle(fontSize: 14, color: newTextHint)),
//         value: null,
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,
//             color: newTextSecondary, size: 22),
//         items: const [],
//         onChanged: null,
//       ),
//     );
//   }
//
//   Widget _remarksField(ApprovalFilterController controller) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: newBorderColor),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       child: TextFormField(
//         controller: controller.remarkController,
//         maxLines: 4,
//         style:
//         const TextStyle(fontSize: 14, color: newTextPrimary),
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           hintText: 'Description',
//           hintStyle: TextStyle(color: newTextHint, fontSize: 14),
//         ),
//       ),
//     );
//   }
//
//   Widget _searchBar() {
//     return Container(
//       height: 44,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: newBorderColor),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: Row(
//         children: const [
//           Icon(Icons.search, color: newTextHint, size: 20),
//           SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search',
//                 hintStyle: TextStyle(color: newTextHint, fontSize: 14),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _historyCard(Details details) {
//     final status = details.status ?? '';
//     final statusColor = _statusColor(status);
//     final statusBg = _statusBgColor(status);
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: newBorderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             child: Row(
//               children: [
//                 Container(
//                   width: 4,
//                   height: 18,
//                   decoration: BoxDecoration(
//                     color: newBlueColor,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(details.date ?? 'N/A',
//                     style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: newTextPrimary)),
//                 const Spacer(),
//                 if (status.isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: statusBg,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(status,
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: statusColor)),
//                   ),
//               ],
//             ),
//           ),
//           const Divider(height: 1, color: Color(0xFFEFF2F7)),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _historyField('Approved By', details.user ?? 'N/A'),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Remarks :',
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: newTextPrimary)),
//                 const SizedBox(height: 4),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: newSurfaceColor,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: newBorderColor),
//                   ),
//                   child: Text(
//                     details.remarks ?? 'N/A',
//                     style: const TextStyle(
//                         fontSize: 13,
//                         color: newTextSecondary,
//                         height: 1.4),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
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
//
//   Widget _miniField(String label, String value) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontSize: 11,
//                   color: newTextSecondary,
//                   fontWeight: FontWeight.w400)),
//           const SizedBox(height: 2),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: newTextPrimary)),
//         ],
//       ),
//     );
//   }
//
//   Widget _verticalDivider() {
//     return Container(
//       width: 1,
//       height: 36,
//       color: newBorderColor,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//     );
//   }
//
//   Widget _historyField(String label, String value) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontSize: 11,
//                   color: newTextSecondary,
//                   fontWeight: FontWeight.w400)),
//           const SizedBox(height: 2),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: newTextPrimary)),
//         ],
//       ),
//     );
//   }
//
//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return newGreenColor;
//       case 'pending':
//         return newOrangeColor;
//       case 'cancelled':
//         return newRedColor;
//       default:
//         return newTextSecondary;
//     }
//   }
//
//   Color _statusBgColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return newGreenLightColor;
//       case 'pending':
//         return newOrangeLightColor;
//       case 'cancelled':
//         return newRedLightColor;
//       default:
//         return newSurfaceColor;
//     }
//   }
// }