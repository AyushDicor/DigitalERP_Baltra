// // lib/screens/tasks/_task_widgets.dart
// //
// // Shared widgets for all task screens.
// // Figma design tokens:
// //   • Page bg:   #F5F5F7  (light grey — NOT AppColors.background)
// //   • AppBar:    pure white, bottom shadow, back arrow + optional right icon
// //   • Fields:    white bg + soft box shadow (NOT border-only)
// //   • Submit:    full-width indigo pill, height 54
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:file_picker/file_picker.dart';
// import 'app_theme.dart';
//
// //  Design tokens 
// class TColors {
//   /// Page background — Figma light grey
//   static const bg = Color(0xFFFDFDFD);
//
//   /// Field shadow — Figma "floating" card effect
//   static BoxShadow get fieldShadow => BoxShadow(
//     color: const Color(0xFF000000).withValues(alpha: 0.1),
//     blurRadius: 15,
//     spreadRadius: 2,
//     offset: const Offset(0, 2),
//   );
//
//   /// AppBar bottom shadow
//   static BoxShadow get appBarShadow => BoxShadow(
//     color: const Color(0xFF000000).withValues(alpha: 0.06),
//     blurRadius: 12,
//     offset: const Offset(0, 3),
//   );
// }
//
// //  AppBar 
// // Figma: white bg, large bold title, back arrow, optional right icon widget,
// //        soft bottom shadow making it look like a floating card
// class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Widget? action;
//   final VoidCallback? onBack;
//
//   const TaskAppBar({
//     super.key,
//     required this.title,
//     this.action,
//     this.onBack,
//   });
//
//   @override
//   Size get preferredSize => const Size.fromHeight(58);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [TColors.appBarShadow],
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: SizedBox(
//           height: 58,
//           child: Row(children: [
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                   size: 18, color: AppColors.textPrimary),
//               onPressed: onBack ?? () => Navigator.pop(context),
//             ),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.textPrimary,
//                   letterSpacing: -0.3,
//                 ),
//               ),
//             ),
//             if (action != null) ...[action!, const SizedBox(width: 12)],
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// //  Field label 
// class TLabel extends StatelessWidget {
//   final String text;
//   const TLabel(this.text, {super.key});
//
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.only(bottom: 8),
//     child: Text(
//       text,
//       style: const TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//       ),
//     ),
//   );
// }
//
// //  Text input with shadow 
// // Figma: white bg, 12px rounded, soft shadow, no visible border
// class TInput extends StatelessWidget {
//   final TextEditingController? controller;
//   final String hint;
//   final int maxLines;
//   final TextInputType? keyboardType;
//   final List<TextInputFormatter>? formatters;
//   final String? Function(String?)? validator;
//   final bool readOnly;
//   final Widget? suffix;
//
//   const TInput({
//     super.key,
//     this.controller,
//     required this.hint,
//     this.maxLines = 1,
//     this.keyboardType,
//     this.formatters,
//     this.validator,
//     this.readOnly = false,
//     this.suffix,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [TColors.fieldShadow],
//       ),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         inputFormatters: formatters,
//         validator: validator,
//         readOnly: readOnly,
//         style: AppTextStyles.body,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(18),
//             borderSide: BorderSide.none,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(18),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(18),
//             borderSide: const BorderSide(color: AppColors.purple, width: 1.5),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(18),
//             borderSide: const BorderSide(color: AppColors.error, width: 1.5),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(18),
//             borderSide: const BorderSide(color: AppColors.error, width: 1.5),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding:
//           const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//           suffixIcon: suffix,
//         ),
//       ),
//     );
//   }
// }
//
// //  Dropdown with shadow 
// // Figma: white bg, 12px rounded, soft shadow, down-caret icon
// class TDropdown extends StatelessWidget {
//   final String hint;
//   final String? value;
//   final List<String> items;
//   final ValueChanged<String?> onChanged;
//   final bool hasError;
//
//   const TDropdown({
//     super.key,
//     required this.hint,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.hasError = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [TColors.fieldShadow],
//         border:
//         hasError ? Border.all(color: AppColors.error, width: 1.5) : null,
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Text(hint,
//               style: AppTextStyles.body.copyWith(color: AppColors.textMuted)),
//           isExpanded: true,
//           icon: const Icon(Icons.keyboard_arrow_down_rounded,
//               color: AppColors.textSecondary, size: 22),
//           items: items
//               .map((i) => DropdownMenuItem(
//               value: i, child: Text(i, style: AppTextStyles.body)))
//               .toList(),
//           onChanged: onChanged,
//           style: AppTextStyles.body,
//           dropdownColor: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//         ),
//       ),
//     );
//   }
// }
//
// //  Date picker field with shadow 
// class TDateField extends StatelessWidget {
//   final DateTime? value;
//   final String hint;
//   final VoidCallback onTap;
//
//   const TDateField({
//     super.key,
//     required this.value,
//     required this.hint,
//     required this.onTap,
//   });
//
//   String get _display {
//     if (value == null) return hint;
//     return '${value!.day.toString().padLeft(2, '0')}/'
//         '${value!.month.toString().padLeft(2, '0')}/${value!.year}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [TColors.fieldShadow],
//         ),
//         child: Row(children: [
//           Expanded(
//             child: Text(
//               _display,
//               style: AppTextStyles.body.copyWith(
//                 color:
//                 value == null ? AppColors.textMuted : AppColors.textPrimary,
//               ),
//             ),
//           ),
//           const Icon(Icons.calendar_today_outlined,
//               size: 18, color: AppColors.textSecondary),
//         ]),
//       ),
//     );
//   }
// }
//
// //  File upload box 
// // Figma: white card with shadow, cloud-upload icon, "Browse" in purple
// class TFileUploadBox extends StatelessWidget {
//   final List<PlatformFile> files;
//   final VoidCallback onTap;
//   final void Function(int index) onRemove;
//
//   const TFileUploadBox({
//     super.key,
//     required this.files,
//     required this.onTap,
//     required this.onRemove,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [TColors.fieldShadow],
//         ),
//         child: files.isEmpty
//             ? Column(children: [
//           Icon(Icons.cloud_upload_outlined,
//               size: 44, color: AppColors.textMuted),
//           const SizedBox(height: 8),
//           RichText(
//             text: TextSpan(
//               style: AppTextStyles.body,
//               children: [
//                 const TextSpan(text: 'Drag & drop files or '),
//                 TextSpan(
//                   text: 'Browse',
//                   style: const TextStyle(
//                     color: AppColors.purple,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Supported formates: EXCEL, PDF, JPG, JPEG, PNG',
//             style: AppTextStyles.caption.copyWith(fontSize: 11),
//             textAlign: TextAlign.center,
//           ),
//         ])
//             : Column(children: [
//           ...files.asMap().entries.map((e) => Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 16, vertical: 4),
//             child: Row(children: [
//               const Icon(Icons.attach_file_rounded,
//                   size: 16, color: AppColors.purple),
//               const SizedBox(width: 6),
//               Expanded(
//                 child: Text(
//                   e.value.name,
//                   style: AppTextStyles.caption
//                       .copyWith(color: AppColors.textPrimary),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => onRemove(e.key),
//                 child: const Icon(Icons.close_rounded,
//                     size: 16, color: AppColors.error),
//               ),
//             ]),
//           )),
//           const SizedBox(height: 8),
//           Text(
//             '+ Add more',
//             style: TextStyle(
//               color: AppColors.purple,
//               fontWeight: FontWeight.w600,
//               fontSize: 13,
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
//
// //  Submit button 
// // Figma: full-width, indigo, 54px tall, 16px rounded pill
// class TSubmitButton extends StatelessWidget {
//   final String label;
//   final bool loading;
//   final VoidCallback? onTap;
//
//   const TSubmitButton({
//     super.key,
//     this.label = 'Submit',
//     required this.loading,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: ElevatedButton(
//         onPressed: loading ? null : onTap,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.purple,
//           foregroundColor: Colors.white,
//           disabledBackgroundColor: AppColors.purple.withValues(alpha: 0.55),
//           elevation: 0,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//         child: loading
//             ? const SizedBox(
//             width: 22,
//             height: 22,
//             child: CircularProgressIndicator(
//                 strokeWidth: 2.5, color: Colors.white))
//             : Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             letterSpacing: 0.2,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //  Info chip (Task Name / Location blue-accent box) 
// class TInfoChip extends StatelessWidget {
//   final String label, value;
//   const TInfoChip({super.key, required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
//     decoration: BoxDecoration(
//       color: AppColors.purpleLight,
//       borderRadius: BorderRadius.circular(8),
//       border:
//       const Border(left: BorderSide(color: AppColors.purple, width: 3)),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: AppTextStyles.caption.copyWith(
//                 color: AppColors.textSecondary,
//                 fontWeight: FontWeight.w600)),
//         const SizedBox(height: 2),
//         Text(value,
//             style: AppTextStyles.bodyMedium
//                 .copyWith(fontWeight: FontWeight.w600),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis),
//       ],
//     ),
//   );
// }
//
// //  Date chip (calendar icon + "Label : value") 
// class TDateChip extends StatelessWidget {
//   final String label, date;
//   const TDateChip({super.key, required this.label, required this.date});
//
//   @override
//   Widget build(BuildContext context) => Row(children: [
//     const Icon(Icons.calendar_today_outlined,
//         size: 16, color: AppColors.textSecondary),
//     const SizedBox(width: 5),
//     RichText(
//       text: TextSpan(
//         style:
//         AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
//         children: [
//           TextSpan(text: '$label : '),
//           TextSpan(
//             text: date,
//             style: AppTextStyles.caption.copyWith(
//                 color: AppColors.textPrimary, fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     ),
//   ]);
// }
