//import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_constant_new.dart';
import 'login_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 52),
                      _heading(),
                      const SizedBox(height: 36),
                      _mobileField(controller),
                      const SizedBox(height: 16),
                      _passwordField(controller),
                      const SizedBox(height: 16),
                      _rememberAndForgot(controller),
                      const SizedBox(height: 32),
                      _loginButton(controller),
                      const SizedBox(height: 24),
                    //  _signUpRow(),
                    //  const SizedBox(height: 24),
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

  Widget _heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome back!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to access your ERP dashboard',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _mobileField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username / Mobile',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.mobileCtrl,
          focusNode: controller.mobileFocus,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
         // maxLength: 10,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: 'Mobile or Username',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: Icon(Icons.person_outline,
                  color: Colors.grey.shade500, size: 20),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide:
              const BorderSide(color: newBlueColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.passwordCtrl,
          focusNode: controller.passwordFocus,
          obscureText: controller.isShowPassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => controller.clickOnLogin(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle:
            TextStyle(color: Colors.grey.shade400, fontSize: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: Icon(Icons.lock_outline_rounded,
                  color: Colors.grey.shade500, size: 20),
            ),
            suffixIcon: GestureDetector(
              onTap: () => controller.tapOnShowPassword(),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Icon(
                  controller.isShowPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide:
              const BorderSide(color: newBlueColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rememberAndForgot(LoginController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              // child: Checkbox(
              //   value: false,
              //   onChanged: (_) {},
              //   activeColor: newBlueColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   side: BorderSide(color: Colors.grey.shade400),
              // ),
            ),
            const SizedBox(width: 8),
            // Text(
            //   'Remember me?',
            //   style: TextStyle(
            //     fontSize: 13,
            //     color: Colors.grey.shade600,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
        GestureDetector(
          onTap: () => controller.tapOnForgotPassword(),
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton(LoginController controller) {
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
        onPressed: () => controller.clickOnLogin(),
        style: ElevatedButton.styleFrom(
          backgroundColor: purpleColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _signUpRow() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
          children: const [
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: purpleColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
