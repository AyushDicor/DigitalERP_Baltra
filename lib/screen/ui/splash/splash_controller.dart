import 'dart:async';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends AppBaseController {
  @override
  void onReady() {
    super.onReady();
    _runTimer();
  }

  void _runTimer() async {
    Timer(
      const Duration(seconds: 2),
          () async {
        final isLogin = await SharedPre.getBoolValue(SharedPre.isLogin);
        if (isLogin) {
          final obj = SharedPre.getObjs(SharedPre.userData) ?? {};
          if (obj.isEmpty) {
            Get.offAllNamed(AppRoutes.login);
            return;
          }
          UserData userdata = UserData.fromJson(obj);
          if (userdata.mobileVerifyStatus == 0) {
            Get.offAllNamed(AppRoutes.login);
          } else {
            Get.offAllNamed(AppRoutes.home);
          }
        } else {
          Get.offAllNamed(AppRoutes.login);
        }
      },
    );
  }
}
