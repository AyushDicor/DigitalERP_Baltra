// import 'package:digitalerp/contactsview/contacts_details.dart';
// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/response/get_executive_dropdown_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/customer_list/customer_list_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_profile_image.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CustomerListView extends StatelessWidget {
//   const CustomerListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CustomerListController>(
//       init: CustomerListController(),
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
//                       title: 'Customer List',
//                       onBackTap: ()=>Get.back(),
//                       // onDrawerTap: () => controller.openDrawer(context),
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
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(height: Get.height * 0.02),
//                       TextField(
//                         controller: controller.searchController,
//                         textInputAction: TextInputAction.search,
//                         focusNode: controller.searchFocus,
//                         onChanged: (value) {
//                           controller.onSearchTextChanged(value);
//                         },
//                         style: const TextStyle().medium,
//                         decoration: const InputDecoration().searchTxtFieldStyle(maxHeight: 50),
//                       ),
//                       /*
//                       _searchBox(controller),
//                        */
//                       const SizedBox(height: 15),
//                       _dropdown(controller),
//                       controller.searchList.isNotEmpty || controller.searchController.text.isNotEmpty
//                           ? Visibility(
//                               visible: controller.searchList.isNotEmpty,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: controller.searchList.length,
//                                 itemBuilder: (context, index) {
//                                   return customerCardNew(
//                                     controller,
//                                     index,
//                                     isSearch: true,
//                                   );
//                                 },
//                               ),
//                               replacement: SizedBox(
//                                 height: Get.height * 0.5,
//                                 child: centerText(AppString.noCustomerFound.tr),
//                               ),
//                             )
//                           : controller.isBusy
//                               ? Column(
//                                   children: [
//                                     SizedBox(
//                                       height: MediaQuery.of(context).size.height * 0.2,
//                                     ),
//                                     const Center(
//                                       child: CircularProgressIndicator(),
//                                     )
//                                   ],
//                                 )
//                               : Visibility(
//                                   visible: ((controller.selectedDropdownValue?.executiveName?.isNotEmpty ?? false) &&
//                                       (controller.executiveList.length > 1)),
//                                   replacement: Visibility(
//                                     visible: controller.customerList.isNotEmpty,
//                                     child: ListView.builder(
//                                       controller: controller.customerScrollController,
//                                       shrinkWrap: true,
//                                       padding: EdgeInsets.zero,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       itemCount: controller.customerList.length,
//                                       itemBuilder: (context, index) {
//                                         return customerCardNew(controller, index); //customerCard(controller, index);
//                                       },
//                                     ),
//                                     replacement: SizedBox(
//                                       height: Get.height * 0.5,
//                                       child: centerText(AppString.noCustomerFound.tr),
//                                     ),
//                                   ),
//                                   child: Visibility(
//                                     visible: controller.executiveFilterList.isNotEmpty,
//                                     child: ListView.builder(
//                                       controller: controller.executiveFilterScrollController,
//                                       shrinkWrap: true,
//                                       padding: EdgeInsets.zero,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       itemCount: controller.executiveFilterList.length,
//                                       itemBuilder: (context, index) {
//                                         return customerCardNew(controller, index, isExecutiveFilterList: true);
//                                       },
//                                     ),
//                                     replacement: SizedBox(
//                                       height: Get.height * 0.5,
//                                       child: centerText(AppString.noCustomerFound.tr),
//                                     ),
//                                   ),
//                                 ),
//                       const SizedBox(height: 60),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 18,
//                 bottom: 95,
//                 child: GradientIconButton(onPressed: () => controller.tapOnAdd(), radius: 10, vPadding: 20),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _dropdown(CustomerListController controller)
//   {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<ExecutiveDropdownData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
//         isExpanded: true,
//         hint: const Text(
//           'Executive User name',
//         ),
//         value: controller.selectedDropdownValue,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.executiveList.map((items) {
//           return DropdownMenuItem(
//             value: items,
//             child: Text(items.executiveName.toString()),
//           );
//         }).toList(),
//         dropdownMaxHeight: Get.height * .35,
//         onChanged: (newValue) {
//           controller.setSelectDropdownValue(newValue);
//         },
//       ),
//     );
//   }
//
//   /*Widget customerCard(CustomerListController controller, int index,
//       {bool? isSearch}) {
//     CustomerListData item;
//     if (isSearch ?? false) {
//       item = controller.searchList[index];
//     } else {
//       item = controller.customerList[index];
//     }
//     return Container(
//       height: 255,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(10)),
//               color: blueColor.withValues(alpha:0.07),
//             ),
//             margin: const EdgeInsets.only(top: 45),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 55),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Location',
//                         style: const TextStyle()
//                             .medium
//                             .copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         item.location ?? '',
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(fontSize: 14, color: Colors.black),
//                       ),
//                       const SizedBox(height: 8),
//                     ],
//                   ),
//                 ),
//                 DottedLine(
//                   dottedLength: 5.0,
//                   color: medGreyColor,
//                   width: double.maxFinite,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Executive',
//                             style: const TextStyle()
//                                 .copyWith(color: purpleColor, fontSize: 12),
//                           ),
//                           Text(
//                             'Outstanding',
//                             style: const TextStyle()
//                                 .copyWith(color: purpleColor, fontSize: 12),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             item.executive.toString() ,
//                             style: const TextStyle().bold.copyWith(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                 ),
//                           ),
//                           Text(
//                             '\u{20B9}${item.outstanding}',
//                             style: const TextStyle()
//                                 .bold
//                                 .copyWith(fontSize: 18, color: Colors.black),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0,
//             left: 0,
//             bottom: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(10),
//                 ),
//                 image: DecorationImage(
//                   image: AssetImage(
//                     AppAssets.toproundImage,
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(bottom: 10, top: 25),
//                       alignment: Alignment.center,
//                       height: 60,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(AppAssets.cartIcon,
//                               color: Colors.white, height: 15),
//                           const SizedBox(
//                             width: 12,
//                           ),
//                           Text(
//                             'Order',
//                             style: const TextStyle().bold.copyWith(
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                 ),
//                           ),
//                         ],
//                       ),
//                       color: Colors.transparent,
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(bottom: 10, top: 25),
//                       alignment: Alignment.center,
//                       height: 60,
//                       color: Colors.transparent,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Payment',
//                             style: const TextStyle().bold.copyWith(
//                                   fontSize: 14,
//                                   color: Colors.white,
//                                 ),
//                           ),
//                           const SizedBox(width: 12),
//                           Image.asset(AppAssets.walletIcon,
//                               color: Colors.white, height: 15),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 20,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ProfileImageView(
//                     size: 84,
//                     imageUrl: item.location ?? '',
//                     borderColor: red2Color,
//                     borderSize: 3),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                   child: Text(item.partyid.toString() ,
//                       style: const TextStyle()
//                           .bold
//                           .copyWith(fontSize: 14, color: red2Color)),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
//                   decoration: BoxDecoration(
//                     color: red2Color.withValues(alpha:0.28),
//                     borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }*/
//
//   Widget customerCardNew(CustomerListController controller, int index, {bool? isSearch, bool? isExecutiveFilterList}) {
//     CustomerListData item;
//     if (isSearch ?? false) {
//       item = controller.searchList[index];
//     } else if (isExecutiveFilterList ?? false) {
//       item = controller.executiveFilterList[index];
//     } else {
//       item = controller.customerList[index];
//     }
//     return Container(
//       //height: 350,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               color: blueColor.withValues(alpha:0.07),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         AppString.customerName,
//                         style: const TextStyle().medium.copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 8),
//                       SizedBox(
//                         width: 220,
//                         child: Text(
//                           item.partyname ?? '',
//                           style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         AppString.mobileTxt,
//                         style: const TextStyle().medium.copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         item.mobileno ?? '',
//                         style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         AppString.addressTxt,
//                         style: const TextStyle().medium.copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         item.address ?? '',
//                         style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             AppString.location,
//                             style: const TextStyle().medium.copyWith(fontSize: 12, color: purpleColor),
//                           ),
//                           const SizedBox(height: 8),
//                           SizedBox(
//                             width: 210,
//                             child: Text(
//                               item.location ?? '',
//                               softWrap: true,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Visibility(
//                         visible: item.isUpdating ?? false,
//                         child: const Center(
//                           child: Text(AppString.updating),
//                         ),
//                         replacement: InkWell(
//                           onTap: () {
//                             controller.tapOnMarkLocation(index);
//                           },
//                           child: Container(
//                             width: 70,
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.lightBlueAccent,
//                                 ),
//                                 color: Colors.transparent,
//                                 borderRadius: BorderRadius.circular(18)),
//                             child: Column(
//                               children: [
//                                 const Icon(
//                                   Icons.location_pin,
//                                   color: red2Color,
//                                 ),
//                                 Text(
//                                   'mark location',
//                                   style: const TextStyle().bold.copyWith(fontSize: 8, color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 DottedLine(
//                   dottedLength: 5.0,
//                   color: medGreyColor,
//                   width: double.maxFinite,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             AppString.executive,
//                             style: const TextStyle().copyWith(color: purpleColor, fontSize: 12),
//                           ),
//                           Flexible(
//                             child: Text(
//                               AppString.outstanding,
//                               style: const TextStyle().copyWith(color: purpleColor, fontSize: 12),
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           FittedBox(
//                             child: Text(
//                               item.executive ?? '',
//                               style: const TextStyle().bold.copyWith(
//                                     fontSize: 14,
//                                     color: Colors.black,
//                                   ),
//                             ),
//                           ),
//                           Text(
//                             '\u{20B9}${double.parse(item.outstanding ?? '').toStringAsFixed(2)}',
//                             style: const TextStyle().bold.copyWith(fontSize: 18, color: Colors.black),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             AppString.remark,
//                             style: const TextStyle().copyWith(color: purpleColor, fontSize: 12),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             item.remarks ?? '',
//                             style: const TextStyle().bold.copyWith(
//                                   fontSize: 14,
//                                   color: Colors.black,
//                                 ),
//                           ),
//                           const SizedBox(height: 15),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0,
//             left: 0,
//             bottom: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(10),
//                 ),
//                 image: DecorationImage(
//                   image: AssetImage(
//                     AppAssets.toproundImage,
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(bottom: 10, top: 25),
//                       alignment: Alignment.center,
//                       height: 60,
//                       child: InkWell(
//                         onTap: () {
//                           controller.tapOnOrder(
//                             index,
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(AppAssets.cartIcon, color: Colors.white, height: 15),
//                             const SizedBox(
//                               width: 12,
//                             ),
//                             Text(
//                               AppString.order,
//                               style: const TextStyle().bold.copyWith(
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       color: Colors.transparent,
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(bottom: 10, top: 25),
//                       alignment: Alignment.center,
//                       height: 60,
//                       color: Colors.transparent,
//                       child: InkWell(
//                         onTap: () {
//                           controller.tapOnPaymentEntry(index);
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               AppString.payment,
//                               style: const TextStyle().bold.copyWith(
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                   ),
//                             ),
//                             const SizedBox(width: 12),
//                             Image.asset(AppAssets.walletIcon, color: Colors.white, height: 15),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 10,
//             right: 10,
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     if (controller.searchController.text.isEmpty) {
//                       controller.remarkController.text = controller.customerList[index].remarks ?? '';
//                       _showDialog(controller, index);
//                     } else {
//                       controller.remarkController.text = controller.searchList[index].remarks ?? '';
//                       _showDialog(controller, index);
//                     }
//                   },
//                   child: Container(
//                     child: Text(
//                       AppString.visit,
//                       style: const TextStyle().bold.copyWith(
//                             fontSize: 14,
//                             color: red2Color,
//                             fontWeight: FontWeight.w900,
//                           ),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 7,
//                       horizontal: 18,
//                     ),
//                     decoration: BoxDecoration(
//                       color: red2Color.withValues(alpha:0.28),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height:Get.height * 0.010),
//                 InkWell(
//                   onTap: () {
//                     controller.addContactsViewList.clear();
//                     Get.to( ViewContactsDetails(partyId: item.partyid.toString(),));
//                     controller.getAddContactsView(item.partyid.toString());
//                     print('PartyId ${item.partyid.toString()}');
//                   },
//                   child: Container(
//                     width: 70,
//                     decoration: BoxDecoration(
//                         // border: Border.all(
//                         //   color: Colors.lightBlueAccent,
//                         // ),
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(18)),
//                     child: Column(
//                       children: [
//                         const ImageIcon(AssetImage('assets/icons/user.png',),color: Colors.red,size: 30,),
//                         Text(
//                           'Add Contacts',
//                           style: const TextStyle().bold.copyWith(fontSize: 8, color: Colors.grey),
//                         ),
//                       ],
//                     ),
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
//   Widget _searchBox(CustomerListController controller) {
//     return Autocomplete<CustomerListData>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         return controller.customerList
//             .where((CustomerListData county) =>
//                 county.partyname!.toLowerCase().contains(textEditingValue.text.toLowerCase()))
//             .toList();
//       },
//       displayStringForOption: (CustomerListData option) => option.partyname ?? '',
//       fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController,
//           FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
//         return TextField(
//           controller: fieldTextEditingController,
//           focusNode: fieldFocusNode,
//           textInputAction: TextInputAction.search,
//           style: const TextStyle().medium,
//           decoration: const InputDecoration().searchTxtFieldStyle(maxHeight: 50),
//         );
//       },
//       onSelected: (CustomerListData selection) {
//         if (kDebugMode) {
//           print('Selected: ${selection.partyname}');
//         }
//       },
//       optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<CustomerListData> onSelected,
//           Iterable<CustomerListData> options) {
//         return Padding(
//           padding: const EdgeInsets.only(right: 40),
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: Material(
//               elevation: 4.0,
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxHeight: 200),
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   itemCount: options.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final CustomerListData option = options.elementAt(index);
//                     return ListTile(
//                       onTap: () {
//                         onSelected(option);
//                         // controller.customerList.clear();
//                         // controller.customerList.add(option);
//                       },
//                       leading: ProfileImageView(
//                           size: 40, borderColor: red2Color, imageUrl: option.partyname, borderSize: 1.25),
//                       title: Text(option.partyname ?? '',
//                           style: const TextStyle().medium.copyWith(decoration: TextDecoration.none)),
//                       trailing: const Icon(
//                         Icons.arrow_forward_outlined,
//                         size: 16,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _showDialog(CustomerListController controller, int index) {
//     Get.defaultDialog(
//       content: TextField(
//           controller: controller.remarkController,
//           decoration: const InputDecoration(
//             labelText: 'Remark',
//             labelStyle: TextStyle(color: purpleColor),
//             border: OutlineInputBorder(borderSide: BorderSide(color: purpleColor)),
//             focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: purpleColor)),
//           ),
//           maxLines: 5,
//           minLines: 1,
//           cursorColor: purpleColor,
//           style: TextStyle(fontSize: 16)),
//       title: 'Remark',
//       titleStyle: const TextStyle(color: purpleColor),
//       backgroundColor: Colors.white,
//       radius: 12,
//       textConfirm: 'Add',
//       buttonColor: purpleColor,
//       confirmTextColor: Colors.white,
//       cancelTextColor: purpleColor,
//       onConfirm: () async {
//         Get.back();
//         controller.searchFocus.unfocus();
//         controller.updateRemark(index, controller.remarkController.text);
//       },
//       onCancel: () {
//         // Get.back();
//       },
//     );
//   }
// }

