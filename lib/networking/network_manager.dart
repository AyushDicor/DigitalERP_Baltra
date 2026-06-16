import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  int connectionType = 0;
  var isNetworkAvailable = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    await getNetworkConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getNetworkConnectionType() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.isNotEmpty) {
        _updateState(results);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void _updateState(List<ConnectivityResult> results) {
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        isNetworkAvailable(true);
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        isNetworkAvailable(true);
        update();
        break;
      case ConnectivityResult.none:
        isNetworkAvailable(false);
        connectionType = 0;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}

// class NetworkManager extends GetxController {
//   int connectionType = 0;
//   var isNetworkAvailable = false.obs;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription _streamSubscription;
//
//   @override
//   void onInit() async {
//     super.onInit();
//     await getNetworkConnectionType();
//     _streamSubscription =
//         _connectivity.onConnectivityChanged.listen(_updateState);
//   }
//
//   Future<void> getNetworkConnectionType() async {
//     // ignore: prefer_typing_uninitialized_variables
//     var connectivityResult;
//     try {
//       connectivityResult = await (_connectivity.checkConnectivity());
//     } on PlatformException catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//     return _updateState(connectivityResult);
//   }
//
//   _updateState(ConnectivityResult result) {
//     switch (result) {
//       case ConnectivityResult.wifi:
//         connectionType = 1;
//         isNetworkAvailable(true);
//         update();
//         break;
//       case ConnectivityResult.mobile:
//         connectionType = 2;
//         isNetworkAvailable(true);
//         update();
//         break;
//       case ConnectivityResult.none:
//         isNetworkAvailable(false);
//         connectionType = 0;
//         update();
//         break;
//       default:
//         Get.snackbar('Network Error', 'Failed to get Network Status');
//         break;
//     }
//   }
//
//   @override
//   void onClose() {
//     _streamSubscription.cancel();
//   }
// }
