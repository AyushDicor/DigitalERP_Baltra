// ─────────────────────────────────────────────────────────────────────────────
// indent_entry_view.dart
// Host widget for the multi-step indent create/edit flow.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'indent_controller/indent_controller.dart';
import 'indent_screens/indent_header_screen.dart';
import 'indent_screens/indent_items_screen.dart';
import 'indent_screens/indent_review_screen.dart';
import 'indent_widgets.dart';

class IndentEntryView extends StatelessWidget {
  const IndentEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentController>(
      init: IndentController(),
      id: 'indentEntry',
      builder: (ctrl) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          if (ctrl.currentStep > 0) {
            ctrl.prevStep();
          } else {
            Get.back();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Column(children: [
              _appBar(ctrl),
              IndentStepBar(current: ctrl.currentStep),
              const Divider(height: 1, color: indBorderColor),
              Expanded(
                child: PageView(
                  controller: ctrl.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    IndentHeaderScreen(),
                    IndentItemsScreen(),
                    IndentReviewScreen(),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _appBar(IndentController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Row(children: [
        GestureDetector(
          onTap: () {
            if (ctrl.currentStep > 0) {
              ctrl.prevStep();
            } else {
              Get.back();
            }
          },
          child: Container(
            width: 38,
            height: 38,
            // decoration: BoxDecoration(
            //     color: indSurfaceColor,
            //     borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: indTextPrimary),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              ctrl.isEditMode ? 'Edit Indent' : 'New Indent',
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: indTextPrimary),
            ),
            Text(ctrl.indentNumber,
                style: const TextStyle(
                    fontSize: 11,
                    color: indTextSecondary,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
      ]),
    );
  }
}