import 'package:digitalerp/contactsview/contacts_details.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/customer_list/customer_list_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fab/menu_fab.dart';

class CustomerListView extends StatelessWidget {
  const CustomerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerListController>(
      init: CustomerListController(),
      builder: (controller) => Scaffold(
        backgroundColor: lightGreyColor,
        resizeToAvoidBottomInset: false,

        // ✅ Proper AppBar — replaces SafeArea + MyAppBar Container pattern
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white, // prevents Material 3 blue tint
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: newTextPrimary,
              size: 20,
            ),
          ),
          title: const Text(
            'Customer List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: newTextPrimary,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.tapOnAdd,
          backgroundColor: newBlueColor,
          shape: const CircleBorder(
              side: BorderSide(color: Colors.white, width: 2)),
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
        body: MenuFabBody(
          parentMenuId: 2380,
          child: Column(
            children: [
              //  Search + Filter bar
              Container(
                color: whiteColor,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: Column(
                  children: [
                    // Search
                    TextField(
                      controller: controller.searchController,
                      focusNode: controller.searchFocus,
                      textInputAction: TextInputAction.search,
                      onChanged: controller.onSearchTextChanged,
                      style:
                          const TextStyle(fontSize: 14, color: newTextPrimary),
                      decoration: InputDecoration(
                        hintText: AppString.type,
                        hintStyle: const TextStyle(
                            fontSize: 14, color: newTextSecondary),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: newTextSecondary, size: 20),
                        filled: true,
                        fillColor: lightGreyColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: newBorderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: newBorderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: newBlueColor, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Dropdown
                    _erpDropdown(controller),
                  ],
                ),
              ),

              const Divider(height: 1, color: unselectedColor),

              //  List 
              Expanded(
                child: controller.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: newBlueColor))
                    : _buildList(controller),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(CustomerListController controller) {
    List<CustomerListData> list;
    ScrollController? scrollCtrl;

    if (controller.searchController.text.isNotEmpty) {
      list = controller.searchList;
    } else if ((controller.selectedDropdownValue?.executiveName?.isNotEmpty ??
            false) &&
        controller.executiveList.length > 1) {
      list = controller.executiveFilterList;
      scrollCtrl = controller.executiveFilterScrollController;
    } else {
      list = controller.customerList;
      scrollCtrl = controller.customerScrollController;
    }

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline_rounded,
                size: 48, color: newTextSecondary.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            const Text(AppString.noCustomerFound,
                style: TextStyle(fontSize: 14, color: newTextSecondary)),
          ],
        ),
      );
    }

    return ListView.separated(
      controller: scrollCtrl,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _CustomerCard(
        item: list[i],
        index: i,
        controller: controller,
        onVisit: () {
          controller.remarkController.text = list[i].remarks ?? '';
          _showDialog(controller, i);
        },
      ),
    );
  }

