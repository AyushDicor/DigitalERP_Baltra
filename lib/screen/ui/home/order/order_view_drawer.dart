
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/order_filter/order_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/custom_clipper.dart';
import 'package:digitalerp/utils/dottedline.dart';
import 'package:digitalerp/utils/gradient_icon_app_button.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fab/menu_fab.dart';
import '../drawer/drawer_view.dart';

class OrderViewDrawer extends StatelessWidget {
  const OrderViewDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: newSurfaceColor,
          resizeToAvoidBottomInset: false,

          /// ✅ FIXED FAB (perfect spacing)
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 70,
            ),
            child: GradientIconButton(
              onPressed: () => controller.tapOnAdd(),
              radius: 10,
              vPadding: 16,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: MenuFabBody(
            parentMenuId: 2378, // e.g. 2409 or whatever showed in debug
            bottomPadding: 90, // match your GradientIconButton's bottom offset
            child: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: MyAppBar(
                    title: 'Order',
                    onDrawerTap: () => controller.openDrawer(context),
                    onFilterTap: () => Get.dialog(const OrderFilterDialogBox()),
                    showCartIcon: true,
                    onCartTap: () => controller.onCartTap(),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: controller.isBusy
                        ? SizedBox(
                      height: Get.height * .4,
                      child: showLoader(),
                    )
                        : Column(
                      children: [
                        if (controller.isManager) _managerView(controller),
                        _segmentButton(controller),
                        controller.isListLoading
                            ? SizedBox(
                          height: Get.height * .4,
                          child: showLoader(),
                        )
                            : controller.executiveOrderList?.isEmpty ?? true
                            ? _emptyState()
                            : ListView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .executiveOrderList?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return orderCard(controller, index);
                          },
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= EMPTY STATE =================

  Widget _emptyState() {
    return SizedBox(
      height: Get.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.receipt_long_outlined, size: 60, color: newTextHint),
          SizedBox(height: 10),
          Text(
            "No Orders Found",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: newTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ================= ORDER CARD =================

  Widget orderCard(OrderController controller, int index) {
    var item = controller.executiveOrderList?[index];

    Color statusColor = controller.selectedSegmentVal == 0
        ? newOrangeColor
        : controller.selectedSegmentVal == 1
        ? newGreenColor
        : newRedColor;

    return InkWell(
      onTap: () => controller.tapOnCard(item!.orderid.toString()),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
        ),
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Text(
                  item?.orderno ?? 'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _txt("Order Date", item?.orderdate)),
                      Expanded(
                          child: _txt("Executive", item?.executivename,
                              isRight: true)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _txt("Party", item?.partyname)),
                      Expanded(
                          child: _txt("₹ Amount", item?.amount.toString(),
                              isRight: true)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= DROPDOWN =================

  Widget _managerView(OrderController controller) {
    return Column(
      children: [
        const SizedBox(height: 16),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            buttonHeight: 44,
            buttonDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: newBorderColor),
            ),
            isExpanded: true,
            hint: const Text("Select Executive"),
            value: controller.selectedExecutiveDropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: controller.executiveList.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items.executiveName.toString()),
              );
            }).toList(),
            onChanged: controller.setSelectedExecutiveNameDropdownValue,
          ),
        ),
      ],
    );
  }

  // ================= SEGMENT =================

  Widget _segmentButton(OrderController controller) {
    final titles = ["Pending", "Approved", "Rejected"];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: newBorderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(3, (index) {
          final isSelected = controller.selectedSegmentVal == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setSegmentValue(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  titles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? newBlueColor : newTextSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ================= TEXT =================

  Widget _txt(String title, String? value, {bool isRight = false}) {
    return Column(
      crossAxisAlignment:
      isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: newTextSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value ?? 'N/A',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: newTextPrimary,
          ),
        ),
      ],
    );
  }
}
