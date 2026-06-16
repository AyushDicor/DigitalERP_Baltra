import 'dart:io';

import 'package:camera/camera.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/Image/image_preview_cam/image_preview_cam_controller.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreviewCamView extends StatelessWidget {
  const ImagePreviewCamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePreviewCamController>(
      init: ImagePreviewCamController(),
      builder: (controller) => Scaffold(
        backgroundColor: purpleColor,
        body: Center(
          child: controller.isBusy
              ? Stack(
                  children: [
                    showLoader(color: Colors.white),
                    // Image.file(
                    //   File(controller.captureImage?.path ?? ''),
                    //   fit: BoxFit.contain,
                    //   width: double.maxFinite,
                    // )
                  ],
                )
              : Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      top: 0,
                      child: SafeArea(
                        child: FutureBuilder<void>(
                          future: controller.initializeControllerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return CameraPreview(controller.cameraController);
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: SafeArea(
                          child: MyAppBar(title: '', onBackTap: () => controller.backTap())),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: controller.isBusy
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : AppBottomButton(
                              onPressed: () => controller.tapOnCaptureAndPreview(),
                              name: 'Capture and Preview'),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
