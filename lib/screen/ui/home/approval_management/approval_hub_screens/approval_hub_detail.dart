import 'package:digitalerp/screen/ui/home/approval/approval_detail/approval_details_responce.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../../../../utils/show_message.dart';
import '../approval_hub_controller/approval_hub_controller.dart';
import 'approval_hub_action.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ApprovalHubDetail extends StatefulWidget {
  const ApprovalHubDetail({super.key});

  @override
  State<ApprovalHubDetail> createState() => _ApprovalHubDetailState();
}

class _ApprovalHubDetailState extends State<ApprovalHubDetail> {
  @override
  void initState() {
    super.initState();
    // Wait for navigation to complete, then load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ApprovalHubController>().loadDetailData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalHubController>(
      builder: (ctrl) {
        final item = ctrl.currentItem;
        if (item == null)
          return const Scaffold(body: Center(child: Text('No item selected')));
        final color = ctrl.catColor(item.documentname);
        final lightColor = ctrl.catLightColor(item.documentname);
        final emoji = ctrl.catEmoji(item.documentname);
        return PopScope(
          canPop: true, // temporarily block ALL back presses to test
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                bottom: false,
                child: Column(children: [
                  _AppBar(ctrl: ctrl, docNo: item.documentno ?? ''),
                  Expanded(
                    child: SingleChildScrollView(
                      // ✅ always scrollable, no outer gate
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 100),
                      child: Column(children: [
                        _MasterCard(
                            // handles its own loading state
                            ctrl: ctrl,
                            color: color,
                            lightColor: lightColor,
                            emoji: emoji),
                        if (!ctrl.isLoadingDetail) ...[
                          // these only show after load
                          _DocPreview(ctrl: ctrl),
                          _ChainCard(ctrl: ctrl),
                          _RelatedCard(ctrl: ctrl),
                        ],
                      ]),
                    ),
                  ),
                  _BottomBar(
                    ctrl: ctrl,
                  ),
                ])),
          ),
        );
      },
    );
  }
}

//  App bar
class _AppBar extends StatelessWidget {
  final ApprovalHubController ctrl;
  final String docNo;
  const _AppBar({required this.ctrl, required this.docNo});
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Row(children: [
          GestureDetector(
              onTap: ctrl.isLoadingDetail // ← disable while loading
                  ? null
                  : () => Get.back(),
              child: Container(
                  width: 38,
                  height: 38,
                  // decoration: BoxDecoration(
                  //     color: newSurfaceColor,
                  //     borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 18, color: newTextPrimary))),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('Approval Detail',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: newTextPrimary)),
                Text(docNo,
                    style:
                        const TextStyle(fontSize: 11, color: newTextSecondary)),
              ])),
              () {
            final pdf = ctrl.detailHeader?.pdfUrl?.trim() ?? '';
            if (pdf.isEmpty) return const SizedBox.shrink();
            return GestureDetector(
              onTap: () async {
                final pdf = ctrl.detailHeader?.pdfUrl?.trim() ?? '';
                if (pdf.isEmpty) return;

                // Show downloading indicator
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Row(children: [
                //       SizedBox(
                //         width: 16, height: 16,
                //         child: CircularProgressIndicator(
                //             strokeWidth: 2, color: Colors.white),
                //       ),
                //       SizedBox(width: 12),
                //       Text('Downloading...'),
                //     ]),
                //     duration: Duration(seconds: 60),
                //     backgroundColor: Colors.black87,
                //   ),
                // );

                try {
                  // Get save directory
                  Directory? dir;
                  if (Platform.isAndroid) {
                    // Request permission first
                    if (await Permission.storage.isDenied) {
                      await Permission.storage.request();
                    }
                    // For Android 11+ use MANAGE_EXTERNAL_STORAGE
                    if (await Permission.manageExternalStorage.isDenied) {
                      await Permission.manageExternalStorage.request();
                    }

                    // Use app's external storage — no permission needed on any Android version
                    dir = await getExternalStorageDirectory(); // → /sdcard/Android/data/your.app/files

                    // Try to use Downloads folder if permission granted
                    final downloadsDir = Directory('/storage/emulated/0/Download');
                    if (await Permission.storage.isGranted ||
                        await Permission.manageExternalStorage.isGranted) {
                      if (await downloadsDir.exists()) {
                        dir = downloadsDir;
                      }
                    }
                  } else {
                    dir = await getApplicationDocumentsDirectory();
                  }

                  if (dir == null) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not access storage')),
                    );
                    return;
                  }

                  // Build filename from URL
                  String fileName = pdf.split('/').last.split('?').first;
                  if (!fileName.toLowerCase().endsWith('.pdf')) {
                    fileName = 'document_${DateTime.now().millisecondsSinceEpoch}.pdf';
                  }
                  final savePath = '${dir.path}/$fileName';

                  // Download
                  await Dio().download(
                    pdf,
                    savePath,
                    options: Options(
                      headers: {
                        'Accept': 'application/pdf,*/*',
                        'Content-Type': 'application/pdf',
                      },
                      responseType: ResponseType.bytes,
                    ),
                  );

                  // Dismiss progress snackbar
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

// Open the URL after download
                  await OpenFilex.open(savePath);

// Show success snackbar
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Downloaded: $fileName'),
//                       backgroundColor: Colors.green.shade700,
//                       duration: const Duration(seconds: 3),
//                     ),
//                   );

                  // Auto open
                 // await OpenFilex.open(savePath);

                } catch (e) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Download failed: $e'),
                      backgroundColor: Colors.red.shade700,
                    ),
                  );
                }
              },
              child: Container(
                width: 38,
                height: 38,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: newRedColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.picture_as_pdf_rounded,
                    color: newRedColor, size: 20),
              ),
            );
          }(),

          // GestureDetector(
          //   onTap: () => Get.to(const ApprovalHubAction()),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          //     decoration: BoxDecoration(
          //         color: newBlueColor, borderRadius: BorderRadius.circular(10)),
          //     child: const Text('Action',
          //         style: TextStyle(
          //             fontSize: 12,
          //             fontWeight: FontWeight.w800,
          //             color: Colors.white)),
          //   ),
          // ),
        ]),
      );
}

