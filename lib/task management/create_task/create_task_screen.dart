// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../response/task_dropdown_response.dart';
// import 'create_task_controller.dart';
//
// class CreateTaskBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<CreateTaskController>(
//             () => CreateTaskController());
//   }
// }
//
// class CreateTaskScreen extends StatelessWidget {
//   const CreateTaskScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CreateTaskController>(
//       init: CreateTaskController(),
//       builder: (ctrl) => Scaffold(
//         backgroundColor: const Color(0xFFF4F6FB),
//         body: SafeArea(
//           bottom: false,
//           child: Column(
//             children: [
//               MyAppBar(
//                 title: 'Create Direct Task',
//                 onBackTap: () => Get.back(),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.only(
//                     left: 16,
//                     right: 16,
//                     top: 16,
//                     bottom:
//                     MediaQuery.of(context).viewInsets.bottom + 100,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Task Date
//                       _sectionLabel('Task Date'),
//                       const SizedBox(height: 8),
//                       _datePicker(
//                         context,
//                         ctrl.taskDateController,
//                         'Select task date',
//                             (date) => ctrl.setTaskDate(date),
//                         firstDate: DateTime(2020),
//                         lastDate: DateTime.now()
//                             .add(const Duration(days: 365)),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Task Description
//                       _sectionLabel('Task Description'),
//                       const SizedBox(height: 8),
//                       _textField(
//                         ctrl.taskController,
//                         ctrl.taskFocus,
//                         'Enter task description',
//                         minLines: 3,
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Assigned To
//                       _sectionLabel('Assigned To'),
//                       const SizedBox(height: 8),
//                       _dropdownField<TaskDropdownItem>(
//                         hint: 'Select person',
//                         items: ctrl.taskToList,
//                         selected: ctrl.selectedTaskTo,
//                         labelBuilder: (e) => e.name ?? '',
//                         onChanged: ctrl.setTaskTo,
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Given By
//                       _sectionLabel('Given By'),
//                       const SizedBox(height: 8),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF0F0F0),
//                           borderRadius: BorderRadius.circular(14),
//                           border: Border.all(color: newBorderColor),
//                         ),
//                         child: Text(
//                           ctrl.givenByName,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: newTextPrimary,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                      // Client Reference — show only if list has data
//                       if (ctrl.clientRefList.isNotEmpty) ...[
//                         _sectionLabel('Client Reference'),
//                         const SizedBox(height: 8),
//                         _dropdownField<TaskDropdownItem>(
//                           hint: 'Select client',
//                           items: ctrl.clientRefList,
//                           selected: ctrl.selectedClientRef,
//                           labelBuilder: (e) => e.name ?? '',
//                           onChanged: ctrl.setClientRef,
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//
//                       // Client Reference
//                       _sectionLabel('Client Reference'),
//                       const SizedBox(height: 8),
//                       _dropdownField<TaskDropdownItem>(
//                         hint: 'Select client',
//                         items: ctrl.clientRefList,
//                         selected: ctrl.selectedClientRef,
//                         labelBuilder: (e) => e.name ?? '',
//                         onChanged: ctrl.setClientRef,
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Site
//                       _sectionLabel('Site'),
//                       const SizedBox(height: 8),
//                       _dropdownField<TaskDropdownItem>(
//                         hint: 'Select site',
//                         items: ctrl.siteList,
//                         selected: ctrl.selectedSite,
//                         labelBuilder: (e) => e.name ?? '',
//                         onChanged: ctrl.setSite,
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Priority
//                       _sectionLabel('Priority'),
//                       const SizedBox(height: 8),
//                       _dropdownField<TaskDropdownItem>(
//                         hint: 'Select priority',
//                         items: ctrl.priorityList,
//                         selected: ctrl.selectedPriority,
//                         labelBuilder: (e) => e.name ?? '',
//                         onChanged: ctrl.setPriority,
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Due Date
//                       _sectionLabel('Due Date'),
//                       const SizedBox(height: 8),
//                       _datePicker(
//                         context,
//                         ctrl.dueDateController,
//                         'Select due date',
//                             (date) => ctrl.setDueDate(date),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime.now()
//                             .add(const Duration(days: 365)),
//                       ),
//                       const SizedBox(height: 28),
//
//                       // Submit button
//                       _submitButton(ctrl),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   //  Section label 
//   Widget _sectionLabel(String label) => Text(
//     label,
//     style: const TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.w600,
//       color: newTextPrimary,
//     ),
//   );
//
//   //  Shared input decoration 
//   BoxDecoration _boxDecoration() => BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(14),
//     border: Border.all(color: newBorderColor),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withValues(alpha: 0.04),
//         blurRadius: 8,
//         offset: const Offset(0, 2),
//       ),
//     ],
//   );
//
//   //  Text field 
//   Widget _textField(
//       TextEditingController ctrl,
//       FocusNode focus,
//       String hint, {
//         int minLines = 1,
//         TextInputType keyboardType = TextInputType.text,
//       }) =>
//       Container(
//         decoration: _boxDecoration(),
//         child: TextField(
//           controller: ctrl,
//           focusNode: focus,
//           minLines: minLines,
//           maxLines: minLines > 1 ? 6 : 1,
//           keyboardType: keyboardType,
//           style: const TextStyle(fontSize: 14, color: newTextPrimary),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle:
//             const TextStyle(color: newTextHint, fontSize: 14),
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 14, vertical: 14),
//           ),
//         ),
//       );
//
//   //  Dropdown field 
//   Widget _dropdownField<T>({
//     required String hint,
//     required List<T> items,
//     required T? selected,
//     required String Function(T) labelBuilder,
//     required ValueChanged<T?> onChanged,
//   }) =>
//       Container(
//         decoration: _boxDecoration(),
//         padding:
//         const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<T>(
//             isExpanded: true,
//             value: items.contains(selected) ? selected : null,
//             hint: Text(hint,
//                 style: const TextStyle(
//                     color: newTextHint, fontSize: 14)),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: newTextSecondary),
//             style: const TextStyle(
//                 fontSize: 14, color: newTextPrimary),
//             dropdownColor: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             items: items
//                 .map((e) => DropdownMenuItem<T>(
//               value: e,
//               child: Text(labelBuilder(e)),
//             ))
//                 .toList(),
//             onChanged: items.isEmpty ? null : onChanged,
//           ),
//         ),
//       );
//
//   //  Date picker 
//   Widget _datePicker(
//       BuildContext context,
//       TextEditingController ctrl,
//       String hint,
//       ValueChanged<DateTime> onPicked, {
//         required DateTime firstDate,
//         required DateTime lastDate,
//       }) =>
//       GestureDetector(
//         onTap: () async {
//           final picked = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: firstDate,
//             lastDate: lastDate,
//             builder: (c, child) => Theme(
//               data: ThemeData.light().copyWith(
//                 colorScheme:
//                 const ColorScheme.light(primary: newBlueColor),
//               ),
//               child: child!,
//             ),
//           );
//           if (picked != null) onPicked(picked);
//         },
//         child: Container(
//           decoration: _boxDecoration(),
//           padding: const EdgeInsets.symmetric(
//               horizontal: 14, vertical: 14),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 ctrl.text.isEmpty ? hint : ctrl.text,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: ctrl.text.isEmpty
//                       ? newTextHint
//                       : newTextPrimary,
//                 ),
//               ),
//               const Icon(Icons.calendar_today_outlined,
//                   size: 18, color: newTextSecondary),
//             ],
//           ),
//         ),
//       );
//
//   //  Submit button 
//   Widget _submitButton(CreateTaskController ctrl) => Obx(
//         () => SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: ElevatedButton(
//         onPressed: ctrl.isLoading.value
//             ? null
//             : ctrl.submitCreateTask,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: newBlueColor,
//           disabledBackgroundColor:
//           newBlueColor.withValues(alpha: 0.5),
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//         ),
//         child: ctrl.isLoading.value
//             ? const SizedBox(
//           height: 20,
//           width: 20,
//           child: CircularProgressIndicator(
//             color: Colors.white,
//             strokeWidth: 2,
//           ),
//         )
//             : const Text(
//           'Submit',
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.w700),
//         ),
//       ),
//     ),
//   );
// }
import 'dart:convert';
import 'dart:io';

