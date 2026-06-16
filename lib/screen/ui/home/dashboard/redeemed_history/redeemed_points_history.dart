import 'package:digitalerp/screen/ui/home/dashboard/redeemed_history/redeemed_points_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RedeemedPointsHistory extends StatelessWidget {
  const RedeemedPointsHistory({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedeemedPointsHistoryController>(
        init: RedeemedPointsHistoryController(),
        builder: (controller) => const Scaffold(
          body: Center(child: BackButton()),
        )
    );
  }
}
