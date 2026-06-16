import 'package:digitalerp/orderfollowup/orderFollowupController/order_followup_controller.dart';
import 'package:digitalerp/orderfollowup/order_followup_details_response.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//  Design tokens
const Color _kBg = backgroundColor;
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
    child: Row(children: [
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
    ]),
  );
}

Widget _styledDropdown({required Widget child}) => Container(
      decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kBorder)),
      child: child,
    );

Widget _sectionLabel(String label) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: _kTextPrimary)),
    );

class OrderFollowupFilterScreen extends StatelessWidget {
  const OrderFollowupFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderFollowupController>(
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(children: [
            _appBar('Filter'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('Party'),
                      _styledDropdown(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonHeight: 50,
                            buttonPadding:
                                const EdgeInsets.symmetric(horizontal: 14),
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: _kWhite),
                            dropdownMaxHeight: 200,
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.transparent),
                            isExpanded: true,
                            hint: const Text('Select Party',
                                style:
                                    TextStyle(fontSize: 14, color: _kTextHint)),
                            value: controller.selectParty?.partyid,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: _kTextSub, size: 22),
                            items: controller.partyList.map((items) {
                              return DropdownMenuItem(
                                value: items.partyid,
                                child: Text(items.partyname.toString(),
                                    style: const TextStyle(
                                        fontSize: 14, color: _kTextPrimary)),
                              );
                            }).toList(),
                            onChanged: (newValue) =>
                                controller.selectPartyValue(controller.partyList
                                    .firstWhere((e) => e.partyid == newValue)),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),

            // Bottom buttons
            Container(
              color: _kWhite,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _kBlue,
                      side: const BorderSide(color: _kBorder, width: 1.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.selectParty == null ||
                          (controller.selectParty!.partyname?.isEmpty ??
                              true)) {
                        ShowMessage.showSnackBar('', 'Please Select Party');
                      } else {
                        controller.getOrderFollowupListResponse();
                        Get.back();
                      }
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
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
