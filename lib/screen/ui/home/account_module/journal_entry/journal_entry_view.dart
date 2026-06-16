// import 'package:digitalerp/response/collection_customer_list_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
// import 'package:digitalerp/screen/ui/home/account_module/journal_entry/journal_entry_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_bottom_button.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class JournalEntryView extends StatelessWidget {
//   const JournalEntryView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<JournalEntryController>(
//       init: JournalEntryController(),
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
//                       image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                   child: SafeArea(child: MyAppBar(title: 'Journal Entry', onBackTap: () => controller.backTap())),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.only(
//                       bottom: (MediaQuery.of(context).viewInsets.bottom > 0) ? 200 : 0, left: 20, right: 20),
//                   child: Column(
//                     children: [
//                       SizedBox(height: Get.height * 0.02),
//                       _dateView(context, controller.selectDate, controller),
//                       const SizedBox(height: 20),
//                       _debitDropdown(controller),
//                       const SizedBox(height: 20),
//                       _creditDropdown(controller),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         maxLength: 6,
//                         style: const TextStyle().light,
//                         keyboardType: TextInputType.number,
//                         textInputAction: TextInputAction.next,
//                         controller: controller.amountController,
//                         focusNode: controller.amountFocus,
//                         decoration: const InputDecoration().txtFieldStyle2(
//                           hintText: 'Enter amount',
//                           labelName: 'Amount',
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       TextFormField(
//                         style: const TextStyle().light,
//                         minLines: 4,
//                         maxLines: 6,
//                         keyboardType: TextInputType.text,
//                         textInputAction: TextInputAction.next,
//                         controller: controller.remarkController,
//                         focusNode: controller.remarkFocus,
//                         decoration: const InputDecoration().txtFieldStyle2(
//                           hintText: ' Type...',
//                           labelName: '  Remark',
//                         ),
//                       ),
//                       const SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 80,
//                 right: 20,
//                 child: GradientIconButton(
//                   icon: AppAssets.accountsModuleIcon,
//                   onPressed: () {},
//                   iconSize: 28,
//                   radius: 15,
//                   vPadding: 16,
//                   hPadding: 16,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AppBottomButton(
//                   onPressed: () {
//                     controller.tapOnSubmit();
//                   },
//                   name: 'Submit',
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: MenuFab(parentMenuId: 2382),
//       ),
//     );
//   }
//
//   Widget _debitDropdown(JournalEntryController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<CustomerData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedCreditAccount,
//         hint: Text(
//           'Debit Account',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.debitAccountList.map((items) {
//           return DropdownMenuItem<CustomerData>(
//             value: items,
//             child: Text(items.partyname ?? ''),
//           );
//         }).toList(),
//         dropdownMaxHeight: Get.height * .3,
//         onChanged: (newValue) {
//           controller.setCreditAccount(newValue);
//         },
//       ),
//     );
//   }
//
//   Widget _creditDropdown(JournalEntryController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<CustomerData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: orangeDropdownGr(0.15),
//         ),
//         isExpanded: true,
//         value: controller.selectedDebitAccount,
//         hint: Text(
//           'Credit Account',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.creditAccountList.map((items) {
//           return DropdownMenuItem<CustomerData>(
//             value: items,
//             child: Text(items.partyname ?? ''),
//           );
//         }).toList(),
//         dropdownMaxHeight: Get.height * .3,
//         onChanged: (newValue) {
//           controller.setDebitAccount(newValue);
//         },
//       ),
//     );
//   }
//
//   Widget _dateView(BuildContext context, String value, JournalEntryController ctrl) {
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: AppConst.calenderFirstDate ?? DateTime(DateTime.now().year, 1, 1),
//             //DateTime.now() - not to allow to choose before today.
//             lastDate: AppConst.calenderLastDate ?? DateTime(DateTime.now().year, 12, 31));
//
//         if (pickedDate != null) {
//           String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           ctrl.setSelectedDate(formattedDate);
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
//           Text(
//             'Date',
//             style: const TextStyle().bold.copyWith(color: red2Color, fontSize: 12),
//           ),
//           const SizedBox(height: 5),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(value, style: const TextStyle().normal),
//               const SizedBox(width: 10),
//               Image.asset(
//                 AppAssets.calendarIcon,
//                 width: 18,
//                 height: 18,
//               )
//             ],
//           ),
//           const SizedBox(height: 5),
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

import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/account_module/journal_entry/journal_entry_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/gradient_icon_app_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final Color _kBg = purpleLightest;
const Color _kWhite = Colors.white;
const Color _kBorder = Color(0xFFE4E7EF);
const Color _kText = newTextPrimary;
const Color _kSub = newTextSecondary;

class JournalEntryView extends StatelessWidget {
  const JournalEntryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JournalEntryController>(
      init: JournalEntryController(),
      builder: (controller) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: _buildAppBar('Journal Entry'),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom:
                      MediaQuery.of(context).viewInsets.bottom > 0 ? 200 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _card(children: [
                      _label('Date'),
                      _dateField(context, controller.selectDate, controller),
                    ]),
                    const SizedBox(height: 16),
                    _card(children: [
                      _label('Debit Account'),
                      _dropdownWrap(_debitDropdown(controller)),
                      const SizedBox(height: 14),
                      _label('Credit Account'),
                      _dropdownWrap(_creditDropdown(controller)),
                    ]),
                    const SizedBox(height: 16),
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
                      const SizedBox(height: 14),
                      _label('Remark'),
                      _textField(
                        controller: controller.remarkController,
                        focusNode: controller.remarkFocus,
                        hint: 'Type remark...',
                        minLines: 3,
                        maxLines: 5,
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

  Widget _debitDropdown(JournalEntryController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<CustomerData>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent),
          isExpanded: true,
          value: controller.selectedCreditAccount,
          hint: const Text('Debit Account',
              style: TextStyle(fontSize: 14, color: _kSub)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          dropdownMaxHeight: Get.height * .3,
          items: controller.debitAccountList.map((items) {
            return DropdownMenuItem<CustomerData>(
              value: items,
              child: Text(items.partyname ?? '',
                  style: const TextStyle(fontSize: 14, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setCreditAccount,
        ),
      );

  Widget _creditDropdown(JournalEntryController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<CustomerData>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent),
          isExpanded: true,
          value: controller.selectedDebitAccount,
          hint: const Text('Credit Account',
              style: TextStyle(fontSize: 14, color: _kSub)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          dropdownMaxHeight: Get.height * .3,
          items: controller.creditAccountList.map((items) {
            return DropdownMenuItem<CustomerData>(
              value: items,
              child: Text(items.partyname ?? '',
                  style: const TextStyle(fontSize: 14, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setDebitAccount,
        ),
      );

  Widget _dateField(
      BuildContext context, String value, JournalEntryController ctrl) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate:
              AppConst.calenderFirstDate ?? DateTime(DateTime.now().year, 1, 1),
          lastDate: AppConst.calenderLastDate ??
              DateTime(DateTime.now().year, 12, 31),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
                colorScheme: const ColorScheme.light(
                    primary: purpleColor, onPrimary: Colors.white)),
            child: child!,
          ),
        );
        if (pickedDate != null) {
          ctrl.setSelectedDate(
              DateFormat(AppString.ddMMyyyy).format(pickedDate));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder),
        ),
        child: Row(children: [
          Expanded(
              child: Text(value,
                  style: const TextStyle(fontSize: 14, color: _kText))),
          const Icon(Icons.calendar_today_outlined, size: 16, color: _kSub),
        ]),
      ),
    );
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
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
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
            borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5)),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Submit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ),
    );
