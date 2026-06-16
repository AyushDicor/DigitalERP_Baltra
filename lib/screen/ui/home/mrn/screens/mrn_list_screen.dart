// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:provider/provider.dart';
// // import '../../constants/app_theme.dart';
// // import '../../providers/auth_provider.dart';
// // import '../../model/mrn_models.dart';
// // import '../../widgets/common_widgets.dart';
// // import '../../config/app_router.dart';
// // import '../../widgets/filter_sheet.dart';
// // import '../provider/mrn_provider.dart';
// //
// // //  Local design tokens (mirrors task screen TColors) 
// // class _C {
// //   static const bg = Color(0xFFF5F5F7);
// //   static const fieldShadow = Color(0x12000000);
// //   static const appBarShadow = Color(0x0F000000);
// //   static const infoBoxBg = Color(0xFFEEF2FF);
// // }
// //
// // BoxDecoration _shadowCard({double radius = 14}) => BoxDecoration(
// //   color: Colors.white,
// //   borderRadius: BorderRadius.circular(radius),
// //   boxShadow: [
// //     BoxShadow(
// //       color: _C.fieldShadow,
// //       blurRadius: 8,
// //       offset: const Offset(0, 2),
// //     ),
// //   ],
// // );
// //
// // // 
// // class MRNListScreen extends StatefulWidget {
// //   const MRNListScreen({super.key});
// //   @override
// //   State<MRNListScreen> createState() => _MRNListScreenState();
// // }
// //
// // class _MRNListScreenState extends State<MRNListScreen> {
// //   final _scrollCtrl = ScrollController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _scrollCtrl.addListener(_onScroll);
// //     WidgetsBinding.instance.addPostFrameCallback(
// //             (_) => context.read<MRNProvider>().loadMRNs(refresh: true));
// //   }
// //
// //   void _onScroll() {
// //     if (_scrollCtrl.position.pixels >=
// //         _scrollCtrl.position.maxScrollExtent - 200) {
// //       context.read<MRNProvider>().loadMore();
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollCtrl.dispose();
// //     super.dispose();
// //   }
// //
// //   Future<void> _confirmDelete(BuildContext context, MRN mrn) async {
// //     final ok = await showConfirmDialog(
// //       context: context,
// //       title: 'Delete MRN',
// //       message: 'Delete ${mrn.mrnNumber}? This cannot be undone.',
// //       confirmLabel: 'Delete',
// //       isDanger: true,
// //     );
// //     if (ok && context.mounted) {
// //       final err = await context.read<MRNProvider>().deleteMRN(mrn.mrnId);
// //       if (context.mounted && err != null) {
// //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //           content: Text(err),
// //           backgroundColor: AppColors.error,
// //           behavior: SnackBarBehavior.floating,
// //         ));
// //       }
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final p = context.watch<MRNProvider>();
// //     final isManager = context.watch<AuthProvider>().isManager;
// //
// //     final completedCount = p.mrns.where((m) => m.statusId == 3).length;
// //     final pendingCount =
// //         p.mrns.where((m) => m.statusId == 1 || m.statusId == 2).length;
// //     final cancelledCount = p.mrns.where((m) => m.statusId == 4).length;
// //
// //     return Scaffold(
// //       backgroundColor: _C.bg,
// //       //  AppBar — PreferredSize pattern 
// //       appBar: PreferredSize(
// //         preferredSize: const Size.fromHeight(60),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             boxShadow: [
// //               BoxShadow(
// //                 color: _C.appBarShadow,
// //                 blurRadius: 12,
// //                 offset: const Offset(0, 3),
// //               ),
// //             ],
// //           ),
// //           child: SafeArea(
// //             bottom: false,
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 4),
// //               child: Row(
// //                 children: [
// //                   IconButton(
// //                     icon:
// //                     const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
// //                     color: AppColors.textPrimary,
// //                     onPressed: () => context.pop(),
// //                   ),
// //                   Expanded(
// //                     child: Text('MRN',
// //                         style: AppTextStyles.h2.copyWith(
// //                             fontSize: 22, fontWeight: FontWeight.w800)),
// //                   ),
// //                   if (p.hasActiveFilters)
// //                     TextButton(
// //                       onPressed: p.clearFilters,
// //                       child: Text('Clear',
// //                           style: AppTextStyles.body
// //                               .copyWith(color: AppColors.error)),
// //                     ),
// //                   Container(
// //                     margin: const EdgeInsets.only(right: 12),
// //                     width: 40,
// //                     height: 40,
// //                     decoration: BoxDecoration(
// //                       color: AppColors.purpleLightest,
// //                       borderRadius: BorderRadius.circular(18),
// //                     ),
// //                     child: IconButton(
// //                       padding: EdgeInsets.zero,
// //                       icon: const Icon(Icons.filter_list_sharp, size: 20),
// //                       color: AppColors.purple,
// //                       onPressed: () => context.push('/mrn/filter'),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () => context.push(AppRoutes.addMrn()),
// //         backgroundColor: AppColors.purple,
// //         shape:
// //         const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
// //         elevation: 4,
// //         child: const Icon(Icons.add, color: Colors.white, size: 28),
// //       ),
// //
// //       body: p.loading && p.mrns.isEmpty
// //           ? const Center(
// //           child: CircularProgressIndicator(color: AppColors.purple))
// //           : p.error != null && p.mrns.isEmpty
// //           ? ErrorState(
// //           message: p.error, onRetry: () => p.loadMRNs(refresh: true))
// //           : RefreshIndicator(
// //         onRefresh: () => p.loadMRNs(refresh: true),
// //         color: AppColors.purple,
// //         child: ListView(
// //           controller: _scrollCtrl,
// //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
// //           children: [
// //             //  Stat cards 
// //             Row(children: [
// //               _StatCard(
// //                 count: completedCount,
// //                 line1: 'Completed',
// //                 line2: 'MRN',
// //                 color: AppColors.success,
// //               ),
// //               const SizedBox(width: 10),
// //               _StatCard(
// //                 count: pendingCount,
// //                 line1: 'Pending',
// //                 line2: 'MRN',
// //                 color: AppColors.orange,
// //               ),
// //               const SizedBox(width: 10),
// //               _StatCard(
// //                 count: cancelledCount,
// //                 line1: 'Cancelled',
// //                 line2: 'MRN',
// //                 color: AppColors.error,
// //               ),
// //             ]),
// //             const SizedBox(height: 24),
// //
// //             Text('List of MRN',
// //                 style: AppTextStyles.h2
// //                     .copyWith(fontWeight: FontWeight.w800)),
// //             const SizedBox(height: 12),
// //
// //             if (p.mrns.isEmpty)
// //               EmptyState(
// //                 icon: Icons.receipt_long_outlined,
// //                 title: 'No MRNs Found',
// //                 subtitle: 'Material receipt notes will appear here.',
// //                 actionLabel: 'Create MRN',
// //                 onAction: () => context.push(AppRoutes.addMrn()),
// //               )
// //             else
// //               ...p.mrns.map((mrn) => _MRNCard(
// //                 mrn: mrn,
// //                 isManager: isManager,
// //                 onTap: () => context.push('/mrn/${mrn.mrnId}'),
// //                 onEdit: () =>
// //                     context.push('/mrn/${mrn.mrnId}/edit'),
// //                 onDelete: () => _confirmDelete(context, mrn),
// //               )),
// //
// //             if (p.loadingMore)
// //               const Padding(
// //                 padding: EdgeInsets.all(16),
// //                 child: Center(
// //                     child: CircularProgressIndicator(
// //                         strokeWidth: 2, color: AppColors.purple)),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // //  Stat Card 
// // class _StatCard extends StatelessWidget {
// //   final int count;
// //   final String line1;
// //   final String line2;
// //   final Color color;
// //
// //   const _StatCard({
// //     required this.count,
// //     required this.line1,
// //     required this.line2,
// //     required this.color,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: Container(
// //         padding: const EdgeInsets.all(12),
// //         decoration: _shadowCard(radius: 12),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               width: 40,
// //               height: 40,
// //               decoration: BoxDecoration(
// //                 color: color.withValues(alpha: 0.12),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               alignment: Alignment.center,
// //               child: Text(
// //                 count.toString().padLeft(2, '0'),
// //                 style: AppTextStyles.h2
// //                     .copyWith(color: color, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             // Two separate Text widgets — prevents "Complet\ned" wrap bug
// //             Text(
// //               line1,
// //               softWrap: false,
// //               overflow: TextOverflow.visible,
// //               style: AppTextStyles.body.copyWith(
// //                   color: AppColors.textPrimary,
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 13),
// //             ),
// //             Text(
// //               line2,
// //               softWrap: false,
// //               overflow: TextOverflow.visible,
// //               style: AppTextStyles.body.copyWith(
// //                   color: AppColors.textPrimary,
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 13),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // //  MRN Card 
// // class _MRNCard extends StatelessWidget {
// //   final MRN mrn;
// //   final bool isManager;
// //   final VoidCallback onTap;
// //   final VoidCallback onEdit;
// //   final VoidCallback onDelete;
// //
// //   const _MRNCard({
// //     super.key,
// //     required this.mrn,
// //     required this.isManager,
// //     required this.onTap,
// //     required this.onEdit,
// //     required this.onDelete,
// //   });
// //
// //   String get _mrnNo {
// //     final match = RegExp(r'\d+$').firstMatch(mrn.mrnNumber);
// //     if (match != null) {
// //       return int.parse(match.group(0)!).toString().padLeft(3, '0');
// //     }
// //     return mrn.mrnNumber;
// //   }
// //
// //   String get _mrnType =>
// //       mrn.warehouseName?.isNotEmpty == true ? mrn.warehouseName! : 'Direct';
// //
// //   String _fmtDate(DateTime d) => '${d.day.toString().padLeft(2, '0')}/'
// //       '${d.month.toString().padLeft(2, '0')}/${d.year}';
// //
// //   bool get _canEdit => mrn.statusId == 1 || mrn.statusId == 2;
// //   bool get _canDelete => mrn.statusId == 1 || mrn.statusId == 2;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         margin: const EdgeInsets.only(bottom: 12),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(
// //             color: _canEdit
// //                 ? AppColors.purple.withValues(alpha: 0.25)
// //                 : AppColors.divider,
// //             width: _canEdit ? 1.5 : 1.0,
// //           ),
// //           boxShadow: [
// //             BoxShadow(
// //               color: _C.fieldShadow,
// //               blurRadius: 8,
// //               offset: const Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Padding(
// //           padding: const EdgeInsets.all(14),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               //  Row 1: MRN No. | MRN Type | icons 
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     'MRN No.:',
// //                     style: AppTextStyles.body
// //                         .copyWith(color: AppColors.textSecondary, fontSize: 13),
// //                   ),
// //                   Text(
// //                     _mrnNo,
// //                     style: AppTextStyles.h3
// //                         .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
// //                   ),
// //                   const SizedBox(width: 8
// //                   ),
// //                   // Type — shrinks before icons get pushed off
// //                   Expanded(
// //                     child: Text(
// //                       'MRN Type :$_mrnType',
// //                       overflow: TextOverflow.ellipsis,
// //                       style: AppTextStyles.body.copyWith(fontSize: 13),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 6),
// //                   // Icons — always on same row, never wrapped
// //                   Row(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       _IconBtn(
// //                         icon: Icons.picture_as_pdf_rounded,
// //                         color: AppColors.error,
// //                         bgColor: AppColors.errorLight,
// //                         onTap: () {},
// //                       ),
// //                       if (_canEdit) ...[
// //                         const SizedBox(width: 6),
// //                         _IconBtn(
// //                           icon: Icons.edit_outlined,
// //                           color: AppColors.info,
// //                           bgColor: AppColors.infoLight,
// //                           onTap: onEdit,
// //                         ),
// //                       ],
// //                       if (_canDelete) ...[
// //                         const SizedBox(width: 6),
// //                         _IconBtn(
// //                           icon: Icons.delete_outline_rounded,
// //                           color: AppColors.error,
// //                           bgColor: AppColors.errorLight,
// //                           onTap: onDelete,
// //                         ),
// //                       ],
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //
// //               const SizedBox(height: 10),
// //               Divider(height: 1, color: AppColors.divider),
// //               const SizedBox(height: 10),
// //
// //               //  Row 2: Party Name | Site Name 
// //               Row(children: [
// //                 Expanded(
// //                   child: _InfoBox(
// //                     label: 'Party Name',
// //                     value: mrn.supplierName?.isNotEmpty == true
// //                         ? mrn.supplierName!
// //                         : '—',
// //                   ),
// //                 ),
// //                 const SizedBox(width: 10),
// //                 Expanded(
// //                   child: _InfoBox(
// //                     label: 'Site Name',
// //                     value:
// //                     mrn.siteName?.isNotEmpty == true ? mrn.siteName! : '—',
// //                   ),
// //                 ),
// //               ]),
// //               const SizedBox(height: 12),
// //
// //               //  Row 3: Paid By | Customer PO | Job Type 
// //               Row(
// //                 children: [
// //                   Text(
// //                     'Job Type : ',
// //                     style: AppTextStyles.body.copyWith(
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   Text(
// //                     mrn.warehouseName?.isNotEmpty == true
// //                         ? mrn.warehouseName!
// //                         : '—',
// //                     style: AppTextStyles.body,
// //                   ),
// //
// //                   const Spacer(),
// //
// //                   Container(
// //                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
// //                     decoration: BoxDecoration(
// //                       color: AppColors.orange.withValues(alpha:0.15),
// //                       borderRadius: BorderRadius.circular(18),
// //                     ),
// //                     child: Text(
// //                       'Pending', // or dynamic
// //                       style: TextStyle(
// //                         color: AppColors.orange,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //
// //               const SizedBox(height: 10),
// //               Divider(height: 1, color: AppColors.divider),
// //               const SizedBox(height: 10),
// //
// //               //  Row 4: Date on its own line 
// //               // FIX: Split into 2 rows to prevent 36px overflow
// //               Row(
// //                 children: [
// //                   const Icon(Icons.calendar_today_outlined,
// //                       size: 14, color: AppColors.textSecondary),
// //                   const SizedBox(width: 6),
// //                   Text(
// //                     'Date : ',
// //                     style: AppTextStyles.body
// //                         .copyWith(fontWeight: FontWeight.w600, fontSize: 13),
// //                   ),
// //                   Text(
// //                     _fmtDate(mrn.mrnDate),
// //                     style: AppTextStyles.body.copyWith(fontSize: 13),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 4),
// //               Row(
// //                 children: [
// //                   Text(
// //                     'Submitted By : ',
// //                     style: AppTextStyles.body
// //                         .copyWith(fontWeight: FontWeight.w600, fontSize: 13),
// //                   ),
// //                   Expanded(
// //                     child: Text(
// //                       mrn.createdByName.isNotEmpty ? mrn.createdByName : '—',
// //                       style: AppTextStyles.body.copyWith(
// //                           color: AppColors.textSecondary, fontSize: 13),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // //  Info Box 
// // class _InfoBox extends StatelessWidget {
// //   final String label;
// //   final String value;
// //   const _InfoBox({required this.label, required this.value});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //       decoration: BoxDecoration(
// //         color: _C.infoBoxBg,
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(label,
// //               style: AppTextStyles.label(color: AppColors.textSecondary)),
// //           const SizedBox(height: 2),
// //           Text(value,
// //               style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // //  Three-col item 
// // class _ThreeColItem extends StatelessWidget {
// //   final String label;
// //   final String value;
// //   const _ThreeColItem({required this.label, required this.value});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(label, style: AppTextStyles.label(color: AppColors.textSecondary)),
// //         const SizedBox(height: 2),
// //         Text(value,
// //             style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
// //             maxLines: 1,
// //             overflow: TextOverflow.ellipsis),
// //       ],
// //     );
// //   }
// // }
// //
// // //  Small icon button 
// // class _IconBtn extends StatelessWidget {
// //   final IconData icon;
// //   final Color color;
// //   final Color bgColor;
// //   final VoidCallback onTap;
// //   const _IconBtn({
// //     required this.icon,
// //     required this.color,
// //     required this.bgColor,
// //     required this.onTap,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: 32,
// //         height: 32,
// //         decoration: BoxDecoration(
// //           color: bgColor,
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Icon(icon, size: 16, color: color),
// //       ),
// //     );
// //   }
// // }
//
//
//
// // lib/screens/mrn/mrn_list_screen.dart
// // lib/screens/mrn/mrn_list_screen.dart
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:flutter/material.dart';
// import '../model/mrn_models.dart';
// import '../widgets/app_theme.dart';
// import 'mrn_detail_screen.dart';
// import 'mrn_filter_screen.dart';
// import 'add_mrn_screen.dart';
//
// //  Design tokens 
// const Color _kBg          = Color(0xFFF5F6FA);
// const Color _kBorder      = Color(0xFFE2E8F0);
// const Color _kBlue        = purpleColor;
// final Color _kBlueBg      = purpleLightest;
// const Color _kGreen       = Color(0xFF10B981);
// const Color _kGreenBg     = Color(0xFFD1FAE5);
// const Color _kOrange      = Color(0xFFF59E0B);
// const Color _kOrangeBg    = Color(0xFFFEF3C7);
// const Color _kRed         = Color(0xFFEF4444);
// const Color _kRedBg       = Color(0xFFFEE2E2);
// const Color _kTextPrimary = Color(0xFF0F172A);
// const Color _kTextSub     = Color(0xFF64748B);
// const Color _kTextHint    = Color(0xFF94A3B8);
// const Color _kInfoBg      = Color(0xFFEEF1FF);
// const Color _kDivider     = Color(0xFFEFF2F7);
//
// //  Confirm dialog 
// Future<bool> _showConfirmDialog({
//   required BuildContext context,
//   required String title,
//   required String message,
//   required String confirmLabel,
//   bool isDanger = false,
// }) async {
//   final result = await showDialog<bool>(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: Text(title),
//       content: Text(message),
//       actions: [
//         TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: const Text('Cancel')),
//         ElevatedButton(
//           onPressed: () => Navigator.pop(ctx, true),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: isDanger ? _kRed : _kBlue,
//             foregroundColor: Colors.white,
//           ),
//           child: Text(confirmLabel),
//         ),
//       ],
//     ),
//   );
//   return result ?? false;
// }
//
// //  Screen 
// class MRNListScreen extends StatefulWidget {
//   const MRNListScreen({super.key});
//   @override
//   State<MRNListScreen> createState() => _MRNListScreenState();
// }
//
// class _MRNListScreenState extends State<MRNListScreen> {
//   final _scrollCtrl = ScrollController();
//
//   late List<MRN> _allMrns;
//   List<MRN> _filtered = [];
//   MRNFilter _activeFilter = MRNFilter.empty;
//
//   @override
//   void initState() {
//     super.initState();
//     _allMrns  = List.of(MRNDummyData.mrns);
//     _filtered = List.of(_allMrns);
//   }
//
//   @override
//   void dispose() {
//     _scrollCtrl.dispose();
//     super.dispose();
//   }
//
//   void _applyFilter(MRNFilter f) {
//     setState(() {
//       _activeFilter = f;
//       _filtered = _allMrns.where((m) {
//         if (f.fromDate != null &&
//             m.mrnDate.isBefore(DateTime(
//                 f.fromDate!.year, f.fromDate!.month, f.fromDate!.day)))
//           return false;
//         if (f.toDate != null &&
//             m.mrnDate.isAfter(DateTime(
//                 f.toDate!.year, f.toDate!.month, f.toDate!.day, 23, 59)))
//           return false;
//         if (f.partyName != null &&
//             !(m.supplierName
//                 ?.toLowerCase()
//                 .contains(f.partyName!.toLowerCase()) ??
//                 false)) return false;
//         if (f.siteName != null &&
//             !(m.siteName
//                 ?.toLowerCase()
//                 .contains(f.siteName!.toLowerCase()) ??
//                 false)) return false;
//         if (f.jobTypeName != null &&
//             !(m.warehouseName
//                 ?.toLowerCase()
//                 .contains(f.jobTypeName!.toLowerCase()) ??
//                 false)) return false;
//         return true;
//       }).toList();
//     });
//   }
//
//   void _clearFilter() => setState(() {
//     _activeFilter = MRNFilter.empty;
//     _filtered     = List.of(_allMrns);
//   });
//
//   Future<void> _openFilter() async {
//     final result = await Navigator.push<MRNFilter>(
//       context,
//       MaterialPageRoute(
//           builder: (_) => MrnFilterScreen(initial: _activeFilter)),
//     );
//     if (result != null) _applyFilter(result);
//   }
//
//   Future<void> _confirmDelete(MRN mrn) async {
//     final ok = await _showConfirmDialog(
//       context: context,
//       title: 'Delete MRN',
//       message: 'Delete ${mrn.mrnNumber}? This cannot be undone.',
//       confirmLabel: 'Delete',
//       isDanger: true,
//     );
//     if (ok && mounted) {
//       setState(() {
//         _allMrns.removeWhere((m) => m.mrnId == mrn.mrnId);
//         _filtered.removeWhere((m) => m.mrnId == mrn.mrnId);
//       });
//     }
//   }
//
//   void _openDetail(MRN mrn) => Navigator.push(context,
//       MaterialPageRoute(builder: (_) => MRNDetailScreen(mrnId: mrn.mrnId)));
//
//   void _openAdd() => Navigator.push(
//       context, MaterialPageRoute(builder: (_) => const AddMRNScreen()));
//
//   @override
//   Widget build(BuildContext context) {
//     final completedCount = _filtered.where((m) => m.statusId == 3).length;
//     final pendingCount =
//         _filtered.where((m) => m.statusId == 1 || m.statusId == 2).length;
//     final cancelledCount = _filtered.where((m) => m.statusId == 4).length;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//
//       //  App Bar 
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   color: Color(0x0F000000),
//                   blurRadius: 12,
//                   offset: Offset(0, 3)),
//             ],
//           ),
//           child: SafeArea(
//             bottom: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_new, size: 22),
//                     color: _kTextPrimary,
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'MRN',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: _kTextPrimary,
//                       ),
//                     ),
//                   ),
//                   if (_activeFilter.isActive)
//                     TextButton(
//                       onPressed: _clearFilter,
//                       child: const Text('Clear',
//                           style: TextStyle(color: _kRed, fontSize: 13)),
//                     ),
//                   Container(
//                     margin: const EdgeInsets.only(right: 12),
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: purpleLightest,
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       icon: const Icon(Icons.filter_list_sharp,
//                           size: 20, color: purpleColor),
//                       onPressed: _openFilter,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       //  FAB 
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openAdd,
//         backgroundColor: _kBlue,
//         shape:
//         const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
//         elevation: 4,
//         child: const Icon(Icons.add, color: Colors.white, size: 28),
//       ),
//
//       //  Body 
//       body: RefreshIndicator(
//         onRefresh: () async => setState(() {
//           _allMrns      = List.of(MRNDummyData.mrns);
//           _filtered     = List.of(_allMrns);
//           _activeFilter = MRNFilter.empty;
//         }),
//         color: _kBlue,
//         child: ListView(
//           controller: _scrollCtrl,
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//           children: [
//             // Stat row
//             Row(children: [
//               _StatCard(
//                   count: completedCount,
//                   label: 'Completed\nMRN',
//                   color: _kGreen,
//                   bgColor: _kGreenBg),
//               const SizedBox(width: 10),
//               _StatCard(
//                   count: pendingCount,
//                   label: 'Pending\nMRN',
//                   color: _kOrange,
//                   bgColor: _kOrangeBg),
//               const SizedBox(width: 10),
//               _StatCard(
//                   count: cancelledCount,
//                   label: 'Cancelled\nMRN',
//                   color: _kRed,
//                   bgColor: _kRedBg),
//             ]),
//             const SizedBox(height: 24),
//
//             const Text(
//               'List of MRN',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w800,
//                   color: _kTextPrimary),
//             ),
//             const SizedBox(height: 12),
//
//             if (_filtered.isEmpty)
//               _EmptyState(onAdd: _openAdd)
//             else
//               ..._filtered.map((mrn) => _MRNCard(
//                 mrn: mrn,
//                 onTap:    () => _openDetail(mrn),
//                 onEdit:   () => _openDetail(mrn),
//                 onDelete: () => _confirmDelete(mrn),
//               )),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //  Empty state 
// class _EmptyState extends StatelessWidget {
//   final VoidCallback onAdd;
//   const _EmptyState({required this.onAdd});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 40),
//           const Icon(Icons.receipt_long_outlined,
//               size: 56, color: _kTextHint),
//           const SizedBox(height: 12),
//           const Text('No MRNs Found',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: _kTextPrimary)),
//           const SizedBox(height: 4),
//           const Text('Material receipt notes will appear here.',
//               style: TextStyle(fontSize: 13, color: _kTextSub)),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: onAdd,
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: _kBlue, foregroundColor: Colors.white),
//             child: const Text('Create MRN'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  Stat Card 
// class _StatCard extends StatelessWidget {
//   final int count;
//   final String label;
//   final Color color;
//   final Color bgColor;
//   const _StatCard(
//       {required this.count,
//         required this.label,
//         required this.color,
//         required this.bgColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: _kBorder),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               decoration: BoxDecoration(
//                 color: bgColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 count.toString().padLeft(2, '0'),
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: color),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: _kTextPrimary,
//                   height: 1.4),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //  MRN Card 
// class _MRNCard extends StatelessWidget {
//   final MRN mrn;
//   final VoidCallback onTap;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;
//
//   const _MRNCard({
//     super.key,
//     required this.mrn,
//     required this.onTap,
//     required this.onEdit,
//     required this.onDelete,
//   });
//
//   String get _mrnNo {
//     final match = RegExp(r'\d+$').firstMatch(mrn.mrnNumber);
//     if (match != null)
//       return int.parse(match.group(0)!).toString().padLeft(3, '0');
//     return mrn.mrnNumber;
//   }
//
//   String get _mrnType =>
//       mrn.warehouseName?.isNotEmpty == true ? mrn.warehouseName! : 'Direct';
//
//   String _fmtDate(DateTime d) =>
//       '${d.day.toString().padLeft(2, '0')}/'
//           '${d.month.toString().padLeft(2, '0')}/${d.year}';
//
//   bool get _canEdit   => mrn.statusId == 1 || mrn.statusId == 2;
//   bool get _canDelete => mrn.statusId == 1 || mrn.statusId == 2;
//
//   Color get _statusColor {
//     switch (mrn.statusId) {
//       case 3:  return _kGreen;
//       case 4:  return _kRed;
//       case 2:  return _kBlue;
//       default: return _kOrange;
//     }
//   }
//
//   Color get _statusBg {
//     switch (mrn.statusId) {
//       case 3:  return _kGreenBg;
//       case 4:  return _kRedBg;
//       case 2:  return _kBlueBg;
//       default: return _kOrangeBg;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: _canEdit
//                 ? _kBlue.withValues(alpha: 0.35)
//                 : _kBorder,
//             width: _canEdit ? 1.5 : 1.0,
//           ),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.04),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2)),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             //  Row 1: MRN No. | MRN Type | PDF / Edit / Delete 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 12, 12, 10),
//               child: Row(
//                 children: [
//                   // MRN No.
//                   Text('MRN No.:',
//                       style: const TextStyle(
//                           fontSize: 13,
//                           color: _kTextSub,
//                           fontWeight: FontWeight.w400)),
//                   Text(' $_mrnNo ',
//                       style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: _kTextPrimary)),
//                   // MRN Type
//                   Text('MRN Type :',
//                       style: const TextStyle(
//                           fontSize: 13,
//                           color: _kTextSub,
//                           fontWeight: FontWeight.w400)),
//                   Expanded(
//                     child: Text(
//                       _mrnType,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w700,
//                           color: _kTextPrimary),
//                     ),
//                   ),
//                   const SizedBox(width: 6),
//
//                   // Action icons
//                   // PDF — custom asset
//                   GestureDetector(
//                     onTap: () {},
//                     child: Image.asset(
//                       'assets/iconsnew/pdfIcon.png',
//                       width: 14,
//                       height: 16,
//                     ),
//                   ),
//                   if (_canEdit) ...[
//                     const SizedBox(width: 6),
//                     _IconBtn(
//                       icon: Icons.edit_outlined,
//                       color: _kBlue,
//                       bgColor: _kBlueBg,
//                       onTap: onEdit,
//                     ),
//                   ],
//                   if (_canDelete) ...[
//                     const SizedBox(width: 6),
//                     _IconBtn(
//                       icon: Icons.delete_outline_rounded,
//                       color: _kRed,
//                       bgColor: _kRedBg,
//                       onTap: onDelete,
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//
//             const Divider(height: 1, color: _kDivider),
//
//             //  Row 2: Party Name box | Site Name box 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _InfoBox(
//                       label: 'Party Name',
//                       value: mrn.supplierName?.isNotEmpty == true
//                           ? mrn.supplierName!
//                           : '—',
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: _InfoBox(
//                       label: 'Site Name',
//                       value: mrn.siteName?.isNotEmpty == true
//                           ? mrn.siteName!
//                           : '—',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             //  Row 3: Paid By | Customer PO | Job Type (3-col) 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
//               child: Row(
//                 children: [
//                   _MiniField(
//                     label: 'Paid By',
//                     value: mrn.createdByName.isNotEmpty
//                         ? mrn.createdByName
//                         : '—',
//                   ),
//                   _VerticalDivider(),
//                   _MiniField(
//                     label: 'Customer PO',
//                     value: mrn.customerPO?.isNotEmpty == true
//                         ? mrn.customerPO!
//                         : '—',
//                   ),
//                   _VerticalDivider(),
//                   _MiniField(
//                     label: 'Job Type',
//                     value: mrn.warehouseName?.isNotEmpty == true
//                         ? mrn.warehouseName!
//                         : '—',
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 10),
//             const Divider(height: 1, color: _kDivider),
//
//             //  Row 4: Date | Submitted By 
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
//               child: Row(
//                 children: [
//                   const Icon(Icons.calendar_today_outlined,
//                       size: 14, color: _kTextSub),
//                   const SizedBox(width: 6),
//                   Text(
//                     'Date : ${_fmtDate(mrn.mrnDate)}',
//                     style: const TextStyle(
//                         fontSize: 13, color: _kTextSub),
//                   ),
//                   const Spacer(),
//                   Text(
//                     'Submitted By : ',
//                     style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: _kTextPrimary),
//                   ),
//                   Flexible(
//                     child: Text(
//                       mrn.createdByName.isNotEmpty
//                           ? mrn.createdByName
//                           : '—',
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                           fontSize: 13, color: _kTextSub),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //  Info Box (blue left border style) 
// class _InfoBox extends StatelessWidget {
//   final String label;
//   final String value;
//   const _InfoBox({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: _kInfoBg,
//         borderRadius: BorderRadius.circular(8),
//         border: const Border(
//           left: BorderSide(color: _kBlue, width: 3),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontSize: 11,
//                   color: _kTextSub,
//                   fontWeight: FontWeight.w400)),
//           const SizedBox(height: 2),
//           Text(
//             value,
//             style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: _kTextPrimary),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  Mini field (3-col row) 
// class _MiniField extends StatelessWidget {
//   final String label;
//   final String value;
//   const _MiniField({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontSize: 11,
//                   color: _kTextSub,
//                   fontWeight: FontWeight.w400)),
//           const SizedBox(height: 2),
//           Text(
//             value,
//             style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: _kTextPrimary),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  Vertical divider between 3-col fields 
// class _VerticalDivider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1,
//       height: 36,
//       color: _kBorder,
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//     );
//   }
// }
//
// //  Small icon button 
// class _IconBtn extends StatelessWidget {
//   final IconData icon;
//   final Color color;
//   final Color bgColor;
//   final VoidCallback onTap;
//   const _IconBtn(
//       {required this.icon,
//         required this.color,
//         required this.bgColor,
//         required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 32,
//         height: 32,
//         decoration: BoxDecoration(
//             color: bgColor, borderRadius: BorderRadius.circular(8)),
//         child: Icon(icon, size: 16, color: color),
//       ),
//     );
//   }
// }