import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final VoidCallback onPress;
  final bool isDoneButton;

  const DialogButton({Key? key, required this.onPress, this.isDoneButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 40,
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
        ),
        child: MaterialButton(
          onPressed: onPress,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
          child: Text(
            isDoneButton ? 'Done' : 'Apply',
            style: const TextStyle().bold.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


class DialogSubmitButton extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonName;
  final  double? height;
  final  double? width;

  const DialogSubmitButton({Key? key, required this.onPress, required this.buttonName,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height:height,
        width: width,
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
        ),
        child: MaterialButton(
          onPressed: onPress,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 10,),
          child: Text(
           buttonName,
            style: const TextStyle().bold.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

