import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_pass_otp/forgot_pass_otp_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends AppBaseController {
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  bool isShowPassword = true;

  /// Captured once when the screen opens. The OTP screen is dropped from the
  /// stack by [Get.offAndToNamed], so [ForgotPassOtpController] is already
  /// deleted by the time the keyboard first opens - looking it up from a field
  /// initializer blew up the rebuild and left a blank screen in release.
  String? userId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['userId'] != null) {
      userId = args['userId'].toString();
    } else if (Get.isRegistered<ForgotPassOtpController>()) {
      userId = Get.find<ForgotPassOtpController>().responseData;
    }
  }

  Future<void> clickOResetPassword() async {
    passwordFocus.unfocus();
    confirmPasswordFocus.unfocus();
    setBusy(true);
    try {
      if (_isValidate()) {
        Map<String, String> body = {};
        body[RequestKeys.userId] = userId ?? '';
        body[RequestKeys.newPassword] = confirmPasswordCtrl.text.trim();
        var res = await api.resetPassword(body);
        if (res.status == 200) {
          Get.offAllNamed(AppRoutes.login);
          ShowMessage.showSnackBar('success', res.message.toString());
        } else {
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  void tapOnShowPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  bool _isValidate() {
    if (userId == null || userId!.isEmpty) {
      ShowMessage.showSnackBar(
        'Session Expired',
        'Please verify your mobile number again.',
      );
      return false;
    }
    if (passwordCtrl.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterPasswordTxt.tr,
      );
      return false;
    }
    if (passwordCtrl.text.toString() != confirmPasswordCtrl.text.toString()) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.passAnConPassNotMatchTxt.tr,
      );
      return false;
    }
    return true;
  }
}
