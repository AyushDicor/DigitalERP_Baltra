import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// class NetworkService extends GetxService {
//   var isAvailable = false.obs;
//   final connectivity = Connectivity();
//   late StreamSubscription _streamSubscription;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getNetworkConnectionType();
//     _streamSubscription = connectivity.onConnectivityChanged.listen(_updateState);
//   }
//
//   Future<void> getNetworkConnectionType() async {
//     ConnectivityResult? connectivityResult;
//     try {
//       connectivityResult = await (connectivity.checkConnectivity());
//     } on PlatformException catch (e) {
//       log(e.toString());
//     }
//     return _updateState(connectivityResult);
//   }
//
//   void _updateState(ConnectivityResult? result) {
//     switch (result) {
//       case ConnectivityResult.wifi:
//       case ConnectivityResult.mobile:
//         isAvailable.value = true;
//         break;
//       case ConnectivityResult.none:
//         isAvailable.value = false;
//         break;
//       default:
// /*
//         final ctrl = Get.find<AppBaseController>();
// */
//         ShowMessage.showSnackBar('', 'Network Error\nFailed to get Network Status');
//         isAvailable.value = false;
//         break;
//     }
//   }
//
//   @override
//   void onClose() {
//     _streamSubscription.cancel();
//   }
// }
class NetworkService extends GetxService {
  var isAvailable = false.obs;
  final connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getNetworkConnectionType();
    _streamSubscription =
        connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getNetworkConnectionType() async {
    try {
      final results = await connectivity.checkConnectivity();
      if (results.isNotEmpty) {
        _updateState(results);
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  void _updateState(List<ConnectivityResult> results) {
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        isAvailable.value = true;
        break;
      case ConnectivityResult.none:
        isAvailable.value = false;
        break;
      default:
        ShowMessage.showSnackBar(
            '', 'Network Error\nFailed to get Network Status');
        isAvailable.value = false;
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
