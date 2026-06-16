import 'package:digitalerp/paymenfollow%20up/paymentfollowup%20controller/payment_followup_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentFollowupFilterScreen extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (PaymentFollowupController controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.white,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
                          onPressed: () => Get.back(),
                        ),
                        const Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Party Label + Dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Party',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _partyDropDown(controller),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Cancel & Apply Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        // Cancel Button
                        Expanded(
                          flex: 2,
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: purpleColor, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: purpleColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Apply Button
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.selectParty == null ||
                                  controller.selectParty!.partyname!.isEmpty) {
                                ShowMessage.showSnackBar('', 'Please Select Party');
                              } else {
                                controller.getPaymentFollowupListApi();
                                Get.back();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: purpleColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
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
      },
    );
  }

  Widget _partyDropDown(PaymentFollowupController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonHeight: 56,
        buttonWidth: double.infinity,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        dropdownMaxHeight: 220,
        isExpanded: true,
        hint: const Text(
          "Select Party",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey, size: 24),
        value: controller.selectParty?.partyid,
        items: controller.partyList.map((items) {
          return DropdownMenuItem(
            value: items.partyid,
            child: Text(
              items.partyname.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          );
        }).toList(),
        onChanged: (newValue) => controller.selectPartyValue(
          controller.partyList.firstWhere((element) => element.partyid == newValue),
        ),
      ),
    );
  }
}