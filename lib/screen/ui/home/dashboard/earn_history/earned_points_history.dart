import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'earned_points_history_controller.dart';

class EarnedPointsHistory extends StatelessWidget {
  const EarnedPointsHistory({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<EarnedPointsHistoryController>(
        init: EarnedPointsHistoryController(),
        builder: (controller) => const Scaffold(
          body: Center(child: BackButton()),
        )
    );
  }
}
