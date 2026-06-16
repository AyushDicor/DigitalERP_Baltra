import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/Image/image_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ImagePreviewController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  final TextEditingController groupController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode groupFocus = FocusNode();
  final FocusNode titleFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  late final GlobalKey globalKey;

  // List<CommonDropdown> groupList = [CommonDropdown(0, 'ABC'), CommonDropdown(1, 'DEF')];
  // CommonDropdown? selectedGroupDropdownValue;
  ImagePreviewArgument captureImage;

  ImagePreviewController(this.captureImage, BuildContext context) {
    globalKey = GlobalKey();
  }

  // void setSelectDropdownValue({required CommonDropdown value}) {
  //   selectedGroupDropdownValue = value;
  //   update();
  // }
  @override
  void onInit() {
    getGroupList();
    // makeImage2();
    super.onInit();
  }

  Future<void> onTapSave() async {
    if (selectedGroupDropdownValue == null) {
      ShowMessage.showSnackBar('', 'Please select Group');
      return;
    } else if (titleController.text.isEmpty) {
      ShowMessage.showSnackBar('', 'Title is required');
      return;
    } else if (descriptionController.text.isEmpty) {
      ShowMessage.showSnackBar('', 'Description is required');
      return;
    }
    setBusy(true);
    await makeImage2();
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] =
          homeController.currentUserData?.branchId.toString() ?? '39';
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '342613';
      body['groupid'] =
          selectedGroupDropdownValue?.categoryid.toString() ?? '0';
      body['title'] = titleController.text;
      body['description'] = descriptionController.text;
      final bytes = captureImage.file.readAsBytesSync();
      String img64 = base64Encode(bytes);
      body['image'] = img64;
      body['imagename'] = captureImage.file.path.split('/').last;
      // log(body.toString());
      // return;
      var res = await api.saveImageStamping(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar('Success', res.message ?? '');
        update();
        Get.offAndToNamed(AppRoutes.home, arguments: 4);
        // Get.offAllNamed(AppRoutes.dashboard,arguments:7);
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  StockCategoryList? selectedGroupDropdownValue;
  List<StockCategoryList>? groupList;

  void setSelectGroup(StockCategoryList? value) {
    selectedGroupDropdownValue = value;
    update();
  }

  Future<void> getGroupList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      var res = await api.categoryListForeImageStamping(body);
      if (res.status == 200) {
        groupList = res.data ?? [];
        update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {}
  }

  Future<void> makeImage2() async {
    // Decode base/original image
    final originalImage = img.decodeImage(captureImage.file.readAsBytesSync());
    final stampImage =
        img.decodeImage(io.File(await makeImage()).readAsBytesSync());

    if (originalImage == null || stampImage == null) return;

    // ✅ Use compositeImage to place stamp on original
    img.compositeImage(
      originalImage,
      stampImage,
      dstX: 0, // position X
      dstY: 0, // position Y
      // You can also scale here:
      // dstW: originalImage.width,
      // dstH: originalImage.height,
    );

    // Save updated image
    final wmImage = img.encodePng(originalImage);
    await captureImage.file.writeAsBytes(wmImage);
    update();
  }
  // Future<void> makeImage2() async {
  //   img.Image? originalImage =
  //       img.decodeImage(captureImage.file.readAsBytesSync());
  //   img.Image? stampImage =
  //       img.decodeImage(io.File(await makeImage()).readAsBytesSync());
  //   // img.drawImage(originalImage!, stampImage!,srcH: (originalImage.height*.5).toInt(),srcW:
  //   // (originalImage.height*.5).toInt());
  //   img.compositeImage(originalImage!, stampImage!,
  //       dstH: originalImage.height, dstW: originalImage.width);
  //
  //   // for adding text over image
  //   // Draw some text using 24pt arial font
  //   // 100 is position from x-axis, 120 is position from y-axis
  //   // img.drawString(originalImage!, img.arial_48, 30, 200, 'LAT - ${captureImage.lat}\nLON - '
  //   //     '${captureImage.long}\nADD - ${captureImage.location*3}');
  //   // Store the watermarked image to a File
  //   List<int> wmImage = img.encodePng(originalImage);
  //   await captureImage.file.writeAsBytes(wmImage);
  //   update();
  //
  //   /*StampImage.create(
  //     context: ctx,
  //     image: captureImage.file,
  //     children: [
  //       Positioned(
  //           left: 0,
  //           right: 0,
  //           bottom: 10,
  //           child: Container(
  //             // decoration: BoxDecoration(
  //             //     color: blueColor.wihValues(alpha:0.3),
  //             //     borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15))),
  //             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
  //             // alignment: Alignment.center,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   // '3929 Jehovah Drive Fredericksburg',
  //                   'LAT - ${captureImage.lat}',
  //                   style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.white),
  //                 ),
  //                 const SizedBox(height: 3,),
  //                 Text(
  //                   // '3929 Jehovah Drive Fredericksburg',
  //                   'LON - ${captureImage.long}',
  //                   style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.white),
  //                 ),
  //                 const SizedBox(height: 3,),
  //
  //                 Text(
  //                   // '3929 Jehovah Drive Fredericksburg',
  //                   'ADD - ${captureImage.location}',
  //                   style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.white),
  //                 ),
  //                 const SizedBox(height: 3,),
  //
  //               ],
  //             ),
  //           ))
  //     ],
  //     onSuccess: (file){
  //       captureImage.file=file;
  //       update();
  //       print('captureImage.file=file;');
  //     },
  //   );*/
  // }

  Future<String> makeImage() async {
    String fileName = DateTime.now()
        .toString()
        .replaceAll('-', '_')
        .replaceAll(' ', '_')
        .replaceAll(':', '_')
        .split('.')
        .first;
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    final temp = await getTemporaryDirectory();
    final cachePath = '${temp.path}/$fileName.jpg';
    io.File(cachePath).writeAsBytesSync(pngBytes);
    return cachePath;
  }

/*
  bool _validate() {
    if (selectedGroupDropdownValue == null) {
      ShowMessage.showSnackBar(requiredFieldTxt, selectGroupTxt);
      return false;
    }
    if (titleController.text.isEmpty) {
      ShowMessage.showSnackBar(requiredFieldTxt, pleaseEnterTitleTxt);
      return false;
    }
    if (descriptionController.text.isEmpty) {
      ShowMessage.showSnackBar(requiredFieldTxt, pleaseEnterDesTxt);
      return false;
    }
    return true;
  }
*/
}
