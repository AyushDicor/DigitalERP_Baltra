import 'dart:async';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_password_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPassOtpController extends AppBaseController {
  final ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();
  int secondsRemaining = 59;
  bool enableResend = false;
  Timer? timer;
  String? responseData;

  final TextEditingController otpController = TextEditingController();

  bool isOneMinuteDone = false;
  UserData? userData;




  void tapOnVerify() async {
    setBusy(true);
    try {
      if (_validate()) {
      forgotOtpVerifyAPI();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Catch', 'Something went wrong');
    } finally {
      setBusy(false);
    }
  }

  void forgotOtpVerifyAPI() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.mobileNo] = forgotPasswordController.responseData?.mobileNo.toString() ?? '';
      body[RequestKeys.otp] = otpController.value.text;
      var res = await api.forgotOtpVerifyAPI(body);
      if (res.status == 200) {
        responseData = res.data?.userid.toString();
        Get.offAndToNamed(AppRoutes.resetPassword);
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Catch Server Res', '$e');
    } finally {}
  }

  bool _validate() {
    if (otpController.value.text.isEmpty) {
      ShowMessage.showSnackBar('Field Empty', 'Please Enter OTP');
      return false;
    }
    return true;
  }
}
