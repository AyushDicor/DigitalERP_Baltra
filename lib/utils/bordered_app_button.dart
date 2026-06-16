import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:flutter/material.dart';

class BorderedAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final Color color;
  final double? textSize;
  final double? vPadding, hPadding;

  const BorderedAppButton(
      {Key? key,
      required this.onPressed,
      required this.name,
      required this.color,
      this.textSize,
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
            border: Border.all(color: color, width: 1),
            color: Colors.transparent),
        padding: EdgeInsets.symmetric(
            horizontal: hPadding ?? 20, vertical: vPadding ?? 8),
        child: Text(
          name,
          style: const TextStyle()
              .bold
              .copyWith(fontSize: textSize ?? 16, color: color),
        ),
      ),
    );
  }
}
