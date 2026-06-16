 import 'package:flutter/material.dart';

class Shared{
static bool keyboardIsVisible(BuildContext context) {
  return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
}
}