//  Master detail card
class _MasterCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  final Color color, lightColor;
  final String emoji;

  const _MasterCard({
    required this.ctrl,
    required this.color,
    required this.lightColor,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalHubController>(
      builder: (ctrl) {
        final item = ctrl.currentItem;
        final header = ctrl.detailHeader;

        //  Build tiles dynamically
        // AFTER
        final docNo = header?.documentNo ?? item?.documentno ?? '';
        final date = header?.documentDate ?? item?.documentDate ?? '';
        final requestedBy = header?.requestedBy ?? item?.requestedBy ?? '';
        final amount = header?.amount ?? 0;
        final site = header?.siteName ?? item?.siteName ?? '';
        final dueDate = header?.dueDate ?? '';
        final party = header?.partyName ?? '';
        final subType = header?.subType ?? item?.subType ?? '';
        final priority = header?.priority ?? '';
        final remarks = header?.remarks ?? item?.remarks ?? '';

        final docType =
            (header?.approvalType ?? item?.documentname ?? '').toLowerCase();
        final isPaymentRequest = docType.contains('payment');
        final isWorkOrder =
            docType.contains('work order') || docType.contains('workorder');
        final isPurchaseOrder = docType.contains('purchase');
        final isEstimate = docType.contains('estimate');

        final requestType = (header?.requestType?.isNotEmpty == true)
            ? header!.requestType!
            : (isPaymentRequest ? subType : '');
        final jobType = header?.jobType ?? '';
        final partyName = header?.partyName ?? '';

        return _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SecHead('Approval Details'),

              // header row (emoji + title + status badge) — unchanged
              Row(children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(11)),
                  alignment: Alignment.center,
                  child: Text(emoji, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${header?.approvalType ?? item?.documentname ?? ''} Approval',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: newTextPrimary),
                        ),
                        Text(
                          header?.documentNo ?? item?.documentno ?? '',
                          style: const TextStyle(
                              fontSize: 11, color: newTextSecondary),
                        ),
                      ]),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: ctrl.statusBadgeBg(header?.status ?? item?.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    header?.status ?? item?.status ?? 'Pending',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: ctrl.statusBadgeFg(header?.status ?? item?.status),
                    ),
                  ),
                ),
              ]),

              const SizedBox(height: 12),

              if (ctrl.isLoadingDetail)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: newBlueColor)),
                      SizedBox(width: 10),
                      Text('Loading details...',
                          style:
                              TextStyle(fontSize: 12, color: newTextSecondary)),
                    ],
                  ),
                )
              else ...[
                // Row 1: Doc No + Date
                if (docNo.isNotEmpty || date.isNotEmpty)
                  _PairedRow(
                    left: docNo.isNotEmpty ? _IT('Doc No', docNo) : null,
                    right: date.isNotEmpty ? _IT('Date', date) : null,
                  ),

                // Row 2: Amount + Site
                if (amount > 0 || site.isNotEmpty)
                  _PairedRow(
                    left: amount > 0 ? _IT('Amount', '₹$amount', vc: color) : null,
                    right: site.isNotEmpty ? _IT('Site', site) : null,
                  ),

                // Row 3: Requested By + Request Type (Payment) or Job Type (WO/PO/Estimate)
                if (requestedBy.isNotEmpty ||
                    (isPaymentRequest && requestType.isNotEmpty) ||
                    ((isWorkOrder || isPurchaseOrder || isEstimate) && jobType.isNotEmpty))
                  _PairedRow(
                    left: requestedBy.isNotEmpty ? _IT('Requested By', requestedBy) : null,
                    right: isPaymentRequest && requestType.isNotEmpty
                        ? _IT('Request Type', requestType)
                        : (isWorkOrder || isPurchaseOrder || isEstimate) && jobType.isNotEmpty
                        ? _IT('Job Type', jobType)
                        : null,
                  ),

                // Row 4: Due Date + Party Name
                if (dueDate.isNotEmpty || party.isNotEmpty)
                  _PairedRow(
                    left: dueDate.isNotEmpty
                        ? _IT('Due By', dueDate, vc: newRedColor)
                        : null,
                    right: party.isNotEmpty ? _IT('Party', party) : null,
                  ),

                // Row 5: Sub Type (Party Name for WO/PO/Estimate) + Priority
                if ((subType.isNotEmpty && !isPaymentRequest) || priority.isNotEmpty)
                  _PairedRow(
                    left: subType.isNotEmpty && !isPaymentRequest
                        ? _IT(
                      (isWorkOrder || isPurchaseOrder || isEstimate)
                          ? 'Party Name'
                          : 'Sub Type',
                      subType,
                    )
                        : null,
                    right: priority.isNotEmpty ? _IT('Priority', priority) : null,
                  ),

                // Row 6: Remarks (full width)
                if (remarks.isNotEmpty) _FullRow(_IT('Remarks', remarks)),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _PairedRow extends StatelessWidget {
  final _IT? left;
  final _IT? right;
  const _PairedRow({this.left, this.right});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (left != null) Expanded(child: _InfoTile(left!)),
            if (left != null && right != null) const SizedBox(width: 8),
            if (right != null)
              Expanded(child: _InfoTile(right!))
            else if (left != null)
              const Expanded(child: SizedBox()), // fill empty space
          ],
        ),
      );
}

