import 'dart:convert';
import 'dart:developer';

import 'package:digitalerp/response/get_sales_receipt_graph_res_model.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/graph/graph_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final graphHeight=Get.height / 4.5;
    return GetBuilder<GraphController>(builder: (controller) {
      if (controller.isSalesReceiptBarLoading|| controller.salesReceiptData.isEmpty) {
        return const SizedBox();
      }
      controller.salesReceiptData
          .sort((a, b) => (b.value ?? 0).compareTo(a.value ?? 0));
      Map<String, List<SalesReceiptData>> salesMap = {};
      controller.salesReceiptData.forEach((element) {
        if (salesMap.containsKey(element.month)) {
          salesMap[element.month]!.add(element);
        } else {
          salesMap.addAll({
            element.month!: [element]
          });
        }
      });

      final maxValue = controller.salesReceiptData.first.value ?? 0;
      final perUnitPercent = maxValue == 0
          ? graphHeight + 10
          : maxValue / (graphHeight+ 10);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height:graphHeight + 40,
            width: Get.width,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: graphHeight + 20,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                      6,
                                      (index) => Text(
                                          "${NumberFormatter.formatter("${((maxValue / 5) * index).toInt()}")}"))
                                  .reversed
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Divider(color: Colors.grey, height: 0),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          salesMap.keys.length,
                          (index) {
                            final receivedData =
                                salesMap[salesMap.keys.toList()[index]]!
                                    .firstWhere(
                              (element) => element.type == "Received",
                              orElse: () => SalesReceiptData(),
                            );
                            final salesData =
                                salesMap[salesMap.keys.toList()[index]]!
                                    .firstWhere(
                              (element) => element.type == "Sales",
                              orElse: () => SalesReceiptData(),
                            );
                            final receiveBarHeight =
                                 (receivedData.value??0) / perUnitPercent;
                            final salesBarHeight =
                                (salesData.value??0) / perUnitPercent;
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          GraphController.to.getMonthWiseSales(
                                              flag: salesData.type!,
                                              month: salesData.month!);
                                          viewBarChartSheet(context);
                                        },
                                        child: Container(
                                          color: Colors.deepPurple,
                                          width: 20,
                                          height: receiveBarHeight,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          GraphController.to.getMonthWiseSales(
                                              flag: receivedData.type!,
                                              month: receivedData.month!);
                                          viewBarChartSheet(context);
                                        },
                                        child: Container(
                                          color: Colors.orange,
                                          width: 20,
                                          height: salesBarHeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(salesMap.keys.toList()[index])
                                ],
                              ),
                            );
                          },
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildLegendItem(Colors.deepPurple, 'Sales'),
              const SizedBox(width: 16),
              buildLegendItem(Colors.orange, 'Amount Received'),
            ],
          ),
        ],
      );
    });
  }

  Widget buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Future viewBarChartSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      // Make sure this is set to allow the bottom sheet to expand
      builder: (BuildContext context) {
        return GetBuilder<GraphController>(
          builder: (controller) {
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
                              width: Get.width * 0.15,
                              child: Text(
                                AppString.srNo,
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.25,
                              child: Text(
                                AppString.salesInvoiceNo,
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: Get.width * 0.25,
                              child: Text(
                                AppString.partyName,
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.12,
                              child: Text(
                                AppString.qty,
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.15,
                              child: Text(
                                AppString.amount,
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.isMonthWiseSalesLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      controller.monthWiseSales.length,
                                      (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: InkWell(
                                        onTap: () {
                                          GraphController.to.getInvoiceDetail(
                                              controller.monthWiseSales[index]
                                                  .invoiceid!
                                                  .toString());
                                          totalViewSheet(context);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 5),
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10, bottom: 10),
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   grBottomColor.withValues(alpha:0.7),
                                            //   grTopColor.withValues(alpha:0.7)
                                            // ]),
                                            gradient: customGradient(
                                                topColor: purpleColor,
                                                bottomColor: blueColor),
                                            color: leaveBoxColor,
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                              left: Radius.circular(13),
                                              right: Radius.circular(13),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.15,
                                                child: Text(
                                                  "${controller.monthWiseSales[index].invoiceid}",
                                                  style: const TextStyle(
                                                    color: blackColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.25,
                                                child: Text(
                                                  "${controller.monthWiseSales[index].invoiceno}",
                                                  style: const TextStyle(
                                                    color: blackColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.25,
                                                child: Text(
                                                  "${controller.monthWiseSales[index].partyname}",
                                                  style: const TextStyle(
                                                    color: blackColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.12,
                                                child: Text(
                                                  "${controller.monthWiseSales[index].totalqty}",
                                                  style: const TextStyle(
                                                    color: blackColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.13,
                                                child: Text(
                                                  "${controller.monthWiseSales[index].grandtotal}",
                                                  style: const TextStyle(
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
        return GetBuilder<GraphController>(
          builder: (controller) {
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
                              width: 40,
                              child: Text(
                                AppString.srNo,
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: Text(
                                AppString.itemName,
                                style: const TextStyle().bold.copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 60,
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
                              width: 60,
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
                        child: controller.isInvoiceDetailLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      controller.invoiceDetailData.length,
                                      (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 5),
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          // gradient: LinearGradient(colors: [
                                          //   grBottomColor.withValues(alpha:0.7),
                                          //   grTopColor.withValues(alpha:0.7)
                                          // ]),
                                          gradient: customGradient(
                                              topColor: orangeColor,
                                              bottomColor: red2Color),
                                          color: red2Color,
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                            left: Radius.circular(13),
                                            right: Radius.circular(13),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              child: Text(
                                                "${index + 1}",
                                                style: const TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                "${controller.invoiceDetailData[index].itemname}",
                                                style: const TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Center(
                                                child: Text(
                                                  "${controller.invoiceDetailData[index].quantity}",
                                                  style: const TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Center(
                                                child: Text(
                                                  "${controller.invoiceDetailData[index].price}",
                                                  style: const TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: Center(
                                                child: Text(
                                                  "${controller.invoiceDetailData[index].amount}",
                                                  style: const TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
      },
    );
  }
}
