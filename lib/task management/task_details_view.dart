import 'dart:convert';
import 'dart:io';
import 'package:digitalerp/task%20management/taskmanagementcontroller/task_manage_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../response/get_executive_dropdown_response.dart';
import '../response/task_dropdown_response.dart';
import '../utils new/file_picker_dialog.dart';
import 'task models/Task_details_responce.dart';

class TaskDetailsView extends StatelessWidget {
  TaskDetailsView({super.key, required this.taskId, this.taskFlag = ''});

  XFile? pickedFile;
  final String taskId;
  final String taskFlag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskManagementController>(
      initState: (_) {
        final ctrl = Get.find<TaskManagementController>();
        ctrl.resetFollowupForm();
        ctrl.selectedImageFileName.value = '';
        ctrl.selectedImageBase64.value = '';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctrl.getTaskDetailsApi(taskId);
        });
      },
      builder: (ctrl) => Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              MyAppBar(
                title: ctrl.isDetailLoading
                    ? (taskFlag.isNotEmpty ? taskFlag : 'Task Follow Up')
                    : (ctrl.currentTaskDetail?.tasksection ?? 'Task Follow Up'),
                onBackTap: () => Get.back(),
              ),
              Expanded(
                child: ctrl.isDetailLoading
                    ? const Center(
                    child: CircularProgressIndicator(color: newBlueColor))
                    : ctrl.currentTaskDetail == null
                    ? const Center(child: Text('No data found'))
                    : SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom:
                    MediaQuery.of(context).viewInsets.bottom + 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _headerCard(ctrl),
                      const SizedBox(height: 16),
                      _statusDropdown(ctrl),
                      const SizedBox(height: 16),

                      if (ctrl.isProjectTask) ...[
                        _qtyRow(ctrl),
                        const SizedBox(height: 12),
                        _progressBar(ctrl),
                        const SizedBox(height: 8),
                        _dateRow(ctrl),
                        const SizedBox(height: 16),
                        // Escalate + Unit AFTER progress bar — only for Project
                        _escalateAndUnitRow(ctrl),
                        const SizedBox(height: 16),
                      ],

                      if (!ctrl.isProjectTask) ...[
                        _dateRow(ctrl),
                        const SizedBox(height: 16),
                        _escalateToOnly(ctrl),
                        const SizedBox(height: 16),
                      ],

                      _fileUploadBox(ctrl),
                      const SizedBox(height: 16),

                      _remarkField(ctrl),
                      const SizedBox(height: 24),

                      _submitBtn(ctrl),
                      const SizedBox(height: 24),

                      const Text(
                        'List',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: newTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _historySearch(),
                      const SizedBox(height: 12),
                      _historyList(ctrl),
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

  // ─── Header card ────────────────────────────────────────────────────────────
  Widget _headerCard(TaskManagementController ctrl) {
    final d = ctrl.currentTaskDetail!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: newBlueLightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.business_outlined, size: 14, color: newBlueColor),
                const SizedBox(width: 8),
                const Text('Client : ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: newBlueColor)),
                Flexible(
                  child: Text(
                    d.clientname ?? 'N/A',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: newBlueColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Row(children: [
            Expanded(child: _infoChip('Task Name', d.task ?? 'N/A')),
            const SizedBox(width: 8),
            Expanded(child: _infoChip('Site', d.sitename ?? 'N/A')),
          ]),

          if (ctrl.isProjectTask) ...[
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: _infoChip('Order No', d.orderno ?? 'N/A')),
              const SizedBox(width: 8),
              Expanded(child: _infoChip('Line Item', d.lineitem ?? 'N/A')),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: _infoChip('Job Type', d.jobtype ?? 'N/A')),
              const SizedBox(width: 8),
              Expanded(child: _infoChip('Project Type', d.projecttype ?? 'N/A')),
            ]),
            if ((d.fromlocation ?? '').isNotEmpty || (d.tolocation ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: _infoChip('From Location', d.fromlocation ?? 'N/A')),
                const SizedBox(width: 8),
                Expanded(child: _infoChip('To Location', d.tolocation ?? 'N/A')),
              ]),
            ],
          ],

          if (ctrl.isDirectTask) ...[
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: _infoChip('Task Type', d.tasktype ?? 'N/A')),
              const SizedBox(width: 8),
              Expanded(child: _infoChip('Reference', d.clientreference ?? 'N/A')),
            ]),
          ],

          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _infoChip('Priority', d.priority ?? 'N/A')),
            const SizedBox(width: 8),
            Expanded(child: _infoChip('Assigned By', d.assignedby ?? 'N/A')),
          ]),

          const SizedBox(height: 8),
          _infoChipFull('Assigned To', d.assignedto ?? 'N/A'),
          _documentAttachments(ctrl),
        ],
      ),
    );
  }

  // ─── Document attachments ─────────────────────────────────────────────────────
  Widget _documentAttachments(TaskManagementController ctrl) {
    final raw = (ctrl.currentTaskDetail?.document ?? '').trim();
    if (raw.isEmpty) return const SizedBox();

    const baseUrl = 'https://supportapi.digitalerp.biz/Images/';
    final urls = raw
        .split(',')
        .map((u) => u.trim())
        .where((u) => u.isNotEmpty)
        .map((u) => u.startsWith('http') ? u : '$baseUrl$u')
        .toList();

    if (urls.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text('Attachments',
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: newTextSecondary)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: urls.map((url) {
            final isPdf = url.toLowerCase().endsWith('.pdf');
            final fileName = Uri.parse(url).pathSegments.last;
            return GestureDetector(
              onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: isPdf ? const Color(0xFFFFF3E0) : newBlueLightColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isPdf ? Colors.orange.shade300 : newBlueColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isPdf ? Icons.picture_as_pdf : Icons.image,
                        size: 14, color: isPdf ? Colors.orange : newBlueColor),
                    const SizedBox(width: 5),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(fileName,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isPdf ? Colors.orange.shade800 : newBlueColor),
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.open_in_new_rounded,
                        size: 12, color: isPdf ? Colors.orange : newBlueColor),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _infoChip(String label, String value) =>
      _InfoChipTile(label: label, value: value);

  Widget _infoChipFull(String label, String value) =>
      _InfoChipTile(label: label, value: value, fullWidth: true);

  // ─── Status dropdown ─────────────────────────────────────────────────────────
  Widget _statusDropdown(TaskManagementController ctrl) {
    return _labeledDropdown(
      label: 'Status',
      value: ctrl.statusDropDown.contains(ctrl.selectedStatus)
          ? ctrl.selectedStatus
          : (ctrl.statusDropDown.isNotEmpty ? ctrl.statusDropDown.first : null),
      items: ctrl.statusDropDown,
      onChanged: (v) {
        if (v != null) ctrl.onChangedStatusListValue(v);
      },
    );
  }

  // ─── Escalate To + Unit row (Project only) ────────────────────────────────────
  Widget _escalateAndUnitRow(TaskManagementController ctrl) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Escalate To',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: newTextPrimary)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  final result = await showModalBottomSheet<ExecutiveDropdownData>(
                    context: Get.context!,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => _EscalateSearchSheet(
                      items: ctrl.assignList,
                      selected: ctrl.selectedEscalateTo,
                    ),
                  );
                  if (result != null) {
                    ctrl.selectedEscalateTo = result;
                    ctrl.update();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: newBorderColor),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        ctrl.selectedEscalateTo?.executiveName ??
                            ((ctrl.currentTaskDetail?.escalateto ?? '').isNotEmpty
                                ? ctrl.currentTaskDetail!.escalateto!
                                : 'Select person'),
                        style: TextStyle(
                          fontSize: 13,
                          color: ctrl.selectedEscalateTo != null
                              ? newTextPrimary
                              : newTextSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: newTextSecondary, size: 18),
                  ]),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Unit',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: newTextPrimary)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  final result = await showModalBottomSheet<TaskDropdownItem>(
                    context: Get.context!,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => _UnitSearchSheet(
                      items: ctrl.unitList,
                      selected: ctrl.selectedUnit,
                    ),
                  );
                  if (result != null) {
                    ctrl.selectedUnit = result;
                    ctrl.update();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: newBorderColor),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        ctrl.selectedUnit?.name ??
                            (ctrl.currentUnitName.isNotEmpty
                                ? ctrl.currentUnitName
                                : 'Select unit'),
                        style: TextStyle(
                          fontSize: 13,
                          color: ctrl.selectedUnit != null
                              ? newTextPrimary
                              : newTextSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: newTextSecondary, size: 18),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _labeledDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String hint = 'Select',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: newTextPrimary)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: newBorderColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: Text(hint,
                  style: const TextStyle(fontSize: 13, color: newTextSecondary)),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: newTextSecondary),
              style: const TextStyle(fontSize: 13, color: newTextPrimary),
              items: items
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // ─── QTY row ─────────────────────────────────────────────────────────────────
  Widget _qtyRow(TaskManagementController ctrl) {
    final d = ctrl.currentTaskDetail!;
    return Row(children: [
      Expanded(
        child: _readonlyField(
          'Assigned QTY',
          d.totalquantity != null
              ? '${d.totalquantity!.toStringAsFixed(0)} ${d.unitname ?? ''}'
              : 'N/A',
        ),
      ),
      const SizedBox(width: 12),
      Expanded(child: _editableQtyField(ctrl)),
    ]);
  }

  Widget _readonlyField(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, color: newTextSecondary)),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: Text(value,
            style: const TextStyle(fontSize: 13, color: newTextPrimary)),
      ),
    ],
  );

  Widget _editableQtyField(TaskManagementController ctrl) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Today's Working QTY",
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, color: newTextSecondary)),
      const SizedBox(height: 4),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: TextField(
          controller: ctrl.quantityController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 13, color: newTextPrimary),
          decoration: const InputDecoration(
            hintText: '00',
            hintStyle: TextStyle(color: newTextHint),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ),
    ],
  );

  // ─── Date row ────────────────────────────────────────────────────────────────
  Widget _dateRow(TaskManagementController ctrl) {
    final d = ctrl.currentTaskDetail!;
    return Row(children: [
      const Icon(Icons.calendar_today_outlined, size: 14, color: newTextSecondary),
      const SizedBox(width: 4),
      Text('Assign : ${d.assigndate ?? 'N/A'}',
          style: const TextStyle(fontSize: 12, color: newTextSecondary)),
      const SizedBox(width: 16),
      const Icon(Icons.event_outlined, size: 14, color: newTextSecondary),
      const SizedBox(width: 4),
      Text('Due : ${d.duedate ?? 'N/A'}',
          style: const TextStyle(fontSize: 12, color: newTextSecondary)),
    ]);
  }

  // ─── Progress bar ────────────────────────────────────────────────────────────
  Widget _progressBar(TaskManagementController ctrl) {
    final d = ctrl.currentTaskDetail!;
    final total = d.totalquantity ?? 0;
    final completed = d.completedquantity ?? 0;
    final progress = total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Working QTY',
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600, color: newTextPrimary)),
            Text(
              '${completed.toStringAsFixed(0)}/${total.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 12, color: newTextSecondary),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: newBorderColor,
            valueColor: const AlwaysStoppedAnimation<Color>(newGreenColor),
          ),
        ),
      ],
    );
  }

  // ─── File upload ─────────────────────────────────────────────────────────────
  Widget _fileUploadBox(TaskManagementController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('File Upload',
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: newTextPrimary)),
        const SizedBox(height: 8),

        Obx(() {
          if (ctrl.followupFiles.isEmpty) return const SizedBox();
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(ctrl.followupFiles.length, (i) {
                final file = ctrl.followupFiles[i];
                final displayName = file['displayName'] ?? '';
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
                        width: 12,
                        height: 12,
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
                          onTap: () => ctrl.removeFollowupFile(i),
                          child: Icon(Icons.close,
                              size: 14,
                              color: isPdf ? Colors.orange.shade700 : newBlueColor),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ),
          );
        }),

        GestureDetector(
          onTap: () => _showFollowupAttachOptions(ctrl),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: newBorderColor),
            ),
            child: Column(children: [
              Icon(Icons.cloud_upload_outlined,
                  size: 36, color: Colors.grey.shade400),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  text: 'Tap to attach or ',
                  style: TextStyle(fontSize: 13, color: newTextSecondary),
                  children: [
                    TextSpan(
                      text: 'Browse',
                      style: TextStyle(
                          color: newBlueColor, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('Supported: PDF, JPG, JPEG, PNG',
                  style: TextStyle(fontSize: 11, color: newTextHint)),
            ]),
          ),
        ),
      ],
    );
  }

  // ─── Task Remark field ────────────────────────────────────────────────────────
  Widget _remarkField(TaskManagementController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Remark :',
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: newTextPrimary)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl.commentController,
          focusNode: ctrl.commentFocus,
          minLines: 3,
          maxLines: 5,
          style: const TextStyle(fontSize: 14, color: newTextPrimary),
          decoration: InputDecoration(
            hintText: 'Enter remark...',
            hintStyle: const TextStyle(color: newTextHint),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: newBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: newBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: newBlueColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Submit ───────────────────────────────────────────────────────────────────
  Widget _submitBtn(TaskManagementController ctrl) => SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: () => ctrl.saveTaskFollowupApi(taskId),
      style: ElevatedButton.styleFrom(
        backgroundColor: newBlueColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: const Text('Submit',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
    ),
  );

  // ─── History search ───────────────────────────────────────────────────────────
  Widget _historySearch() => TextFormField(
    style: const TextStyle(fontSize: 14),
    decoration: InputDecoration(
      hintText: 'Search',
      hintStyle: const TextStyle(color: newTextHint),
      prefixIcon: const Icon(Icons.search, color: newTextSecondary, size: 20),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: newBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: newBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: newBlueColor, width: 1.5),
      ),
    ),
  );

  // ─── History list ─────────────────────────────────────────────────────────────
  Widget _historyList(TaskManagementController ctrl) {
    final history = ctrl.taskHistory;
    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('No history found',
              style: TextStyle(fontSize: 14, color: newTextSecondary)),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: history.length,
      itemBuilder: (_, i) => _historyCard(history[i], ctrl.isProjectTask),
    );
  }

  Widget _historyCard(TaskHistory h, bool isProject) {
    Color badgeBg, badgeFg;
    switch ((h.status ?? '').toLowerCase()) {
      case 'completed':
      case 'close':
        badgeBg = newGreenLightColor;
        badgeFg = newGreenColor;
        break;
      case 'pending':
        badgeBg = newOrangeLightColor;
        badgeFg = newOrangeColor;
        break;
      default:
        badgeBg = newBlueLightColor;
        badgeFg = newBlueColor;
    }

    final rawAttach = (h.attachfile ?? '').toString().trim();
    const baseUrl = 'https://supportapi.digitalerp.biz/Images/';
    final attachUrls = rawAttach
        .split(',')
        .map((u) => u.trim())
        .where((u) => u.isNotEmpty)
        .map((u) => u.startsWith('http') ? u : '$baseUrl$u')
        .toList();
    final hasAttachment = (h.hasfile ?? 0) == 1 && attachUrls.isNotEmpty;

    final fileUrl = attachUrls.isNotEmpty ? attachUrls.first : '';
    final isImage = fileUrl.endsWith('.jpg') ||
        fileUrl.endsWith('.jpeg') ||
        fileUrl.endsWith('.png');
    final isPdf = fileUrl.endsWith('.pdf');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'S.NO : ${(h.sno ?? 0).toString().padLeft(2, '0')}',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: newTextPrimary),
              ),
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: badgeBg, borderRadius: BorderRadius.circular(20)),
                  child: Text(h.status ?? '',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: badgeFg)),
                ),
                if ((h.hasfile ?? 0) == 1) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: hasAttachment
                        ? () => launchUrl(Uri.parse(fileUrl),
                        mode: LaunchMode.externalApplication)
                        : null,
                    child: Icon(
                      isPdf
                          ? Icons.picture_as_pdf_outlined
                          : isImage
                          ? Icons.image_outlined
                          : Icons.attach_file_rounded,
                      color: isPdf ? newRedColor : newBlueColor,
                      size: 22,
                    ),
                  ),
                ],
              ]),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.calendar_today_outlined,
                size: 13, color: newTextSecondary),
            const SizedBox(width: 4),
            Text('Date : ${h.entrydate ?? 'N/A'}',
                style: const TextStyle(fontSize: 12, color: newTextSecondary)),
          ]),
          if (isProject && (h.quantity ?? 0) > 0) ...[
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.straighten, size: 13, color: newTextSecondary),
              const SizedBox(width: 4),
              Text(
                'QTY : ${h.quantity?.toStringAsFixed(0) ?? '0'} ${h.unitname ?? ''}',
                style: const TextStyle(fontSize: 12, color: newTextSecondary),
              ),
              if ((h.escalatedto ?? '').isNotEmpty) ...[
                const SizedBox(width: 12),
                const Icon(Icons.person_outline, size: 13, color: newTextSecondary),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Escalated: ${h.escalatedto}',
                    style: const TextStyle(fontSize: 12, color: newTextSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ]),
          ],
          const SizedBox(height: 8),
          if ((h.enteredby ?? '').isNotEmpty) ...[
            Text('By: ${h.enteredby}',
                style: const TextStyle(fontSize: 11, color: newTextSecondary)),
            const SizedBox(height: 6),
          ],
          const Text('Comment :',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: newTextPrimary)),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xFFF4F6FB),
                borderRadius: BorderRadius.circular(8)),
            child: Text(h.comment ?? '',
                style: const TextStyle(fontSize: 12, color: newTextSecondary)),
          ),

          // ✅ File link chips only — image preview removed
          if (hasAttachment) ...[
            const SizedBox(height: 10),
            ...attachUrls.map((url) {
              final isImg = url.endsWith('.jpg') ||
                  url.endsWith('.jpeg') ||
                  url.endsWith('.png');
              final isPdfFile = url.endsWith('.pdf');
              return GestureDetector(
                onTap: () =>
                    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 6),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isPdfFile ? newRedLightColor : newBlueLightColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isPdfFile ? newRedColor : newBlueColor,
                        width: 0.8),
                  ),
                  child: Row(children: [
                    Icon(
                      isPdfFile
                          ? Icons.picture_as_pdf_outlined
                          : isImg
                          ? Icons.image_outlined
                          : Icons.insert_drive_file_outlined,
                      size: 18,
                      color: isPdfFile ? newRedColor : newBlueColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        Uri.parse(url).pathSegments.last,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isPdfFile ? newRedColor : newBlueColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.open_in_new_rounded,
                        size: 14,
                        color: isPdfFile ? newRedColor : newBlueColor),
                  ]),
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  void _showImageDialog(TaskManagementController ctrl) {
    FilePickerDialog.show(
      onFileSelected: (base64, fileName, filePath) {
        ctrl.selectedImageBase64.value = base64;
        ctrl.selectedImageFileName.value = fileName;
        ctrl.setSelectedImage(filePath);
      },
      allowedExtensions: ['pdf', 'xlsx', 'xls', 'jpg', 'jpeg', 'png'],
    );
  }

  void _showFollowupAttachOptions(TaskManagementController ctrl) {
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
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: newBorderColor,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Attach File',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary)),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: _attachOption(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera',
                  color: newBlueColor,
                  bgColor: newBlueLightColor,
                  onTap: () async {
                    Get.back();
                    final picker = ImagePicker();
                    final xfile = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 80);
                    if (xfile != null) {
                      await ctrl.addFollowupFile(
                          xfile.path, xfile.path.split('/').last);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _attachOption(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  color: newGreenColor,
                  bgColor: newGreenLightColor,
                  onTap: () async {
                    Get.back();
                    final picker = ImagePicker();
                    final files = await picker.pickMultiImage(imageQuality: 80);
                    for (final f in files) {
                      await ctrl.addFollowupFile(f.path, f.path.split('/').last);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _attachOption(
                  icon: Icons.picture_as_pdf_outlined,
                  label: 'PDF',
                  color: Colors.orange,
                  bgColor: const Color(0xFFFFF3E0),
                  onTap: () async {
                    Get.back();
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                      allowMultiple: true,
                    );
                    if (result != null) {
                      for (final f in result.files) {
                        if (f.path != null) {
                          await ctrl.addFollowupFile(f.path!, f.name);
                        }
                      }
                    }
                  },
                ),
              ),
            ]),
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
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: color)),
          ]),
        ),
      );

  Widget _escalateToOnly(TaskManagementController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Assign To',
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: newTextPrimary)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final result = await showModalBottomSheet<ExecutiveDropdownData>(
              context: Get.context!,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => _EscalateSearchSheet(
                items: ctrl.assignList,
                selected: ctrl.selectedEscalateTo,
              ),
            );
            if (result != null) {
              ctrl.selectedEscalateTo = result;
              ctrl.update();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: newBorderColor),
            ),
            child: Row(children: [
              Expanded(
                child: Text(
                  ctrl.selectedEscalateTo?.executiveName ??
                      ((ctrl.currentTaskDetail?.escalateto ?? '').isNotEmpty
                          ? ctrl.currentTaskDetail!.escalateto!
                          : 'Select person'),
                  style: TextStyle(
                    fontSize: 13,
                    color: ctrl.selectedEscalateTo != null
                        ? newTextPrimary
                        : newTextSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: newTextSecondary, size: 18),
            ]),
          ),
        ),
      ],
    );
  }
}

