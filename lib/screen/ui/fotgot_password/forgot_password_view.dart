// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/safeAreaWrapper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'forgot_password_controller.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
//
// class ForgotPasswordView extends StatelessWidget {
//   const ForgotPasswordView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ForgotPasswordController>(
//       init: ForgotPasswordController(),
//       builder: (controller) => Scaffold(
//         backgroundColor: whiteBoxColor,
//         body: LayoutBuilder(
//           builder: (context, constraint) => SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraint.maxHeight),
//               child: IntrinsicHeight(
//                 child: Column(
//                   children: [
//                     headerPart(),
//                     Expanded(child: loginCard(controller)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget headerPart() {
//     return Container(
//       height: Get.height * .40,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(bottomRight: Radius.circular(45.0)),
//         color: purpleColor,
//       ),
//       child: Center(
//         child: SizedBox(
//           height: 90,
//           width: 90,
//           child: Image.asset(
//             AppAssets.appLogo,
//             // fit: BoxFit.fill,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget loginCard(ForgotPasswordController controller) {
//     return Container(
//       color: purpleColor,
//       height: Get.height * .60,
//       child: Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0)),
//           color: whiteBoxColor,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Enter Your\nMobile Number',
//                       style: const TextStyle().bold.copyWith(fontSize: 26),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'We will send you a confirmation code for reset password',
//                       style: const TextStyle()
//                           .bold
//                           .copyWith(fontSize: 14, color: msgTextColor),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     TextFormField(
//                       style: const TextStyle().normal,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.next,
//                       controller: controller.mobileCtrl,
//                       focusNode: controller.mobileFocus,
//                       maxLength: 10,
//                       decoration: const InputDecoration()
//                           .txtFieldStyle2(
//                               hintText: 'Enter number',
//                               labelName: 'Enter mobile number',
//                               labelColor: darkGreenColor)
//                           .copyWith(
//                             suffixIcon: SizedBox(
//                               height: 45,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 25),
//                                 child: Image.asset(
//                                   AppAssets.callIcon,
//                                   width: 14,
//                                   height: 14,
//                                   // fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                             suffixIconConstraints: const BoxConstraints(
//                               minHeight: 50,
//                               maxHeight: 50,
//                             ),
//                           ),
//                     ),
//                     /*
//                     TextFormField(
//                       style: const TextStyle().light,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.next,
//                       controller: controller.passwordCtrl,
//                       focusNode: controller.passwordFocus,
//                       decoration: const InputDecoration()
//                           .txtFieldStyle2(
//                               hintText: 'Enter Password',
//                               labelName: 'Password',
//                               labelColor: darkGreenColor)
//                           .copyWith(
//                               suffixIcon: SizedBox(
//                                 height: 45,
//                                 child: InkWell(
//                                   onTap: () => controller.tapOnShowPassword(),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 25),
//                                     child: Icon(
//                                         controller.isShowPassword
//                                             ? Icons.visibility_off
//                                             : Icons.visibility,
//                                         color: unselectedColor),
//                                   ),
//                                 ),
//                               ),
//                               suffixIconConstraints:
//                                   const BoxConstraints(minHeight: 50, maxHeight: 50)),
//                       obscureText: controller.isShowPassword,
//                     ),
//
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'Forgot password?',
//                           style: const TextStyle().normal.copyWith(fontSize: 12),
//                         ),
//                       ),
//                     ),
//
//                      */
//                   ],
//                 ),
//               ),
//             ),
//             controller.isBusy
//                 ? const Center(
//                     child: CircularProgressIndicator(
//                       color: purpleColor,
//                     ),
//                   )
//                 : SafeAreaWrapper(
//                     child: InkWell(
//                       onTap: () => controller.clickOnSendOtp(),
//                       child: Container(
//                         width: Get.width,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(40.0)),
//                             gradient: gr1),
//                         child: Center(
//                           child: Text(
//                             'Send OTP',
//                             style: const TextStyle()
//                                 .bold
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  //  Tokens 

  static const Color _blue    = Color(0xFF3B6EF6);
  static const Color _blueD   = Color(0xFF2756D6);



  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).viewPadding.bottom;

    return GetBuilder<ForgotPasswordController>(
      // build() depends on MediaQuery, so it re-runs every time the keyboard
      // opens; only build a controller when there isn't one already.
      init: Get.isRegistered<ForgotPasswordController>()
          ? null
          : ForgotPasswordController(),
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

                      //  Logo 
                      Image.asset(
                        AppAssets.appLogo,
                        height: 44,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 40),

                      //  Headline 
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: newTextPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enter your mobile number and we\'ll\nsend you a reset OTP.',
                        style: TextStyle(
                          color: newTextSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      //  Mobile field 
                      _fieldLabel('Mobile Number'),
                      const SizedBox(height: 8),
                      _inputField(
                        controller: controller.mobileCtrl,
                        focusNode: controller.mobileFocus,
                        hint: 'Enter your mobile number',
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        prefixIcon: Icons.phone_outlined,
                      ),

                      const SizedBox(height: 36),

                      //  Send OTP button 
                      controller.isBusy
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: purpleColor,
                          strokeWidth: 2.5,
                        ),
                      )
                          : _sendOtpButton(controller),

                      const SizedBox(height: 24),

                      //  Back to login 
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: RichText(
                            text: const TextSpan(
                              text: 'Remember your password? ',
                              style: TextStyle(
                                color: newTextSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: purpleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: newTextPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required TextInputType keyboardType,
    required IconData prefixIcon,
    int? maxLength,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: whiteBoxColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        obscureText: obscure,
        maxLength: maxLength,
        style: const TextStyle(
          color: newTextPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: newTextHint, fontSize: 15),
          counterText: '',
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: Icon(prefixIcon, color: newTextHint, size: 20),
          ),
          prefixIconConstraints:
          const BoxConstraints(minWidth: 48, minHeight: 48),
          suffixIcon: suffix,
        ),
      ),
    );
  }

  Widget _sendOtpButton(ForgotPasswordController controller) {
    return GestureDetector(
      onTap: () => controller.clickOnSendOtp(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: purpleColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: _blue.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Send OTP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}


