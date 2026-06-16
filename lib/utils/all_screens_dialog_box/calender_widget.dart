import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalenderWidget extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final double? width;
  final String value;
  final VoidCallback onTap;

  CalenderWidget({
    Key? key,
    required this.value,
    required this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        int currentYear = int.parse('${homeController.currentUserData?.yearId?.split('-').first}');
        DateTime initDate = value != AppString.dateTimeEmpty
            ? DateTime.parse(formatDate(value, AppString.ddMMyyyy, AppString.yyyyMMdd))
            : DateTime.now();
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
          lastDate: AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
          // onDateSelect(formattedDate);
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
            width: width ?? Get.width * .31,
            child: const Divider(
              color: purpleColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
