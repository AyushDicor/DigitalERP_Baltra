// import 'dart:convert';
// import 'dart:io';
//
// import 'package:digitalerp/response/cash_bank_ledger_response.dart';
// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
// import 'package:digitalerp/screen/ui/home/account_module/receipt_entry/receipt_entry_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_bottom_button.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_loader.dart';
// import 'package:digitalerp/utils/my_app_bar.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ReceiptEntryView extends StatelessWidget {
//   const ReceiptEntryView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ReceiptEntryController>(
//       init: ReceiptEntryController(),
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
//                       title: 'Receipt Entry',
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
//                 child: controller.isBusy
//                     ? const AppLoader()
//                     : SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: Get.height * 0.02),
//                               controller.argument == null
//                                   ? _dropdown(controller)
//                                   : Container(
//                                       width: Get.width,
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           color: dropdownBoxColor,
//                                           borderRadius: BorderRadius.circular(8)),
//                                       child: Text(
//                                         controller.customerName,
//                                         style: const TextStyle().bold.copyWith(),
//                                       ),
//                                     ),
//                               const SizedBox(height: 20),
//                               _dateView(context, controller.selectDate, controller),
//                               const SizedBox(height: 15),
//                               TextFormField(
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                 ],
//                                 maxLength: 6,
//                                 style: const TextStyle().light,
//                                 keyboardType: TextInputType.number,
//                                 textInputAction: TextInputAction.next,
//                                 controller: controller.amountController,
//                                 focusNode: controller.amountFocus,
//                                 decoration: const InputDecoration().txtFieldStyle2(
//                                   hintText: 'Enter amount',
//                                   labelName: 'Amount',
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text('  Payment Mode',
//                                   style: const TextStyle()
//                                       .normal
//                                       .copyWith(color: red2Color, fontSize: 12)),
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: controller.paymentOptionList.length,
//                                 itemBuilder: (context, index) {
//                                   return Column(
//                                     children: [
//                                       controller.selectedIndex == 1
//                                           ? paymentCard2(controller, index, context)
//                                           : paymentCard(controller, index),
//                                     ],
//                                   );
//                                 },
//                               ) /*paymentCard(controller, 'Cash', () =>
//                                 controller.isSelectedCash()),
//                             paymentCard2(controller, 'Cheque', () =>
//                                 controller.isSelectedCheque(), context),
//                             paymentCard3(controller, 'Online', () =>
//                                 controller.isSelectedOnline()),*/
//                               ,
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               _cashAndBankLedgerDropdown(controller),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 style: const TextStyle().light,
//                                 minLines: 4,
//                                 maxLines: 6,
//                                 keyboardType: TextInputType.text,
//                                 textInputAction: TextInputAction.next,
//                                 controller: controller.remarkController,
//                                 focusNode: controller.remarkFocus,
//                                 decoration: const InputDecoration().txtFieldStyle2(
//                                   hintText: 'Type...',
//                                   labelName: 'Remark',
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Material(
//                                 child: InkWell(
//                                   onTap: () => _showImageDialog(controller),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         gradient: LinearGradient(
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                           colors: [
//                                             grBottomColor.withValues(alpha:0.2),
//                                             grTopColor.withValues(alpha:0.2),
//                                           ],
//                                         )),
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: controller.selectedImage.value == '' ? 45 : 0),
//                                     alignment: Alignment.center,
//                                     clipBehavior: Clip.antiAlias,
//                                     child: controller.selectedImage.value == ''
//                                         ? Image.asset(
//                                             AppAssets.uploadIcon,
//                                             height: 28,
//                                             width: 28,
//                                           )
//                                         : Image.file(
//                                             File(controller.selectedImage.value),
//                                             // height: size,
//                                             // width: size,
//                                             fit: BoxFit.fill,
//                                           ),
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: TextButton(
//                                   onPressed: () => _showImageDialog(controller),
//                                   child: Text(
//                                       controller.selectedImage.value == ''
//                                           ? 'Upload picture'
//                                           : 'Change image',
//                                       style: const TextStyle()
//                                           .normal
//                                           .copyWith(color: red2Color, fontSize: 12)),
//                                 ),
//                               ),
//                               const SizedBox(height: 80),
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//               Positioned(
//                 bottom: 80,
//                 right: 20,
//                 child: Visibility(
//                   visible: false,
//                   child: InkWell(
//                     onTap: () {
//                       controller.onTabAccountModule();
//                     },
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           gradient: gr2,
//                           boxShadow: const [
//                             BoxShadow(
//                               blurRadius: 10,
//                               color: purpleColor,
//                             )
//                           ]),
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
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AppBottomButton(
//                     onPressed: () {
//                       controller.tapOnSubmit();
//                     },
//                     name: 'Submit'),
//               )
//             ],
//           ),
//         ),
//         floatingActionButton: MenuFab(parentMenuId: 2382),
//       ),
//     );
//   }
//
//   Widget _dateView(BuildContext context, String value, ReceiptEntryController ctrl) {
//     return InkWell(
//       onTap: () => ctrl.tapOnDate(context),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Select Date',
//                   style: const TextStyle().bold.copyWith(color: red2Color, fontSize: 12),
//                 ),
//                 const SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(value, style: const TextStyle().normal),
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
//
//   Widget paymentCard(
//     ReceiptEntryController controller,
//     int index,
//   ) {
//     return SizedBox(
//       height: 60,
//       child: Stack(
//         children: [
//           Positioned(
//             left: 0,
//             top: 0,
//             right: 14,
//             bottom: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.transparent,
//                 border: Border.all(width: 1, color: purpleColor),
//               ),
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
//               child: Text(
//                 controller.paymentOptionList[index],
//                 style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             top: 16,
//             child: InkWell(
//               onTap: () => controller.setSelectedIndex(index),
//               child: Container(
//                 height: 28,
//                 width: 28,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     gradient: gr1,
//                     boxShadow: const [
//                       BoxShadow(
//                         color: purpleColor,
//                         blurRadius: 5,
//                         offset: Offset(
//                           -3,
//                           1,
//                         ),
//                       ),
//                     ]),
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   controller.selectedIndex == index ? AppAssets.checkIcon : AppAssets.uncheckIcon,
//                   width: 10,
//                   height: 10,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget paymentCard2(ReceiptEntryController controller, int index, BuildContext context) {
//     return SizedBox(
//       height: controller.selectedIndex == index ? 160 : 60,
//       child: Stack(
//         children: [
//           Positioned(
//             left: 0,
//             top: 0,
//             right: 14,
//             bottom: 0,
//             child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.transparent,
//                   border: Border.all(width: 1, color: purpleColor),
//                 ),
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 12.5,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       controller.paymentOptionList[index],
//                       style: const TextStyle().bold.copyWith(
//                             fontSize: 12,
//                             color: purpleColor,
//                           ),
//                     ),
//                     Visibility(
//                       visible: controller.selectedIndex == index,
//                       child: const SizedBox(
//                         height: 10,
//                       ),
//                     ),
//                     Visibility(
//                       visible: controller.selectedIndex == index,
//                       child: Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 grBottomColor.withValues(alpha:0.2),
//                                 grTopColor.withValues(alpha:0.2),
//                               ],
//                             )),
//                         child: TextFormField(
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                           ],
//                           maxLength: 6,
//                           decoration: const InputDecoration().newTxtFieldStyle(),
//                           controller: controller.chequeNoController,
//                           focusNode: FocusNode(),
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.search,
//                           onChanged: (value) {},
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: controller.selectedIndex == index,
//                       child: const SizedBox(height: 10),
//                     ),
//                     Visibility(
//                       visible: controller.selectedIndex == index,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         height: 40,
//                         width: double.maxFinite,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               grBottomColor.withValues(alpha:0.2),
//                               grTopColor.withValues(alpha:0.2),
//                             ],
//                           ),
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             controller.tapOnChequeDate(context);
//                           },
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               controller.selectDate2,
//                               style: const TextStyle().normal.copyWith(
//                                     fontSize: 12,
//                                     color: medGreyColor,
//                                   ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )),
//           ),
//           Positioned(
//             right: 0,
//             top: 16,
//             child: InkWell(
//               onTap: () => controller.setSelectedIndex(index),
//               child: Container(
//                 height: 28,
//                 width: 28,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     gradient: gr1,
//                     boxShadow: const [
//                       BoxShadow(
//                         color: purpleColor,
//                         blurRadius: 5,
//                         offset: Offset(
//                           -3,
//                           1,
//                         ),
//                       ),
//                     ]),
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   controller.selectedIndex == index ? AppAssets.checkIcon : AppAssets.uncheckIcon,
//                   width: 10,
//                   height: 10,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _dropdown(ReceiptEntryController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<CustomerListData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         isExpanded: true,
//         value: controller.selectedDropdownValue,
//         hint: Text(
//           'Select Customer',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.customerDataList.map(
//           (items) {
//             return DropdownMenuItem<CustomerListData>(
//               value: items,
//               child: Text(items.partyname.toString()),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) {
//           controller.setDropdownValue(newValue);
//         },
//         dropdownMaxHeight: Get.height * .35,
//       ),
//     );
//   }
//
//   Widget _cashAndBankLedgerDropdown(ReceiptEntryController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<CashAndBankLedgerDataList>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         isExpanded: true,
//         value: controller.selectedCollectionLedgerValue,
//         hint: Text(
//           'Select Collection Ledger',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.cashAndBankLedgerList.map(
//           (items) {
//             return DropdownMenuItem<CashAndBankLedgerDataList>(
//               value: items,
//               child: Text(items.partyname.toString()),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) {
//           controller.setCashAndBankLedgerDropdownValue(newValue);
//         },
//       ),
//     );
//   }
//
//   _showImageDialog(ReceiptEntryController value) {
//     return Get.defaultDialog(
//       title: 'Choose Option',
//       radius: 8,
//       titleStyle: const TextStyle().normal,
//       content: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               _getImage(ImageSource.gallery, value);
//             },
//             child: Text(
//               'Select Image From Gallery',
//               style: const TextStyle().normal,
//             ),
//           ),
//           SizedBox(height: Get.height * .02),
//           InkWell(
//             onTap: () {
//               _getImage(ImageSource.camera, value);
//             },
//             child: Text(
//               'Take picture',
//               style: const TextStyle().normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _getImage(ImageSource source, ReceiptEntryController value) async {
//     Get.back();
//     var pickedFile = await value.picker.pickImage(
//       source: source,
//       imageQuality: 65,
//     );
//     if (pickedFile != null) {
//       var file = File(pickedFile.path);
//       value.selectedImageBase64.value = base64.encode(file.readAsBytesSync());
//       value.selectedImageFileName.value = file.path.split('/').last;
//       value.setSelectedImage(file.path);
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:digitalerp/response/cash_bank_ledger_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/account_module/receipt_entry/receipt_entry_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_loader.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

const Color _kWhite  = Colors.white;
const Color _kBorder = Color(0xFFE4E7EF);
const Color _kText   = Color(0xFF111827);
const Color _kSub    = Color(0xFF6B7280);

class ReceiptEntryView extends StatelessWidget {
  const ReceiptEntryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptEntryController>(
      init: ReceiptEntryController(),
      builder: (controller) => Scaffold(
        backgroundColor: purpleLightest,
        appBar: _buildAppBar('Receipt Entry'),
        floatingActionButton: MenuFab(parentMenuId: 2382),
        body: controller.isBusy
            ? const AppLoader()
            : Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer
                    _card(children: [
                      _label('Customer'),
                      controller.argument == null
                          ? _dropdownWrap(_customerDropdown(controller))
                          : _infoBox(controller.customerName),
                    ]),
                    const SizedBox(height: 16),

                    // Date
                    _card(children: [
                      _label('Date'),
                      _dateTile(controller.selectDate,
                              () => controller.tapOnDate(context)),
                    ]),
                    const SizedBox(height: 16),

                    // Amount
                    _card(children: [
                      _label('Amount'),
                      _textField(
                        controller: controller.amountController,
                        focusNode: controller.amountFocus,
                        hint: 'Enter amount',
                        keyboardType: TextInputType.number,
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 6,
                      ),
                    ]),
                    const SizedBox(height: 16),

                    // Payment mode
                    _card(children: [
                      _label('Payment Mode'),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.paymentOptionList.length,
                        itemBuilder: (context, index) =>
                        controller.selectedIndex == 1
                            ? _paymentCard2(
                            controller, index, context)
                            : _paymentCard(controller, index),
                      ),
                    ]),
                    const SizedBox(height: 16),

                    // Collection Ledger
                    _card(children: [
                      _label('Collection Ledger'),
                      _dropdownWrap(
                          _cashAndBankLedgerDropdown(controller)),
                    ]),
                    const SizedBox(height: 16),

                    // Remark
                    _card(children: [
                      _label('Remark'),
                      _textField(
                        controller: controller.remarkController,
                        focusNode: controller.remarkFocus,
                        hint: 'Type remark...',
                        minLines: 3,
                        maxLines: 5,
                      ),
                    ]),
                    const SizedBox(height: 16),

                    // Image upload
                    _card(children: [
                      _label('Attachment'),
                      GestureDetector(
                        onTap: () => _showImageDialog(controller),
                        child: Container(
                          width: double.infinity,
                          height: controller.selectedImage.value == ''
                              ? 100
                              : null,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: _kBorder),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: controller.selectedImage.value == ''
                              ? Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file_outlined,
                                  size: 28, color: _kSub),
                              const SizedBox(height: 6),
                              Text('Tap to upload',
                                  style: TextStyle(
                                      fontSize: 13, color: _kSub)),
                            ],
                          )
                              : Image.file(
                              File(controller.selectedImage.value),
                              fit: BoxFit.cover),
                        ),
                      ),
                      if (controller.selectedImage.value != '')
                        TextButton(
                          onPressed: () => _showImageDialog(controller),
                          child: const Text('Change image',
                              style: TextStyle(
                                  color: purpleColor, fontSize: 13)),
                        ),
                    ]),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            _submitBar(() => controller.tapOnSubmit()),
          ],
        ),
      ),
    );
  }

  Widget _customerDropdown(ReceiptEntryController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<CustomerListData>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.transparent),
          isExpanded: true,
          value: controller.selectedDropdownValue,
          hint: const Text('Select Customer',
              style: TextStyle(fontSize: 14, color: _kSub)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          dropdownMaxHeight: Get.height * .35,
          items: controller.customerDataList.map((items) {
            return DropdownMenuItem<CustomerListData>(
              value: items,
              child: Text(items.partyname.toString(),
                  style: const TextStyle(fontSize: 14, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setDropdownValue,
        ),
      );

  Widget _cashAndBankLedgerDropdown(ReceiptEntryController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<CashAndBankLedgerDataList>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.transparent),
          isExpanded: true,
          value: controller.selectedCollectionLedgerValue,
          hint: const Text('Select Collection Ledger',
              style: TextStyle(fontSize: 14, color: _kSub)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          items: controller.cashAndBankLedgerList.map((items) {
            return DropdownMenuItem<CashAndBankLedgerDataList>(
              value: items,
              child: Text(items.partyname.toString(),
                  style: const TextStyle(fontSize: 14, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setCashAndBankLedgerDropdownValue,
        ),
      );

  Widget _paymentCard(ReceiptEntryController controller, int index) {
    final isSelected = controller.selectedIndex == index;
    return GestureDetector(
      onTap: () => controller.setSelectedIndex(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? purpleColor.withValues(alpha:0.06) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ?purpleColor: _kBorder, width: 1.5),
        ),
        child: Row(children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_unchecked_rounded,
            color: isSelected ?purpleColor: _kSub,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(controller.paymentOptionList[index],
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ?purpleColor: _kText)),
        ]),
      ),
    );
  }

  Widget _paymentCard2(
      ReceiptEntryController controller, int index, BuildContext context) {
    final isSelected = controller.selectedIndex == index;
    return GestureDetector(
      onTap: () => controller.setSelectedIndex(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? purpleColor.withValues(alpha:0.06) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ?purpleColor: _kBorder, width: 1.5),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected ?purpleColor: _kSub,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(controller.paymentOptionList[index],
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ?purpleColor: _kText)),
          ]),
          if (isSelected) ...[
            const SizedBox(height: 12),
            TextField(
              controller: controller.chequeNoController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 6,
              style: const TextStyle(fontSize: 14, color: _kText),
              decoration: InputDecoration(
                hintText: 'Cheque No.',
                hintStyle:
                const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                filled: true,
                fillColor: _kWhite,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE4E7EF))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE4E7EF))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color(0xFF4F46E5), width: 1.5)),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => controller.tapOnChequeDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 13),
                decoration: BoxDecoration(
                  color: _kWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBorder),
                ),
                child: Row(children: [
                  Expanded(
                      child: Text(controller.selectDate2,
                          style: const TextStyle(
                              fontSize: 13, color: _kText))),
                  const Icon(Icons.calendar_today_outlined,
                      size: 14, color: _kSub),
                ]),
              ),
            ),
          ],
        ]),
      ),
    );
  }

  _showImageDialog(ReceiptEntryController value) {
    return Get.defaultDialog(
      title: 'Choose Option',
      radius: 12,
      titleStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w700, color: _kText),
      content: Column(children: [
        ListTile(
          leading: const Icon(Icons.photo_library_outlined, color: purpleColor),
          title: const Text('From Gallery'),
          onTap: () => _getImage(ImageSource.gallery, value),
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined, color: purpleColor),
          title: const Text('Take Photo'),
          onTap: () => _getImage(ImageSource.camera, value),
        ),
      ]),
    );
  }

  void _getImage(ImageSource source, ReceiptEntryController value) async {
    Get.back();
    var pickedFile =
    await value.picker.pickImage(source: source, imageQuality: 65);
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      value.selectedImageBase64.value =
          base64.encode(file.readAsBytesSync());
      value.selectedImageFileName.value = file.path.split('/').last;
      value.setSelectedImage(file.path);
    }
  }
}

