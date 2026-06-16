import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class OpenFile {
  static const MethodChannel _channel = MethodChannel('open_file');

  OpenFile._();

  ///linuxDesktopName like 'xdg'/'gnome'
  static Future<OpenResult> open(String? filePath,
      {String? type,
        String? uti,
        String linuxDesktopName = "xdg",
        bool linuxByProcess = false}) async {
    assert(filePath != null);
    if (!Platform.isIOS && !Platform.isAndroid) {
      int? _result;
      var _windowsResult;

      return OpenResult(
          type: _result == 0 ? ResultType.done : ResultType.error,
          message: _result == 0
              ? "done"
              : _result == -1
              ? "This operating system is not currently supported"
              : "there are some errors when open $filePath${Platform.isWindows ? "   HINSTANCE=$_windowsResult" : ""}");
    }

    Map<String, String?> map = {
      "file_path": filePath!,
      "type": type,
      "uti": uti,
    };
    final _result = await _channel.invokeMethod('open_file', map);
    final resultMap = json.decode(_result) as Map<String, dynamic>;
    return OpenResult.fromJson(resultMap);
  }
}

class OpenResult {
  ResultType type;
  String message;

  OpenResult({this.type = ResultType.done, this.message = "done"});

  OpenResult.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        type = _convertJson(json['type']);

  static ResultType _convertJson(int? jsonType) {
    switch (jsonType) {
      case -1:
        return ResultType.noAppToOpen;
      case -2:
        return ResultType.fileNotFound;
      case -3:
        return ResultType.permissionDenied;
      case -4:
        return ResultType.error;
    }
    return ResultType.done;
  }
}

enum ResultType {
  done,
  fileNotFound,
  noAppToOpen,
  permissionDenied,
  error,
}