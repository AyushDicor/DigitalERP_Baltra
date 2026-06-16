// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/visit_plan_flter/visit_plan_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class VisitPlanView extends StatelessWidget {
//   const VisitPlanView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<VisitPlanController>(
//       init: VisitPlanController(),
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
//                     child: MyAppBar(
//                       title: 'Visit Plan',
//                       onResetTap: () => controller.resetFilter(),
//                       onBackTap: ()=>Get.back(),
//
//                       // onDrawerTap: () => controller.openDrawer(context),
//                       onFilterTap: () => Get.dialog(
//                         const VisitPlanFilterView() /*CustomDialogBox(type: visitPlanFilter)*/,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 60,
//                 top: Get.height * 0.135,
//                 child: controller.isBusy
//                     ? SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         child: const Center(child: CircularProgressIndicator()),
//                       )
//                     : controller.visitListData.isEmpty
//                         ? SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.4,
//                             child: Center(
//                               child: Text(
//                                 'Not Available',
//                                 style: const TextStyle().bold,
//                               ),
//                             ))
//                         : ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             itemCount: controller.visitListData.length,
//                             itemBuilder: (context, index) {
//                               return visitPlanCard(controller, index);
//                             },
//                           ),
//               ),
//               Positioned(
//                 right: 18,
//                 bottom: 95,
//                 child: GradientIconButton(onPressed: () => controller.tapOnAdd(), radius: 10, vPadding: 20),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget visitPlanCard(VisitPlanController controller, int index) {
//     var item = controller.visitListData[index];
//     return InkWell(
//       onTap: () {
//         controller.tapOnCard(item);
//       },
//       child: Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
//         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Visit Area',
//               style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               item.vistarea ?? '',
//               style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: Get.width*0.400,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Date',
//                         style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         item.visitdate ?? '',
//                         style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Status',
//                         style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         item.visitstatus ?? '',
//                         style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Party Name',
//                         style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         item.party ?? '',
//                         style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 DottedLine(
//                   color: Colors.grey,
//                   height: 80.0,
//                   strokeWidth: 2.0,
//                   dottedLength: 5.0,
//                   space: 2.0,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Timing',
//                       style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       item.visittime ?? '',
//                       style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Executive',
//                       style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       item.executive ?? '',
//                       style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                     ),
//                     const SizedBox(height: 10),
//
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/visit_plan_flter/visit_plan_filter_view.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fab/menu_fab.dart';

class VisitPlanView extends StatelessWidget {
  const VisitPlanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Get bottom inset so FAB is never hidden behind bottom nav bar
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return GetBuilder<VisitPlanController>(
      init: VisitPlanController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: newTextPrimary, size: 20),
          ),
          title: const Text('Visit Plan',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
          actions: [
            GestureDetector(
              onTap: () => controller.resetFilter(),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.refresh_rounded,
                    color: Color(0xFFF39C12), size: 20),
              ),
            ),
            GestureDetector(
              onTap: () => Get.dialog(const VisitPlanFilterView()),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: purpleLightest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.filter_list_rounded,
                    color: purpleColor, size: 20),
              ),
            ),
          ],
        ),

        // ✅ FAB padded above bottom nav bar height + safe area
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: bottomInset + 64),
          child: FloatingActionButton(
            onPressed: () => controller.tapOnAdd(),
            backgroundColor: purpleColor,
            shape: const CircleBorder(
                side: BorderSide(color: Colors.white, width: 2)),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
          ),
        ),

        body: MenuFabBody(
          parentMenuId: 2377,
          child: controller.isBusy
              ? showLoader(color: newBlueColor)
              : controller.visitListData.isEmpty
                  ? _emptyState()
                  : ListView.builder(
                      // ✅ Extra bottom padding so last card clears FAB + bottom nav
                      padding:
                          EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 110),
                      itemCount: controller.visitListData.length,
                      itemBuilder: (ctx, i) => _visitCard(controller, i),
                    ),
        ),
      ),
    );
  }

  //  Empty state 

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF0FF),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Icons.event_note_outlined,
                size: 38, color: Color(0xFF5B5FC7)),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Visit Plans',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: newTextPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'No visit plans available.',
            style: TextStyle(fontSize: 13, color: newTextSecondary),
          ),
        ],
      ),
    );
  }

  //  Visit plan card 

  Widget _visitCard(VisitPlanController controller, int index) {
    final item = controller.visitListData[index];
    final status = item.visitstatus ?? '';
    final statusColor = _statusColor(status);
    final statusBg = _statusBgColor(status);

    return GestureDetector(
      onTap: () => controller.tapOnCard(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Card header: Area + Status badge 
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF0FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.place_outlined,
                        color: Color(0xFF5B5FC7), size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Visit Area',
                          style: TextStyle(
                              fontSize: 11,
                              color: newTextSecondary,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.vistarea ?? 'N/A',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: newTextPrimary),
                        ),
                      ],
                    ),
                  ),
                  // Status pill
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status.isEmpty ? 'N/A' : status,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFEFF2F7)),

            //  Info grid: 2 columns 
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoItem(Icons.calendar_today_outlined, 'Date',
                            item.visitdate ?? 'N/A'),
                        const SizedBox(height: 12),
                        _infoItem(Icons.business_outlined, 'Party Name',
                            item.party ?? 'N/A'),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 70,
                    color: const Color(0xFFEFF2F7),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoItem(Icons.access_time_outlined, 'Timing',
                            item.visittime ?? 'N/A'),
                        const SizedBox(height: 12),
                        _infoItem(Icons.person_outline_rounded, 'Executive',
                            item.executive ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: newTextSecondary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      color: newTextSecondary,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: newTextPrimary)),
            ],
          ),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF27AE60);
      case 'pending':
        return const Color(0xFFF39C12);
      case 'cancelled':
        return const Color(0xFFE74C3C);
      default:
        return newTextSecondary;
    }
  }

  Color _statusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFFE8F8EF);
      case 'pending':
        return const Color(0xFFFFF4E0);
      case 'cancelled':
        return const Color(0xFFFFECEA);
      default:
        return const Color(0xFFF0F3FF);
    }
  }
}
