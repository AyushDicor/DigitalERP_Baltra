// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/safeAreaWrapper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'reset_password_controller.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
//
// class ResetPasswordView extends StatelessWidget {
//   const ResetPasswordView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ResetPasswordController>(
//       init: ResetPasswordController(),
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
//   Widget loginCard(ResetPasswordController controller) {
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
//                       'Enter Your\nNew Password',
//                       style: const TextStyle().bold.copyWith(fontSize: 26),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'create new password',
//                       style: const TextStyle()
//                           .bold
//                           .copyWith(fontSize: 14, color: msgTextColor),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     TextFormField(
//                       style: const TextStyle().light,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.next,
//                       controller: controller.passwordCtrl,
//                       focusNode: controller.passwordFocus,
//                       decoration: const InputDecoration()
//                           .txtFieldStyle2(
//                               hintText: 'Enter new Password',
//                               labelName: 'Enter new Password',
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
//                               suffixIconConstraints: const BoxConstraints(
//                                   minHeight: 50, maxHeight: 50)),
//                       obscureText: controller.isShowPassword,
//                     ),
//                     TextFormField(
//                       style: const TextStyle().light,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.next,
//                       controller: controller.confirmPasswordCtrl,
//                       focusNode: controller.confirmPasswordFocus,
//                       obscureText: true,
//                       decoration: const InputDecoration().txtFieldStyle2(
//                           hintText: 'Confirm Password',
//                           labelName: 'Confirm Password',
//                           labelColor: darkGreenColor),
//                     ),
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
//                       onTap: () => controller.clickOResetPassword(),
//                       child: Container(
//                         width: Get.width,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(40.0)),
//                             gradient: gr1),
//                         child: Center(
//                           child: Text(
//                             'Reset Password',
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
import 'reset_password_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).viewPadding.bottom;

    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
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
                        onTap: () => Get.back(),
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
                        'Reset Password',
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
                        'Create a new secure password\nfor your account.',
                        style: TextStyle(
                          color: newTextSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // New password field
                      _fieldLabel('New Password'),
                      const SizedBox(height: 8),
                      _inputField(
                        controller: controller.passwordCtrl,
                        focusNode: controller.passwordFocus,
                        hint: 'Enter new password',
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.lock_outline_rounded,
                        obscure: controller.isShowPassword,
                        suffix: GestureDetector(
                          onTap: () => controller.tapOnShowPassword(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Icon(
                              controller.isShowPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: newTextHint,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Confirm password field
                      _fieldLabel('Confirm Password'),
                      const SizedBox(height: 8),
                      _inputField(
                        controller: controller.confirmPasswordCtrl,
                        focusNode: controller.confirmPasswordFocus,
                        hint: 'Re-enter your password',
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.lock_outline_rounded,
                        obscure: true,
                      ),

                      const SizedBox(height: 40),

                      // Reset button
                      controller.isBusy
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: purpleColor,
                          strokeWidth: 2.5,
                        ),
                      )
                          : GestureDetector(
                        onTap: () =>
                            controller.clickOResetPassword(),
                        child: Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: purpleColor,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color:
                                purpleColor.withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Reset Password',
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
          hintStyle:
          const TextStyle(color: newTextHint, fontSize: 15),
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
}