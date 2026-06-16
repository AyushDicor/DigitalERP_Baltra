import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_constant_new.dart';
import 'issue_item_contoller/issue_item_contoller.dart';
import 'issue_item_screens/issue_item_review_screen.dart';
import 'issue_item_screens/issue_item_source_screen.dart';
import 'issue_item_screens/issue_items_screen.dart';

class IssueItemEntryView extends StatelessWidget {
  const IssueItemEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IssueItemEntryController>(
      init: IssueItemEntryController(),
      builder: (ctrl) => Scaffold(
        backgroundColor: newSurfaceColor,
        appBar: _buildAppBar(ctrl),
        body: Column(children: [
          _StepIndicator(currentStep: ctrl.currentStep),
          Expanded(
            child: PageView(
              controller: ctrl.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                IssueItemSourceScreen(),
                IssueItemItemsScreen(),
                IssueItemReviewScreen(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(IssueItemEntryController ctrl) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: newTextPrimary),
        onPressed: () {
          if (ctrl.currentStep > 0) {
            ctrl.prevStep();
          } else {
            Get.back();
          }
        },
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          ctrl.isEditMode ? 'Edit Issue Item' : 'New Issue Item',
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: newTextPrimary),
        ),
        Text(
          ['Header Details', 'Add Items', 'Review & Submit'][ctrl.currentStep],
          style: const TextStyle(fontSize: 11, color: newTextSecondary),
        ),
      ]),
    );
  }
}

// ── Step indicator ─────────────────────────────────────────────────────────────
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    const steps = ['Header', 'Items', 'Review'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            final stepIndex = i ~/ 2;
            final isDone = currentStep > stepIndex;
            return Expanded(
              child: Container(
                height: 2,
                color: isDone ? newBlueColor : newBorderColor,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isDone    = currentStep > stepIndex;
          final isActive  = currentStep == stepIndex;
          return Column(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28, height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone
                    ? newBlueColor
                    : isActive
                    ? newBlueLightColor
                    : newSurfaceColor,
                border: Border.all(
                  color: isActive || isDone ? newBlueColor : newBorderColor,
                  width: isActive ? 2 : 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: isDone
                  ? const Icon(Icons.check_rounded,
                  size: 14, color: Colors.white)
                  : Text('${stepIndex + 1}',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color:
                      isActive ? newBlueColor : newTextSecondary)),
            ),
            const SizedBox(height: 4),
            Text(steps[stepIndex],
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: isActive
                        ? FontWeight.w800
                        : FontWeight.w500,
                    color:
                    isActive ? newBlueColor : newTextSecondary)),
          ]);
        }),
      ),
    );
  }
}