class _FullRow extends StatelessWidget {
  final _IT tile;
  const _FullRow(this.tile);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _InfoTile(tile),
      );
}

class _DocPreview extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _DocPreview({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final attachFile = ctrl.detailHeader?.attachFile?.trim() ?? '';

    // ✅ Split comma-separated files into a list
    final fileUrls = attachFile
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Also check single docUrl from print API
    final docUrl = ctrl.currentDocUrl?.trim() ?? '';
    if (docUrl.isNotEmpty && !fileUrls.contains(docUrl)) {
      fileUrls.insert(0, docUrl);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: fileUrls.isEmpty
          ? // ── No files ──────────────────────────────────────────────
          const Column(
              children: [
                Icon(Icons.insert_drive_file_outlined,
                    size: 60, color: Colors.white38),
                SizedBox(height: 12),
                Text('No File Uploaded',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70)),
                SizedBox(height: 6),
                Text(
                  'Document is not available for this approval',
                  style: TextStyle(fontSize: 12, color: Colors.white38),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : // ── One or more files ─────────────────────────────────────
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileUrls.length == 1
                      ? 'Attached Document'
                      : '${fileUrls.length} Attached Documents',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white54,
                    letterSpacing: .5,
                  ),
                ),
                const SizedBox(height: 10),
                ...fileUrls.asMap().entries.map((e) {
                  final index = e.key;
                  final url = e.value;
                  final fileName = url.split('/').last.split('\\').last;
                  final isPdf = fileName.toLowerCase().endsWith('.pdf');

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(children: [
                      // ── File icon ──
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isPdf
                              ? const Color(0x33FF5252)
                              : const Color(0x334CAF50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          isPdf ? '📄' : '🖼',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // ── File name + index ──
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'File ${index + 1}',
                              style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white38,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              fileName,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // ── View + Download buttons ──
                      const SizedBox(width: 8),
                      _DocBtn(
                        '👁 View',
                        Colors.white12,
                        Colors.white70,
                        () => _launchFile(url),
                      ),
                      const SizedBox(width: 6),
                      // _DocBtn(
                      //   '⬇',
                      //   newGreenLightColor,
                      //   newGreenColor,
                      //       () => _launchFile(url),
                      // ),
                    ]),
                  );
                }),
              ],
            ),
    );
  }

  Future<void> _launchFile(String url) async {
    if (url.isEmpty) return;
    try {
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasScheme) {
        ShowMessage.showSnackBar('Invalid URL', 'Cannot open this file');
        return;
      }
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) ShowMessage.showSnackBar('Error', 'Could not open file');
    } catch (e) {
      ShowMessage.showSnackBar('Failed to open', 'File may not be accessible');
    }
  }
}