//  Shared helpers 
AppBar _buildAppBar(String title, {List<Widget>? actions}) => AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  surfaceTintColor: Colors.white,
  leading: GestureDetector(
    onTap: () => Get.back(),
    child: const Icon(Icons.arrow_back_ios_new_rounded,
        color: Color(0xFF111827), size: 20),
  ),
  title: Text(title,
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF111827))),
  actions: actions,
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(1),
    child: Container(color: const Color(0xFFE4E7EF), height: 1),
  ),
);

Widget _card({required List<Widget> children}) => Container(
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

Widget _infoBox(String text) => Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  decoration: BoxDecoration(
    color: const Color(0xFFF3F4F6),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: const Color(0xFFE4E7EF)),
  ),
  child: Text(text,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111827))),
);

Widget _dateTile(String value, VoidCallback onTap) => GestureDetector(
  onTap: onTap,
  child: Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE4E7EF)),
    ),
    child: Row(children: [
      Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF111827)))),
      const Icon(Icons.calendar_today_outlined,
          size: 16, color: Color(0xFF6B7280)),
    ]),
  ),
);

Widget _textField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String hint,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? formatters,
  int? maxLength,
  int minLines = 1,
  int maxLines = 1,
}) =>
    TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E7EF))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E7EF))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
                color: Color(0xFF4F46E5), width: 1.5)),
      ),
    );

Widget _submitBar(VoidCallback onTap) => Container(
  color: Colors.white,
  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
  child: SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)),
      ),
      child: const Text('Submit',
          style:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
    ),
  ),
);