// import 'package:digitalerp/response/get_store_name_resp.dart';
// import 'package:digitalerp/response/stock_reconcilation_report_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation_controller/stock_reconciliation_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/dialog_button.dart';
// import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class StockReconciliation extends StatelessWidget {
//    StockReconciliation({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StockReconciliationController>(
//         init: StockReconciliationController(),
//         builder: (StockReconciliationController controller) {
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
//                           onFilterTap: () {
//                             Get.dialog(StockReconciliationFilterView());
//                           },
//                           title: 'Stock Reconciliation',
//                           onBackTap: () => Get.back(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       right: 0,
//                       left: 0,
//                       bottom: Get.height * 0.0,
//                       top: Get.height * 0.140,
//                       child: controller.isBusy
//                           ? SizedBox(
//                               child: showLoader(),
//                             )
//                           : SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: Column(children: [
//                                 showDateView(controller),
//                                 SizedBox(
//                                   height: Get.height * 0.0100,
//                                 ),
//                                 storeDropDown(controller),
//                                 SizedBox(
//                                   height: Get.height * 0.0200,
//                                 ),
//
//                                 SizedBox(
//                                   height: Get.height * 0.0100,
//                                 ),
//                                 _dateColumn(controller, context),
//                                 SizedBox(
//                                   height: Get.height * 0.0100,
//                                 ),
//                                 ListView.builder(
//                                     // itemCount: 5,
//                                     padding: EdgeInsets.zero,
//                                     itemCount: controller
//                                         .stockReconciliationReportList.length,
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.vertical,
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     itemBuilder: (context, index) => listItem(
//                                         controller.stockReconciliationReportList
//                                             .elementAt(index),
//                                         controller
//                                     )
//
//                                 ),
//
//
//                                 SizedBox(
//                                   height: Get.height * 0.010,
//                                 )
//                               ]),
//                             )),
//                 if(controller.loading)
//                   Container(
//                     height: Get.height,
//                     width: Get.width,
//                     color: Colors.black26,
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   )
//
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget storeDropDown(StockReconciliationController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<GetStoreNameData>(
//           buttonHeight: Get.height * 0.0550,
//           buttonWidth: Get.width * 0.900,
//           buttonPadding:
//               const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//           dropdownDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: dropdownBoxColor,
//           ),
//           dropdownMaxHeight: 200,
//           buttonDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: dropdownBoxColor,
//             gradient: LinearGradient(
//               colors: [
//                 grBottomColor.withValues(alpha:0.2),
//                 grTopColor.withValues(alpha:0.2)
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           isExpanded: true,
//           hint: Text("Select Store",
//               style: const TextStyle().normal.copyWith(fontSize: 14)
//               // overflow: TextOverflow.ellipsis,
//               ),
//           // value: controller.selectedDocument,
//           icon: Image.asset(
//             AppAssets.dropdownIcon,
//             width: 15,
//             height: 15,
//           ),
//           value: controller.storeNameData,
//           items: controller.storeNameDataList?.map((items) {
//             return DropdownMenuItem<GetStoreNameData>(
//               value: items,
//               child: Text(
//                 items.storename ?? '',
//                 style: TextStyle()
//                     .bold
//                     .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//             );
//           }).toList(),
//           onChanged: (newValue) {
//             controller.setStoreName(newValue);
//           }),
//     );
//   }
//   Widget showDateView(StockReconciliationController controller) {
//     return Container(
//       height: Get.height * 0.0550,
//       width: Get.width * 0.900,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           )),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Reconciliation Date:",
//                 style: const TextStyle().normal.copyWith(fontSize: 14)),
//             SizedBox(
//               width: 20,
//             ),
//             Text(
//                 controller.selectStockReconciliationReport?.lastreconciledate
//                         .toString() ??
//                     "Date Not Found....",
//                 style: const TextStyle().bold.copyWith(fontSize: 14)),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _dateColumn(StockReconciliationController controller, BuildContext context,) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text("Posting Date :",
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 15, color: darkOrangeColor)),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                   height: 30,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.blueGrey),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: _dateView(controller.postingDate, Get.width * .31,
//                       true, controller, context)),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 width: Get.width*0.300,
//                 child: Text("Posting Time :",
//                     style: const TextStyle()
//                         .bold
//                         .copyWith(fontSize: 15, color: darkOrangeColor)),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                   height: 30,
//                   width: Get.width*0.390,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.blueGrey),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: _timeView(context, controller)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _dateView(String value, double width, bool isFirst, StockReconciliationController controller, BuildContext context,) {
//     int currentYear = int.parse(
//         '${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     String date = isFirst ? controller.postingDate : controller.lastDate;
//     DateTime initDate = date != AppString.dateTimeEmpty
//         ? DateTime.parse(
//             formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: initDate,
//             firstDate: DateTime(currentYear),
//             lastDate: DateTime.now());
//         if (pickedDate != null) {
//           String formattedDate =
//               DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           if (isFirst) {
//             controller.setPostingDate(formattedDate, true);
//           } else {
//             controller.setPostingDate(formattedDate, false);
//           }
//         } else {
//           if (kDebugMode) {
//             print('Date is not selected');
//           }
//         }
//       },
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(value, style: const TextStyle().medium),
//                 const SizedBox(width: 10),
//                 Image.asset(
//                   AppAssets.calendarIcon,
//                   width: 18,
//                   height: 18,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//    Widget _timeView(BuildContext context, StockReconciliationController controller) {
//      TimeOfDay initTime = TimeOfDay.now();
//
//      return StreamBuilder(
//        stream: Stream.periodic(Duration(seconds: 1)),
//        builder: (context, snapshot) {
//          return InkWell(
//            onTap: () async {
//              TimeOfDay? pickedTime = await showTimePicker(
//                context: context,
//                initialTime: initTime,
//              );
//              if (pickedTime != null) {
//                DateTime parsedTime = DateTime(
//                  DateTime.now().year,
//                  DateTime.now().month,
//                  DateTime.now().day,
//                  pickedTime.hour,
//                  pickedTime.minute,
//                );
//                String formattedTime = DateFormat('hh:mm:ss a').format(parsedTime);
//                controller.setPostingTime(formattedTime);
//              } else {
//                if (kDebugMode) {
//                  print('Time is not selected');
//                }
//              }
//            },
//            child: Row(
//              mainAxisSize: MainAxisSize.min,
//              children: [
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 5),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    mainAxisSize: MainAxisSize.min,
//                    children: [
//                      Container(
//                           width: Get.width*0.270,
//                          child: Text(DateFormat('hh:mm:ss a').format(DateTime.now()), style: const TextStyle().medium)),
//                      const SizedBox(width: 10),
//                      Image.asset(
//                        AppAssets.clockIcon,
//                        width: 20,
//                        height: 20,
//                      ),
//
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          );
//        },
//      );
//    }
//   Widget listItem(StockReconciliationData data, StockReconciliationController controller,) {
//     return Stack(
//       children: [
//         Card(
//           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//           elevation: 5,
//           shape: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide.none),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Item Name : ",
//                       style: const TextStyle()
//                           .bold
//                           .copyWith(fontSize: 13, color: purpleColor),
//                     ),
//                     SizedBox(
//                       width: 06,
//                     ),
//                     Expanded(
//                       child: Text(data.itemname ?? "N/A",
//                           style: const TextStyle()
//                               .bold
//                               .copyWith(fontSize: 13, color: Colors.black)),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Brand : ",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(data.brand ?? "N/A",
//                                   style: const TextStyle().bold.copyWith(
//                                       fontSize: 13, color: Colors.black)),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Rack No : ",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Container(
//                                 width: Get.width * 0.300,
//                                 child: Text(
//                                   overflow: TextOverflow.ellipsis,
//                                     data.rackno ?? "N/A",
//                                     style: const TextStyle().bold.copyWith(
//                                         fontSize: 13, color: Colors.black)
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Phy QTY : ",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: purpleColor),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 height: Get.height*0.038,
//                                 width: Get.width*0.220,
//                                 child: TextField(
//                                   onTap: () =>
//                                       data.phyQtyController!.selection =
//                                           TextSelection(
//                                               baseOffset: 0,
//                                               extentOffset: data
//                                                   .phyQtyController!
//                                                   .text
//                                                   .length),
//                                   style: TextStyle().bold.copyWith(
//                                       fontSize: 13, color: Colors.black),
//                                   controller: data.phyQtyController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                       icon: Icon(
//                                         Icons.edit,
//                                         size: 15,
//                                       ),
//                                       border: InputBorder.none,
//                                       hintText: "Enter..",
//                                       hintStyle: TextStyle().bold.copyWith(
//                                           fontSize: 12, color: Colors.black45)),
//                                 ),
//                               )
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Reorder \nLevel :       ",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: purpleColor),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 height: Get.height*0.038,
//                                 width: Get.width*0.220,
//                                 child: TextField(
//                                   onTap: () =>
//                                       data.reOrderController!.selection =
//                                           TextSelection(
//                                               baseOffset: 0,
//                                               extentOffset: data
//                                                   .reOrderController!
//                                                   .text
//                                                   .length),
//                                   style: TextStyle().bold.copyWith(
//                                       fontSize: 13, color: Colors.black),
//                                   controller: data.reOrderController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                       icon: Icon(
//                                         Icons.edit,
//                                         size: 15,
//                                       ),
//                                       border: InputBorder.none,
//                                       hintText: "Enter..",
//                                       hintStyle: TextStyle().bold.copyWith(
//                                           fontSize: 12, color: Colors.black45)),
//                                 ),
//                               )
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "PUOM :  ",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(data.unit ?? "N/A",
//                                   style: const TextStyle().bold.copyWith(
//                                       fontSize: 13, color: Colors.black)),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "ERP QTY : ",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(data.erpquantity.toString(),
//                                   style: const TextStyle().bold.copyWith(
//                                       fontSize: 13, color: Colors.black)),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Scarp  : ",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: purpleColor),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 height: Get.height*0.038,
//                                 width: Get.width*0.210,
//                                 child: TextField(
//                                   onTap:()=>data.scarpController!.selection = TextSelection(baseOffset: 0, extentOffset: data.scarpController!.text.length),
//                                   style: TextStyle().bold.copyWith(
//                                       fontSize: 12, color: Colors.black),
//                                   controller: data.scarpController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                       icon: const Icon(
//                                         Icons.edit,
//                                         size: 15,
//                                       ),
//                                       border: InputBorder.none,
//                                       hintText: "Enter..",
//                                       hintStyle: TextStyle().bold.copyWith(
//                                           fontSize: 12, color: Colors.black45)),
//                                 ),
//                               )
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Mini\nStk Qty :",
//                                 style: const TextStyle()
//                                     .bold
//                                     .copyWith(fontSize: 14, color: purpleColor),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: purpleColor),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 height: Get.height*0.038,
//                                 width: Get.width*0.210,
//                                 child: TextField(
//                                   onTap: () =>
//                                       data.miniStkQtyController!.selection =
//                                           TextSelection(
//                                               baseOffset: 0,
//                                               extentOffset: data
//                                                   .miniStkQtyController!
//                                                   .text
//                                                   .length),
//                                   style: TextStyle().bold.copyWith(
//                                       fontSize: 12, color: Colors.black),
//                                   controller: data.miniStkQtyController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                       icon: const Icon(
//                                         Icons.edit,
//                                         size: 15,
//                                       ),
//                                       border: InputBorder.none,
//                                       hintText: "Enter..",
//                                       hintStyle: TextStyle().bold.copyWith(
//                                           fontSize: 12, color: Colors.black45)),
//                                 ),
//                               )
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Counted\n By :",
//                           style: const TextStyle()
//                               .bold
//                               .copyWith(fontSize: 14, color: purpleColor),
//                         ),
//                         _executiveDropdown(controller)
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: DialogSubmitButton(
//                             onPress: () {
//                                 controller.selectedDropdownValue?.executiveName?.isEmpty == true|| controller.selectedDropdownValue?.executiveId == null
//                                 // log("Data =>>${(jsonEncode(data.toJson()))}");
//                                ?  ShowMessage.showSnackBar("", "Please Select Counted By")
//                                 : controller.submitStockReconciliationReportList(data);},
//
//                             buttonName: data.postingstatus== 0 ?"Save":"Update",
//                             height:  Get.width * 0.10,
//                             width: Get.width * 0.25,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Visibility(
//                   visible: data.postingstatus==0?false:true,
//                   child: Row(
//                     children: [
//                       Text(
//                         " Posting Date And Time : ",
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(fontSize: 14, color: purpleColor),
//                       ),
//                       Text(
//                          data.postingdatetime?? "N/A",
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(fontSize: 13, color: purpleColor),
//                           overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//         ),
//         // Visibility(
//         //   visible: data.postingstatus == 0 ? false : true,
//         //   child: Positioned(
//         //     top: 5,
//         //     left: 10,
//         //     bottom: 5,
//         //     child: Container(
//         //       decoration: BoxDecoration(
//         //         borderRadius: BorderRadius.circular(10),
//         //         color: Colors.black26,
//         //       ),
//         //       height: Get.height * 0.550,
//         //       width: Get.width * 0.950,
//         //       child: Stack(
//         //         children: [
//         //           Positioned(
//         //             left: 70,
//         //             bottom: 140,
//         //             child: Center(
//         //                 child: Container(
//         //                   color: Colors.transparent,
//         //                   child: Text('All Ready Submitted',
//         //                       style: TextStyle().bold.copyWith(
//         //                           fontSize: 20,
//         //                           color:Colors.red,
//         //                           fontWeight: FontWeight.w600,
//         //                           )),
//         //                 )),
//         //           ),
//         //         ],
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
//
//   Widget _executiveDropdown(StockReconciliationController controller) =>
//       DropdownButtonHideUnderline(
//         child: DropdownButton2(
//           buttonHeight: Get.height * 0.050,
//           buttonWidth: Get.width * 0.380,
//           buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
//           dropdownDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: dropdownBoxColor,
//           ),
//           buttonDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             gradient: blueDropdownGr,
//           ),
//           isExpanded: true,
//           hint: Text(
//             AppString.selectExecutive,
//             style: const TextStyle().normal.copyWith(fontSize: 12),
//           ),
//           value: controller.selectedDropdownValue,
//           icon: Image.asset(
//             AppAssets.dropdownIcon,
//             width: 15,
//             height: 15,
//           ),
//           items: controller.executiveDropdownList!.map((items) {
//             return DropdownMenuItem(
//               value: items,
//               child: Text(
//                 items.executiveName.toString(),
//                 style: TextStyle(fontSize: 12),
//               ),
//             );
//           }).toList(),
//           onChanged: (newValue) {
//             controller.setSelectDropdownValue(newValue);
//           },
//           dropdownMaxHeight: Get.height * 0.3,
//         ),
//       );
// }
//
// // Widget dataTableView() {
// //   return Container(
// //     height: Get.height*0.600,
// //     child: Padding(
// //       padding:  EdgeInsets.all(16),
// //       child: DataTable2(
// //           decoration: BoxDecoration(
// //               border: Border.all()
// //           ),
// //           columnSpacing: 13,
// //           horizontalMargin: 12,
// //           minWidth: 500,
// //           columns: [
// //             DataColumn2(
// //               label: Text('Item Code',style: TextStyle().xstyle.copyWith(fontSize: 14)),
// //               // size: ColumnSize.L,
// //             ),
// //             DataColumn(
// //               label: Text('Rack No',style: TextStyle().xstyle.copyWith(fontSize: 14)),
// //             ),
// //             DataColumn(
// //               label: Text('Purchase \nUOM',style: TextStyle().xstyle.copyWith(fontSize: 14)),
// //             ),
// //             DataColumn(
// //               label: Text('ERP QTY',style: TextStyle().xstyle.copyWith(fontSize: 14),),
// //             ),
// //             DataColumn(
// //               label: Text('Phy QTY',style: TextStyle().xstyle.copyWith(fontSize: 14)),
// //             ),
// //             DataColumn(
// //               label: Text('Scrap',style: TextStyle().xstyle.copyWith(fontSize: 14)),
// //             ),
// //           ],
// //           rows: List<DataRow>.generate(
// //               50,
// //                   (index) => DataRow(cells: [
// //                 DataCell(Text('A')),
// //                 DataCell(Text('B')),
// //                 DataCell(Text('C')),
// //                 DataCell(Text('D')),
// //                 DataCell(TextField(
// //                   decoration: InputDecoration(border: InputBorder.none),
// //                   textAlign: TextAlign.center,
// //                 )),
// //                 DataCell(TextField(
// //                   decoration:
// //                   InputDecoration(border: InputBorder.none),
// //                   textAlign: TextAlign.center,
// //                 )),
// //               ]))),
// //     ),
// //   );
// // }

import 'package:digitalerp/response/get_store_name_resp.dart';
import 'package:digitalerp/response/stock_reconcilation_report_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation_controller/stock_reconciliation_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/dialog_button.dart';
import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../screen/ui/fab/menu_fab.dart';

//  Design tokens 
const Color _kBg = Color(0xFFF8F9FC);
const Color _kWhite = Colors.white;
const Color _kAccent = Color(0xFF4F46E5);
const Color _kBorder = Color(0xFFE4E7EF);
const Color _kText = Color(0xFF111827);
const Color _kSub = Color(0xFF6B7280);
const Color _kGreen = Color(0xFF10B981);

class StockReconciliation extends StatelessWidget {
  StockReconciliation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockReconciliationController>(
      init: StockReconciliationController(),
      builder: (controller) => Scaffold(
        backgroundColor: _kBg,
        appBar: AppBar(
          backgroundColor: _kWhite,
          elevation: 0,
          surfaceTintColor: _kWhite,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: _kText, size: 20),
          ),
          title: const Text('Stock Reconciliation',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: _kText)),
          actions: [
            GestureDetector(
              onTap: () => Get.dialog(StockReconciliationFilterView()),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _kAccent.withValues(alpha:0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.filter_list_rounded,
                    color: _kAccent, size: 20),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(color: _kBorder, height: 1),
          ),
        ),
        body: Stack(
          children: [
            controller.isBusy
                ? const Center(
                    child: CircularProgressIndicator(color: _kAccent))
                : SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Reconciliation date info card
                        _infoCard(controller),
                        const SizedBox(height: 16),

                        // Store dropdown
                        _sectionCard(children: [
                          _label('Store'),
                          _dropdownWrap(_storeDropDown(controller)),
                        ]),
                        const SizedBox(height: 16),

                        // Date & Time row
                        _sectionCard(children: [
                          _label('Posting Date & Time'),
                          Row(children: [
                            Expanded(
                              child: _dateFieldTile(controller.postingDate,
                                  true, controller, context),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _timeFieldTile(context, controller),
                            ),
                          ]),
                        ]),
                        const SizedBox(height: 20),

                        // List
                        if (controller
                            .stockReconciliationReportList.isNotEmpty) ...[
                          Text(
                            '${controller.stockReconciliationReportList.length} Items',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _kText),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount:
                                controller.stockReconciliationReportList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => _listItem(
                              controller.stockReconciliationReportList
                                  .elementAt(index),
                              controller,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
            if (controller.loading)
              Container(
                color: Colors.black26,
                child: const Center(
                    child: CircularProgressIndicator(color: _kAccent)),
              ),
          ],
        ),
        floatingActionButton: MenuFab(parentMenuId: 2383),
      ),
    );
  }

  Widget _infoCard(StockReconciliationController controller) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kAccent.withValues(alpha:0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withValues(alpha:0.2)),
      ),
      child: Row(children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: _kAccent.withValues(alpha:0.12),
              borderRadius: BorderRadius.circular(10)),
          child:
              const Icon(Icons.event_note_outlined, color: _kAccent, size: 18),
        ),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Last Reconciliation Date',
              style: TextStyle(fontSize: 12, color: _kSub)),
          const SizedBox(height: 2),
          Text(
            controller.selectStockReconciliationReport?.lastreconciledate
                    ?.toString() ??
                'Not available',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: _kText),
          ),
        ]),
      ]),
    );
  }

  Widget _storeDropDown(StockReconciliationController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<GetStoreNameData>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          dropdownMaxHeight: 200,
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent),
          isExpanded: true,
          hint: const Text('Select Store',
              style: TextStyle(fontSize: 14, color: _kSub)),
          value: controller.storeNameData,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          items: controller.storeNameDataList?.map((items) {
            return DropdownMenuItem<GetStoreNameData>(
              value: items,
              child: Text(items.storename ?? '',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _kText)),
            );
          }).toList(),
          onChanged: controller.setStoreName,
        ),
      );

  Widget _dateFieldTile(String value, bool isFirst,
      StockReconciliationController controller, BuildContext context) {
    int currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');
    String date = isFirst ? controller.postingDate : controller.lastDate;
    DateTime initDate = date != AppString.dateTimeEmpty
        ? DateTime.parse(
            formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();

    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: DateTime(currentYear),
          lastDate: DateTime.now(),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
                colorScheme: const ColorScheme.light(
                    primary: _kAccent, onPrimary: Colors.white)),
            child: child!,
          ),
        );
        if (pickedDate != null) {
          controller.setPostingDate(
              DateFormat(AppString.ddMMyyyy).format(pickedDate), isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kBorder),
        ),
        child: Row(children: [
          Expanded(
              child: Text(value,
                  style: const TextStyle(fontSize: 13, color: _kText))),
          const Icon(Icons.calendar_today_outlined, size: 14, color: _kSub),
        ]),
      ),
    );
  }

  Widget _timeFieldTile(
      BuildContext context, StockReconciliationController controller) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              DateTime parsedTime = DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                pickedTime.hour,
                pickedTime.minute,
              );
              controller
                  .setPostingTime(DateFormat('hh:mm:ss a').format(parsedTime));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kBorder),
            ),
            child: Row(children: [
              Expanded(
                child: Text(
                  DateFormat('hh:mm:ss a').format(DateTime.now()),
                  style: const TextStyle(fontSize: 13, color: _kText),
                ),
              ),
              const Icon(Icons.access_time_outlined, size: 14, color: _kSub),
            ]),
          ),
        );
      },
    );
  }

  Widget _listItem(
      StockReconciliationData data, StockReconciliationController controller) {
    final isPosted = data.postingstatus != 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha:0.04),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(children: [
            Expanded(
              child: Text(data.itemname ?? 'N/A',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kText)),
            ),
            if (isPosted)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: newGreenLightColor,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('Posted',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: newGreenColor)),
              ),
          ]),
        ),

        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info row
              Row(children: [
                Expanded(child: _infoTile('Brand', data.brand ?? 'N/A')),
                Expanded(
                    child: _infoTile('PUOM', data.unit ?? 'N/A',
                        align: CrossAxisAlignment.end)),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: _infoTile('Rack No', data.rackno ?? 'N/A')),
                Expanded(
                    child: _infoTile('ERP QTY', data.erpquantity.toString(),
                        align: CrossAxisAlignment.end)),
              ]),
              const SizedBox(height: 14),
              const Divider(height: 1, color: _kBorder),
              const SizedBox(height: 14),

              // Editable fields
              Row(children: [
                Expanded(child: _editField('Phy QTY', data.phyQtyController!)),
                const SizedBox(width: 12),
                Expanded(child: _editField('Scrap', data.scarpController!)),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child:
                        _editField('Reorder Level', data.reOrderController!)),
                const SizedBox(width: 12),
                Expanded(
                    child: _editField(
                        'Min Stock Qty', data.miniStkQtyController!)),
              ]),
              const SizedBox(height: 14),
              const Divider(height: 1, color: _kBorder),
              const SizedBox(height: 14),

              // Counted By + Save
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Counted By'),
                        _dropdownWrap(_executiveDropdown(controller)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      controller.selectedDropdownValue?.executiveName
                                      ?.isEmpty ==
                                  true ||
                              controller.selectedDropdownValue?.executiveId ==
                                  null
                          ? ShowMessage.showSnackBar(
                              '', 'Please Select Counted By')
                          : controller
                              .submitStockReconciliationReportList(data);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: _kAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isPosted ? 'Update' : 'Save',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _kWhite),
                      ),
                    ),
                  ),
                ],
              ),

              if (isPosted) ...[
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: newGreenColor.withValues(alpha:0.06),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: newGreenColor.withValues(alpha:0.2)),
                  ),
                  child: Row(children: [
                    Icon(Icons.check_circle_outline, size: 14, color: _kGreen),
                    const SizedBox(width: 6),
                    Text(
                      'Posted: ${data.postingdatetime ?? 'N/A'}',
                      style: TextStyle(
                          fontSize: 12,
                          color: _kGreen,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                ),
              ],
            ],
          ),
        ),
      ]),
    );
  }

  Widget _infoTile(String label, String value,
      {CrossAxisAlignment align = CrossAxisAlignment.start}) {
    return Column(crossAxisAlignment: align, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: _kSub)),
      const SizedBox(height: 2),
      Text(value,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: _kText)),
    ]);
  }

  Widget _editField(String label, TextEditingController ctrl) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: _kSub)),
      const SizedBox(height: 6),
      TextField(
        onTap: () => ctrl.selection =
            TextSelection(baseOffset: 0, extentOffset: ctrl.text.length),
        controller: ctrl,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 13, color: _kText),
        decoration: InputDecoration(
          hintText: 'Enter...',
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _kBorder)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _kBorder)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _kAccent, width: 1.5)),
          prefixIcon: const Icon(Icons.edit_outlined, size: 14, color: _kSub),
        ),
      ),
    ]);
  }

  Widget _executiveDropdown(StockReconciliationController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          buttonHeight: 44,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent),
          isExpanded: true,
          hint: const Text(AppString.selectExecutive,
              style: TextStyle(fontSize: 12, color: _kSub)),
          value: controller.selectedDropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 20),
          items: controller.executiveDropdownList!.map((items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items.executiveName.toString(),
                  style: const TextStyle(fontSize: 13, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setSelectDropdownValue,
          dropdownMaxHeight: Get.height * 0.3,
        ),
      );
}

//  Shared helpers 
Widget _sectionCard({required List<Widget> children}) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha:0.06),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );

Widget _label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151))),
    );

Widget _dropdownWrap(Widget child) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E7EF)),
      ),
      child: child,
    );
