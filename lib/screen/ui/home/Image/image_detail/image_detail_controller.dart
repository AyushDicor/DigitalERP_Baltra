import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:digitalerp/response/image_list_resp.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class ImageDetailController extends AppBaseController {
  bool isReadOnly = true;
  final TextEditingController groupController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode groupFocus = FocusNode();
  final FocusNode titleFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  late final ImageListRespData? data;
  final GlobalKey globalKey = GlobalKey();

  @override
  onInit() {
    if (Get.arguments is ImageListRespData) {
      data = Get.arguments;
      groupController.text = data?.groupName ?? '';
      titleController.text = data?.title ?? '';
      descriptionController.text = data?.description ?? '';
    } else {
      data = null;
    }
    super.onInit();
  }

  Future<String> makeImage(bool isDownload) async {
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
    var cachePath = '${temp.path}/$fileName.jpg';
    final devicePath = await getExternalStorageDirectory();
    final downloadPath = '${await getDownloadPath()}/$fileName.jpg';
    // File(cachePath).writeAsBytesSync(pngBytes);
    // File(data?.image??'').copy(cachePath);
    var r = await http.get(Uri.parse(data?.image ?? ''));
    File(cachePath).writeAsBytesSync(r.bodyBytes);
    if (isDownload) {
      File(downloadPath).writeAsBytesSync(pngBytes);
      return downloadPath;
    } else {
      return cachePath;
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> tapOnShareButton() async {
    try {
      final path = await makeImage(false); // e.g. /tmp/snap.png or .jpg
      if (path == null || path.isEmpty) {
        throw Exception('No image to share');
      }

      final ext = p.extension(path).toLowerCase();
      final mime =
          (ext == '.jpg' || ext == '.jpeg') ? 'image/jpeg' : 'image/png';
      final name = 'image_${DateTime.now().millisecondsSinceEpoch}$ext';

      await SharePlus.instance.share(
        ShareParams(
          text: 'Image Shared',
          files: [XFile(path, name: name, mimeType: mime)],
          // fileNameOverrides: [name], // optional
          // sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1), // iPad popover (optional)
        ),
      );
    } catch (e, st) {
      debugPrint('tapOnShareButton error: $e\n$st');
      // ShowMessage.showSnackBar('Share Error', e.toString());
    }
  }

  void tapOnEditButton() {
    isReadOnly = !isReadOnly;
    update();
  }

  void tapOnDownloadButton() async {
    final imagePath = await makeImage(true);
    ShowMessage.showSnackBar('Info', 'Image save successfully in $imagePath');
  }
}