class _DocBtn extends StatelessWidget {
  final String label;
  final Color bg, fg;
  final VoidCallback? onTap;
  const _DocBtn(this.label, this.bg, this.fg, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration:
              BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
        ),
      );
}

//  Approval chain
class _ChainCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _ChainCard({required this.ctrl});

  bool _isDone(String? status) {
    final s = (status ?? '').toLowerCase();
    return s == 'approved' ||
        s == 'approve' ||
        s == 'verified' ||
        s == 'verify';
  }

  bool _isRejected(String? status) {
    final s = (status ?? '').toLowerCase();
    return s == 'rejected' || s == 'reject';
  }

  @override
  Widget build(BuildContext context) {
    final chain = ctrl.approvalChain;
    return _Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _SecHead('Approval Chain'),
        _TlRow(
          dotBg: newGreenLightColor,
          dotFg: newGreenColor,
          icon: Icons.check_rounded,
          label: 'Submitted',
          sub: 'Accounts Dept',
          comment: null,
          isDone: true,
        ),
        if (chain.isNotEmpty)
          ...chain.map((step) {
            final done = _isDone(step.status);
            final rejected = _isRejected(step.status);
            return _TlRow(
              dotBg: done
                  ? newGreenLightColor
                  : rejected
                      ? newRedLightColor
                      : newOrangeLightColor,
              dotFg: done
                  ? newGreenColor
                  : rejected
                      ? newRedColor
                      : newOrangeColor,
              icon: done
                  ? Icons.check_rounded
                  : rejected
                      ? Icons.close_rounded
                      : Icons.access_time_rounded,
              label: '${step.status ?? ''} — ${step.user ?? ''}',
              sub: step.date ?? '',
              comment: (step.remarks ?? '').isNotEmpty ? step.remarks : null,
              isDone: done,
            );
          })
        else
          const _TlRow(
            dotBg: newOrangeLightColor,
            dotFg: newOrangeColor,
            icon: Icons.access_time_rounded,
            label: 'Awaiting Approval',
            sub: 'No chain steps yet',
            comment: null,
            isDone: false,
          ),
      ]),
    );
  }
}

