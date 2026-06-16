// // import 'package:digitalerp/lead%20management/lead%20management%20controller/lead_management_controller.dart';
// // import 'package:digitalerp/lead%20management/lead_entry_view.dart';
// // import 'package:digitalerp/lead%20management/lead_filtter_view.dart';
// // import 'package:digitalerp/lead%20management/lead_followup_details_view.dart';
// // import 'package:digitalerp/lead%20management/lead_followup_history.dart';
// // import 'package:digitalerp/screen/base/base_controller.dart';
// // import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_view.dart';
// // import 'package:digitalerp/utils/app_assets.dart';
// // import 'package:digitalerp/utils/app_constant.dart';
// // import 'package:digitalerp/utils/my_app_bar_new.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_navigation/get_navigation.dart';
// // import 'package:get/get_state_manager/get_state_manager.dart';
// //
// // class LeadManagementView extends StatefulWidget {
// //   const LeadManagementView({Key? key}) : super(key: key);
// //
// //   @override
// //   State<LeadManagementView> createState() => _LeadManagementViewState();
// // }
// //
// // class _LeadManagementViewState extends State<LeadManagementView> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<LeadManagementController>(
// //         init: LeadManagementController(),
// //         builder: (controller){
// //       return Scaffold(
// //         body: Center(
// //             child: Stack(
// //                 children: [
// //                   Positioned(
// //                     top: 0,
// //                     left: 0,
// //                     right: 0,
// //                     bottom: 0,
// //                     child: Container(
// //                       decoration: const BoxDecoration(
// //                         image: DecorationImage(
// //                           image: AssetImage('assets/images/dashboard_bg.png'),
// //                           fit: BoxFit.fill,
// //                         ),
// //                       ),
// //                       child: SafeArea(
// //                         child: MyAppBar(
// //                           title: 'Lead Management',
// //                           onFilterTap: (){
// //                             Get.to(LeadFilterScreen());
// //                           },
// //                           // onDrawerTap: () => controller.openDrawer(context),
// //                           onBackTap: () =>Get.back(),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   Positioned(
// //                     top: Get.height * 0.138,
// //                     left: 25,
// //                     right: 0,
// //                     bottom: 0,
// //                     child: Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       children: [
// //                         Padding(
// //                           padding: EdgeInsets.only(top: 15),
// //                           child: Text('Add Lead',style: TextStyle().bold,),
// //                         ),
// //                         SizedBox(width: Get.width * 0.500,),
// //                         Container(
// //                             height: 35,
// //                             width: 30,
// //                             decoration: BoxDecoration(
// //                                 shape:BoxShape.circle,
// //                                 gradient: customGradient(topColor: orangeColor, bottomColor: red2Color)
// //                             ),
// //                             child:InkWell(
// //                               onTap: (){
// //                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LeadEntryView()));
// //                               },
// //                               child: Icon(Icons.add,color: Colors.white,),
// //                             )
// //                         ),
// //
// //                       ],
// //                     ),
// //                   ),
// //                   Positioned(
// //                       right: 0,
// //                       left: 0,
// //                       bottom: 0,
// //                       top: Get.height * 0.200,
// //                       child:  SingleChildScrollView(
// //                         child: Column(children: [
// //                           ListView.builder(
// //                               shrinkWrap: true,
// //                               padding: EdgeInsets.zero,
// //                               physics: const NeverScrollableScrollPhysics(),
// //                               itemCount:5,
// //                               itemBuilder: (context, index) => LeadCard()
// //                           ),
// //                         ]),
// //                       )
// //
// //                   ),
// //
// //                 ]
// //             )
// //         ),
// //       );
// //     });
// //
// //   }
// //   LeadCard() {
// //     return Padding(
// //       padding: const EdgeInsets.all(5.0),
// //       child: Card(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //         color: Colors.white,
// //         child: InkWell(
// //           onTap: () => Get.to(LeadFollowupDetailsView()),
// //           child: Container(
// //             width: Get.width,
// //             // height: Get.height * 0.270,
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10),
// //                 color: Colors.white,
// //                 boxShadow: const [
// //                   BoxShadow(
// //                       color: Colors.black12, blurRadius: 3, offset: Offset(0, 3))
// //                 ]),
// //             padding: const EdgeInsets.only(top: 20, left: 7, right: 20),
// //             child: Column(
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text("Lead No.",
// //                             style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.deepOrange.shade400)),
// //                         Text(
// //                               'N/A',
// //                           style: TextStyle().xstyle
// //                         ),
// //                         const SizedBox(
// //                           height: 10,
// //                         ),
// //                         Row(
// //                           children: [
// //                             Text(
// //                               "Edit",
// //                               style: const TextStyle().newstyle,
// //                             ),
// //                             SizedBox(width: Get.width * 0.030,),
// //                             InkWell(
// //                               onTap: (){},
// //                               child: Image.asset(AppAssets.editIcon,color: Colors.deepOrange.shade400,scale: 4,),
// //                             )
// //                           ],
// //                         ),
// //                         const SizedBox(
// //                           height: 12,
// //                         ),
// //                         Text(
// //                           "Contact Person",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                               'N/A',
// //                           style: const TextStyle().xstyle,
// //                         ),
// //                         const SizedBox(
// //                           height: 7,
// //                         ),
// //                         Text(
// //                           "Next Followp date",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                               'N/A',
// //                           style:  const TextStyle().xstyle,
// //                         ),
// //                         SizedBox(height: 7,),
// //                         Text(
// //                           "Status",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                           'N/A',
// //                           style:  const TextStyle().xstyle,
// //                         ),
// //                         SizedBox(height: 7,),
// //                         Text(
// //                           "Specificatiion",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                           'N/A',
// //                           style:  const TextStyle().xstyle,
// //                         ),
// //                         SizedBox(height: 7,),
// //                         Row(
// //                           children: [
// //                             Text(
// //                               "Followp",
// //                               style: const TextStyle().newstyle,
// //                             ),
// //                             SizedBox(width: Get.width * 0.020,),
// //                             InkWell(
// //                               child: Icon(Icons.supervised_user_circle,color: Colors.deepOrange.shade400,),
// //                             )
// //                           ],
// //                         ),
// //                         Text(
// //                           'N/A',
// //                           style:  const TextStyle().xstyle,
// //                         ),
// //                         SizedBox(height: 7,),
// //                         Text(
// //                           "Print",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Padding(
// //                           padding:  EdgeInsets.only(top: 5),
// //                           child: InkWell(
// //                             onTap: () {
// //                             },
// //                             child: Image(
// //                               image: const AssetImage('assets/images/pdf.png'),
// //                               height: Get.height * 0.0370,
// //                             ),
// //                           ),
// //                         ),
// //
// //
// //                       ],
// //                     ),
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //
// //                       children: [
// //                         Text("Lead Date",
// //                             style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.deepOrange.shade400)),
// //                         Text(
// //                             'N/A',
// //                             style: const TextStyle().xstyle),
// //                         const SizedBox(
// //                           height: 7,
// //                         ),
// //                         Text(
// //                           "Company",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                               'N/A',
// //                           overflow: TextOverflow.visible,
// //                           softWrap: false,
// //                           maxLines: 2,
// //                           style: const TextStyle().xstyle,
// //                         ),
// //                         const SizedBox(
// //                           height: 7,
// //                         ),
// //                         Text(
// //                           "Mobile No.",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                               'N/A',
// //                           style: const TextStyle().xstyle,
// //                         ),
// //                         const SizedBox(
// //                           height: 7,
// //                         ),
// //                         Text(
// //                           "Followp Entry date",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                               'N/A',
// //                           style: const TextStyle().xstyle,
// //                         ),
// //                         const SizedBox(
// //                           height: 7,
// //                         ),
// //                         Text(
// //                           "Handler",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                           'N/A',
// //                           style: const TextStyle().xstyle,
// //                         ),
// //                         const SizedBox(
// //                           height: 7,
// //                         ),
// //                         Row(
// //                           children: [
// //                             Text(
// //                               "Followp Histroy",
// //                               style: const TextStyle().newstyle,
// //                             ),
// //                             SizedBox(width: Get.width * 0.010,),
// //                            InkWell(
// //                              onTap: ()=> Get.to(LeadFolloupHistory()),
// //                              child:Icon(Icons.history,color: Colors.deepOrange.shade400,),)
// //                           ],
// //                         ),
// //                         Text(
// //                           'N/A',
// //                           style: const TextStyle().xstyle,
// //                         ),
// //                         const SizedBox(
// //                           height: 7,
// //                         ),
// //                         Text(
// //                           "Quotation",
// //                           style: const TextStyle().newstyle,
// //                         ),
// //                         Text(
// //                           'N/A',
// //                           style: const TextStyle().xstyle,
// //                         ),
// //                         const SizedBox(
// //                           height: 15,
// //                         ),
// //                        Container(
// //                          height: 38,
// //                          // width: 120,
// //                          decoration: ShapeDecoration(
// //                            shape: const StadiumBorder(),
// //                            gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
// //                          ),
// //                          child: MaterialButton(
// //                            onPressed: (){
// //                              Get.to(SelectBrandView());
// //                            },
// //                            shape: const StadiumBorder(),
// //                            child: Row(
// //                              children: [
// //                                CircleAvatar(child: Icon(Icons.add,color: Colors.orange,),backgroundColor: Colors.white,radius: 12,),
// //                                SizedBox(width:5,),
// //                                Text(
// //                                 'Add Item',
// //                                  style:  TextStyle(fontSize: 15,color: Colors.white),
// //                                ),
// //                              ],
// //                            ),
// //                          ),
// //                        )
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.only(
// //                         left: 255,
// //                         top: 10,
// //                       ),
// //
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:digitalerp/lead%20management/lead%20management%20controller/lead_management_controller.dart';
// import 'package:digitalerp/lead%20management/lead_entry_view.dart';
// import 'package:digitalerp/lead%20management/lead_followup_details_view.dart';
// import 'package:digitalerp/lead%20management/lead_followup_history.dart';
// import 'package:digitalerp/lead%20management/lead_filtter_view.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/documentname_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/mrn/widgets/app_theme.dart';
// import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_view.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
//
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// //  Design tokens 
// const Color _kBg = Color(0xFFF5F6FA);
// const Color _kWhite = Colors.white;
// const Color _kBlue = purpleColor;
// final Color _kBlueBg = purpleLightest;
// const Color _kBorder = Color(0xFFE2E8F0);
// const Color _kTextPrimary = Color(0xFF0F172A);
// const Color _kTextSub = Color(0xFF64748B);
// const Color _kDivider = Color(0xFFEFF2F7);
// const Color _kGreen = Color(0xFF10B981);
// const Color _kGreenBg = Color(0xFFD1FAE5);
// const Color _kOrange = Color(0xFFF59E0B);
// const Color _kOrangeBg = Color(0xFFFEF3C7);
//
// //  Shared helpers 
// Widget _appBar(String title, {VoidCallback? onFilter}) {
//   return Container(
//     color: _kWhite,
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     child: Row(children: [
//       GestureDetector(
//         onTap: () => Get.back(),
//         child: const Icon(Icons.arrow_back_ios, color: _kTextPrimary, size: 22),
//       ),
//       const SizedBox(width: 12),
//       Expanded(
//         child: Text(title,
//             style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: _kTextPrimary)),
//       ),
//       if (onFilter != null)
//         GestureDetector(
//           onTap: onFilter,
//           child: Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//                 color: AppColors.purpleLightest, borderRadius: BorderRadius.circular(18)),
//             child: const Icon(Icons.filter_list_sharp, color: purpleColor, size: 20),
//           ),
//         ),
//     ]),
//   );
// }
//
//
// Widget _sectionLabel(String label) => Padding(
//   padding: const EdgeInsets.only(bottom: 8),
//   child: Text(label,
//       style: const TextStyle(
//           fontSize: 14, fontWeight: FontWeight.w600, color: _kTextPrimary)),
// );
//
//
//
// class LeadManagementView extends StatefulWidget {
//   const LeadManagementView({Key? key}) : super(key: key);
//   @override
//   State<LeadManagementView> createState() => _LeadManagementViewState();
// }
//
// class _LeadManagementViewState extends State<LeadManagementView> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LeadManagementController>(
//       init: LeadManagementController(),
//       builder: (controller) => Scaffold(
//         backgroundColor: const Color(0xFFF5F6FA),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Column(
//               children: [
//                 _appBar(
//                   'Lead Management',
//                   onFilter: () => Get.to(LeadFilterScreen()),
//                 ),
//
//                 Expanded(
//                   child: controller.isBusy
//                       ? showLoader(color: _kBlue)
//                       : ListView.builder(
//                     padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//                     itemCount: 5, // replace with controller.leadList.length
//                     itemBuilder: (context, index) =>
//                         _LeadCard(controller: controller),
//                   ),
//
//                 ),
//
//               ],
//             ),
//               Positioned(
//                 right: 20,
//                 bottom: 28,
//                 child: FloatingActionButton(
//                   onPressed: () => Get.to(const LeadEntryView()),
//                   backgroundColor: purpleColor,
//                   shape:
//                   const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
//                   elevation: 4,
//                   child: const Icon(Icons.add,
//                       color: Colors.white, size: 32),
//                 ),
//               ),
//             ],
//           ),
//
//         ),
//       ),
//     );
//   }
// }
//
// //  Lead Card 
// class _LeadCard extends StatelessWidget {
//   final LeadManagementController controller;
//   const _LeadCard({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Get.to(const LeadFollowupDetailsView()),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 14),
//         decoration: BoxDecoration(
//           color: _kWhite,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: _kBorder),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.04),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2))
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //  Header: Lead No. + Lead Date + Edit 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 12, 12, 10),
//               child: Row(children: [
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   const Text('Lead No.',
//                       style: TextStyle(fontSize: 11, color: _kTextSub)),
//                   const SizedBox(height: 2),
//                   const Text('N/A',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                           color: _kTextPrimary)),
//                 ]),
//                 const SizedBox(width: 16),
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   const Text('Lead Date',
//                       style: TextStyle(fontSize: 11, color: _kTextSub)),
//                   const SizedBox(height: 2),
//                   const Text('N/A',
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: _kTextPrimary)),
//                 ]),
//                 const Spacer(),
//                 // Edit icon
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     width: 32,
//                     height: 32,
//                     decoration: BoxDecoration(
//                         color: _kBlueBg,
//                         borderRadius: BorderRadius.circular(8)),
//                     child: const Icon(Icons.edit_outlined,
//                         color: _kBlue, size: 16),
//                   ),
//                 ),
//               ]),
//             ),
//
//             const Divider(height: 1, color: _kDivider),
//
//             //  Info boxes: Company | Contact Person 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
//               child: Row(children: [
//                 _infoBox('Company', 'N/A'),
//                 const SizedBox(width: 10),
//                 _infoBox('Contact Person', 'N/A'),
//               ]),
//             ),
//
//             //  Mini fields: Mobile | Status | Handler 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
//               child: Row(children: [
//                 _miniField('Mobile No.', 'N/A'),
//                 _vDivider(),
//                 _miniField('Status', 'N/A'),
//                 _vDivider(),
//                 _miniField('Handler', 'N/A'),
//               ]),
//             ),
//
//             const SizedBox(height: 10),
//             const Divider(height: 1, color: _kDivider),
//
//             //  Footer: Next Followup | Specification | Actions 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 10, 12, 12),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(children: [
//                   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     const Text('Next Followup',
//                         style: TextStyle(fontSize: 11, color: _kTextSub)),
//                     const Text('N/A',
//                         style: TextStyle(fontSize: 12, color: _kTextPrimary)),
//                   ]),
//                   const SizedBox(width: 20),
//                   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     const Text('Specification',
//                         style: TextStyle(fontSize: 11, color: _kTextSub)),
//                     const Text('N/A',
//                         style: TextStyle(fontSize: 12, color: _kTextPrimary)),
//                   ]),
//                   const Spacer(),
//                   // Followup icon
//                   GestureDetector(
//                     onTap: () => Get.to(const LeadFollowupDetailsView()),
//                     child: Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                           color: _kGreenBg,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Icon(Icons.person_add_outlined,
//                           color: _kGreen, size: 16),
//                     ),
//                   ),
//                   const SizedBox(width: 6),
//                   // History icon
//                   GestureDetector(
//                     onTap: () => Get.to(const LeadFolloupHistory()),
//                     child: Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                           color: _kOrangeBg,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Icon(Icons.history, color: _kOrange, size: 16),
//                     ),
//                   ),
//                   const SizedBox(width: 6),
//                   // PDF icon
//                   Image.asset('assets/iconsnew/pdfIcon.png',
//                       width: 28, height: 28),
//                   const SizedBox(width: 6),
//                   // Add Item button
//                   GestureDetector(
//                     onTap: () => Get.to(SelectBrandView()),
//                     child: Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                       decoration: BoxDecoration(
//                           color: _kBlueBg,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Row(children: [
//                         Icon(Icons.add, color: _kBlue, size: 14),
//                         SizedBox(width: 4),
//                         Text('Add Item',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: _kBlue)),
//                       ]),
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoBox(String label, String value) => Expanded(
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: _kBlueBg,
//         borderRadius: BorderRadius.circular(8),
//         border: const Border(left: BorderSide(color: _kBlue, width: 3)),
//       ),
//       child:
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(label, style: const TextStyle(fontSize: 11, color: _kTextSub)),
//         const SizedBox(height: 2),
//         Text(value,
//             style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: _kTextPrimary),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis),
//       ]),
//     ),
//   );
//
//   Widget _miniField(String label, String value) => Expanded(
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Text(label, style: const TextStyle(fontSize: 10, color: _kTextSub)),
//       const SizedBox(height: 2),
//       Text(value,
//           style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: _kTextPrimary),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis),
//     ]),
//   );
//
//   Widget _vDivider() => Container(
//       width: 1,
//       height: 32,
//       color: _kBorder,
//       margin: const EdgeInsets.symmetric(horizontal: 8));
// }



import 'package:digitalerp/lead%20management/lead%20management%20controller/lead_management_controller.dart';
import 'package:digitalerp/lead%20management/lead_entry_view.dart';
import 'package:digitalerp/lead%20management/lead_filtter_view.dart';
import 'package:digitalerp/lead%20management/lead_followup_details_view.dart';
import 'package:digitalerp/lead%20management/lead_followup_history.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_view.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//  Design tokens 
const Color _kPrimary       = Color(0xFF4361EE);
const Color _kPrimaryLight  = Color(0xFFEEF1FF);
const Color _kBg            = Color(0xFFF6F7FB);
const Color _kSurface       = Colors.white;
const Color _kBorder        = Color(0xFFE4E7F0);
const Color _kDivider       = Color(0xFFEFF2F7);
const Color _kTextPrimary   = Color(0xFF111827);
const Color _kTextSecondary = Color(0xFF6B7280);
const Color _kCardShadow    = Color(0x0A000000);
const Color _kGreen         = Color(0xFF27AE60);
const Color _kGreenLight    = Color(0xFFE8F8EF);
const Color _kOrange        = Color(0xFFF39C12);
const Color _kOrangeLight   = Color(0xFFFFF4E0);
const Color _kAccent        = Color(0xFF5B5FC7);
const Color _kAccentLight   = Color(0xFFF0F3FF);

class LeadManagementView extends StatefulWidget {
  const LeadManagementView({Key? key}) : super(key: key);
  @override
  State<LeadManagementView> createState() => _LeadManagementViewState();
}

class _LeadManagementViewState extends State<LeadManagementView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeadManagementController>(
      init: LeadManagementController(),
      builder: (controller) => Scaffold(
        backgroundColor: _kBg,

        appBar: AppBar(
          backgroundColor: _kSurface,
          elevation: 0,
          scrolledUnderElevation: 1,
          shadowColor: _kBorder,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: _kBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBorder)),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: _kTextPrimary, size: 16),
            ),
          ),
          title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Lead Management',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: _kTextPrimary)),
            Text('Manage and track your leads',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: _kTextSecondary)),
          ]),
          actions: [
            GestureDetector(
              onTap: () => Get.to(LeadFilterScreen()),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                    color: _kAccentLight,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.filter_list_rounded,
                    color: _kAccent, size: 20),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(const LeadEntryView()),
          backgroundColor: _kPrimary,
          elevation: 3,
          shape: const CircleBorder(
              side: BorderSide(color: Colors.white, width: 2.5)),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
        ),

        body: controller.isBusy
            ? Center(
            child: CircularProgressIndicator(
                color: _kPrimary, strokeWidth: 2.5))
            : controller.leadList.isEmpty
            ? _emptyState()
            : RefreshIndicator(
          color: _kPrimary,
          onRefresh: () async => controller.getLeadList(),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: controller.leadList.length,
            itemBuilder: (ctx, i) =>
                _LeadCard(item: controller.leadList[i]),
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
              color: _kAccentLight,
              borderRadius: BorderRadius.circular(36)),
          child: const Icon(Icons.leaderboard_outlined,
              size: 34, color: _kAccent),
        ),
        const SizedBox(height: 16),
        const Text('No Leads Found',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _kTextPrimary)),
        const SizedBox(height: 6),
        const Text('Tap + to add a new lead',
            style: TextStyle(fontSize: 13, color: _kTextSecondary)),
      ]),
    );
  }
}

