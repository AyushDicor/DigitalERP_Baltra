import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class AppDateWidget extends StatelessWidget {
  const AppDateWidget(
      {Key? key,
      required this.value,
      required this.title,
      required this.onSelectDate})
      : super(key: key);
  final String value, title;
  final void Function(String value) onSelectDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: AppConst.calenderFirstDate,
            lastDate: AppConst.calenderLastDate);

        if (pickedDate != null) {
          String formattedDate =
              DateFormat(AppString.ddMMyyyy).format(pickedDate);
          onSelectDate(formattedDate);
        } else {
          if (kDebugMode) {
            print('Date is not selected');
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle()
                      .bold
                      .copyWith(color: purpleColor, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(   // ← wrap Text in Flexible
                      child: Text(
                        value,
                        style: const TextStyle().xstyle.copyWith(fontSize: 15),
                        overflow: TextOverflow.ellipsis, // ← prevent overflow
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 6), // ← reduced from 10
                    Icon(
                      Icons.calendar_today_outlined,
                      color: purpleColor,
                      size: 18, // ← slightly smaller icon
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: purpleColor,
            thickness: 1,
            height: 2,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}

class AppDateWidgetNew extends StatelessWidget {
  const AppDateWidgetNew({
    Key? key,
    required this.value,
    required this.onSelectDate,
  }) : super(key: key);

  final String value;
  final void Function(String value) onSelectDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: AppConst.calenderFirstDate,
          lastDate: AppConst.calenderLastDate,
        );

        if (pickedDate != null) {
          String formattedDate =
          DateFormat(AppString.yyyyMMdd).format(pickedDate);
          onSelectDate(formattedDate);
        }
      },
      child: Container(
        height: 52,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withValues(alpha:0.15),
          ),
        ),
        child: Row(
          children: [
            // 📅 Icon (left)
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: grTopColor.withValues(alpha:0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image.asset(
                  AppAssets.calendarIcon,
                  width: 18,
                  height: 18,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 📄 Date Text
            Expanded(
              child: Text(
                value.isEmpty ? "Select date" : value,
                style: TextStyle().normal.copyWith(
                  fontSize: 14,
                  color: value.isEmpty
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ),

            // ➡ Arrow
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
class AppDateView extends StatelessWidget {
  const AppDateView(
      {Key? key, required this.value, required this.onSelectDate})
      : super(key: key);
  final String value;
  final void Function(String value) onSelectDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.0550,
      width: Get.width * 0.900,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dropdownBoxColor,
          gradient: LinearGradient(
            colors: [
              grBottomColor.withValues(alpha:0.2),
              grTopColor.withValues(alpha:0.2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Padding(
        padding:  EdgeInsets.only(left: 33,right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.toString(),
                style: const TextStyle().normal.copyWith(fontSize: 14)
            ),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: AppConst.calenderFirstDate,
                    lastDate: AppConst.calenderLastDate);

                if (pickedDate != null) {
                  String formattedDate =
                  DateFormat(AppString.yyyyMMdd).format(pickedDate);
                  onSelectDate(formattedDate);
                } else {
                  if (kDebugMode) {
                    print('Date is not selected');
                  }
                }
              },
              child: Image.asset(
                AppAssets.calendarIcon,
                width: 18,
                height: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AppDateWidget2 extends StatelessWidget {
  const AppDateWidget2(
      {Key? key, required this.value, required this.onSelectDate})
      : super(key: key);
  final String value;
  final void Function(String value) onSelectDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.0600,
      width: Get.width * 0.900,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dropdownBoxColor,
          gradient: LinearGradient(
            colors: [
              grBottomColor.withValues(alpha:0.2),
              grTopColor.withValues(alpha:0.2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.toString(),
                style: const TextStyle().xstyle.copyWith(fontSize: 16)),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: AppConst.calenderFirstDate,
                    lastDate: AppConst.calenderLastDate);

                if (pickedDate != null) {
                  String formattedDate =
                  DateFormat(AppString.yyyyMMdd).format(pickedDate);
                  onSelectDate(formattedDate);
                } else {
                  if (kDebugMode) {
                    print('Date is not selected');
                  }
                }
              },
              child: Image.asset(
                AppAssets.calendarIcon,
                width: 18,
                height: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
