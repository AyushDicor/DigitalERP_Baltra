// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';
//
// import '../app_constant_new.dart';
//
// /// Decodes a base64 string, writes it to a temp file, returns the file path.
// /// [fileName] should include extension e.g. "receipt_123.jpg" or "ref_123.pdf"
// Future<String?> _saveBase64ToTempFile(String base64Str, String fileName) async {
//   try {
//     // Strip data URI prefix if present: "data:image/jpeg;base64,/9j/..."
//     final cleanBase64 = base64Str.contains(',')
//         ? base64Str.split(',').last
//         : base64Str;
//
//     final bytes = base64Decode(cleanBase64);
//     final dir   = await getTemporaryDirectory();
//     final file  = File('${dir.path}/$fileName');
//     await file.writeAsBytes(bytes);
//     return file.path;
//   } catch (e) {
//     debugPrint('Base64 decode error: $e');
//     return null;
//   }
// }
//
// /// Returns 'image', 'pdf', or 'unknown'
// String _detectFileType(String base64Str, {String? fileName}) {
//   // Check data URI prefix first  e.g. "data:image/png;base64,..."
//   if (base64Str.startsWith('data:image')) return 'image';
//   if (base64Str.startsWith('data:application/pdf')) return 'pdf';
//
//   // Fall back to filename extension
//   final ext = (fileName ?? '').split('.').last.toLowerCase();
//   if (['jpg', 'jpeg', 'png', 'webp', 'gif'].contains(ext)) return 'image';
//   if (ext == 'pdf') return 'pdf';
//
//   // Peek at raw bytes — PDF magic bytes are "%PDF"
//   try {
//     final clean =
//     base64Str.contains(',') ? base64Str.split(',').last : base64Str;
//     final bytes = base64Decode(clean.substring(0, 8.clamp(0, clean.length)));
//     if (bytes.length >= 4 &&
//         bytes[0] == 0x25 &&
//         bytes[1] == 0x50 &&
//         bytes[2] == 0x44 &&
//         bytes[3] == 0x46) return 'pdf';
//   } catch (_) {}
//
//   return 'unknown';
// }
//
// Future<void> _openBase64File(String base64Data, String fileName) async {
//   try {
//     // Show loading
//     Get.dialog(
//       const Center(child: CircularProgressIndicator(color: purpleColor)),
//       barrierDismissible: false,
//     );
//
//     final filePath = await _saveBase64ToTempFile(base64Data, fileName);
//     Get.back(); // dismiss loading
//
//     if (filePath == null) {
//       Get.snackbar("Error", "Could not prepare file",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
//
//     final result = await OpenFilex.open(filePath);
//
//     if (result.type != ResultType.done) {
//       Get.snackbar("Error", "No app found to open this file",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   } catch (e) {
//     Get.back(); // dismiss loading if still shown
//     Get.snackbar("Error", "Failed to open file: $e",
//         backgroundColor: Colors.red, colorText: Colors.white);
//   }
// }
//
