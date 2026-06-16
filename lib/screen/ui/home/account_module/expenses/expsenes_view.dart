import 'dart:io';
import 'package:digitalerp/response/collection_customer_list_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/account_module/expenses/expenses_controller.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_constant_new.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesController>(
      init: ExpensesController(),
      builder: (ctrl) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              MyAppBar(title: 'Add Expense', onBackTap: () => ctrl.backTap()),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fieldLabel('Claim Date'),
                        _dateField(context, ctrl),
                        const SizedBox(height: 16),
                        _fieldLabel('Reimbursement Type'),
                        _dropdownField(_executiveHeadItems(ctrl),
                            ctrl.selectedExecutiveHead?.partyname, (v) {
                          ctrl.setExecutiveHeadValue(ctrl.executiveHeadList
                              .firstWhere((e) => e.partyname == v,
                                  orElse: () => ctrl.executiveHeadList.first));
                        }, 'Select reimbursement'),
                        const SizedBox(height: 16),
                        _fieldLabel('Site Name'),
                        _dropdownField([], null, (_) {}, 'Enter site name'),
                        const SizedBox(height: 16),
                        _fieldLabel('Description'),
                        _multilineField(ctrl.remarkController, ctrl.remarkFocus,
                            'Description',
                            minLines: 4),
                        const SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                _fieldLabel('Amount(Rs)'),
                                _singleLineField(ctrl.amountController,
                                    ctrl.amountFocus, 'Enter Amount',
                                    keyboard: TextInputType.number),
                              ])),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                _fieldLabel('Bill No.'),
                                _singleLineField(null, null, '121',
                                    keyboard: TextInputType.number),
                              ])),
                        ]),
                        const SizedBox(height: 16),
                        _fieldLabel('Reference File'),
                        _fileUploadBox(ctrl, isReference: true),
                        const SizedBox(height: 16),
                        _fieldLabel('Receipt File'),
                        _fileUploadBox(ctrl, isReference: false),
                        const SizedBox(height: 32),
                        _submitBtn(ctrl),
                        const SizedBox(height: 24),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _executiveHeadItems(ExpensesController ctrl) =>
      ctrl.executiveHeadList.map((e) => e.partyname ?? '').toList();

  Widget _fieldLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: newTextPrimary)),
      );

  Widget _dateField(BuildContext ctx, ExpensesController ctrl) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: ctx,
          initialDate: DateTime.now(),
          firstDate: AppConst.calenderFirstDate,
          lastDate: AppConst.calenderLastDate,
          builder: (c, child) => Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(primary: newBlueColor)),
            child: child!,
          ),
        );
        if (picked != null)
          ctrl.setSelectedDate(DateFormat(AppString.ddMMyyyy).format(picked));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(18),
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
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(ctrl.selectDate,
              style: const TextStyle(fontSize: 14, color: newTextPrimary)),
          const Icon(Icons.calendar_today_outlined,
              size: 18, color: newTextSecondary),
        ]),
      ),
    );
  }

  Widget _dropdownField(List<String> items, String? value,
      ValueChanged<String?> onChange, String hint) {
    return Container(
      decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(18),
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
        ],),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint,
              style: const TextStyle(color: newTextHint, fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: newTextSecondary),
          style: const TextStyle(fontSize: 14, color: newTextPrimary),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(18),
          items: items
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: onChange,
        ),
      ),
    );
  }

  Widget _singleLineField(
      TextEditingController? ctrl, FocusNode? focus, String hint,
      {TextInputType keyboard = TextInputType.text}) {
    return TextFormField(
      controller: ctrl,
      focusNode: focus,
      keyboardType: keyboard,
      style: const TextStyle(fontSize: 14, color: newTextPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: newTextHint, fontSize: 14),
        filled: true,
        fillColor: newSurfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBorderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
      ),
    );
  }

  Widget _multilineField(
      TextEditingController? ctrl, FocusNode? focus, String hint,
      {int minLines = 1}) {
    return TextFormField(
      controller: ctrl,
      focusNode: focus,
      minLines: minLines,
      maxLines: minLines + 2,
      style: const TextStyle(fontSize: 14, color: newTextPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: newTextHint, fontSize: 14),
        filled: true,
        fillColor: newSurfaceColor,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBorderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
      ),
    );
  }

  Widget _fileUploadBox(ExpensesController ctrl, {required bool isReference}) {
    final hasImage = !isReference && ctrl.selectedImage.value.isNotEmpty;
    return GestureDetector(
      onTap: () => _showImageDialog(ctrl),
      child: Container(
        padding: const EdgeInsets.all(60),
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(18),
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
        clipBehavior: Clip.antiAlias,
        child: hasImage
            ? Image.file(File(ctrl.selectedImage.value),
                fit: BoxFit.cover, height: 120, width: double.infinity)
            : Column(children: [
                Icon(Icons.cloud_upload_outlined,
                    size: 36, color: Colors.grey.shade400),
                const SizedBox(height: 8),
                RichText(
                    text: const TextSpan(
                  text: 'Drag & drop files or ',
                  style: TextStyle(fontSize: 13, color: newTextSecondary),
                  children: [
                    TextSpan(
                        text: 'Browse',
                        style: TextStyle(
                            color: newBlueColor, fontWeight: FontWeight.w700))
                  ],
                )),
                const SizedBox(height: 4),
                const Text('Supported formats: EXCEL, PDF, JPG, JPEG, PNG',
                    style: TextStyle(fontSize: 11, color: newTextHint)),
              ]),
      ),
    );
  }

  Widget _submitBtn(ExpensesController ctrl) => SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () => ctrl.tapOnSubmit(),
          style: ElevatedButton.styleFrom(
              backgroundColor: newBlueColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          child: const Text('Submit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      );

  void _showImageDialog(ExpensesController ctrl) {
    Get.defaultDialog(
      title: 'Choose Option',
      radius: 12,
      content: Column(children: [
        _dialogOption(
            'Select from Gallery', () => ctrl.getImage(ImageSource.gallery)),
        const SizedBox(height: 12),
        _dialogOption('Take a Photo', () => ctrl.getImage(ImageSource.camera)),
      ]),
    );
  }

  Widget _dialogOption(String label, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: newBlueLightColor, borderRadius: BorderRadius.circular(8)),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: newBlueColor)),
        ),
      );
}