  Widget _erpDropdown(CustomerListController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ExecutiveDropdownData>(
        isExpanded: true,
        buttonHeight: 42,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 12),
        buttonDecoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: newBorderColor),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: whiteColor,
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        hint: const Text(AppString.selectExecutiveName,
            style: TextStyle(fontSize: 14, color: newTextSecondary)),
        value: controller.selectedDropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: newTextSecondary, size: 20),
        items: controller.executiveList.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e.executiveName.toString(),
                style: const TextStyle(fontSize: 14, color: newTextPrimary)),
          );
        }).toList(),
        dropdownMaxHeight: Get.height * .35,
        onChanged: controller.setSelectDropdownValue,
      ),
    );
  }

  void _showDialog(CustomerListController controller, int index) {
    Get.defaultDialog(
      title: AppString.remark,
      titleStyle: const TextStyle(
          color: newTextPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      backgroundColor: const Color(0xFFF5F6FA),
      radius: 10,
      content: TextField(
        controller: controller.remarkController,
        maxLines: 4,
        minLines: 1,
        cursorColor: newBlueColor,
        style: const TextStyle(fontSize: 14, color: newTextPrimary),
        decoration: InputDecoration(
          labelText: AppString.remark,
          labelStyle: const TextStyle(color: newTextSecondary, fontSize: 13),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: newBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
        ),
      ),
      textConfirm: AppString.submit,
      buttonColor: newBlueColor,
      confirmTextColor: Colors.white,
      cancelTextColor: newBlueColor,
      onConfirm: () async {
        Get.back();
        controller.searchFocus.unfocus();
        controller.updateRemark(index, controller.remarkController.text);
      },
    );
  }
}

