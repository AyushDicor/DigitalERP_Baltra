// import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';

class AliceInterceptor {
  static final AliceInterceptor _instance = AliceInterceptor._internal();
  factory AliceInterceptor() => _instance;
  AliceInterceptor._internal();

  static final Alice _alice = Alice(
    showInspectorOnShake: false,
    navigatorKey: GlobalKey<NavigatorState>(),
    showNotification: false,
  );

  static Alice get getAlice => _alice;
}
