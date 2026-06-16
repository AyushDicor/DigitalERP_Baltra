import 'dart:io';

import 'package:camera/camera.dart';
import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/Image/image_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ImagePreviewCamController extends AppBaseController {
  late CameraController cameraController;
  Future<void>? initializeControllerFuture;
  XFile? captureImage;
  @override
  void onInit() async {
    // TODO: implement onInit
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    cameraController = CameraController(
      firstCamera,
      ResolutionPreset.max,
    );
    initializeControllerFuture = cameraController.initialize();
    Future.delayed(const Duration(milliseconds: 500)).then((value) => update());
    super.onInit();
  }


  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.onClose();
  }

  void tapOnCaptureAndPreview() async {
    captureImage = await cameraController.takePicture();
    setBusy(true);
    String location = await getUserCurrentAddress();
    var pos = await getUserCurrentPosition();
    Get.offNamed(
      AppRoutes.imagePreview,
      arguments: ImagePreviewArgument(
          file: File(captureImage!.path),
          location: location,
          lat: pos.latitude.toString(),
          long: pos.longitude.toString()),
    );
    setBusy(false);
  }
}
