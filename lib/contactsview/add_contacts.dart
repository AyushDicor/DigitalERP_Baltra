import 'package:digitalerp/contactsview/Designation_dropdown_responce.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/customer_list/customer_list_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/date_widget.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddContactsView extends StatefulWidget {
  String? partyId;
   AddContactsView({Key? key,this.partyId}) : super(key: key);

  @override
  State<AddContactsView> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContactsView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerListController>(
        init: CustomerListController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/dashboard_bg.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SafeArea(
                        child: MyAppBar(
                          title: 'Add Contacts',
                          onBackTap: () => Get.back(),
                          showApprovalIcon: false,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.150,
                    left: 0,
                    right: 0,
                    bottom:0,
                    child: Column(
                      children: [
                        _addcontactDetails(controller),
                        SizedBox(
                          height: Get.height * 0.0500,
                        ),
                        controller.customerList==[]
                        ? const CircularProgressIndicator()
                        :submitButton(controller)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _addcontactDetails(CustomerListController controller) {
    return SingleChildScrollView(
      child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            customTextFieldText(
                focusNode: controller.contactPersonFocus,
                hintText: 'Enter Contact Person',
                controller: controller.contactPersonController),
            SizedBox(
              height: Get.height * 0.0100,
            ),
            customTextFieldNumber(
                focusNode: controller.whatsAppNumberFocus,
                hintText: 'Enter WhatsApp Number',
                controller: controller.whatsAppNumberController),
            SizedBox(
              height: Get.height * 0.0100,
            ),
            customTextFieldText(
                focusNode: controller.emailFocus,
                hintText: 'Enter Email',
                controller: controller.emailController),
            SizedBox(
              height: Get.height * 0.0100,
            ),
            // DropdownButtonHideUnderline(
            //   child: DropdownButton2(
            //     buttonHeight: Get.height * 0.0600,
            //     buttonWidth: Get.width * 0.900,
            //     buttonPadding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            //     dropdownDecoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: dropdownBoxColor,
            //     ),
            //     dropdownMaxHeight: 200,
            //     buttonDecoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: dropdownBoxColor,
            //       gradient: LinearGradient(
            //         colors: [
            //           grBottomColor.withValues(alpha:0.2),
            //           grTopColor.withValues(alpha:0.2)
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //     ),
            //     isExpanded: true,
            //     hint: Text(
            //       "Designation",
            //       style: const TextStyle().newstyle.copyWith(
            //             // fontSize: 15,
            //             // fontWeight: FontWeight.bold,
            //             color: Colors.black,
            //           ),
            //       // overflow: TextOverflow.ellipsis,
            //     ),
            //     // value: controller.selectedDocument,
            //     icon: Image.asset(
            //       AppAssets.calendarIcon,
            //       width: 15,
            //       height: 15,
            //     ),
            //     items: [],
            //     // items: controller.filterDocumentData.map(
            //     //       (items) {
            //     //     return DropdownMenuItem(
            //     //       value: items,
            //     //       child: Text(
            //     //         items.documentname ?? '',
            //     //       ),
            //     //     );
            //     //   },
            //     // ).toList(),
            //     // onChanged: (newValue){
            //     //   controller.onChangedDocumentDataValue(newValue);
            //     //   controller.update();
            //     // },
            //   ),
            // ),
           // _dropdown(controller),
            _dropdown(controller),
            SizedBox(
              height: Get.height * 0.0100,
            ),
            AppDateWidgetNew(value: controller.selectDateOfBirth, onSelectDate: controller.setSelectedDate),
            // DropdownButtonHideUnderline(
            //   child: DropdownButton2(
            //     buttonHeight: Get.height * 0.0600,
            //     buttonWidth: Get.width * 0.900,
            //     buttonPadding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            //     dropdownDecoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: dropdownBoxColor,
            //     ),
            //     dropdownMaxHeight: 200,
            //     buttonDecoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: dropdownBoxColor,
            //       gradient: LinearGradient(
            //         colors: [
            //           grBottomColor.withValues(alpha:0.2),
            //           grTopColor.withValues(alpha:0.2)
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //     ),
            //     isExpanded: true,
            //     hint: Text(
            //       "Date of birth",
            //       style: const TextStyle().newstyle.copyWith(
            //             // fontSize: 15,
            //             // fontWeight: FontWeight.bold,
            //             color: Colors.black,
            //           ),
            //       // overflow: TextOverflow.ellipsis,
            //     ),
            //     // value: controller.selectedDocument,
            //     icon: Image.asset(
            //       AppAssets.calendarIcon,
            //       width: 15,
            //       height: 15,
            //     ),
            //     items: [],
            //     // items: controller.filterDocumentData.map(
            //     //       (items) {
            //     //     return DropdownMenuItem(
            //     //       value: items,
            //     //       child: Text(
            //     //         items.documentname ?? '',
            //     //       ),
            //     //     );
            //     //   },
            //     // ).toList(),
            //     // onChanged: (newValue){
            //     //   controller.onChangedDocumentDataValue(newValue);
            //     //   controller.update();
            //     // },
            //   ),
            // ),
            SizedBox(
              height: Get.height * 0.0100,
            ),
            AppDateWidgetNew(value: controller.selectAssociateDate, onSelectDate: controller.setSelectedAssociateDate),
            // DropdownButtonHideUnderline(
            //   child: DropdownButton2(
            //     buttonHeight: Get.height * 0.0600,
            //     buttonWidth: Get.width * 0.900,
            //     buttonPadding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            //     dropdownDecoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: dropdownBoxColor,
            //     ),
            //     dropdownMaxHeight: 200,
            //     buttonDecoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: dropdownBoxColor,
            //       gradient: LinearGradient(
            //         colors: [
            //           grBottomColor.withValues(alpha:0.2),
            //           grTopColor.withValues(alpha:0.2)
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //     ),
            //     isExpanded: true,
            //     hint: Text(
            //       "Associate Date",
            //       style: const TextStyle().newstyle.copyWith(
            //             // fontSize: 15,
            //             // fontWeight: FontWeight.bold,
            //             color: Colors.black,
            //           ),
            //       // overflow: TextOverflow.ellipsis,
            //     ),
            //     // value: controller.selectedDocument,
            //     icon: Image.asset(
            //       AppAssets.calendarIcon,
            //       width: 15,
            //       height: 15,
            //     ),
            //     items: [],
            //     // items: controller.filterDocumentData.map(
            //     //       (items) {
            //     //     return DropdownMenuItem(
            //     //       value: items,
            //     //       child: Text(
            //     //         items.documentname ?? '',
            //     //       ),
            //     //     );
            //     //   },
            //     // ).toList(),
            //     // onChanged: (newValue){
            //     //   controller.onChangedDocumentDataValue(newValue);
            //     //   controller.update();
            //     // },
            //   ),
            // ),
            SizedBox(
              height: Get.height * 0.0100,
            ),
            customTextFieldText(
                focusNode: controller.comissionFocus,
                hintText: 'Enter Comission %',
                controller: controller.comissionController),
          ]),
    );
  }

  Widget _dropdown(CustomerListController controller)
  {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonHeight: Get.height * 0.0600,
        buttonWidth: Get.width * 0.900,
        buttonPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: dropdownBoxColor,
        ),
        dropdownMaxHeight: 200,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dropdownBoxColor,
          gradient: LinearGradient(
            colors: [
              grBottomColor.withValues(alpha:0.2),
              grTopColor.withValues(alpha:0.2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        isExpanded: true,
        hint: Text(
          "Designation",
          style: const TextStyle().newstyle.copyWith(
            color: Colors.black,
          ),
          // overflow: TextOverflow.ellipsis,
        ),
        // value: controller.selectedDocument,
        icon: Image.asset(
          AppAssets.dropdownIcon,
          width: 15,
          height: 15,
        ),
        value:  controller.selectDesignation?.designnationid,
        items: controller.designationList.map(
              (items) {
            return DropdownMenuItem(
              value: items.designnationid,
              child: Text(
                items.designnation.toString(),
                style: TextStyle().newstyle.copyWith(color: Colors.black),
              ),
            );
          },
        ).toList(),
        onChanged:(newValue) => controller.onChangedDesignationValue(controller
            .designationList
            .firstWhere((element) => element.designnationid == newValue)),
        // items: controller.filterDocumentData.map(
        //       (items) {
        //     return DropdownMenuItem(
        //       value: items,
        //       child: Text(
        //         items.documentname ?? '',
        //       ),
        //     );
        //   },
        // ).toList(),
        // onChanged: (newValue){
        //   controller.onChangedDocumentDataValue(newValue);
        //   controller.update();
        // },
      ),
    );
  }

  Widget submitButton(CustomerListController controller, ) {
    return Container(
      height: Get.height * 0.05,
      width: Get.height * 0.120,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
      ),
      child: MaterialButton(
        onPressed: () {
          if(controller.contactPersonController.text.isEmpty){
            ShowMessage.showSnackBar(
              AppString.requiredFieldTxt.tr,
              AppString.pleaseEnterContactPerson.tr,
            );
          }
          else if(controller.selectDesignation==null){
            ShowMessage.showSnackBar("","Please Select designation");
          } else{
            controller.getAddContactsDetails(widget.partyId.toString());
          }
          print('PartyID => ${widget.partyId.toString()}');

        },
        shape: const StadiumBorder(),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Text(
              'Submit',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
