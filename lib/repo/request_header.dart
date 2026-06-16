import 'package:flutter/foundation.dart';

void debugPrintData({required dynamic tittle, dynamic val}) {
  if (kDebugMode) {
    debugPrint("$tittle:-$val");
  }
}

String errorText = "Something went wrong";
String statusText = "Success";

Map<String, String> requestHeader() {
  return {"Content-Type": "application/json"};
}
// TODO Implement this library.