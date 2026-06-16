// // // lib/screens/mrn/mrn_filter_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:provider/provider.dart';
// // import '../../constants/app_theme.dart';
// // import '../../providers/mrn_provider.dart';
// //
// // //  Local design tokens 
// // class _C {
// //   static const bg           = Color(0xFFF5F5F7);
// //   static const fieldShadow  = Color(0x12000000);
// //   static const appBarShadow = Color(0x0F000000);
// // }
// //
// // class MrnFilterScreen extends StatefulWidget {
// //   const MrnFilterScreen({super.key});
// //   @override
// //   State<MrnFilterScreen> createState() => _MrnFilterScreenState();
// // }
// //
// // class _MrnFilterScreenState extends State<MrnFilterScreen> {
// //   DateTime? _fromDate = DateTime(2026, 1, 20);
// //   DateTime? _toDate   = DateTime(2026, 1, 27);
// //   int?      _partyId;
// //   int?      _siteId;
// //   int?      _jobTypeId;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback(
// //             (_) => context.read<MRNProvider>().loadDropdowns());
// //   }
// //
// //   Future<void> _pickDate(bool isFrom) async {
// //     final initial = isFrom
// //         ? (_fromDate ?? DateTime.now())
// //         : (_toDate   ?? DateTime.now());
// //     final picked = await showDatePicker(
// //       context:     context,
// //       initialDate: initial,
// //       firstDate:   DateTime(2020),
// //       lastDate:    DateTime(2030),
// //       builder: (ctx, child) => Theme(
// //         data: Theme.of(ctx).copyWith(
// //             colorScheme:
// //             const ColorScheme.light(primary: AppColors.purple)),
// //         child: child!,
// //       ),
// //     );
// //     if (picked != null) {
// //       setState(() {
// //         if (isFrom) _fromDate = picked;
// //         else        _toDate   = picked;
// //       });
// //     }
// //   }
// //
// //   String _fmtDate(DateTime d) =>
// //       '${d.day.toString().padLeft(2, '0')}/'
// //           '${d.month.toString().padLeft(2, '0')}/${d.year}';
// //
// //   void _apply() {
// //     context.read<MRNProvider>().setFilters(
// //       partyId:   _partyId,
// //       siteId:    _siteId,
// //       jobTypeId: _jobTypeId,
// //       fromDate:  _fromDate,
// //       toDate:    _toDate,
// //     );
// //     context.pop();
// //   }
// //
// //   void _reset() {
// //     setState(() {
// //       _fromDate  = null;
// //       _toDate    = null;
// //       _partyId   = null;
// //       _siteId    = null;
// //       _jobTypeId = null;
// //     });
// //     context.read<MRNProvider>().clearFilters();
// //     context.pop();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final p        = context.watch<MRNProvider>();
// //     final parties  = p.parties;
// //     final sites    = p.sites;
// //     final jobTypes = p.jobTypes;
// //
// //     return Scaffold(
// //       backgroundColor: _C.bg,
// //
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
// //                     icon: const Icon(
// //                         Icons.arrow_back_ios_new_rounded, size: 20),
// //                     color: AppColors.textPrimary,
// //                     onPressed: () => context.pop(),
// //                   ),
// //                   Expanded(
// //                     child: Text(
// //                       'Filter',
// //                       style: AppTextStyles.h2.copyWith(
// //                           fontSize: 22, fontWeight: FontWeight.w800),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   //  Date range 
// //                   Row(children: [
// //                     Expanded(
// //                       child: _DateBox(
// //                         label: _fromDate != null
// //                             ? _fmtDate(_fromDate!)
// //                             : 'From Date',
// //                         onTap: () => _pickDate(true),
// //                       ),
// //                     ),
// //                     Padding(
// //                       padding:
// //                       const EdgeInsets.symmetric(horizontal: 10),
// //                       child: Text('to',
// //                           style: AppTextStyles.body
// //                               .copyWith(color: AppColors.textSecondary)),
// //                     ),
// //                     Expanded(
// //                       child: _DateBox(
// //                         label: _toDate != null
// //                             ? _fmtDate(_toDate!)
// //                             : 'To Date',
// //                         onTap: () => _pickDate(false),
// //                       ),
// //                     ),
// //                   ]),
// //                   const SizedBox(height: 16),
// //
// //                   //  Party Name 
// //                   _FilterLabel('Party Name'),
// //                   _FilterDropdown<int>(
// //                     hint:      'Select party',
// //                     value:     _partyId,
// //                     items:     parties
// //                         .map((p) => DropdownMenuItem<int>(
// //                       value: p['PartyID'] as int,
// //                       child: Text(
// //                           p['PartyName']?.toString() ?? '',
// //                           style: AppTextStyles.body),
// //                     ))
// //                         .toList(),
// //                     onChanged: parties.isEmpty
// //                         ? null
// //                         : (v) => setState(() => _partyId = v),
// //                   ),
// //                   const SizedBox(height: 14),
// //
// //                   //  Site Name 
// //                   _FilterLabel('Site Name'),
// //                   _FilterDropdown<int>(
// //                     hint:      'Select site',
// //                     value:     _siteId,
// //                     items:     sites
// //                         .map((s) => DropdownMenuItem<int>(
// //                       value: s['SiteID'] as int,
// //                       child: Text(
// //                           s['SiteName']?.toString() ?? '',
// //                           style: AppTextStyles.body),
// //                     ))
// //                         .toList(),
// //                     onChanged: sites.isEmpty
// //                         ? null
// //                         : (v) => setState(() => _siteId = v),
// //                   ),
// //                   const SizedBox(height: 14),
// //
// //                   //  Job Type 
// //                   _FilterLabel('Job Type'),
// //                   _FilterDropdown<int>(
// //                     hint:      'Select job type',
// //                     value:     _jobTypeId,
// //                     items:     jobTypes
// //                         .map((j) => DropdownMenuItem<int>(
// //                       value: j['JobTypeID'] as int,
// //                       child: Text(
// //                           j['JobTypeName']?.toString() ?? '',
// //                           style: AppTextStyles.body),
// //                     ))
// //                         .toList(),
// //                     onChanged: jobTypes.isEmpty
// //                         ? null
// //                         : (v) => setState(() => _jobTypeId = v),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //
// //           //  Bottom buttons 
// //           Container(
// //             padding: EdgeInsets.only(
// //               left:   16,
// //               right:  16,
// //               top:    16,
// //               bottom: MediaQuery.of(context).padding.bottom + 16,
// //             ),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: _C.appBarShadow,
// //                   blurRadius: 12,
// //                   offset: const Offset(0, -3),
// //                 ),
// //               ],
// //             ),
// //             child: Row(children: [
// //               Expanded(
// //                 child: OutlinedButton(
// //                   onPressed: _reset,
// //                   style: OutlinedButton.styleFrom(
// //                     foregroundColor: AppColors.purple,
// //                     minimumSize: const Size(double.infinity, 52),
// //                     side: const BorderSide(color: AppColors.purple),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(18)),
// //                   ),
// //                   child: Text('Reset',
// //                       style: AppTextStyles.button(
// //                           color: AppColors.purple)),
// //                 ),
// //               ),
// //               const SizedBox(width: 14),
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: _apply,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.purple,
// //                     foregroundColor: Colors.white,
// //                     minimumSize: const Size(double.infinity, 52),
// //                     elevation: 0,
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(18)),
// //                   ),
// //                   child: Text('Apply',
// //                       style:
// //                       AppTextStyles.button(color: Colors.white)),
// //                 ),
// //               ),
// //             ]),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // //  Filter section label 
// // class _FilterLabel extends StatelessWidget {
// //   final String text;
// //   const _FilterLabel(this.text);
// //   @override
// //   Widget build(BuildContext context) => Padding(
// //     padding: const EdgeInsets.only(bottom: 8),
// //     child: Text(text, style: AppTextStyles.label()),
// //   );
// // }
// //
// // //  Date Box 
// // class _DateBox extends StatelessWidget {
// //   final String       label;
// //   final VoidCallback onTap;
// //   const _DateBox({required this.label, required this.onTap});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding:
// //         const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(18),
// //           boxShadow: [
// //             BoxShadow(
// //               color: const Color(0x12000000),
// //               blurRadius: 8,
// //               offset: const Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Row(children: [
// //           Expanded(
// //             child: Text(label,
// //                 style: AppTextStyles.body.copyWith(fontSize: 14)),
// //           ),
// //           const Icon(Icons.calendar_today_outlined,
// //               size: 18, color: AppColors.textSecondary),
// //         ]),
// //       ),
// //     );
// //   }
// // }
// //
// // //  Filter Dropdown 
// // class _FilterDropdown<T> extends StatelessWidget {
// //   final String                    hint;
// //   final T?                        value;
// //   final List<DropdownMenuItem<T>> items;
// //   final ValueChanged<T?>?         onChanged;
// //
// //   const _FilterDropdown({
// //     required this.hint,
// //     required this.value,
// //     required this.items,
// //     required this.onChanged,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(18),
// //         boxShadow: [
// //           BoxShadow(
// //             color: const Color(0x12000000),
// //             blurRadius: 8,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: DropdownButtonHideUnderline(
// //         child: DropdownButton<T>(
// //           value:      value,
// //           isExpanded: true,
// //           hint: Text(
// //             hint,
// //             style: AppTextStyles.body.copyWith(
// //                 fontSize: 15, color: AppColors.textTertiary),
// //           ),
// //           icon: const Icon(Icons.keyboard_arrow_down_rounded,
// //               size: 24, color: AppColors.textSecondary),
// //           items:     items.isEmpty ? [] : items,
// //           onChanged: onChanged,
// //           style: AppTextStyles.body.copyWith(
// //               fontSize: 15, color: AppColors.textPrimary),
// //           disabledHint: items.isEmpty
// //               ? Text(hint,
// //               style: AppTextStyles.body.copyWith(
// //                   fontSize: 15, color: AppColors.textTertiary))
// //               : null,
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // lib/screens/mrn/mrn_filter_screen.dart
// // lib/screens/mrn/mrn_filter_screen.dart
// import 'package:flutter/material.dart';
//
// import '../model/mrn_models.dart';
// import '../widgets/app_theme.dart';
//
//
// //  Local design tokens 
// class _C {
//   static const bg           = Color(0xFFF5F5F7);
//   static const appBarShadow = Color(0x0F000000);
// }
//
// class MrnFilterScreen extends StatefulWidget {
//   // Receives current active filter so fields are pre-populated
//   final MRNFilter initial;
//   const MrnFilterScreen({super.key, this.initial = MRNFilter.empty});
//
//   @override
//   State<MrnFilterScreen> createState() => _MrnFilterScreenState();
// }
//
// class _MrnFilterScreenState extends State<MrnFilterScreen> {
//   DateTime? _fromDate;
//   DateTime? _toDate;
//   int?      _partyId;
//   String?   _partyName;
//   int?      _siteId;
//   String?   _siteName;
//   int?      _jobTypeId;
//   String?   _jobTypeName;
//
//   final List<Map<String, dynamic>> _parties  = MRNDummyData.parties;
//   final List<Map<String, dynamic>> _sites    = MRNDummyData.sites;
//   final List<Map<String, dynamic>> _jobTypes = MRNDummyData.jobTypes;
//
//   @override
//   void initState() {
//     super.initState();
//     // Pre-populate from the filter passed in
//     _fromDate    = widget.initial.fromDate;
//     _toDate      = widget.initial.toDate;
//     _partyId     = widget.initial.partyId;
//     _partyName   = widget.initial.partyName;
//     _siteId      = widget.initial.siteId;
//     _siteName    = widget.initial.siteName;
//     _jobTypeId   = widget.initial.jobTypeId;
//     _jobTypeName = widget.initial.jobTypeName;
//   }
//
//   Future<void> _pickDate(bool isFrom) async {
//     final initial = isFrom
//         ? (_fromDate ?? DateTime.now())
//         : (_toDate   ?? DateTime.now());
//     final picked = await showDatePicker(
//       context:     context,
//       initialDate: initial,
//       firstDate:   DateTime(2020),
//       lastDate:    DateTime(2030),
//       builder: (ctx, child) => Theme(
//         data: Theme.of(ctx).copyWith(
//             colorScheme:
//             const ColorScheme.light(primary: AppColors.purple)),
//         child: child!,
//       ),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isFrom) _fromDate = picked;
//         else        _toDate   = picked;
//       });
//     }
//   }
//
//   String _fmtDate(DateTime d) =>
//       '${d.day.toString().padLeft(2, '0')}/'
//           '${d.month.toString().padLeft(2, '0')}/${d.year}';
//
//   // Pop with built MRNFilter — list screen applies it
//   void _apply() => Navigator.pop(
//     context,
//     MRNFilter(
//       fromDate:    _fromDate,
//       toDate:      _toDate,
//       partyId:     _partyId,
//       partyName:   _partyName,
//       siteId:      _siteId,
//       siteName:    _siteName,
//       jobTypeId:   _jobTypeId,
//       jobTypeName: _jobTypeName,
//     ),
//   );
//
//   // Pop with empty filter — list screen resets
//   void _reset() {
//     setState(() {
//       _fromDate    = null;
//       _toDate      = null;
//       _partyId     = null;
//       _partyName   = null;
//       _siteId      = null;
//       _siteName    = null;
//       _jobTypeId   = null;
//       _jobTypeName = null;
//     });
//     Navigator.pop(context, MRNFilter.empty);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _C.bg,
//
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   color: _C.appBarShadow,
//                   blurRadius: 12,
//                   offset: const Offset(0, 3)),
//             ],
//           ),
//           child: SafeArea(
//             bottom: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                         size: 20),
//                     color: AppColors.textPrimary,
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   Expanded(
//                     child: Text('Filter',
//                         style: AppTextStyles.h2.copyWith(
//                             fontSize: 22, fontWeight: FontWeight.w800)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //  Date range 
//                   Row(children: [
//                     Expanded(
//                       child: _DateBox(
//                         label: _fromDate != null
//                             ? _fmtDate(_fromDate!)
//                             : 'From Date',
//                         onTap: () => _pickDate(true),
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 10),
//                       child: Text('to',
//                           style: AppTextStyles.body.copyWith(
//                               color: AppColors.textSecondary)),
//                     ),
//                     Expanded(
//                       child: _DateBox(
//                         label: _toDate != null
//                             ? _fmtDate(_toDate!)
//                             : 'To Date',
//                         onTap: () => _pickDate(false),
//                       ),
//                     ),
//                   ]),
//                   const SizedBox(height: 16),
//
//                   //  Party Name 
//                   _FilterLabel('Party Name'),
//                   _FilterDropdown<int>(
//                     hint:  'Select party',
//                     value: _partyId,
//                     items: _parties
//                         .map((p) => DropdownMenuItem<int>(
//                       value: p['PartyID'] as int,
//                       child: Text(p['PartyName']?.toString() ?? '',
//                           style: AppTextStyles.body),
//                     ))
//                         .toList(),
//                     onChanged: (v) => setState(() {
//                       _partyId   = v;
//                       _partyName = v == null
//                           ? null
//                           : _parties.firstWhere(
//                               (p) => p['PartyID'] == v,
//                           orElse: () => {})['PartyName'] as String?;
//                     }),
//                   ),
//                   const SizedBox(height: 14),
//
//                   //  Site Name 
//                   _FilterLabel('Site Name'),
//                   _FilterDropdown<int>(
//                     hint:  'Select site',
//                     value: _siteId,
//                     items: _sites
//                         .map((s) => DropdownMenuItem<int>(
//                       value: s['SiteID'] as int,
//                       child: Text(s['SiteName']?.toString() ?? '',
//                           style: AppTextStyles.body),
//                     ))
//                         .toList(),
//                     onChanged: (v) => setState(() {
//                       _siteId   = v;
//                       _siteName = v == null
//                           ? null
//                           : _sites.firstWhere(
//                               (s) => s['SiteID'] == v,
//                           orElse: () => {})['SiteName'] as String?;
//                     }),
//                   ),
//                   const SizedBox(height: 14),
//
//                   //  Job Type 
//                   _FilterLabel('Job Type'),
//                   _FilterDropdown<int>(
//                     hint:  'Select job type',
//                     value: _jobTypeId,
//                     items: _jobTypes
//                         .map((j) => DropdownMenuItem<int>(
//                       value: j['JobTypeID'] as int,
//                       child: Text(
//                           j['JobTypeName']?.toString() ?? '',
//                           style: AppTextStyles.body),
//                     ))
//                         .toList(),
//                     onChanged: (v) => setState(() {
//                       _jobTypeId   = v;
//                       _jobTypeName = v == null
//                           ? null
//                           : _jobTypes.firstWhere(
//                               (j) => j['JobTypeID'] == v,
//                           orElse: () => {})['JobTypeName'] as String?;
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           //  Bottom buttons 
//           Container(
//             padding: EdgeInsets.only(
//               left:   16,
//               right:  16,
//               top:    16,
//               bottom: MediaQuery.of(context).padding.bottom + 16,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                     color: _C.appBarShadow,
//                     blurRadius: 12,
//                     offset: const Offset(0, -3)),
//               ],
//             ),
//             child: Row(children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: _reset,
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: AppColors.purple,
//                     minimumSize: const Size(double.infinity, 52),
//                     side: const BorderSide(color: AppColors.purple),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18)),
//                   ),
//                   child: Text('Reset',
//                       style: AppTextStyles.button(
//                           color: AppColors.purple)),
//                 ),
//               ),
//               const SizedBox(width: 14),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: _apply,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.purple,
//                     foregroundColor: Colors.white,
//                     minimumSize: const Size(double.infinity, 52),
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18)),
//                   ),
//                   child: Text('Apply',
//                       style: AppTextStyles.button(color: Colors.white)),
//                 ),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  Filter section label 
// class _FilterLabel extends StatelessWidget {
//   final String text;
//   const _FilterLabel(this.text);
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.only(bottom: 8),
//     child: Text(text, style: AppTextStyles.label()),
//   );
// }
//
// //  Date Box 
// class _DateBox extends StatelessWidget {
//   final String       label;
//   final VoidCallback onTap;
//   const _DateBox({required this.label, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding:
//         const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: const [
//             BoxShadow(
//                 color: Color(0x12000000),
//                 blurRadius: 8,
//                 offset: Offset(0, 2)),
//           ],
//         ),
//         child: Row(children: [
//           Expanded(
//               child: Text(label,
//                   style: AppTextStyles.body.copyWith(fontSize: 14))),
//           const Icon(Icons.calendar_today_outlined,
//               size: 18, color: AppColors.textSecondary),
//         ]),
//       ),
//     );
//   }
// }
//
// //  Filter Dropdown 
// class _FilterDropdown<T> extends StatelessWidget {
//   final String                    hint;
//   final T?                        value;
//   final List<DropdownMenuItem<T>> items;
//   final ValueChanged<T?>?         onChanged;
//
//   const _FilterDropdown({
//     required this.hint,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: const [
//           BoxShadow(
//               color: Color(0x12000000),
//               blurRadius: 8,
//               offset: Offset(0, 2)),
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<T>(
//           value:      value,
//           isExpanded: true,
//           hint: Text(hint,
//               style: AppTextStyles.body
//                   .copyWith(fontSize: 15, color: AppColors.textTertiary)),
//           icon: const Icon(Icons.keyboard_arrow_down_rounded,
//               size: 24, color: AppColors.textSecondary),
//           items:     items,
//           onChanged: onChanged,
//           style: AppTextStyles.body
//               .copyWith(fontSize: 15, color: AppColors.textPrimary),
//         ),
//       ),
//     );
//   }
// }