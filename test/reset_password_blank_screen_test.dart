// Regression test for the blank grey Reset Password screen seen on release APKs.
//
// The OTP screen reaches Reset Password via Get.offAndToNamed, which removes the
// OTP route -> GetBuilder's autoRemove deletes ForgotPassOtpController. The
// reset screen's build() depends on MediaQuery, so it re-runs the moment the
// soft keyboard opens; ResetPasswordController used to resolve the (now
// deleted) OTP controller from a field initializer, which threw during build
// and left Flutter's release ErrorWidget - a plain grey screen - in its place.
import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_pass_otp/forgot_pass_otp_controller.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_pass_otp/reset_password/reset_password_controller.dart';
import 'package:digitalerp/screen/ui/fotgot_password/forgot_pass_otp/reset_password/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('survives the keyboard opening after the OTP route is gone',
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      smartManagement: SmartManagement.keepFactory,
      initialRoute: '/otp',
      getPages: [
        GetPage(name: '/otp', page: () => const Scaffold(body: SizedBox())),
        GetPage(
          name: AppRoutes.resetPassword,
          page: () => const ResetPasswordView(),
        ),
      ],
    ));
    await tester.pumpAndSettle();

    // What forgotOtpVerifyAPI() does: replace the OTP route, hand over the id.
    Get.offAndToNamed(AppRoutes.resetPassword, arguments: {'userId': '4242'});
    await tester.pumpAndSettle();

    expect(Get.isRegistered<ForgotPassOtpController>(), isFalse,
        reason: 'the OTP controller is NOT available to the reset screen');
    expect(find.text('New Password'), findsOneWidget);
    expect(Get.find<ResetPasswordController>().userId, '4242',
        reason: 'id survives without reaching into the dead OTP controller');

    // The user taps the password field and the soft keyboard comes up.
    tester.view.viewInsets = const FakeViewPadding(bottom: 900);
    addTearDown(tester.view.reset);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull,
        reason: 'no build exception -> no blank grey ErrorWidget');
    expect(find.text('New Password'), findsOneWidget,
        reason: 'screen is still on screen');
    expect(Get.find<ResetPasswordController>().userId, '4242',
        reason: 'the live controller was not swapped out by the rebuild');
  });
}
