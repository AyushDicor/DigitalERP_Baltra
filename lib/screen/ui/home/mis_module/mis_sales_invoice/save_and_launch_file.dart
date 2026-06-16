// // ignore_for_file: empty_catches
//
// import 'dart:io';
//
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
//
// Future<String> saveAndLaunchFile(List<int> bytes, String fileName) async {
//   try {
//     final permissionStatus = await Helper.isPhotoPermissionGranted();
//
//     // final storageStatus = await getStoragePermission();
//     if (!permissionStatus) {
//       Helper.showBottomFlash(false, 'Alert', "Enable Storage Permission");
//     }
//
//     // return saveFile(fileName, bytes);
//
//     String? path;
//     if (Platform.isAndroid ||
//         Platform.isIOS ||
//         Platform.isLinux ||
//         Platform.isWindows) {
//       path = await getDownloadPath();
//       if (path == null) {
//         final Directory directory =
//             await path_provider.getApplicationSupportDirectory();
//         path = directory.path;
//       }
//     } else {
//       path = (await PathProviderPlatform.instance.getApplicationSupportPath())!;
//     }
//     final File file =
//         File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
//
//     await file.writeAsBytes(
//       bytes,
//     );
//
//     return file.path;
//   } catch (e) {
//     return "";
//   }
// }
//
// Future<String> saveFile(String fileName, List<int> bytes) async {
//   Directory? directory;
//   File? file;
//   try {
//     if (Platform.isAndroid) {
//       directory = Directory('/storage/emulated/0/Download');
//     } else {
//       directory = await path_provider.getApplicationDocumentsDirectory();
//     }
//
//     bool hasExisted = await directory.exists();
//     if (!hasExisted) {
//       directory.create();
//     }
//     file = File("${directory.path}${Platform.pathSeparator}$fileName");
//     if (!file.existsSync()) {
//       await file.create();
//     }
//     await file.writeAsBytes(bytes);
//     return file.path;
//   } catch (e) {
//     if (file != null && file.existsSync()) {
//       file.deleteSync();
//     }
//     return "";
//   }
// }
//
// Future<String?> getDownloadPath() async {
//   Directory? directory;
//   try {
//     if (Platform.isIOS) {
//       directory = await path_provider.getApplicationDocumentsDirectory();
//       // directory = await path_provider.getDownloadsDirectory();
//     } else {
//       directory = Directory('/storage/emulated/0/Download');
//       final existsPathStatus = await directory.exists();
//
//       if (!existsPathStatus) {
//         directory = (await path_provider.getExternalStorageDirectory())!;
//       }
//     }
//   } catch (err) {
//   }
//   return directory?.path;
// }
//
// Future<void> openInvoice(String path) async {
//   return;
// /*  if (Platform.isAndroid || Platform.isIOS) {
//     await open_file.OpenFile.open(path).then((value) {
//       if (value.type == open_file.ResultType.noAppToOpen) {
//         Helper.showBottomFlash(
//             false, 'Alert', "Please first install excel app");
//       } else if (value.type == open_file.ResultType.error) {
//         Helper.showBottomFlash(
//             false, 'Alert', "Something want wrong, please try again");
//       } else if (value.type == open_file.ResultType.fileNotFound) {
//         Helper.showBottomFlash(
//             false, 'Alert', "File not found, please try again");
//       } else if (value.type == open_file.ResultType.permissionDenied) {
//         Helper.showBottomFlash(false, 'Alert', "Please allow permission");
//       }
//     });
//   }*/
// }