//  Lead Card 
class _LeadCard extends StatelessWidget {
  final dynamic item;
  const _LeadCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(const LeadFollowupDetailsView()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder),
          boxShadow: const [
            BoxShadow(
                color: _kCardShadow,
                blurRadius: 10,
                offset: Offset(0, 3))
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          //  Header: Lead No + Date + Edit 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
            child: Row(children: [
              // Lead No badge
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: _kPrimaryLight,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(children: [
                  const Text('Lead No. ',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _kPrimary)),
                  Text(item?.leadnumber?.toString() ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: _kPrimary)),
                ]),
              ),
              const SizedBox(width: 10),
              // Date
              Expanded(
                child: Row(children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 12, color: _kTextSecondary),
                  const SizedBox(width: 4),
                  Text(item?.leaddate ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _kTextSecondary)),
                ]),
              ),
              // Edit
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: _kAccentLight,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.edit_outlined,
                      color: _kAccent, size: 16),
                ),
              ),
            ]),
          ),

          const Divider(height: 1, color: _kDivider),

          //  Company + Contact Person 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Row(children: [
              _bracketBox('Company', item?.companyname ?? 'N/A'),
              const SizedBox(width: 10),
              _bracketBox('Contact Person', item?.contactperson ?? 'N/A'),
            ]),
          ),

          //  Mobile | Status | Handler 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Row(children: [
              _miniField(Icons.phone_outlined, 'Mobile',
                  item?.mobilenumber ?? 'N/A'),
              _vDivider(),
              _miniField(Icons.flag_outlined, 'Status',
                  item?.status ?? 'N/A'),
              _vDivider(),
              _miniField(Icons.person_outline_rounded, 'Handler',
                  item?.handler ?? 'N/A'),
            ]),
          ),

          const SizedBox(height: 10),
          const Divider(height: 1, color: _kDivider),

          //  Footer: next followup, spec, action icons 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 12, 12),
            child: Row(children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Next Followup',
                          style: TextStyle(
                              fontSize: 10, color: _kTextSecondary)),
                      const SizedBox(height: 2),
                      Text(item?.nextfollowupdate ?? 'N/A',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _kTextPrimary)),
                    ]),
              ),
              // Action icon buttons
              _iconBtn(Icons.person_add_alt_1_outlined, _kGreen,
                  _kGreenLight, () => Get.to(const LeadFollowupDetailsView())),
              const SizedBox(width: 6),
              _iconBtn(Icons.history_rounded, _kOrange, _kOrangeLight,
                      () => Get.to(const LeadFolloupHistory())),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {},
                child: Image.asset('assets/images/pdf.png',
                    width: 28, height: 28),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => Get.to(SelectBrandView()),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      color: _kAccentLight,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Row(children: [
                    Icon(Icons.add_rounded, color: _kAccent, size: 14),
                    SizedBox(width: 4),
                    Text('Add Item',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _kAccent)),
                  ]),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _bracketBox(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: _kAccentLight,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8)),
        border: Border(
            left: BorderSide(color: _kAccent, width: 3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10, color: _kTextSecondary)),
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

  Widget _miniField(IconData icon, String label, String value) => Expanded(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, size: 11, color: _kTextSecondary),
        const SizedBox(width: 3),
        Text(label,
            style: const TextStyle(
                fontSize: 10, color: _kTextSecondary)),
      ]),
      const SizedBox(height: 2),
      Text(value,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kTextPrimary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    ]),
  );

  Widget _vDivider() => Container(
      width: 1,
      height: 32,
      color: _kBorder,
      margin: const EdgeInsets.symmetric(horizontal: 8));

  Widget _iconBtn(
      IconData icon, Color color, Color bg, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 16),
        ),
      );
}