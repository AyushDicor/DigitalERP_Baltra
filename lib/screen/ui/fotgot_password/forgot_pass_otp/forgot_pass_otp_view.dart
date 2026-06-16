import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/safeAreaWrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'forgot_pass_otp_controller.dart';

class ForgotPassOtpView extends StatelessWidget {
  const ForgotPassOtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPassOtpController>(
      init: ForgotPassOtpController(),
      builder: (controller) => Scaffold(
        // backgroundColor: whiteBoxColor,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppAssets.otpBg),
                          fit: BoxFit.fill)),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: myAppBar(
                        title: 'OTP Verification',
                        onBackTap: () => controller.backTap(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Get.height * 0.15,
                bottom: 100,
                right: 0,
                left: 0,
                child: _otpBox(context, controller),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: controller.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: purpleColor),
                      )
                    : SafeAreaWrapper(
                        child: AppBottomButton(
                          onPressed: () {
                            controller.tapOnVerify();
                          },
                          name: 'Verify',
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpBox(BuildContext context, ForgotPassOtpController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          Text(
            controller.forgotPasswordController.responseData?.otp.toString() ??
                '',
            style: const TextStyle()
                .bold
                .copyWith(fontSize: 26, color: Colors.green),
          ),
          Text(
            'Enter code sent\nto your number',
            style: const TextStyle().bold.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'we sent it to the number ',
                style: const TextStyle()
                    .bold
                    .copyWith(fontSize: 14, color: msgTextColor),
              ),
              Text(
                controller.forgotPasswordController.responseData?.mobileNo
                        .toString() ??
                    '9876543210',
                style: const TextStyle().bold,
              ),
            ],
          ),
          const SizedBox(height: 40),
          PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                inactiveColor: unselectedColor,
                // activeColor: voiletColor,
                selectedColor: purpleColor,
                borderRadius: BorderRadius.circular(5),
                // fieldHeight: 50,
                // fieldWidth: 55,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: false,
            controller: controller.otpController,
            keyboardType: TextInputType.number,
            textStyle: const TextStyle().bold.copyWith(fontSize: 41),
            onCompleted: (v) {
              if (kDebugMode) {
                print('Completed');
              }
            },
            onChanged: (value) {
              // setState(() {
              //   currentText = value;
              // });
            },
            beforeTextPaste: (text) {
              if (kDebugMode) {
                print('Allowing to paste $text');
              }
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
          const Spacer(),
          /*
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                if (controller.enableResend) {
                  controller.resendCode();
                }
              },
              child: Text(
                !controller.enableResend
                    ? 'Resent code in 00:${controller.addZero()}${controller.secondsRemaining}'
                    : 'Resent Code',
                style: const TextStyle().bold.copyWith(
                      color: orangeColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

           */
        ],
      ),
    );
  }
}
