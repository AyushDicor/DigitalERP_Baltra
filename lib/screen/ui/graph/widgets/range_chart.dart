import 'package:digitalerp/screen/ui/graph/graph_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RangeChart extends StatelessWidget {
  const RangeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 5,
      child: GetBuilder<GraphController>(
        builder: (controller) {
          if (controller.isPerformanceGraphLoading ||
              controller.performanceGraphData.isEmpty) {
            return const Center();
          }

          final totalPercentage = controller
                  .performanceGraphData.first.performancepercent
                  ?.toDouble() ??
              0;
          return Center(
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showLabels: false,
                  showAxisLine: false,
                  showTicks: false,
                  minimum: 0,
                  maximum: 99,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 0,
                      endValue: 33,
                      color: const Color(0xFFFE2A25),
                      label: 'Slow',
                      sizeUnit: GaugeSizeUnit.factor,
                      labelStyle: const GaugeTextStyle(
                          fontFamily: 'Times', fontSize: 20),
                      startWidth: 0.65,
                      endWidth: 0.65,
                    ),
                    GaugeRange(
                      startValue: 33,
                      endValue: 66,
                      color: const Color(0xFFFFBA00),
                      label: 'Moderate',
                      labelStyle: const GaugeTextStyle(
                          fontFamily: 'Times', fontSize: 20),
                      startWidth: 0.65,
                      endWidth: 0.65,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    GaugeRange(
                      startValue: 66,
                      endValue: 99,
                      color: const Color(0xFF00AB47),
                      label: 'Fast',
                      labelStyle: const GaugeTextStyle(
                          fontFamily: 'Times', fontSize: 20),
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.65,
                      endWidth: 0.65,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(value: totalPercentage),
                    // Example pointer position
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$totalPercentage%',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          // Text(
                          //   'Moderate: $moderatePercentage%',
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.orange,
                          //   ),
                          // ),
                          // Text(
                          //   'Fast: $fastPercentage%',
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.green,
                          //   ),
                          // ),
                        ],
                      ),
                      angle: 90, // Positioning at the bottom center
                      positionFactor:
                          0.8, // Adjust this value to control vertical placement
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