class _TlRow extends StatelessWidget {
  final Color dotBg, dotFg;
  final IconData icon;
  final String label, sub;
  final String? comment;
  final bool isDone;
  const _TlRow(
      {required this.dotBg,
      required this.dotFg,
      required this.icon,
      required this.label,
      required this.sub,
      required this.comment,
      required this.isDone});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: dotBg, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(icon, size: 13, color: dotFg)),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isDone ? newTextPrimary : newOrangeColor)),
                Text(sub,
                    style:
                        const TextStyle(fontSize: 10, color: newTextSecondary)),
                if (comment != null) ...[
                  const SizedBox(height: 5),
                  Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                          color: newSurfaceColor,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: newBorderColor)),
                      child: Text(comment!,
                          style: const TextStyle(
                              fontSize: 11,
                              color: newTextSecondary,
                              height: 1.4))),
                ],
              ])),
        ]),
      );
}

//  Related documents
class _RelatedCard extends StatelessWidget {
  final ApprovalHubController ctrl; // ✅ only ctrl needed
  const _RelatedCard({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final docs = ctrl.relatedDocs;
    if (docs.isEmpty) return const SizedBox();
    return _Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _SecHead('Related Documents'),
        ...docs.map((d) => Container(
              margin: const EdgeInsets.only(bottom: 7),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                  color: newSurfaceColor,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: newBorderColor)),
              child: Row(children: [
                const Text('📄', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('${d.relatedType ?? ''} — ${d.relatedDocNo ?? ''}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: newTextPrimary)),
                      Text(d.relatedDate ?? '',
                          style: const TextStyle(
                              fontSize: 10, color: newTextSecondary)),
                    ])),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: newBlueLightColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(d.relatedStatus ?? d.relatedType ?? '',
                      style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: newBlueColor)),
                ),
              ]),
            )),
      ]),
    );
  }
}

//  Bottom action bar
// 1. Add const + pass ctrl to _BottomBar
class _BottomBar extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _BottomBar({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final headerStatus = (ctrl.detailHeader?.status ?? '').toLowerCase().trim();
    final listStatus = (ctrl.currentItem?.status ?? '').toLowerCase().trim();
    final status = headerStatus.isNotEmpty ? headerStatus : listStatus;

    final isApproved = status == 'approved' || status == 'approve';
    final isRejected = status == 'rejected' || status == 'reject';
    final isDisapproved = status == 'disapproved' || status == 'disapprove';

    final isReimbursement = (ctrl.currentItem?.approvalType ?? '')
        .toLowerCase()
        .contains('reimbursement');
    final isL2 = (ctrl.currentItem?.approvalTypeCode ??
            ctrl.currentItem?.approvalType ??
            '')
        .toLowerCase()
        .contains('l2');

    // ✅ Check disapprove first — overrides everything
    if (ctrl.showDisapprove) {
      return Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: newBorderColor))),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: ctrl.isLoadingDetail
                  ? null
                  : () {
                      ctrl.pickAction(ApprovalAction.disapprove);
                      Get.to(const ApprovalHubAction());
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor: newRedColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('Disapprove 🚫',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
        ),
      );
    }

    final hideAction = isApproved ||
        isRejected ||
        isDisapproved || // ✅ hide action button for disapproved
        (isReimbursement && isL2 && status != 'verify' && status != 'verified');

    if (hideAction) return const SizedBox();

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: newBorderColor))),
      child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: ctrl.isLoadingDetail
                  ? null
                  : () => Get.to(const ApprovalHubAction()),
              style: ElevatedButton.styleFrom(
                  backgroundColor: newBlueColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('Take Action →',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          )),
    );
  }
}

//  Shared widgets
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: newBorderColor),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2))
            ]),
        child: child,
      );
}

class _SecHead extends StatelessWidget {
  final String text;
  const _SecHead(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: newTextSecondary,
                letterSpacing: .6)),
      );
}

class _InfoGrid extends StatelessWidget {
  final List<_IT> tiles;
  const _InfoGrid({required this.tiles});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tiles
            .map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _InfoTile(t),
                ))
            .toList(),
      );
}

class _InfoTile extends StatelessWidget {
  final _IT t;
  const _InfoTile(this.t);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: newSurfaceColor,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: newBorderColor)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.label,
              style: const TextStyle(
                  fontSize: 10,
                  color: newTextSecondary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text(t.value,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: t.vc ?? newTextPrimary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ]),
      );
}

class _IT {
  final String label, value;
  final Color? vc;
  final bool full;
  const _IT(this.label, this.value, {this.vc, this.full = false});
}
