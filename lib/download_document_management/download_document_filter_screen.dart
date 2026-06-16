import 'package:digitalerp/download_document_management/dawnload_documents_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//  Shared design tokens 
const Color _kBg = Color(0xFFF5F6FA);
const Color _kWhite = Colors.white;
const Color _kBlue = purpleColor;
const Color _kBlueBg = Color(0xFFEEF1FF);
const Color _kBorder = Color(0xFFE2E8F0);
const Color _kTextPrimary = Color(0xFF0F172A);
const Color _kTextSub = Color(0xFF64748B);
const Color _kTextHint = Color(0xFF94A3B8);

//  Shared helpers 
Widget _appBar(String title, {VoidCallback? onFilter}) {
  return Container(
    color: _kWhite,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new, color: _kTextPrimary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _kTextPrimary)),
        ),
        if (onFilter != null)
          GestureDetector(
            onTap: onFilter,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: _kBlueBg, borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.filter_list_sharp, color: _kBlue, size: 20),
            ),
          ),
      ],
    ),
  );
}

Widget _styledDropdown({required Widget child}) => Container(
      decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kBorder)),
      child: child,
    );

Widget _sectionLabel(String label) => Text(label,
    style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: _kTextPrimary));

class DownloadDocumentFilterScreen extends StatelessWidget {
  const DownloadDocumentFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloadDocumentController>(
      init: DownloadDocumentController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(
            children: [
              _appBar('Filter'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('Date Range'),
                      const SizedBox(height: 8),
                      _dateRow(controller, context),
                      const SizedBox(height: 16),
                      _sectionLabel('Document Type'),
                      const SizedBox(height: 8),
                      _styledDropdown(child: _documentTypeDropdown(controller)),
                    ],
                  ),
                ),
              ),
// Bottom buttons
              Container(
                color: _kWhite,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _kBlue,
                          side: const BorderSide(color: _kBlue, width: 1.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Reset',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.getDownloadDocumentListApi();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kBlue,
                          foregroundColor: _kWhite,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Apply',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _documentTypeDropdown(DownloadDocumentController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: _kWhite),
        dropdownMaxHeight: 200,
        buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.transparent),
        isExpanded: true,
        hint: const Text('Document Type',
            style: TextStyle(fontSize: 14, color: _kTextHint)),
        value: controller.selectDocument?.did,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: _kTextSub, size: 22),
        items: controller.downloadDocumentData.map((items) {
          return DropdownMenuItem(
            value: items.did,
            child: Text(items.documentname.toString(),
                style: const TextStyle(fontSize: 14, color: _kTextPrimary)),
          );
        }).toList(),
        onChanged: (newValue) => controller.setSelectDocumentTypeDropdown(
            controller.downloadDocumentData
                .firstWhere((e) => e.did == newValue)),
      ),
    );
  }

  Widget _dateRow(DownloadDocumentController controller, BuildContext context) {
    return Row(
      children: [
        Expanded(child: _datePicker(controller, context, isFirst: true)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('to', style: TextStyle(fontSize: 14, color: _kTextSub)),
        ),
        Expanded(child: _datePicker(controller, context, isFirst: false)),
      ],
    );
  }

  Widget _datePicker(
      DownloadDocumentController controller, BuildContext context,
      {required bool isFirst}) {
    final int currentYear = int.parse(
        controller.homeController.currentUserData?.yearId?.split('-').first ??
            '2024');
    final String date =
        isFirst ? controller.firstDownloadDate : controller.lastDownloadDate;
    final DateTime initDate = date != AppString.dateTimeEmpty
        ? DateTime.parse(
            formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: DateTime(currentYear),
          lastDate: DateTime.now(),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: _kBlue, onPrimary: Colors.white),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          final fmt = DateFormat(AppString.ddMMyyyy).format(picked);
          controller.setDownloadDate(fmt, isFirst);
          controller.setDateByDownloadDate(picked, isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _kBorder)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                date == AppString.dateTimeEmpty
                    ? 'DD/MM/YYYY'
                    : DateFormat(AppString.ddMMyyyy).format(initDate),
                style: TextStyle(
                    fontSize: 13,
                    color: date == AppString.dateTimeEmpty
                        ? _kTextHint
                        : _kTextPrimary),
              ),
            ),
            const Icon(Icons.calendar_today_outlined,
                size: 15, color: _kTextSub),
          ],
        ),
      ),
    );
  }
}
