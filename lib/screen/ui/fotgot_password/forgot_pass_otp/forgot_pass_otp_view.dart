// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_bottom_button.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/safeAreaWrapper.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import 'forgot_pass_otp_controller.dart';
//
// class ForgotPassOtpView extends StatelessWidget {
//   const ForgotPassOtpView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ForgotPassOtpController>(
//       init: ForgotPassOtpController(),
//       builder: (controller) => Scaffold(
//         // backgroundColor: whiteBoxColor,
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(AppAssets.otpBg),
//                           fit: BoxFit.fill)),
//                   child: SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: myAppBar(
//                         title: 'OTP Verification',
//                         onBackTap: () => controller.backTap(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: Get.height * 0.15,
//                 bottom: 100,
//                 right: 0,
//                 left: 0,
//                 child: _otpBox(context, controller),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: controller.isBusy
//                     ? const Center(
//                         child: CircularProgressIndicator(color: purpleColor),
//                       )
//                     : SafeAreaWrapper(
//                         child: AppBottomButton(
//                           onPressed: () {
//                             controller.tapOnVerify();
//                           },
//                           name: 'Verify',
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _otpBox(BuildContext context, ForgotPassOtpController controller) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 35),
//           Text(
//             controller.forgotPasswordController.responseData?.otp.toString() ??
//                 '',
//             style: const TextStyle()
//                 .bold
//                 .copyWith(fontSize: 26, color: Colors.green),
//           ),
//           Text(
//             'Enter code sent\nto your number',
//             style: const TextStyle().bold.copyWith(fontSize: 26),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Text(
//                 'we sent it to the number ',
//                 style: const TextStyle()
//                     .bold
//                     .copyWith(fontSize: 14, color: msgTextColor),
//               ),
//               Text(
//                 controller.forgotPasswordController.responseData?.mobileNo
//                         .toString() ??
//                     '9876543210',
//                 style: const TextStyle().bold,
//               ),
//             ],
//           ),
//           const SizedBox(height: 40),
//           PinCodeTextField(
//             appContext: context,
//             length: 6,
//             obscureText: false,
//             animationType: AnimationType.fade,
//             pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.underline,
//                 inactiveColor: unselectedColor,
//                 // activeColor: voiletColor,
//                 selectedColor: purpleColor,
//                 borderRadius: BorderRadius.circular(5),
//                 // fieldHeight: 50,
//                 // fieldWidth: 55,
//                 activeFillColor: Colors.transparent,
//                 inactiveFillColor: Colors.transparent),
//             animationDuration: const Duration(milliseconds: 300),
//             backgroundColor: Colors.transparent,
//             enableActiveFill: false,
//             controller: controller.otpController,
//             keyboardType: TextInputType.number,
//             textStyle: const TextStyle().bold.copyWith(fontSize: 41),
//             onCompleted: (v) {
//               if (kDebugMode) {
//                 print('Completed');
//               }
//             },
//             onChanged: (value) {
//               // setState(() {
//               //   currentText = value;
//               // });
//             },
//             beforeTextPaste: (text) {
//               if (kDebugMode) {
//                 print('Allowing to paste $text');
//               }
//               //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//               //but you can show anything you want here, like your pop up saying wrong paste format or etc
//               return true;
//             },
//           ),
//           const Spacer(),
//           /*
//           Align(
//             alignment: Alignment.center,
//             child: InkWell(
//               onTap: () {
//                 if (controller.enableResend) {
//                   controller.resendCode();
//                 }
//               },
//               child: Text(
//                 !controller.enableResend
//                     ? 'Resent code in 00:${controller.addZero()}${controller.secondsRemaining}'
//                     : 'Resent Code',
//                 style: const TextStyle().bold.copyWith(
//                       color: orangeColor,
//                     ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//
//            */
//         ],
//       ),
//     );
//   }
// }



import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'forgot_pass_otp_controller.dart';

class ForgotPassOtpView extends StatelessWidget {
  const ForgotPassOtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).viewPadding.bottom;

    return GetBuilder<ForgotPassOtpController>(
      init: ForgotPassOtpController(),
      builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewPadding.top -
                      safeBottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 52),

                      // Back button
                      GestureDetector(
                        onTap: () => controller.backTap(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: whiteBoxColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: newBorderColor),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            color: newTextPrimary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Logo
                      Image.asset(
                        AppAssets.appLogo,
                        height: 44,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 40),

                      // Headline
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                          color: newTextPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Code sent to ',
                            style: TextStyle(
                              color: newTextSecondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            controller.forgotPasswordController.responseData
                                ?.mobileNo
                                .toString() ??
                                '9876543210',
                            style: const TextStyle(
                              color: newTextPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),

                      // Debug OTP (only shown when available)
                      if (controller.forgotPasswordController.responseData?.otp
                          .toString()
                          .isNotEmpty ==
                          true) ...[
                        const SizedBox(height: 4),
                        Text(
                          'OTP: ${controller.forgotPasswordController.responseData?.otp}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                      const SizedBox(height: 40),

                      // PIN field
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 56,
                          fieldWidth: 48,
                          activeFillColor: whiteBoxColor,
                          inactiveFillColor: whiteBoxColor,
                          selectedFillColor: whiteBoxColor,
                          activeColor: purpleColor,
                          inactiveColor: newBorderColor,
                          selectedColor: purpleColor,
                          borderWidth: 1.5,
                        ),
                        animationDuration:
                        const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        controller: controller.otpController,
                        keyboardType: TextInputType.number,
                        textStyle: const TextStyle(
                          color: newTextPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                        onCompleted: (v) {
                          if (kDebugMode) print('Completed');
                        },
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          if (kDebugMode) print('Allowing to paste $text');
                          return true;
                        },
                      ),

                      const SizedBox(height: 40),

                      // Verify button
                      controller.isBusy
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: purpleColor,
                          strokeWidth: 2.5,
                        ),
                      )
                          : GestureDetector(
                        onTap: () => controller.tapOnVerify(),
                        child: Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: purpleColor,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: purpleColor.withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: safeBottom + 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
