// import 'package:digitalerp/contactsview/Designation_dropdown_responce.dart';
// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/response/get_executive_dropdown_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/customer_list/customer_list_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/date_widget.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// class AddContactsView extends StatefulWidget {
//   String? partyId;
//    AddContactsView({Key? key,this.partyId}) : super(key: key);
//
//   @override
//   State<AddContactsView> createState() => _AddContactsState();
// }
//
// class _AddContactsState extends State<AddContactsView> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CustomerListController>(
//         init: CustomerListController(),
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
//                           title: 'Add Contacts',
//                           onBackTap: () => Get.back(),
//                           showApprovalIcon: false,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: Get.height * 0.150,
//                     left: 0,
//                     right: 0,
//                     bottom:0,
//                     child: Column(
//                       children: [
//                         _addcontactDetails(controller),
//                         SizedBox(
//                           height: Get.height * 0.0500,
//                         ),
//                         controller.customerList==[]
//                         ? const CircularProgressIndicator()
//                         :submitButton(controller)
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
//   Widget _addcontactDetails(CustomerListController controller) {
//     return SingleChildScrollView(
//       child: Column(
//           // mainAxisSize: MainAxisSize.min,
//           children: [
//             customTextFieldText(
//                 focusNode: controller.contactPersonFocus,
//                 hintText: 'Enter Contact Person',
//                 controller: controller.contactPersonController),
//             SizedBox(
//               height: Get.height * 0.0100,
//             ),
//             customTextFieldNumber(
//                 focusNode: controller.whatsAppNumberFocus,
//                 hintText: 'Enter WhatsApp Number',
//                 controller: controller.whatsAppNumberController),
//             SizedBox(
//               height: Get.height * 0.0100,
//             ),
//             customTextFieldText(
//                 focusNode: controller.emailFocus,
//                 hintText: 'Enter Email',
//                 controller: controller.emailController),
//             SizedBox(
//               height: Get.height * 0.0100,
//             ),
//             // DropdownButtonHideUnderline(
//             //   child: DropdownButton2(
//             //     buttonHeight: Get.height * 0.0600,
//             //     buttonWidth: Get.width * 0.900,
//             //     buttonPadding:
//             //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//             //     dropdownDecoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(15),
//             //       color: dropdownBoxColor,
//             //     ),
//             //     dropdownMaxHeight: 200,
//             //     buttonDecoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(10),
//             //       color: dropdownBoxColor,
//             //       gradient: LinearGradient(
//             //         colors: [
//             //           grBottomColor.withValues(alpha:0.2),
//             //           grTopColor.withValues(alpha:0.2)
//             //         ],
//             //         begin: Alignment.topCenter,
//             //         end: Alignment.bottomCenter,
//             //       ),
//             //     ),
//             //     isExpanded: true,
//             //     hint: Text(
//             //       "Designation",
//             //       style: const TextStyle().newstyle.copyWith(
//             //             // fontSize: 15,
//             //             // fontWeight: FontWeight.bold,
//             //             color: Colors.black,
//             //           ),
//             //       // overflow: TextOverflow.ellipsis,
//             //     ),
//             //     // value: controller.selectedDocument,
//             //     icon: Image.asset(
//             //       AppAssets.calendarIcon,
//             //       width: 15,
//             //       height: 15,
//             //     ),
//             //     items: [],
//             //     // items: controller.filterDocumentData.map(
//             //     //       (items) {
//             //     //     return DropdownMenuItem(
//             //     //       value: items,
//             //     //       child: Text(
//             //     //         items.documentname ?? '',
//             //     //       ),
//             //     //     );
//             //     //   },
//             //     // ).toList(),
//             //     // onChanged: (newValue){
//             //     //   controller.onChangedDocumentDataValue(newValue);
//             //     //   controller.update();
//             //     // },
//             //   ),
//             // ),
//            // _dropdown(controller),
//             _dropdown(controller),
//             SizedBox(
//               height: Get.height * 0.0100,
//             ),
//             AppDateWidgetNew(value: controller.selectDateOfBirth, onSelectDate: controller.setSelectedDate),
//             // DropdownButtonHideUnderline(
//             //   child: DropdownButton2(
//             //     buttonHeight: Get.height * 0.0600,
//             //     buttonWidth: Get.width * 0.900,
//             //     buttonPadding:
//             //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//             //     dropdownDecoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(15),
//             //       color: dropdownBoxColor,
//             //     ),
//             //     dropdownMaxHeight: 200,
//             //     buttonDecoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(10),
//             //       color: dropdownBoxColor,
//             //       gradient: LinearGradient(
//             //         colors: [
//             //           grBottomColor.withValues(alpha:0.2),
//             //           grTopColor.withValues(alpha:0.2)
//             //         ],
//             //         begin: Alignment.topCenter,
//             //         end: Alignment.bottomCenter,
//             //       ),
//             //     ),
//             //     isExpanded: true,
//             //     hint: Text(
//             //       "Date of birth",
//             //       style: const TextStyle().newstyle.copyWith(
//             //             // fontSize: 15,
//             //             // fontWeight: FontWeight.bold,
//             //             color: Colors.black,
//             //           ),
//             //       // overflow: TextOverflow.ellipsis,
//             //     ),
//             //     // value: controller.selectedDocument,
//             //     icon: Image.asset(
//             //       AppAssets.calendarIcon,
//             //       width: 15,
//             //       height: 15,
//             //     ),
//             //     items: [],
//             //     // items: controller.filterDocumentData.map(
//             //     //       (items) {
//             //     //     return DropdownMenuItem(
//             //     //       value: items,
//             //     //       child: Text(
//             //     //         items.documentname ?? '',
//             //     //       ),
//             //     //     );
//             //     //   },
//             //     // ).toList(),
//             //     // onChanged: (newValue){
//             //     //   controller.onChangedDocumentDataValue(newValue);
//             //     //   controller.update();
//             //     // },
//             //   ),
//             // ),
//             SizedBox(
//               height: Get.height * 0.0100,
//             ),
//             AppDateWidgetNew(value: controller.selectAssociateDate, onSelectDate: controller.setSelectedAssociateDate),
//             // DropdownButtonHideUnderline(
//             //   child: DropdownButton2(
//             //     buttonHeight: Get.height * 0.0600,
//             //     buttonWidth: Get.width * 0.900,
//             //     buttonPadding:
//             //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//             //     dropdownDecoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(15),
//             //       color: dropdownBoxColor,
//             //     ),
//             //     dropdownMaxHeight: 200,
//             //     buttonDecoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(10),
//             //       color: dropdownBoxColor,
//             //       gradient: LinearGradient(
//             //         colors: [
//             //           grBottomColor.withValues(alpha:0.2),
//             //           grTopColor.withValues(alpha:0.2)
//             //         ],
//             //         begin: Alignment.topCenter,
//             //         end: Alignment.bottomCenter,
//             //       ),
//             //     ),
//             //     isExpanded: true,
//             //     hint: Text(
//             //       "Associate Date",
//             //       style: const TextStyle().newstyle.copyWith(
//             //             // fontSize: 15,
//             //             // fontWeight: FontWeight.bold,
//             //             color: Colors.black,
//             //           ),
//             //       // overflow: TextOverflow.ellipsis,
//             //     ),
//             //     // value: controller.selectedDocument,
//             //     icon: Image.asset(
//             //       AppAssets.calendarIcon,
//             //       width: 15,
//             //       height: 15,
//             //     ),
//             //     items: [],
//             //     // items: controller.filterDocumentData.map(
//             //     //       (items) {
//             //     //     return DropdownMenuItem(
//             //     //       value: items,
//             //     //       child: Text(
//             //     //         items.documentname ?? '',
//             //     //       ),
//             //     //     );
//             //     //   },
//             //     // ).toList(),
//             //     // onChanged: (newValue){
//             //     //   controller.onChangedDocumentDataValue(newValue);
//             //     //   controller.update();
//             //     // },
//             //   ),
//             // ),
//             SizedBox(
//               height: Get.height * 0.0100,
//             ),
//             customTextFieldText(
//                 focusNode: controller.comissionFocus,
//                 hintText: 'Enter Comission %',
//                 controller: controller.comissionController),
//           ]),
//     );
//   }
//
//   Widget _dropdown(CustomerListController controller)
//   {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: Get.height * 0.0600,
//         buttonWidth: Get.width * 0.900,
//         buttonPadding:
//         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text(
//           "Designation",
//           style: const TextStyle().newstyle.copyWith(
//             color: Colors.black,
//           ),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         // value: controller.selectedDocument,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         value:  controller.selectDesignation?.designnationid,
//         items: controller.designationList.map(
//               (items) {
//             return DropdownMenuItem(
//               value: items.designnationid,
//               child: Text(
//                 items.designnation.toString(),
//                 style: TextStyle().newstyle.copyWith(color: Colors.black),
//               ),
//             );
//           },
//         ).toList(),
//         onChanged:(newValue) => controller.onChangedDesignationValue(controller
//             .designationList
//             .firstWhere((element) => element.designnationid == newValue)),
//         // items: controller.filterDocumentData.map(
//         //       (items) {
//         //     return DropdownMenuItem(
//         //       value: items,
//         //       child: Text(
//         //         items.documentname ?? '',
//         //       ),
//         //     );
//         //   },
//         // ).toList(),
//         // onChanged: (newValue){
//         //   controller.onChangedDocumentDataValue(newValue);
//         //   controller.update();
//         // },
//       ),
//     );
//   }
//
//   Widget submitButton(CustomerListController controller, ) {
//     return Container(
//       height: Get.height * 0.05,
//       width: Get.height * 0.120,
//       decoration: ShapeDecoration(
//         shape: const StadiumBorder(),
//         gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
//       ),
//       child: MaterialButton(
//         onPressed: () {
//           if(controller.contactPersonController.text.isEmpty){
//             ShowMessage.showSnackBar(
//               AppString.requiredFieldTxt.tr,
//               AppString.pleaseEnterContactPerson.tr,
//             );
//           }
//           else if(controller.selectDesignation==null){
//             ShowMessage.showSnackBar("","Please Select designation");
//           } else{
//             controller.getAddContactsDetails(widget.partyId.toString());
//           }
//           print('PartyID => ${widget.partyId.toString()}');
//
//         },
//         shape: const StadiumBorder(),
//         child: Row(
//           children: [
//             SizedBox(
//               width: 5,
//             ),
//             Text(
//               'Submit',
//               style: TextStyle(fontSize: 15, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:digitalerp/contactsview/Designation_dropdown_responce.dart';
import 'package:digitalerp/screen/ui/home/customer_list/customer_list_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/date_widget.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddContactsView extends StatefulWidget {
  final String? partyId;
  const AddContactsView({Key? key, this.partyId}) : super(key: key);

  @override
  State<AddContactsView> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContactsView> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).viewPadding.bottom;

    return GetBuilder<CustomerListController>(
      init: CustomerListController(),
      builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top bar ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 40,
                          height: 40,
                          // decoration: BoxDecoration(
                          //   color: whiteBoxColor,
                          //   borderRadius: BorderRadius.circular(12),
                          //   border: Border.all(color: newBorderColor),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.black.withValues(alpha: 0.06),
                          //       blurRadius: 8,
                          //       offset: const Offset(0, 2),
                          //     ),
                          //   ],
                          // ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            color: newTextPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Add Contact',
                        style: TextStyle(
                          color: newTextPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Form ─────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, bottom + 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fieldLabel('Contact Person'),
                        const SizedBox(height: 8),
                        _inputField(
                          controller: controller.contactPersonController,
                          focusNode: controller.contactPersonFocus,
                          hint: 'Enter contact person name',
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.person_outline_rounded,
                        ),

                        const SizedBox(height: 18),
                        _fieldLabel('WhatsApp Number'),
                        const SizedBox(height: 8),
                        _inputField(
                          controller: controller.whatsAppNumberController,
                          focusNode: controller.whatsAppNumberFocus,
                          hint: 'Enter WhatsApp number',
                          keyboardType: TextInputType.number,
                          prefixIcon: Icons.chat_outlined,
                        ),

                        const SizedBox(height: 18),
                        _fieldLabel('Email'),
                        const SizedBox(height: 8),
                        _inputField(
                          controller: controller.emailController,
                          focusNode: controller.emailFocus,
                          hint: 'Enter email address',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 18),
                        _fieldLabel('Designation'),
                        const SizedBox(height: 8),
                        _designationDropdown(controller),

                        const SizedBox(height: 18),
                        _fieldLabel('Date of Birth'),
                        const SizedBox(height: 8),
                        _dateCard(
                          child: AppDateWidgetNew(
                            value: controller.selectDateOfBirth,
                            onSelectDate: controller.setSelectedDate,
                          ),
                        ),

                        const SizedBox(height: 18),
                        _fieldLabel('Associate Date'),
                        const SizedBox(height: 8),
                        _dateCard(
                          child: AppDateWidgetNew(
                            value: controller.selectAssociateDate,
                            onSelectDate: controller.setSelectedAssociateDate,
                          ),
                        ),

                        const SizedBox(height: 18),
                        _fieldLabel('Commission %'),
                        const SizedBox(height: 8),
                        _inputField(
                          controller: controller.comissionController,
                          focusNode: controller.comissionFocus,
                          hint: 'Enter commission percentage',
                          keyboardType: TextInputType.number,
                          prefixIcon: Icons.percent_rounded,
                        ),

                        const SizedBox(height: 36),

                        // Submit button
                        GestureDetector(
                          onTap: () {
                            if (controller.contactPersonController.text.isEmpty) {
                              ShowMessage.showSnackBar(
                                AppString.requiredFieldTxt.tr,
                                AppString.pleaseEnterContactPerson.tr,
                              );
                            } else if (controller.selectDesignation == null) {
                              ShowMessage.showSnackBar('', 'Please select a designation');
                            } else {
                              controller.getAddContactsDetails(widget.partyId.toString());
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: purpleColor,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: purpleColor.withValues(alpha: 0.35),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: safeBottom + 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: newTextPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required TextInputType keyboardType,
    required IconData prefixIcon,
    int? maxLength,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: whiteBoxColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        obscureText: obscure,
        maxLength: maxLength,
        style: const TextStyle(
          color: newTextPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: newTextHint, fontSize: 15),
          counterText: '',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: Icon(prefixIcon, color: newTextHint, size: 20),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          suffixIcon: suffix,
        ),
      ),
    );
  }

  Widget _designationDropdown(CustomerListController controller) {
    return Container(
      decoration: BoxDecoration(
        color: whiteBoxColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          buttonHeight: 52,
          buttonWidth: double.infinity,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.transparent,
          ),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: whiteBoxColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          dropdownMaxHeight: 220,
          isExpanded: true,
          hint: Row(
            children: [
              Icon(Icons.badge_outlined, color: newTextHint, size: 20),
              const SizedBox(width: 10),
              const Text(
                'Select designation',
                style: TextStyle(color: newTextHint, fontSize: 15),
              ),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: newTextHint),
          value: controller.selectDesignation?.designnationid,
          items: controller.designationList.map((item) {
            return DropdownMenuItem(
              value: item.designnationid,
              child: Text(
                item.designnation.toString(),
                style: const TextStyle(
                  color: newTextPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) => controller.onChangedDesignationValue(
            controller.designationList
                .firstWhere((e) => e.designnationid == newValue),
          ),
        ),
      ),
    );
  }

  Widget _dateCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: whiteBoxColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: child,
    );
  }
}