// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/visit_plan/new_visit_planing/new_visit_planing_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/new_visit_planning_filter/new_visit_planning_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_bottom_button.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class NewVisitPlaningView extends StatelessWidget {
//   const NewVisitPlaningView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NewVisitPlaningController>(
//       init: NewVisitPlaningController(),
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                   child: SafeArea(
//                       child: MyAppBar(
//                           title: 'New Visit Planning',
//                           onBackTap: () => controller.backTap(),
//                           onFilterTap: () => Get.dialog(
//                                  NewVisitPlanningFilterView() /*CustomDialogBox(type: newVisitPlanFilter)*/,
//                               ).then((value) => controller.update()))),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: Get.height * 0.02),
//
//                       //_dropdown(controller),
//                       Container(
//                         width: Get.width,
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(color: dropdownBoxColor, borderRadius: BorderRadius.circular(8)),
//                         child: Text(
//                           controller.executiveName ?? '',
//                           style: const TextStyle().bold.copyWith(),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       TextFormField(
//                         decoration: const InputDecoration().searchTxtFieldStyle(),
//                         controller: controller.searchController,
//                         focusNode: controller.searchFocus,
//                         keyboardType: TextInputType.text,
//                         textInputAction: TextInputAction.search,
//                         onChanged: (value) => controller.onSearch(value.trim()),
//                       ),
//                       const SizedBox(height: 20),
//                       Obx(() => _datePicker(controller, context)),
//                       const SizedBox(height: 5),
//                       controller.isBusy
//                           ? SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.4,
//                               child: const Center(child: CircularProgressIndicator()),
//                             )
//                           : controller.visitPlanCustomerList.isEmpty || controller.visitPlanCustomerList==null
//                               ? SizedBox(
//                                   height: MediaQuery.of(context).size.height * 0.4,
//                                   child: Center(
//                                     child: Text(
//                                       'Not Available',
//                                       style: const TextStyle().bold,
//                                     ),
//                                   ))
//                               : ListView.builder(
//                                   shrinkWrap: true,
//                                   padding: EdgeInsets.zero,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: controller.visitPlanCustomerList.length,
//                                   itemBuilder: (context, index) {
//                                     return planCard(controller, index);
//                                   },
//                                 ),
//                       const SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AppBottomButton(onPressed: () => controller.tapOnPreview(), name: 'Preview'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   planCard(NewVisitPlaningController controller, int index) {
//     var item = controller.visitPlanCustomerList[index];
//     return SizedBox(
//       height: 185,
//       child: Stack(
//         alignment: Alignment.centerRight,
//         children: [
//           Positioned(
//             left: 0,
//             top: 0,
//             right: 20,
//             bottom: 0,
//             child: Container(
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
//               margin: const EdgeInsets.only(top: 10, bottom: 10),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               child: Column(
//                 // mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Customer name',
//                     style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     item.customername ?? '',
//                     style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Area',
//                     style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     item.area ?? '',
//                     style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Distance',
//                     style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     item.distance ?? '',
//                     style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           GradientIconButton(
//             topColor: grTopColor,
//             bottomColor: grBottomColor,
//             radius: 8,
//             vPadding: 12.5,
//             hPadding: 12.5,
//             onPressed: () => controller.tapOnChecked(index),
//             icon: controller.visitPlanCustomerList[index].isChecked ?? false
//                 ? AppAssets.checkIcon
//                 : AppAssets.uncheckIcon,
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _datePicker(NewVisitPlaningController controller, BuildContext context) {
//     return ColorFiltered(
//       colorFilter: const ColorFilter.mode(
//         Colors.transparent,
//         BlendMode.saturation,
//       ),
//       child: _dateView(Get.width * .31, controller, context, controller.defaultDate.value),
//     );
//   }
//
//   Widget _dateView(
//     double width,
//     NewVisitPlaningController controller,
//     BuildContext context,
//     String value,
//   ) {
//     int currentYear = int.parse('${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     String date = controller.defaultDate.value;
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: initialDateOfPicker(currentYear, date),
//           firstDate: AppConst.calenderFirstDate ?? DateTime.now(), //firstDateOfPicker(currentYear),
//           lastDate: AppConst.calenderLastDate ?? lastDateOfPicker(currentYear),
//         );
//
//         if (pickedDate != null) {
//           controller.dateTime = pickedDate;
//           controller.defaultDate.value = DateFormat(AppString.ddMMyyyy).format(pickedDate);
//         } else {
//           if (kDebugMode) {
//             print('Date is not selected');
//           }
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(value, style: const TextStyle().bold.copyWith(color: red2Color)),
//                 const SizedBox(width: 10),
//                 Image.asset(
//                   AppAssets.calendarIcon,
//                   width: 18,
//                   height: 18,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   DateTime initialDateOfPicker(int currentYear, String date) {
//     // print("----------------------${DateTime.parse(firstDate)}");
//     // print("----------------------${DateTime.now()}");
//     return date != 'Select Date'
//         ? DateTime.parse(formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//   }
//
//   DateTime firstDateOfPicker(int currentYear) {
//     return DateTime(currentYear, 4, 1);
//   }
//
//   DateTime lastDateOfPicker(int currentYear) {
//     return DateTime(currentYear + 1, 4);
//   }
//
// /* _dropdown(NewVisitPlaningController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         isExpanded: true,
//         value: controller.selectedDropdownValue,
//         hint: Text(
//           'Select Executive user name',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.dropdownList.map((items) {
//           return DropdownMenuItem(
//             value: items,
//             child: Text(items),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setDropdownValue(newValue.toString());
//         },
//       ),
//     );
//   }*/
// }




import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/new_visit_planing/new_visit_planing_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/new_visit_planning_filter/new_visit_planning_filter_view.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewVisitPlaningView extends StatelessWidget {
  const NewVisitPlaningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewVisitPlaningController>(
      init: NewVisitPlaningController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: false,

        // ✅ Proper AppBar
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => controller.backTap(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: newTextPrimary,
              size: 20,
            ),
          ),
          title: const Text(
            'New Visit Planning',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: newTextPrimary,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.dialog(NewVisitPlanningFilterView())
                  .then((_) => controller.update()),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.filter_list_rounded,
                  color: Color(0xFF5B5FC7),
                  size: 20,
                ),
              ),
            ),
          ],
        ),

        // ✅ Bottom Preview button as a persistent bottom bar
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => controller.tapOnPreview(),
                icon: const Icon(Icons.preview_outlined,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Preview',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: newBlueColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Executive name chip 
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFD0D4F5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person_outline_rounded,
                        color: Color(0xFF5B5FC7), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.executiveName ?? 'Executive Name',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: newTextPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              //  Search field 
              TextField(
                controller: controller.searchController,
                focusNode: controller.searchFocus,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onChanged: (v) => controller.onSearch(v.trim()),
                style: const TextStyle(fontSize: 14, color: newTextPrimary),
                decoration: InputDecoration(
                  hintText: 'Search customer...',
                  hintStyle: const TextStyle(
                      fontSize: 14, color: newTextSecondary),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: newTextSecondary, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: newBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: newBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide:
                    const BorderSide(color: newBlueColor, width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              //  Date picker 
              Obx(() => _datePicker(controller, context)),

              const SizedBox(height: 16),

              //  Customer list 
              controller.isBusy
                  ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: showLoader(color: newBlueColor),
              )
                  : (controller.visitPlanCustomerList.isEmpty)
                  ? _emptyState()
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.visitPlanCustomerList.length,
                itemBuilder: (context, index) =>
                    _planCard(controller, index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Date picker row 

  Widget _datePicker(
      NewVisitPlaningController controller, BuildContext context) {
    int currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');
    final date = controller.defaultDate.value;

    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _initialDate(currentYear, date),
          firstDate: AppConst.calenderFirstDate ?? DateTime.now(),
          lastDate: AppConst.calenderLastDate ?? _lastDate(currentYear),
        );
        if (pickedDate != null) {
          controller.dateTime = pickedDate;
          controller.defaultDate.value =
              DateFormat(AppString.ddMMyyyy).format(pickedDate);
        }
      },
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                color: newBlueColor, size: 20),
            const SizedBox(width: 10),
            const Text(
              'Visit Date',
              style: TextStyle(fontSize: 13, color: newTextSecondary),
            ),
            const Spacer(),
            Text(
              date.isEmpty ? 'Select Date' : date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: date.isEmpty ? newTextSecondary : newTextPrimary,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: newTextSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  //  Customer plan card 

  Widget _planCard(NewVisitPlaningController controller, int index) {
    final item = controller.visitPlanCustomerList[index];
    final isChecked = item.isChecked ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isChecked
              ? const Color(0xFF5B5FC7)
              : const Color(0xFFE8ECF0),
          width: isChecked ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Info column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardInfoRow(Icons.person_outline_rounded,
                      'Customer Name', item.customername ?? 'N/A'),
                  const SizedBox(height: 10),
                  _cardInfoRow(Icons.place_outlined,
                      'Area', item.area ?? 'N/A'),
                  const SizedBox(height: 10),
                  _cardInfoRow(Icons.straighten_outlined,
                      'Distance', item.distance ?? 'N/A'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Checkbox toggle
            GestureDetector(
              onTap: () => controller.tapOnChecked(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isChecked
                      ? const Color(0xFF5B5FC7)
                      : const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isChecked
                      ? Icons.check_rounded
                      : Icons.check_box_outline_blank_rounded,
                  color: isChecked
                      ? Colors.white
                      : const Color(0xFF5B5FC7),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: newTextSecondary),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    color: newTextSecondary,
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 1),
            Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary)),
          ],
        ),
      ],
    );
  }

  Widget _emptyState() {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0FF),
                borderRadius: BorderRadius.circular(36),
              ),
              child: const Icon(Icons.event_busy_outlined,
                  size: 34, color: Color(0xFF5B5FC7)),
            ),
            const SizedBox(height: 14),
            const Text('No Customers Found',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary)),
            const SizedBox(height: 6),
            const Text('Try adjusting your filters.',
                style: TextStyle(fontSize: 13, color: newTextSecondary)),
          ],
        ),
      ),
    );
  }

  DateTime _initialDate(int currentYear, String date) {
    return date != 'Select Date'
        ? DateTime.parse(
        formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();
  }

  DateTime _lastDate(int currentYear) =>
      DateTime(currentYear + 1, 4);
}