package com.globenex.erp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.webviewflutter.WebViewFlutterPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(WebViewFlutterPlugin())
    }
}

//package com.example.digitalerp
//
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity: FlutterActivity()