import 'package:digitalerp/response/task_dropdown_response.dart';
import 'package:digitalerp/task%20management/create_task/create_task_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTaskController>(
      init: CreateTaskController(),
      builder: (ctrl) => Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              //  AppBar with auto task ID 
              _buildAppBar(ctrl),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  Row: Date + Priority 
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _fieldLabel('Date *'),
                                const SizedBox(height: 6),
                                _datePicker(
                                  context,
                                  ctrl.taskDateController,
                                  'Date',
                                  (date) => ctrl.setTaskDate(date),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _fieldLabel('Priority *'),
                                const SizedBox(height: 6),
                                _dropdownField<TaskDropdownItem>(
                                  hint: 'Select',
                                  items: ctrl.priorityList,
                                  selected: ctrl.selectedPriority,
                                  labelBuilder: (e) => e.name ?? '',
                                  onChanged: ctrl.setPriority,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      //  Assign To 
                      _fieldLabel('To (Assign To) *'),
                      const SizedBox(height: 6),
                      _searchableDropdown<TaskDropdownItem>(
                        hint: '---Select---',
                        items: ctrl.taskToList,
                        selected: ctrl.selectedTaskTo,
                        labelBuilder: (e) => e.name ?? '',
                        onChanged: ctrl.setTaskTo,
                      ),

                      const SizedBox(height: 16),

                      //  Given By (read-only) 
                      _fieldLabel('Given By *'),
                      const SizedBox(height: 6),
                      _readonlyField(ctrl.givenByName),
                      const SizedBox(height: 16),

                      //  Client Reference 
                      if (ctrl.clientRefList.isNotEmpty) ...[
                        _fieldLabel('Client Reference *'),
                        const SizedBox(height: 6),
                        _searchableDropdown<TaskDropdownItem>(
                          hint: '---Select---',
                          items: ctrl.clientRefList,
                          selected: ctrl.selectedClientRef,
                          labelBuilder: (e) => e.name ?? '',
                          onChanged: ctrl.setClientRef,
                        ),
                        const SizedBox(height: 16),
                      ],

                      //  Site Name 
                      _fieldLabel('Site Name *'),
                      const SizedBox(height: 6),
                      _searchableDropdown<TaskDropdownItem>(
                        hint: '--Select--',
                        items: ctrl.siteList,
                        selected: ctrl.selectedSite,
                        labelBuilder: (e) => e.name ?? '',
                        onChanged: ctrl.setSite,
                      ),
                      const SizedBox(height: 16),

                      //  Due Date 
                      _fieldLabel('Due Date *'),
                      const SizedBox(height: 6),
                      _datePicker(
                        context,
                        ctrl.dueDateController,
                        'Due Date',
                        (date) => ctrl.setDueDate(date),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ),
                      const SizedBox(height: 16),

                      //  Task Description 
                      _fieldLabel('Task *'),
                      const SizedBox(height: 6),
                      _textField(
                        ctrl.taskController,
                        ctrl.taskFocus,
                        'Enter task description...',
                        minLines: 4,
                      ),
                      const SizedBox(height: 16),

                      //  Attach Reference File 
                      _fieldLabel('Attach Reference File'),
                      const SizedBox(height: 6),
                      _filePickerField(ctrl),
                      const SizedBox(height: 28),

                      //  Submit 
                      _submitButton(ctrl),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Custom AppBar with task ID 
  Widget _buildAppBar(CreateTaskController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new,
                color: newTextPrimary, size: 20),
          ),
          const Text(
            'Assign Task',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: newTextPrimary,
            ),
          ),
          const SizedBox(width: 8),
          if (ctrl.autoTaskId > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: newBlueLightColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '#${ctrl.autoTaskId}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: newBlueColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  //  Field label 
  Widget _fieldLabel(String label) => Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: newTextPrimary,
        ),
      );

  //  Box decoration 
  BoxDecoration _boxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: newBorderColor),
      );

  //  Read-only field (Given By) 
  Widget _readonlyField(String value) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: newBorderColor),
        ),
        child: Text(
          value.isEmpty ? '---' : value,
          style: const TextStyle(
            fontSize: 14,
            color: newTextPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  //  Text field 
  Widget _textField(
    TextEditingController ctrl,
    FocusNode focus,
    String hint, {
    int minLines = 1,
  }) =>
      Container(
        decoration: _boxDecoration(),
        child: TextField(
          controller: ctrl,
          focusNode: focus,
          minLines: minLines,
          maxLines: minLines > 1 ? 8 : 1,
          style: const TextStyle(fontSize: 14, color: newTextPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: newTextHint, fontSize: 14),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          ),
        ),
      );

  //  Dropdown field 
  Widget _dropdownField<T>({
    required String hint,
    required List<T> items,
    required T? selected,
    required String Function(T) labelBuilder,
    required ValueChanged<T?> onChanged,
  }) =>
      Container(
        decoration: _boxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: items.contains(selected) ? selected : null,
            hint: Text(hint,
                style: const TextStyle(color: newTextHint, fontSize: 14)),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: newTextSecondary),
            style: const TextStyle(fontSize: 14, color: newTextPrimary),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(8),
            items: items
                .map((e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(labelBuilder(e)),
                    ))
                .toList(),
            onChanged: items.isEmpty ? null : onChanged,
          ),
        ),
      );

  //  Date picker 
  Widget _datePicker(
    BuildContext context,
    TextEditingController ctrl,
    String hint,
    ValueChanged<DateTime> onPicked, {
    required DateTime firstDate,
    required DateTime lastDate,
  }) =>
      GestureDetector(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: firstDate,
            lastDate: lastDate,
            builder: (c, child) => Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(primary: newBlueColor),
              ),
              child: child!,
            ),
          );
          if (picked != null) onPicked(picked);
        },
        child: Container(
          decoration: _boxDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ctrl.text.isEmpty ? hint : ctrl.text,
                style: TextStyle(
                  fontSize: 14,
                  color: ctrl.text.isEmpty ? newTextHint : newTextPrimary,
                ),
              ),
              const Icon(Icons.calendar_today_outlined,
                  size: 16, color: newTextSecondary),
            ],
          ),
        ),
      );

  //  File picker field 
  Widget _filePickerField(CreateTaskController ctrl) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ctrl.attachedFiles.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(ctrl.attachedFiles.length, (i) {
              final file = ctrl.attachedFiles[i];
              final displayName = file['displayName'] ?? '';  // ✅ fixed key
              final isUploading = file['isUploading'] == 'true';
              final isPdf = displayName.toLowerCase().endsWith('.pdf');

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: isUploading
                      ? const Color(0xFFF4F6FB)
                      : isPdf
                      ? const Color(0xFFFFF3E0)
                      : newBlueLightColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isUploading
                        ? newBorderColor
                        : isPdf
                        ? Colors.orange.shade300
                        : newBlueColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isUploading
                        ? const SizedBox(
                      width: 12, height: 12,
                      child: CircularProgressIndicator(
                          strokeWidth: 1.5, color: newTextSecondary),
                    )
                        : Icon(
                      isPdf ? Icons.picture_as_pdf : Icons.image,
                      size: 14,
                      color: isPdf ? Colors.orange : newBlueColor,
                    ),
                    const SizedBox(width: 5),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 130),
                      child: Text(
                        isUploading ? 'Uploading...' : displayName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isUploading
                              ? newTextSecondary
                              : isPdf
                              ? Colors.orange.shade800
                              : newBlueColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!isUploading) ...[
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => ctrl.removeAttachedFile(i),
                        child: Icon(Icons.close,
                            size: 14,
                            color: isPdf
                                ? Colors.orange.shade700
                                : newBlueColor),
                      ),
                    ],
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
        ],

        // ── Add file button — unchanged ──────────────────────
        GestureDetector(
          onTap: () => _showAttachOptions(ctrl),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: _boxDecoration(),
            child: Row(
              children: [
                const Icon(Icons.attach_file, size: 18, color: newTextSecondary),
                const SizedBox(width: 8),
                Text(
                  ctrl.attachedFiles.isEmpty
                      ? 'Tap to attach files'
                      : 'Add more files',
                  style: const TextStyle(fontSize: 14, color: newTextHint),
                ),
                const Spacer(),
                if (ctrl.attachedFiles.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: newBlueLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${ctrl.attachedFiles.length}',
                      style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700,
                        color: newBlueColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  void _showAttachOptions(CreateTaskController ctrl) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: newBorderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Attach File',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: newTextPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Camera
                Expanded(
                  child: _attachOption(
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    color: newBlueColor,
                    bgColor: newBlueLightColor,
                    onTap: () async {
                      Get.back();
                      await _pickImage(ctrl, ImageSource.camera);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Gallery
                Expanded(
                  child: _attachOption(
                    icon: Icons.photo_library_outlined,
                    label: 'Gallery',
                    color: newGreenColor,
                    bgColor: newGreenLightColor,
                    onTap: () async {
                      Get.back();
                      await _pickMultipleImages(ctrl);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // PDF
                Expanded(
                  child: _attachOption(
                    icon: Icons.picture_as_pdf_outlined,
                    label: 'PDF',
                    color: Colors.orange,
                    bgColor: const Color(0xFFFFF3E0),
                    onTap: () async {
                      Get.back();
                      await _pickPdf(ctrl);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _attachOption({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(CreateTaskController ctrl, ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source, imageQuality: 80);
    if (file != null) {
      await ctrl.addFileFromPick(file.path, file.path.split('/').last);
    }
  }

  Future<void> _pickMultipleImages(CreateTaskController ctrl) async {
    final picker = ImagePicker();
    final files = await picker.pickMultiImage(imageQuality: 80);
    for (final f in files) {
      await ctrl.addFileFromPick(f.path, f.path.split('/').last);
    }
  }

  Future<void> _pickPdf(CreateTaskController ctrl) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      for (final f in result.files) {
        if (f.path != null) {
          await ctrl.addFileFromPick(f.path!, f.name);
        }
      }
    }
  }

  //  Submit button 
  Widget _submitButton(CreateTaskController ctrl) => Obx(
        () => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: ctrl.isLoading.value ? null : ctrl.submitCreateTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: newBlueColor,
              disabledBackgroundColor: newBlueColor.withValues(alpha: 0.5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: ctrl.isLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
          ),
        ),
      );

  // ─── Searchable Dropdown ──────────────────────────────────────────────────────
  Widget _searchableDropdown<T>({
    required String hint,
    required List<T> items,
    required T? selected,
    required String Function(T) labelBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<T>(
          context: Get.context!,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => _SearchableBottomSheet<T>(
            items: items,
            selected: selected,
            labelBuilder: labelBuilder,
            hint: hint,
          ),
        );
        if (result != null) onChanged(result);
      },
      child: Container(
        decoration: _boxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selected != null ? labelBuilder(selected) : hint,
                style: TextStyle(
                  fontSize: 14,
                  color: selected != null ? newTextPrimary : newTextHint,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: newTextSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}

class _SearchableBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final T? selected;
  final String Function(T) labelBuilder;
  final String hint;

  const _SearchableBottomSheet({
    required this.items,
    required this.selected,
    required this.labelBuilder,
    required this.hint,
  });

  @override
  State<_SearchableBottomSheet<T>> createState() =>
      _SearchableBottomSheetState<T>();
}

class _SearchableBottomSheetState<T>
    extends State<_SearchableBottomSheet<T>> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<T> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = List.from(widget.items);
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = widget.items
            .where((e) =>
            widget.labelBuilder(e).toLowerCase().contains(q))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: newBorderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.hint,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary),
              ),
            ),
            const SizedBox(height: 12),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                autofocus: true,
                style: const TextStyle(fontSize: 14, color: newTextPrimary),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle:
                  const TextStyle(color: newTextHint, fontSize: 14),
                  prefixIcon: const Icon(Icons.search,
                      color: newTextSecondary, size: 20),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? GestureDetector(
                    onTap: () => _searchCtrl.clear(),
                    child: const Icon(Icons.close,
                        color: newTextSecondary, size: 18),
                  )
                      : null,
                  filled: true,
                  fillColor: const Color(0xFFF4F6FB),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: newBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: newBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: newBlueColor, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Results count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_filtered.length} result${_filtered.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                      fontSize: 11, color: newTextSecondary),
                ),
              ),
            ),

            // List
            Expanded(
              child: _filtered.isEmpty
                  ? const Center(
                child: Text('No results found',
                    style: TextStyle(
                        fontSize: 14, color: newTextSecondary)),
              )
                  : ListView.builder(
                controller: scrollCtrl,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final item = _filtered[i];
                  final label = widget.labelBuilder(item);
                  final isSelected = item == widget.selected;
                  return ListTile(
                    title: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? newBlueColor
                            : newTextPrimary,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_rounded,
                        color: newBlueColor, size: 18)
                        : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: isSelected
                        ? newBlueLightColor
                        : Colors.transparent,
                    onTap: () => Navigator.of(context).pop(item),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

