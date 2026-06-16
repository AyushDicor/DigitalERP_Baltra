import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:digitalerp/utils/app_constant_new.dart';

class FilePickerDialog {
  static void show({
    required Function(String base64, String fileName, String filePath) onFileSelected,
    bool allowMultiple = false,
    List<String> allowedExtensions = const ['pdf', 'xlsx', 'xls', 'jpg', 'jpeg', 'png'],
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose Option',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Gallery
            _buildDialogOption(
              'Select from Gallery',
                  () => _pickImage(ImageSource.gallery, onFileSelected),
            ),
            const SizedBox(height: 8),

            // Camera
            _buildDialogOption(
              'Take a Photo',
                  () => _pickImage(ImageSource.camera, onFileSelected),
            ),
            const SizedBox(height: 8),

            // Documents
            _buildDialogOption(
              'Choose Document',
                  () => _pickDocument(onFileSelected, allowedExtensions),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static Widget _buildDialogOption(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: newBlueLightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: newBlueColor,
          ),
        ),
      ),
    );
  }

  static Future<void> _pickImage(
      ImageSource source,
      Function(String, String, String) onFileSelected,
      ) async {
    Get.back(); // Close bottom sheet

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 65,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final base64String = base64.encode(file.readAsBytesSync());
      final fileName = file.path.split('/').last;

      onFileSelected(base64String, fileName, file.path);

      _showSuccessMessage(fileName);
    }
  }

  static Future<void> _pickDocument(
      Function(String, String, String) onFileSelected,
      List<String> allowedExtensions,
      ) async {
    Get.back(); // Close bottom sheet

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);

        // Check file size (10MB limit)
        final fileSize = await file.length();
        if (fileSize > 10 * 1024 * 1024) {
          _showErrorMessage('File too large. Maximum size is 10MB');
          return;
        }

        final base64String = base64.encode(file.readAsBytesSync());
        final fileName = result.files.single.name;

        onFileSelected(base64String, fileName, file.path);

        _showSuccessMessage(fileName);
      }
    } catch (e) {
      _showErrorMessage('Failed to pick file: $e');
    }
  }

  static void _showSuccessMessage(String fileName) {
    Get.snackbar(
      'File Selected',
      fileName,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: newGreenLightColor,
      colorText: newGreenColor,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );
  }

  static void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
    );
  }
}