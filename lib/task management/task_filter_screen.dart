// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/task%20management/taskmanagementcontroller/task_manage_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/dialog_bg_widget.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class TaskFilterScreen extends StatelessWidget {
//   HomeController homeController = Get.find<HomeController>();
//   String firstDate = AppString.dateTimeEmpty;
//   String lastDate = AppString.dateTimeEmpty;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       builder: ( TaskManagementController  controller) {
//         return DialogBgWidget(
//           onApplyOrDoneButtonTap: () {
//             if(controller.selectAssignList==null || controller.selectAssignList!.executiveName!.isEmpty){
//               ShowMessage.showSnackBar('', 'Please Select Exe'
//                   'cutive');
//             }
//             else {
//               controller.getTaskListView();
//               Get.back();
//             }
//             },
//           // onApplyOrDoneButtonTap: () {
//           //   if ((controller.firstDateInDate != null &&
//           //       controller.lastDateInDate == null) ||
//           //       (controller.firstDateInDate == null &&
//           //           controller.lastDateInDate != null )) {
//           //     ShowMessage.showSnackBar(AppString.pleaseCheckTxt,
//           //         "From date and to date must be required");
//           //     return;
//           //   }
//           //   if(firstDate == AppString.dateTimeEmpty || lastDate ==AppString.dateTimeEmpty){}
//           //   if (controller.firstDateInDate!
//           //       .isBefore(controller.lastDateInDate!) ||
//           //       controller.firstDateInDate!
//           //           .isAtSameMomentAs(controller.lastDateInDate!)) {
//           //     Navigator.pop(
//           //       context,
//           //       ApprovalFilterModels(
//           //         documentName: controller.selectedDocument,
//           //         status: controller.selectedstatus,
//           //         client: controller.selectedClient,
//           //         vendor: controller.selectedvendor,
//           //         item: controller.selectedItemList,
//           //         startDate: controller.firstDateInDate,
//           //         endDate: controller.lastDateInDate,
//           //       ),
//           //     );
//           //   } else {
//           //     ShowMessage.showSnackBar(
//           //         AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
//           //   }
//           // },
//           children: [
//             _dateColumn(controller, context),
//             SizedBox(height: 25),
//             statusDropdown(controller),
//             SizedBox(height: 15),
//             _executiveDropDown(controller)
//           ],
//         );
//       },
//     );
//   }
//
//   statusDropdown(TaskManagementController controller) {
//     print(
//         "Rendering Dropdown with selectedStatus: ${controller.selectedStatus}");
//     if (controller.selectedStatus.isEmpty) {
//       controller.selectedStatus = "Running";
//     }
//
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//           buttonHeight: Get.height * 0.0550,
//           buttonWidth: Get.width * 0.900,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text(
//           "Status",
//           style: const TextStyle().newstyle.copyWith(
//                 // fontSize: 11,
//                 // fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         value: controller.selectedStatus,
//         items: controller.statusDropDown.map((String status) {
//           return DropdownMenuItem(
//             value: status,
//             child: Text(status,style:  const TextStyle().newstyle.copyWith(
//               color: Colors.black,
//             ),),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           print("Dropdown changed to: $newValue");
//
//           if (newValue != null) {
//             controller.onChangedStatusListValue(newValue);
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _executiveDropDown(TaskManagementController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: Get.height * 0.0550,
//         buttonWidth: Get.width * 0.900,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text(
//           "Executive",
//           style: const TextStyle().newstyle.copyWith(
//                 color: Colors.black,
//               ),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         // value: controller.selectedDocument,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         value: controller.selectAssignList?.executiveId,
//         items: controller.assignList.map(
//           (items) {
//             return DropdownMenuItem(
//               value: items.executiveId,
//               child: Text(
//                 items.executiveName.toString(),
//                 style: TextStyle().newstyle.copyWith(color: Colors.black),
//               ),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) => controller.setSelectAssignDropdownValue(
//             controller.assignList
//                 .firstWhere((element) => element.executiveId == newValue)),
//         // items: controller.filterDocumentData.map(
//         //       (items) {
//         //     return DropdownMenuItem(
//         //       value: items,
//         //       child: Text(
//         //         items.documentname ?? '',
//         //       ),
//         //     );
//         //   },
//         // ).toList(),
//         // onChanged: (newValue){
//         //   controller.onChangedDocumentDataValue(newValue);
//         //   controller.update();
//         // },
//       ),
//     );
//   }
//
//
//
//   Widget _dateColumn(
//     TaskManagementController controller,
//     BuildContext context,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             const SizedBox(width: 5),
//             Text(
//               'FromDate',
//               style: const TextStyle().bold.copyWith(
//                     fontSize: 15,
//                     color: red2Color,
//                   ),
//             ),
//             const SizedBox(
//               width: 60,
//             ),
//             Text(
//               'To Date',
//               style: const TextStyle().bold.copyWith(
//                     fontSize: 15,
//                     color: red2Color,
//                   ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _dateView(controller.firstDate, Get.width * .31, true, controller,
//                 context),
//             _dateView(controller.lastDate, Get.width * .31, false, controller,
//                 context),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _dateView(
//     String value,
//     double width,
//     bool isFirst,
//     TaskManagementController controller,
//     BuildContext context,
//   ) {
//     int currentYear = int.parse(
//         '${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     String date = isFirst ? controller.firstDate : controller.lastDate;
//     DateTime initDate = date != AppString.dateTimeEmpty
//         ? DateTime.parse(
//             formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: initDate,
//             firstDate: DateTime(currentYear),
//             lastDate: DateTime.now());
//
//         if (pickedDate != null) {
//           String formattedDate =
//               DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           if (isFirst) {
//             controller.setDate(formattedDate, true);
//             controller.setDateByDate(pickedDate, true);
//           } else {
//             controller.setDate(formattedDate, false);
//             controller.setDateByDate(pickedDate, false);
//           }
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
//                 Text(value, style: const TextStyle().medium),
//                 const SizedBox(width: 10),
//                 Image.asset(
//                   AppAssets.calendarIcon,
//                   width: 18,
//                   height: 18,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             width: Get.width * .31,
//             child: const Divider(
//               color: purpleColor,
//               thickness: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   dateValidate() {
//     if (firstDate == AppString.dateTimeEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
//       return false;
//     } else if (lastDate == AppString.dateTimeEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.pleaseCheckTxt, AppString.selectToDateTxt);
//       return false;
//     } else if (DateFormat(AppString.ddMMyyyy)
//         .parse(lastDate)
//         .isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate))) {
//       ShowMessage.showSnackBar(
//           AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
//       return false;
//     }
//   }
// }

import 'package:digitalerp/task%20management/taskmanagementcontroller/task_manage_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskFilterScreen extends StatelessWidget {
  TaskFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskManagementController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios, color: newTextPrimary),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Body - Scrollable filters
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Range
                      _dateRow(ctrl, context),
                      const SizedBox(height: 16),

                      // Site Name (Expandable with checkboxes)
                      _dropdownFilter(
                        'Task Status',
                        ['', ...ctrl.statusDropDown],   // '' = All
                        ctrl.selectedStatus,
                            (v) => ctrl.onChangedStatusListValue(v ?? ''),
                        emptyLabel: 'Select Status',
                      ),
                      const SizedBox(height: 12),

                      //  Executive 
                      _dropdownFilter(
                        'Executive',
                        ctrl.assignList.map((e) => e.executiveName ?? '').toList(),
                        ctrl.selectAssignList?.executiveName,
                            (v) {
                          if (v == null || v.isEmpty) {
                            ctrl.setSelectAssignDropdownValue(null);
                          } else {
                            ctrl.setSelectAssignDropdownValue(
                              ctrl.assignList
                                  .firstWhere((e) => e.executiveName == v),
                            );
                          }
                        },
                        emptyLabel: 'Select Executive',
                      ),
                      const SizedBox(height: 12),

                      //  Priority 
                      _dropdownFilter(
                        'Priority',
                        ['', 'High', 'Low'],
                        ctrl.selectedPriority,
                            (v) {
                          ctrl.selectedPriority = v ?? '';
                          ctrl.update();
                        },
                        emptyLabel: 'Select Prioritie',
                      ),
                      const SizedBox(height: 12),

                      //  Site Name 
                      _dropdownFilter(
                        'Site Name',
                        ['', ...ctrl.taskListData
                            .map((e) => e.sitename ?? '')
                            .where((s) => s.isNotEmpty)
                            .toSet()
                            .toList()],
                        ctrl.selectedSiteName,
                            (v) {
                          ctrl.selectedSiteName = v ?? '';
                          ctrl.update();
                        },
                        emptyLabel: 'Select Site',
                      ),
                      const SizedBox(height: 12),

                      //  Client Name 
                      _dropdownFilter(
                        'Client Name',
                        ['', ...ctrl.taskListData
                            .map((e) => e.clientname ?? '')
                            .where((s) => s.isNotEmpty)
                            .toSet()
                            .toList()],
                        ctrl.selectedClientName,
                            (v) {
                          ctrl.selectedClientName = v ?? '';
                          ctrl.update();
                        },
                        emptyLabel: 'Select Client',
                      ),
                      const SizedBox(height: 12),

                      //  Task Section 
                      _dropdownFilter(
                        'Task Section',
                        ctrl.taskFilterOptions,
                        ctrl.selectedTaskFilter,
                            (v) => ctrl.setTaskFilter(v ?? 'All'),
                      ),
                      const SizedBox(height: 12),

                      //  Assigned To 
                      _dropdownFilter(
                        'Assigned To',
                        ['', ...ctrl.taskListData
                            .map((e) => e.assignedto ?? '')
                            .where((s) => s.isNotEmpty)
                            .toSet()
                            .toList()],
                        ctrl.selectedAssignedTo,
                            (v) {
                          ctrl.selectedAssignedTo = v ?? '';
                          ctrl.update();
                        },
                        emptyLabel: 'Select',
                      ),
                      const SizedBox(height: 24),
                    ]),
                ),
              ),

              // Bottom Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2)),
                  ],
                ),
                child: Row(children: [
                  Expanded(child: _outlineBtn('Reset', ctrl.resetFilters)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _fillBtn('Apply', () {
                      // Date change needs re-fetch; local filters apply instantly
                      ctrl.getTaskListView();
                      Get.back();
                    }),
                  ),
                ]),
              ),
            ]),
        ),
      );
    });
  }

  // 
  // DATE ROW
  // 
  Widget _dateRow(TaskManagementController ctrl, BuildContext ctx) {
    return Row(children: [
      Expanded(child: _datePicker(ctrl.firstDate, 'From Date', true, ctrl, ctx)),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text('to',
            style: TextStyle(
                color: newTextSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
      ),
      Expanded(child: _datePicker(ctrl.lastDate, 'To Date', false, ctrl, ctx)),
    ]);
  }


  Widget _datePicker(String value, String hint, bool isFirst,
      TaskManagementController ctrl, BuildContext ctx) {
    return GestureDetector(
      onTap: () async {
        DateTime initDate;
        try {
          initDate = DateFormat('dd-MM-yyyy').parse(value);
        } catch (_) {
          initDate = DateTime.now();
        }
        final picked = await showDatePicker(
          context: ctx,
          initialDate: initDate,
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (c, child) => Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(primary: newBlueColor)),
            child: child!,
          ),
        );
        if (picked != null) {
          final fmt = DateFormat('dd-MM-yyyy').format(picked);
          ctrl.setDate(fmt, isFirst);
          ctrl.setDateByDate(picked, isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8EAED)),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value == AppString.dateTimeEmpty ? hint : value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: value == AppString.dateTimeEmpty
                      ? newTextHint
                      : newTextPrimary,
                ),
              ),
              const Icon(Icons.calendar_today_outlined,
                  size: 18, color: newTextSecondary),
            ]),
      ),
    );
  }


  // 
  // EXPANDABLE MULTI-SELECT (Like Site Name in image)
  // 
  Widget _expandableMultiSelectFilter(
    String label,
    List<String> items,
    List<String> selectedItems,
    ValueChanged<List<String>> onChanged,
  ) {
    bool isExpanded = false;
    return StatefulBuilder(
      builder: (context, setState) {

        final displayItems = items; // Show all items

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8EAED)),
          ),
          child: Column(
            children: [
              // Header
              InkWell(
                onTap: () {
                  setState(() => isExpanded = !isExpanded);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: newTextPrimary,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: newTextSecondary,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded content
              if (isExpanded) ...[
                const Divider(height: 1, color: Color(0xFFE8EAED)),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Search field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE8EAED)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: newTextHint,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: newTextSecondary,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Checkbox list
                      if (displayItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'No items available',
                            style: TextStyle(color: newTextHint),
                          ),
                        )
                      else
                        Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: displayItems.length,
                            itemBuilder: (_, i) {
                              final item = displayItems[i];
                              final isSelected = selectedItems.contains(item);
                              return CheckboxListTile(
                                value: isSelected,
                                onChanged: (bool? val) {
                                  List<String> updated =
                                      List.from(selectedItems);
                                  if (val == true) {
                                    updated.add(item);
                                  } else {
                                    updated.remove(item);
                                  }
                                  onChanged(updated);
                                },
                                title: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                activeColor: newBlueColor,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // 
  // SIMPLE DROPDOWN
  // 
  Widget _dropdownFilter(
      String label,
      List<String> items,
      String? selected,
      ValueChanged<String?> onChanged, {
        String emptyLabel = 'All',
      }) {
    // Deduplicate and remove empty strings from items
    final cleanItems = items
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    final isSelected = selected != null && selected.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  Label 
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: newTextSecondary,
                    letterSpacing: 0.3)),
            if (isSelected) ...[
              const SizedBox(width: 8),
              //  Clear chip 
              GestureDetector(
                onTap: () => onChanged(''),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: newBlueLightColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(selected,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: newBlueColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(width: 4),
                    const Icon(Icons.close_rounded,
                        size: 10, color: newBlueColor),
                  ]),
                ),
              ),
            ],
          ]),
        ),

        //  Dropdown 
        Container(
          decoration: BoxDecoration(
            color: isSelected
                ? newBlueLightColor          // highlight when active
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? newBlueColor : const Color(0xFFE8EAED)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: isSelected ? selected : null,
              hint: Text(
                emptyLabel,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: newTextHint),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isSelected ? newBlueColor : newTextSecondary,
                size: 22,
              ),
              style: const TextStyle(
                  fontSize: 14,
                  color: newTextPrimary,
                  fontWeight: FontWeight.w500),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              items: [
                //  None option at top 
                DropdownMenuItem<String>(
                  value: '',
                  child: Row(children: [
                    Icon(Icons.remove_circle_outline_rounded,
                        size: 16, color: newTextHint),
                    const SizedBox(width: 8),
                    Text('None',
                        style: TextStyle(
                            fontSize: 14,
                            color: newTextHint,
                            fontWeight: FontWeight.w500)),
                  ]),
                ),
                //  Divider 
                const DropdownMenuItem<String>(
                  enabled: false,
                  value: '__divider__',
                  child: Divider(height: 1),
                ),
                //  Actual items 
                ...cleanItems.map((s) => DropdownMenuItem<String>(
                  value: s,
                  child: Text(s,
                      overflow: TextOverflow.ellipsis, maxLines: 1),
                )),
              ],
              onChanged: cleanItems.isEmpty
                  ? null
                  : (v) => onChanged(v == '__divider__' ? selected : v),
            ),
          ),
        ),
      ],
    );
  }


  // 
  // BUTTONS
  // 
  Widget _outlineBtn(String label, VoidCallback onTap) => OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      foregroundColor: newBlueColor,
      side: const BorderSide(color: newBlueColor, width: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Text(label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
  );

  Widget _fillBtn(String label, VoidCallback onTap) => ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: newBlueColor,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Text(label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
  );
}
