import 'package:digitalerp/response/incentive_graph_detail_res_model.dart';
import 'package:digitalerp/screen/ui/graph/graph_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenPieChart extends StatelessWidget {
  FullScreenPieChart({super.key});

  List<Color> colorList = [
    Colors.deepPurple,
    Colors.orange,
    Colors.green,
    Colors.grey,
    Colors.blue,
    Colors.purple,
    Colors.brown,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Get.height / 4.2,
      height: 220,
      child: GetBuilder<GraphController>(
        builder: (controller) {
          if (controller.isIncentiveGraphLoading ||
              controller.incentiveGraphData.isEmpty) {
            return const Center();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Text(
                      "Total Incentive",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade700,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "${controller.incentiveGraphData.first.total}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: Get.width/4,
                        width: Get.width/4,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: showingSections(
                                controller.incentiveGraphData.first.details ??
                                    []),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width:
                      40,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            controller.incentiveGraphData.first.details?.length ??
                                0,
                            (index) => buildLegendItem(
                                colorList[index],
                                controller.incentiveGraphData.first
                                        .details![index].commisiontype ??
                                    ""),
                          )),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }

  Widget buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      List<IncentiveGraphDetails> graphData) {
    return List.generate(
      graphData.length,
      (index) => PieChartSectionData(
        color: colorList[index],
        value: graphData[index].value?.toDouble() ?? 0,
        title: (graphData[index].value?.toDouble() ?? 0).toStringAsFixed(2),
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
