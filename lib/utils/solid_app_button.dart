import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:flutter/material.dart';

class SolidAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final Color topColor;
  final Color bottomColor;
  final double textSize;
  final double? vPadding, hPadding;

  const SolidAppButton(
      {Key? key,
      required this.onPressed,
      required this.name,
      required this.topColor,
      required this.bottomColor,
      required this.textSize,
      this.hPadding,
      this.vPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              topColor,
              bottomColor,
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: hPadding ?? 20, vertical: vPadding ?? 8),
        child: Text(
          name,
          style: const TextStyle().bold.copyWith(fontSize: textSize, color: Colors.white),
        ),
      ),
    );
  }
}
