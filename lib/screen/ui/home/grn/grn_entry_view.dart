
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'grn_controller/grn_controller.dart';
import 'grn_screens/grn_items_screen.dart';
import 'grn_screens/grn_review_screen.dart';
import 'grn_screens/grn_source_screen.dart';
import 'grn_widgets.dart';

class GrnEntryView extends StatelessWidget {
  const GrnEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GrnController>(
      init: GrnController(),
      builder: (ctrl) => PopScope(
        canPop: false, // ✅ intercept phone back button
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          if (ctrl.currentStep > 0) {
            ctrl.prevStep(); // ✅ go to previous step
          } else {
            Get.back(); // ✅ exit Grn entry
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _appBar(ctrl),
                GrnStepBar(current: ctrl.currentStep),
                const Divider(height: 1, color: newBorderColor),
                Expanded(
                  child: PageView(
                    controller: ctrl.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      GrnSourceScreen(),
                      GrnItemsScreen(),
                      //GrnScanScreen(),
                      GrnReviewScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(GrnController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Row(children: [
        // Back / close
        GestureDetector(
          onTap: () {
            if (ctrl.currentStep > 0) {
              ctrl.prevStep();
            } else {
              Get.back();
            }
          },
          child: Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
                color: newSurfaceColor,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: newTextPrimary),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              ctrl.isEditMode ? 'Edit GRN Entry' : 'New GRN Entry',
              style: const TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w800, color: newTextPrimary),
            ),
            Text(
              ctrl.GrnNumber,
              style: const TextStyle(
                  fontSize: 11, color: newTextSecondary, fontWeight: FontWeight.w600),
            ),
          ]),
        ),
        // Print icon (visible on review step)
        if (ctrl.currentStep == 3)
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
                color: newBlueLightColor,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Icon(Icons.print_outlined,
                size: 20, color: newBlueColor),
          ),
      ]),
    );
  }
}