//  Customer Card 
class _CustomerCard extends StatelessWidget {
  final CustomerListData item;
  final int index;
  final CustomerListController controller;
  final VoidCallback onVisit;

  const _CustomerCard({
    required this.item,
    required this.index,
    required this.controller,
    required this.onVisit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Header row: name + action buttons 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 10, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: newBlueLightColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (item.partyname ?? 'C').substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: newBlueColor),
                  ),
                ),
                const SizedBox(width: 10),
                // Name + mobile
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.partyname ?? '',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: newTextPrimary)),
                      const SizedBox(height: 2),
                      Text(item.mobileno ?? '',
                          style: const TextStyle(
                              fontSize: 12, color: newTextSecondary)),
                    ],
                  ),
                ),
                // Action chips
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _chip(AppString.visit, newRedColor, newRedLightColor,
                        onVisit),
                    const SizedBox(height: 6),
                    _contactsChip(),
                  ],
                ),
              ],
            ),
          ),

          const Divider(
              height: 1, color: unselectedColor, indent: 14, endIndent: 14),

          //  Detail grid 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _labelValue(AppString.addressTxt, item.address ?? ''),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _labelValue(
                            AppString.location, item.location ?? '',
                            maxLines: 2)),
                    const SizedBox(width: 8),
                    _locationBtn(),
                  ],
                ),
              ],
            ),
          ),

          const Divider(
              height: 1, color: unselectedColor, indent: 14, endIndent: 14),

          //  Stats row 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: Row(
              children: [
                Expanded(
                    child:
                        _labelValue(AppString.executive, item.executive ?? '')),
                Container(width: 1, height: 32, color: unselectedColor),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppString.outstanding,
                            style: TextStyle(
                                fontSize: 11, color: newTextSecondary)),
                        const SizedBox(height: 2),
                        Text(
                          '₹${double.tryParse(item.outstanding ?? '0')?.toStringAsFixed(2) ?? '0.00'}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: (double.tryParse(item.outstanding ?? '0') ??
                                        0) >
                                    0
                                ? newRedColor
                                : newGreenColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //  Remark (if present) 
          if ((item.remarks ?? '').isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: unselectedColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notes_rounded,
                      size: 14, color: newTextSecondary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(item.remarks ?? '',
                        style: const TextStyle(
                            fontSize: 12, color: newTextSecondary)),
                  ),
                ],
              ),
            ),
          ],

          //  Action footer 
          Row(
            children: [
              _footerBtn(AppString.order, Icons.shopping_cart_outlined,
                  orangeColor, () => controller.tapOnOrder(index)),
              _footerBtn(
                  AppString.payment,
                  Icons.account_balance_wallet_outlined,
                  newBlueColor,
                  () => controller.tapOnPaymentEntry(index)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, Color fg, Color bg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
      ),
    );
  }

  Widget _contactsChip() {
    return GestureDetector(
      onTap: () {
        controller.addContactsViewList.clear();
        Get.to(ViewContactsDetails(partyId: item.partyid.toString()));
        controller.getAddContactsView(item.partyid.toString());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: newBlueLightColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.person_add_alt_1_outlined,
                size: 13, color: newBlueColor),
            SizedBox(width: 4),
            Text('Add Contacts',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: newBlueColor)),
          ],
        ),
      ),
    );
  }

  Widget _locationBtn() {
    return GestureDetector(
      onTap: () => controller.tapOnMarkLocation(index),
      child: item.isUpdating == true
          ? const Text(AppString.updating,
              style: TextStyle(fontSize: 11, color: newTextSecondary))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: newBlueLightColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: const [
                  Icon(Icons.location_on_outlined,
                      size: 16, color: newRedColor),
                  SizedBox(height: 2),
                  Text(AppString.goToMap,
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: newTextSecondary)),
                ],
              ),
            ),
    );
  }

  Widget _labelValue(String label, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                color: newTextSecondary,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 13,
                color: newTextPrimary,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _footerBtn(String label, IconData icon, Color bg, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          color: bg,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
