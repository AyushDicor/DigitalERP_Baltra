import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: CircularProgressIndicator(color: purpleColor),
    );
  }
}
