import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/safeAreaWrapper.dart';
import 'package:flutter/material.dart';

class AppBottomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;
  final bool isLoading;

  const AppBottomButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return SafeAreaWrapper(
      child: Container(
        height: 52,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Material(
          color: isDisabled ? Colors.grey.shade300 : purpleColor,
          borderRadius: BorderRadius.circular(14),
          elevation: isDisabled ? 0 : 3,
          child: InkWell(
            onTap: isDisabled ? null : onPressed,
            borderRadius: BorderRadius.circular(14),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