class _UnitSearchSheet extends StatefulWidget {
  final List<TaskDropdownItem> items;
  final TaskDropdownItem? selected;

  const _UnitSearchSheet({required this.items, this.selected});

  @override
  State<_UnitSearchSheet> createState() => _UnitSearchSheetState();
}

class _UnitSearchSheetState extends State<_UnitSearchSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<TaskDropdownItem> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = List.from(widget.items);
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = widget.items
            .where((e) => (e.name ?? '').toLowerCase().contains(q))
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
        child: Column(children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: newBorderColor, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Unit',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary)),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              style: const TextStyle(fontSize: 14, color: newTextPrimary),
              decoration: InputDecoration(
                hintText: 'Search unit...',
                hintStyle: const TextStyle(color: newTextHint, fontSize: 14),
                prefixIcon:
                const Icon(Icons.search, color: newTextSecondary, size: 20),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? GestureDetector(
                    onTap: () => _searchCtrl.clear(),
                    child: const Icon(Icons.close,
                        color: newTextSecondary, size: 18))
                    : null,
                filled: true,
                fillColor: const Color(0xFFF4F6FB),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: newBorderColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: newBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: newBlueColor, width: 1.5)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_filtered.length} result${_filtered.length == 1 ? '' : 's'}',
                style: const TextStyle(fontSize: 11, color: newTextSecondary),
              ),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                child: Text('No results found',
                    style:
                    TextStyle(fontSize: 14, color: newTextSecondary)))
                : ListView.builder(
              controller: scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final item = _filtered[i];
                final isSelected = item.id == widget.selected?.id;
                return ListTile(
                  title: Text(
                    item.name ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected ? newBlueColor : newTextPrimary,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded,
                      color: newBlueColor, size: 18)
                      : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor:
                  isSelected ? newBlueLightColor : Colors.transparent,
                  onTap: () => Navigator.of(context).pop(item),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}

class _InfoChipTile extends StatelessWidget {
  final String label;
  final String value;
  final bool fullWidth;

  const _InfoChipTile({
    required this.label,
    required this.value,
    this.fullWidth = false,
  });

  void _showFullValue(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: newBorderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: newTextSecondary,
                    letterSpacing: 0.4)),
            const SizedBox(height: 8),
            const Divider(height: 1, color: newBorderColor),
            const SizedBox(height: 12),
            Text(value,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary,
                    height: 1.5)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: newBlueLightColor,
                  foregroundColor: newBlueColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Close',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(
          text: value,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: newTextPrimary),
        );
        final tp = TextPainter(
          text: span,
          maxLines: 2,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth - 20);

        final overflows = tp.didExceedMaxLines;

        return GestureDetector(
          onTap: overflows ? () => _showFullValue(context) : null,
          child: Container(
            width: fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FB),
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                  left: BorderSide(color: newBlueColor, width: 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            fontSize: 10, color: newTextSecondary)),
                    if (overflows)
                      const Text('tap to expand',
                          style: TextStyle(
                              fontSize: 9,
                              color: newBlueColor,
                              fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: newTextPrimary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EscalateSearchSheet extends StatefulWidget {
  final List<ExecutiveDropdownData> items;
  final ExecutiveDropdownData? selected;

  const _EscalateSearchSheet({required this.items, this.selected});

  @override
  State<_EscalateSearchSheet> createState() => _EscalateSearchSheetState();
}

class _EscalateSearchSheetState extends State<_EscalateSearchSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<ExecutiveDropdownData> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = List.from(widget.items);
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = widget.items
            .where((e) => (e.executiveName ?? '').toLowerCase().contains(q))
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
        child: Column(children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: newBorderColor, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Escalate To',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary)),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              style: const TextStyle(fontSize: 14, color: newTextPrimary),
              decoration: InputDecoration(
                hintText: 'Search person...',
                hintStyle: const TextStyle(color: newTextHint, fontSize: 14),
                prefixIcon:
                const Icon(Icons.search, color: newTextSecondary, size: 20),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? GestureDetector(
                    onTap: () => _searchCtrl.clear(),
                    child: const Icon(Icons.close,
                        color: newTextSecondary, size: 18))
                    : null,
                filled: true,
                fillColor: const Color(0xFFF4F6FB),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: newBorderColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: newBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    const BorderSide(color: newBlueColor, width: 1.5)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_filtered.length} result${_filtered.length == 1 ? '' : 's'}',
                style: const TextStyle(fontSize: 11, color: newTextSecondary),
              ),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                child: Text('No results found',
                    style:
                    TextStyle(fontSize: 14, color: newTextSecondary)))
                : ListView.builder(
              controller: scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final item = _filtered[i];
                final isSelected =
                    item.executiveId == widget.selected?.executiveId;
                return ListTile(
                  title: Text(
                    item.executiveName ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected ? newBlueColor : newTextPrimary,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded,
                      color: newBlueColor, size: 18)
                      : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor:
                  isSelected ? newBlueLightColor : Colors.transparent,
                  onTap: () => Navigator.of(context).pop(item),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}