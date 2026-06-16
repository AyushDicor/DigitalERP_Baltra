import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/dialog_button.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogBgWidget extends StatelessWidget {
  final bool isEdit;

  final List<Widget> children;
  final VoidCallback onApplyOrDoneButtonTap;

  const DialogBgWidget({
    Key? key,
    this.isEdit = false,
    required this.children,
    required this.onApplyOrDoneButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: customGradient(
            topColor: purpleColor,
            bottomColor: blueColor,
            opacity: 0.20,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 40,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(
                top: 25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEdit ? AppString.edit : AppString.filter,
                    style: const TextStyle().bold.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                  const SizedBox(height: 35),
                  DialogSubmitButton(
                    onPress: onApplyOrDoneButtonTap,
                    buttonName: "Search",
                    height: 40,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 8,
              child: InkWell(
                onTap: () {
                  Get.back();
                  // Navigator.of(context).pop();
                },
                child: Image.asset(
                  AppAssets.coloredCloseIcon,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class DialogNewWidget extends StatelessWidget {
  final bool isEdit;
    final String text;
    final String?  buttonName;
  final List<Widget> children;
  final VoidCallback onApplyOrDoneButtonTap;

  const DialogNewWidget({
    Key? key,
    this.buttonName,
    this.isEdit = false,
    required this.text,
    required this.children,
    required this.onApplyOrDoneButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: customGradient(
            topColor: purpleColor,
            bottomColor: blueColor,
            opacity: 0.20,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 40,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(
                top: 25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      isEdit ==false? AppString.edit : text,
                      style: const TextStyle().bold.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                  const SizedBox(height: 35),
                  DialogSubmitButton(
                    buttonName: buttonName??"",
                    height: Get.height*0.035,

                    onPress: onApplyOrDoneButtonTap,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 8,
              child: InkWell(
                onTap: () {
                  Get.back();
                  // Navigator.of(context).pop();
                },
                child: Image.asset(
                  AppAssets.coloredCloseIcon,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


