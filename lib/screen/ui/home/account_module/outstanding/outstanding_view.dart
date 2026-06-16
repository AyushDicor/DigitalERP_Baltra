// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:digitalerp/response/collection_customer_list_response.dart';
// import 'package:digitalerp/response/outstanding_data_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/account_module/outstanding/outstanding_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/bordered_app_button.dart';
// import 'package:digitalerp/utils/date_widget.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class OutstandingView extends StatelessWidget {
//   OutstandingView({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OutstandingController>(
//       init: OutstandingController(),
//       initState: (_) {
//
//       },
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(AppAssets.dashboardBg),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   child: SafeArea(
//                     child: MyAppBar(
//                       title: 'Party ledger',
//                       onBackTap: () => controller.backTap(),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         SizedBox(height: Get.height * 0.02),
//                         _partyDropdown(controller),
//                         const SizedBox(height: 15),
//                         Visibility(
//                           visible: false,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _dropdown2(controller),
//                               const SizedBox(height: 15),
//                               _dropdown3(controller),
//                               const SizedBox(height: 50),
//                               SolidAppButton(
//                                 onPressed: () {},
//                                 name: 'Total Due Amount',
//                                 topColor: orangeColor,
//                                 bottomColor: red2Color,
//                                 textSize: 16,
//                                 hPadding: 30,
//                               ),
//                               const SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                         Visibility(
//                           visible: controller
//                                   .selectedPartyValue?.partyname?.isNotEmpty ??
//                               false,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               outstandingCard(controller.partyOutstandingData),
//                               const SizedBox(height: 20),
//                               // Row(
//                               //   children: [
//                               //     Expanded(
//                               //         child: _dateView(context, controller.selectFromDate, 'From date', controller)),
//                               //     const SizedBox(width: 15),
//                               //     Expanded(child: _dateView(context, controller.selectToDate, 'To Date', controller)),
//                               //   ],
//                               // ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: AppDateWidget(
//                                       value: controller.selectFromDate,
//                                       title: 'From date',
//                                       onSelectDate:
//                                           controller.setSelectedFromDate,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 15),
//                                   Expanded(
//                                     child: AppDateWidget(
//                                       value: controller.selectToDate,
//                                       title: 'To Date',
//                                       onSelectDate:
//                                           controller.setSelectedToDate,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//                               BorderedAppButton(
//                                 onPressed: () => controller.getPartyLedger(),
//                                 name: 'Party Ledger',
//                                 color: orangeColor,
//                                 hPadding: 50,
//                               ),
//                             ],
//                           ),
//                           replacement: SizedBox(
//                             height: Get.height * 0.35,
//                             child: Center(
//                               child: Text(
//                                 AppString.pleaseSelectAnyParty,
//                                 style: const TextStyle().bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 180),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Visibility(
//                   visible: false,
//                   child: InkWell(
//                     onTap: () {
//                       controller.tapOnSubmit();
//                     },
//                     child: Container(
//                       height: 50,
//                       decoration: const BoxDecoration(
//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(30.0)),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               grTopColor,
//                               grBottomColor,
//                             ],
//                           )),
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       alignment: Alignment.center,
//                       child: Text(
//                         'Submit',
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 80,
//                 right: 20,
//                 child: Visibility(
//                   visible: false,
//                   child: InkWell(
//                     onTap: () {},
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         gradient: gr2,
//                         boxShadow: const [
//                           BoxShadow(
//                             blurRadius: 10,
//                             color: purpleColor,
//                           )
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       alignment: Alignment.center,
//                       child: Image.asset(
//                         AppAssets.accountsModuleIcon,
//                         height: 18,
//                         width: 28,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget outstandingCard(OutstandingData? item) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Credit Limit',
//                   style: const TextStyle().normal.copyWith(fontSize: 12),
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   'Executive Name',
//                   style: const TextStyle().normal.copyWith(fontSize: 12),
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   'Total Due Amount',
//                   style: const TextStyle().normal.copyWith(fontSize: 12),
//                 ),
//               ],
//             ),
//             DottedLine(
//               color: Colors.grey,
//               height: 80.0,
//               strokeWidth: 1.2,
//               dottedLength: 4.0,
//               space: 2.0,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item?.creditlimit ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(fontSize: 12),
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   item?.executivename ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(fontSize: 12),
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   item?.totaldueamount ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget _partyDropdownNew(OutstandingController controller) {
//   //   return DropdownButtonHideUnderline(
//   //     child: DropdownButton2<CustomerData>(
//   //       buttonHeight: 40,
//   //       buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//   //       dropdownDecoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(10),
//   //         color: dropdownBoxColor,
//   //       ),
//   //       buttonDecoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(10),
//   //         gradient: blueDropdownGr,
//   //       ),
//   //       isExpanded: true,
//   //       value: controller.selectedPartyValue,
//   //       hint: Text(
//   //         'Select Party Name',
//   //         style: const TextStyle().normal.copyWith(fontSize: 14),
//   //         overflow: TextOverflow.ellipsis,
//   //       ),
//   //       icon: Image.asset(
//   //         AppAssets.dropdownIcon,
//   //         width: 15,
//   //         height: 15,
//   //       ),
//   //       items: controller.partyList
//   //           .where((party) => party.partyid == controller.homeController.currentUserData?.accountCode)
//   //           .map((items) {
//   //         return DropdownMenuItem<CustomerData>(
//   //           value: items,
//   //           child: Text(items.partyname ?? ''),
//   //         );
//   //       }).toList(),
//   //       onChanged: (newValue) {
//   //         controller.setSelectedPartyValue(newValue);
//   //       },
//   //     ),
//   //   );
//   // }
//
//   // Widget _partyDropdown(OutstandingController controller) {
//   //   return DropdownButtonHideUnderline(
//   //     child: AbsorbPointer(
//   //       absorbing: controller.currentUserType.toLowerCase() == 'customer',
//   //       child: DropdownButton2<CustomerData>(
//   //         buttonHeight: 40,
//   //         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//   //         dropdownDecoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(10),
//   //           color: dropdownBoxColor,
//   //         ),
//   //         buttonDecoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(10),
//   //           gradient: blueDropdownGr,
//   //         ),
//   //         isExpanded: true,
//   //         // value: userType.toLowerCase() == 'customer'?"": controller.selectedPartyValue,
//   //         value:  controller.currentUserType.toLowerCase() == 'customer'
//   //             ?  controller.selectedDropdown
//   //             : controller.selectedPartyValue,
//   //         hint: Text(
//   //           'Select Party Name',
//   //           style: const TextStyle().normal.copyWith(fontSize: 14),
//   //           overflow: TextOverflow.ellipsis,
//   //         ),
//   //         icon: Image.asset(
//   //           AppAssets.dropdownIcon,
//   //           width: 15,
//   //           height: 15,
//   //         ),
//   //         items: controller.partyList.map((items) {
//   //           return DropdownMenuItem<CustomerData>(
//   //             value: items,
//   //             child: Text(items.partyname ?? ''),
//   //           );
//   //         }).toList(),
//   //         onChanged: (newValue) {
//   //           controller.setSelectedPartyValue(newValue);
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }
//
//
//
//   _partyDropdown(OutstandingController controller) {
//     final partyNameController = TextEditingController(text: controller.selectedPartyValue?.partyname ?? "");
//     final focusNode = FocusNode();
//
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         partyNameController.selection = TextSelection(
//           baseOffset: 0,
//           extentOffset: partyNameController.text.length,
//         );
//       }
//     });
//
//     return Container(
//       height: Get.height / 20,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(7),
//         color: dropdownBoxColor,
//         gradient: blueDropdownGr,
//       ),
//       child: AutoCompleteTextField<CustomerData>(
//         key: GlobalKey<AutoCompleteTextFieldState<CustomerData>>(),
//         controller: partyNameController,
//         focusNode: focusNode,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(top: 10, left: 30),
//           hintText: 'Select Party Name',
//           hintStyle: TextStyle().normal.copyWith(fontSize: 14, color: Colors.black),
//           border: InputBorder.none,
//           suffixIcon: Icon(Icons.search, color: Colors.deepOrangeAccent,),
//         ),
//         clearOnSubmit: false,
//         suggestions: controller.partyList.toList() ?? [],
//         itemBuilder: (context, suggestion) {
//           return ListTile(
//             style: ListTileStyle.list,
//             tileColor: dropdownBoxColor,
//             title: Text(suggestion.partyname.toString()),
//           );
//         },
//         itemSorter: (a, b) {
//           return a.partyname!.compareTo(b.partyname!);
//         },
//         itemFilter: (suggestion, input) {
//           return suggestion.partyname!.toLowerCase().contains(input.toLowerCase());
//         },
//         itemSubmitted: (suggestion) {
//           controller.setSelectedPartyValue(suggestion);
//           partyNameController.text = suggestion.partyname ?? '';
//           partyNameController.selection = TextSelection.fromPosition(
//             TextPosition(offset: partyNameController.text.length),
//           );
//         },
//       ),
//     );
//   }
//
//   _dropdown2(OutstandingController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: yellowColor.withValues(alpha:0.15),
//         ),
//         isExpanded: true,
//         value: controller.selectedDropdown2Value,
//         hint: Text(
//           'Select Credit Limit',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.dropdown2List.map((items) {
//           return DropdownMenuItem(
//             value: items,
//             child: Text(items),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setDropdown2Value(newValue.toString());
//         },
//       ),
//     );
//   }
//
//   _dropdown3(OutstandingController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: orangeDropdownGr(0.19),
//         ),
//         isExpanded: true,
//         value: controller.selectedDropdown3Value,
//         hint: Text(
//           'Select Executive Name',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.dropdown3List.map((items) {
//           return DropdownMenuItem(
//             value: items,
//             child: Text(items),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setDropdown3Value(newValue.toString());
//         },
//       ),
//     );
//   }
//
//   Widget _dateView(BuildContext context, String value, String title,
//       OutstandingController ctrl) {
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: AppConst.calenderFirstDate ??
//                 DateTime(
//                     int.parse(ctrl.homeController.currentUserData!.yearId!
//                         .split('-')
//                         .first),
//                     4,
//                     1),
//             lastDate: AppConst.calenderLastDate ??
//                 DateTime(DateTime.now().year + 1, 3, 31));
//
//         if (pickedDate != null) {
//           String formattedDate =
//               DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           if (title == 'To Date') {
//             ctrl.setSelectedToDate(formattedDate);
//           } else {
//             ctrl.setSelectedFromDate(formattedDate);
//           }
//         } else {
//           if (kDebugMode) {
//             print('Date is not selected');
//           }
//         }
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(color: red2Color, fontSize: 12),
//                 ),
//                 const SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(value, style: const TextStyle().normal),
//                     const SizedBox(width: 10),
//                     Image.asset(
//                       AppAssets.calendarIcon,
//                       width: 18,
//                       height: 18,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const Divider(
//             color: purpleColor,
//             thickness: 1,
//             height: 2,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/response/outstanding_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/account_module/outstanding/outstanding_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/date_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_constant_new.dart';

class OutstandingView extends StatelessWidget {
  OutstandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutstandingController>(
      init: OutstandingController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: false,

        // ✅ Proper AppBar
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => controller.backTap(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: newTextPrimary,
              size: 20,
            ),
          ),
          title: const Text(
            'Party Ledger',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: newTextPrimary,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Section label 
              const Text(
                'Search Party',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: newTextSecondary,
                ),
              ),
              const SizedBox(height: 8),

              //  Party autocomplete search 
              _partySearchField(controller),

              //  Content shown after party is selected 
              if (controller.selectedPartyValue?.partyname?.isNotEmpty ??
                  false) ...[
                const SizedBox(height: 24),

                // Party info card
                _partyInfoCard(controller.partyOutstandingData),

                const SizedBox(height: 20),

                // Date range label
                const Text(
                  'Select Date Range',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: newTextSecondary,
                  ),
                ),
                const SizedBox(height: 10),

                // From / To date row
                Row(
                  children: [
                    Expanded(
                      child: AppDateWidget(
                        value: controller.selectFromDate,
                        title: 'From Date',
                        onSelectDate: controller.setSelectedFromDate,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppDateWidget(
                        value: controller.selectToDate,
                        title: 'To Date',
                        onSelectDate: controller.setSelectedToDate,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Party Ledger button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => controller.getPartyLedger(),
                    icon: const Icon(Icons.receipt_long_outlined,
                        color: Colors.white, size: 20),
                    label: const Text(
                      'View Party Ledger',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: newBlueColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                //  Empty state 
                const SizedBox(height: 60),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: newBlueLightColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 38,
                          color: newBlueColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select a Party',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: newTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        AppString.pleaseSelectAnyParty,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: newTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        floatingActionButton: MenuFab(parentMenuId: 2382),
      ),
    );
  }

  //  Party autocomplete search field 

  Widget _partySearchField(OutstandingController controller) {
    final partyNameController = TextEditingController(
        text: controller.selectedPartyValue?.partyname ?? '');
    final focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        partyNameController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: partyNameController.text.length,
        );
      }
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AutoCompleteTextField<CustomerData>(
        key: GlobalKey<AutoCompleteTextFieldState<CustomerData>>(),
        controller: partyNameController,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintText: 'Search party name...',
          hintStyle: const TextStyle(fontSize: 14, color: newTextSecondary),
          prefixIcon: const Icon(Icons.search_rounded,
              color: newTextSecondary, size: 20),
          suffixIcon: controller.selectedPartyValue != null
              ? const Icon(Icons.check_circle_rounded,
                  color: Color(0xFF27AE60), size: 20)
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        clearOnSubmit: false,
        suggestions: controller.partyList.toList(),
        itemBuilder: (context, suggestion) {
          return Container(
            color: Colors.white,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.business_outlined,
                  size: 18, color: newTextSecondary),
              title: Text(
                suggestion.partyname.toString(),
                style: const TextStyle(
                    fontSize: 14,
                    color: newTextPrimary,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
        itemSorter: (a, b) => a.partyname!.compareTo(b.partyname!),
        itemFilter: (suggestion, input) =>
            suggestion.partyname!.toLowerCase().contains(input.toLowerCase()),
        itemSubmitted: (suggestion) {
          controller.setSelectedPartyValue(suggestion);
          partyNameController.text = suggestion.partyname ?? '';
          partyNameController.selection = TextSelection.fromPosition(
            TextPosition(offset: partyNameController.text.length),
          );
        },
      ),
    );
  }

  //  Party info card (Credit Limit / Executive / Due Amount) 

  Widget _partyInfoCard(OutstandingData? item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F3FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(color: Color(0xFFE8ECF0)),
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.account_balance_outlined,
                    size: 18, color: Color(0xFF5B5FC7)),
                SizedBox(width: 8),
                Text(
                  'Party Summary',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary,
                  ),
                ),
              ],
            ),
          ),

          // 3 info rows
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _infoRow(
                  icon: Icons.credit_card_outlined,
                  iconColor: const Color(0xFF5B5FC7),
                  iconBg: const Color(0xFFEEF0FF),
                  label: 'Credit Limit',
                  value: item?.creditlimit ?? 'N/A',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(height: 1, color: Color(0xFFEFF2F7)),
                ),
                _infoRow(
                  icon: Icons.person_outline_rounded,
                  iconColor: const Color(0xFF27AE60),
                  iconBg: const Color(0xFFE8F8EF),
                  label: 'Executive Name',
                  value: item?.executivename ?? 'N/A',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(height: 1, color: Color(0xFFEFF2F7)),
                ),
                _infoRow(
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: const Color(0xFFE74C3C),
                  iconBg: const Color(0xFFFFECEA),
                  label: 'Total Due Amount',
                  value: item?.totaldueamount ?? 'N/A',
                  valueColor: const Color(0xFFE74C3C),
                  valueBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    Color? valueColor,
    bool valueBold = false,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: newTextSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: valueBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? newTextPrimary,
          ),
        ),
      ],
    );
  }
}
