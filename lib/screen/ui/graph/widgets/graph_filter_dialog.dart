import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/graph/graph_filter_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/dialog_bg_widget.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/dialog_button.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/order_filter/order_filter_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class GraphFilterDialogBox extends StatelessWidget {
  const GraphFilterDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GraphFilterController>(
      // init: GraphFilterController(),
      builder: (controller) {
        print("FIRS :==> ${controller.firstDate}");
        ///mew way
        return DialogBgWidget(
          onApplyOrDoneButtonTap: () => controller.onApplyFilter(),
          children: [
            _dateColumn(controller, context),
            Visibility(
              visible: !(controller.homeController.isCustomer ?? true),
              child: _executiveDropdown(controller),
            ),
          ],
        );

        /// oldWay
        /*
        return Dialog(
        child: _contentBox(context, controller),
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
      );

         */
      },
    );
  }


  Widget _dateColumn(GraphFilterController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          'Date',
          style: const TextStyle().bold.copyWith(
            fontSize: 10,
            color: red2Color,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _dateView(controller.firstDate, Get.width * .34, true, controller, context),
            _dateView(controller.lastDate, Get.width * .34, false, controller, context),
          ],
        ),
      ],
    );
  }

  Widget _dateView(String value, double width, bool isFirst, GraphFilterController controller, BuildContext context) {
    int currentYear = int.parse('${controller.homeController.currentUserData?.yearId?.split('-').first}');
    String date = isFirst ? controller.firstDate : controller.lastDate;
    DateTime initDate = date != AppString.dateTimeEmpty
        ? DateTime.parse(formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
          lastDate: AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
          if (isFirst) {
            controller.setDate(formattedDate, true);
          } else {
            controller.setDate(formattedDate, false);
          }
        } else {
          if (kDebugMode) {
            print('Date is not selected');
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value, style: const TextStyle().medium),
                const SizedBox(width: 10),
                Image.asset(
                  AppAssets.calendarIcon,
                  width: 18,
                  height: 18,
                )
              ],
            ),
          ),
          SizedBox(
            width: Get.width * .31,
            child: const Divider(
              color: purpleColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _executiveDropdown(GraphFilterController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 25),
        DropdownButtonHideUnderline(
          child: DropdownButton2<ExecutiveDropdownData>(
            buttonHeight: 40,
            buttonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: dropdownBoxColor,
            ),
            dropdownMaxHeight: 200,
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: dropdownBoxColor,
              gradient: LinearGradient(
                colors: [grBottomColor.withValues(alpha:0.2), grTopColor.withValues(alpha:0.2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            isExpanded: true,
            hint: Text(
              AppString.selectExecutiveName,
              style:
              const TextStyle().normal.copyWith(fontSize: 11, fontWeight: FontWeight.normal, color: msgTextColor),
              overflow: TextOverflow.ellipsis,
            ),
            value: controller.graphController.selectedExecutiveDropdownValue,
            icon: Image.asset(
              AppAssets.dropdownIcon,
              width: 15,
              height: 15,
            ),
            items: controller.graphController.executiveList.map((items) {
              return DropdownMenuItem<ExecutiveDropdownData>(
                value: items,
                child: Text(
                  items.executiveName ?? '',
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              controller.graphController.setSelectedExecutiveNameDropdownValue(newValue);
              controller.update();
            },
          ),
        ),
      ],
    );
  }
}
