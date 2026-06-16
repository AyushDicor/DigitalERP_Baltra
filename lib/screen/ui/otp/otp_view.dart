//import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../utils/app_constant_new.dart';
import 'otp_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      init: OtpController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 52),
               Text(
                controller.userData?.otp.toString() ?? '',
                style: const TextStyle()
                 .bold
                  .copyWith(fontSize: 26, color: Colors.green),
                   ),
                _heading(),
                const SizedBox(height: 40),
                _phoneIcon(),
                const SizedBox(height: 40),
                _otpFields(context, controller),
                const SizedBox(height: 32),
                _verifyButton(controller),
                const SizedBox(height: 20),
                _resendRow(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verification Code',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Secure access with verification code',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _phoneIcon() {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: newBlueColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: newBlueColor.withValues(alpha:0.25),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: const Icon(
          Icons.phone_android_rounded,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }

  Widget _otpFields(BuildContext context, OtpController controller) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(18),
        fieldHeight: 54,
        fieldWidth: 48,
        activeFillColor: const Color(0xFFF8FAFC),
        inactiveFillColor: const Color(0xFFF8FAFC),
        selectedFillColor: Colors.white,
        activeColor: newBlueColor,
        inactiveColor: const Color(0xFFE2E8F0),
        selectedColor: newBlueColor,
      ),
      cursorColor: newBlueColor,
      animationDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: controller.otpController,
      keyboardType: TextInputType.number,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
      onCompleted: (v) {
        if (kDebugMode) print('OTP Completed: $v');
      },
      onChanged: (value) {},
      beforeTextPaste: (text) => true,
    );
  }

  Widget _verifyButton(OtpController controller) {
    if (controller.isBusy) {
      return const Center(
        child: SizedBox(
          height: 54,
          child: Center(
            child: CircularProgressIndicator(color: newBlueColor),
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () => controller.tapOnVerify(Get.arguments?[1] ?? ''),
        style: ElevatedButton.styleFrom(
          backgroundColor: newBlueColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Verify OTP',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _resendRow(OtpController controller) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don't receive OTP? ",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  if (controller.enableResend) controller.resendCode();
                },
                child: Text(
                  controller.enableResend
                      ? 'Resend code'
                      : 'Resend in 00:${controller.addZero()}${controller.secondsRemaining}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: controller.enableResend
                        ? newBlueColor
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
