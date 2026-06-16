import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/graph/graph_controller.dart';
import 'package:digitalerp/screen/ui/graph/graph_filter_controller.dart';
import 'package:digitalerp/screen/ui/graph/widgets/pie_chart.dart';
import 'package:digitalerp/screen/ui/graph/widgets/graph_filter_dialog.dart';
import 'package:digitalerp/screen/ui/home/dashboard/dashboard_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/order_filter/order_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

import 'widgets/range_chart.dart';
import 'widgets/custom_bar_chart.dart';

class AllGraphScreen extends StatefulWidget {
  const AllGraphScreen({super.key});

  @override
  State<AllGraphScreen> createState() => _AllGraphScreenState();
}

class _AllGraphScreenState extends State<AllGraphScreen> {
  @override
  void initState() {
    Get.put<GraphController>(GraphController());
    Get.put<GraphFilterController>(GraphFilterController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GraphController>(
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          GraphController.to.getAllGraph();
        });
      },
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppAssets.dashboardBg),
                          fit: BoxFit.fill),
                    ),
                    child: SafeArea(
                      child: MyAppBar(
                        title: 'Dashboard',
                        // onBackTap: () => Get.back(),
                        onDrawerTap: () {
                          Get.put<DashboardController>(DashboardController());
                          DashboardController.to.openDrawer(context);
                        },
                        onFilterTap: () => Get.dialog(
                            const GraphFilterDialogBox() /*CustomDialogBox(type: orderFilter)*/),

                        onCartTap: () => Get.back(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: Get.height * 0.135,
                  child: controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomBarChart(),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.7,
                                ),
                                InkWell(
                                    onTap: () {
                                      // viewPieChartSheet(context);
                                    },
                                    child: FullScreenPieChart()),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.7,
                                ),
                                const RangeChart(),
                                SizedBox(
                                  height: IphoneHasNotch.hasNotch ? 100 : 90,
                                )
                              ],
                            ),
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

  Future viewPieChartSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      // Make sure this is set to allow the bottom sheet to expand
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 5, 10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.13,
                          child: Text(
                            AppString.srNo,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        const SizedBox(width: 3),
                        SizedBox(
                          width: Get.width * 0.22,
                          child: Text(
                            AppString.billNo,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: Get.width * 0.19,
                          child: Text(
                            AppString.incentiveReceive,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.19,
                          child: Text(
                            AppString.incentivePaid,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.18,
                          child: Text(
                            AppString.incentiveDue,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(10, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {
                                totalViewSheet(context);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 5),
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    grBottomColor.withValues(alpha:0.7),
                                    grTopColor.withValues(alpha:0.7)
                                  ]),
                                  color: leaveBoxColor,
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(13),
                                    right: Radius.circular(13),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.12,
                                      child: const Text(
                                        "134",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.22,
                                      child: const Text(
                                        "CGU1214",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      width: Get.width * 0.19,
                                      child: const Text(
                                        "100",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.19,
                                      child: const Text(
                                        "100",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.18,
                                      child: const Text(
                                        "100",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -15 + 5,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: Color(0X40000000),
                      blurRadius: 4,
                    ),
                  ], shape: BoxShape.circle, gradient: gr2),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future totalViewSheet(BuildContext context) {
    return showModalBottomSheet(
      constraints: BoxConstraints(maxHeight: Get.height * 0.40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.15,
                          child: Text(
                            AppString.srNo,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            AppString.itemName,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 85,
                          child: Text(
                            AppString.itemQty,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Text(
                            AppString.price,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            AppString.totalPrice,
                            style: const TextStyle().bold.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(10, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 5),
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                decoration: const BoxDecoration(
                                  // gradient: LinearGradient(colors: [
                                  //   grBottomColor.withValues(alpha:0.7),
                                  //   grTopColor.withValues(alpha:0.7)
                                  // ]),
                                  color: red2Color,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(13),
                                    right: Radius.circular(13),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 45,
                                      child: Text(
                                        "gtg",
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 75,
                                      child: Text(
                                        "CGU123",
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 93,
                                      child: Text(
                                        "ABC Company",
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                        "100",
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                        "100",
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -15 + 5,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: Color(0X40000000),
                      blurRadius: 4,
                    ),
                  ], shape: BoxShape.circle, gradient: gr2),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
