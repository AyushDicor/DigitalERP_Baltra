//
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../mrn_controller/mrn_controller.dart';
// import '../mrn_response/mrn_models.dart';
// import '../mrn_widgets.dart';
//
// class MrnScanScreen extends StatelessWidget {
//   const MrnScanScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MrnController>(builder: (ctrl) {
//       return Column(children: [
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
//             child: Column(children: [
//               //  Animated scanner frame
//               _ScannerFrame(),
//               const SizedBox(height: 12),
//
//               //  Manual barcode entry
//               MrnCard(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const MrnSectionHead('Manual Barcode / QR Entry'),
//                     Row(children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: ctrl.barcodeCtrl,
//                           style: const TextStyle(
//                               fontSize: 13, fontFamily: 'monospace',
//                               color: newTextPrimary),
//                           decoration: InputDecoration(
//                             hintText: 'Type or scan barcode...',
//                             hintStyle: const TextStyle(
//                                 color: newTextHint, fontSize: 13),
//                             prefixIcon: const Icon(Icons.qr_code_rounded,
//                                 size: 18, color: newTextSecondary),
//                             filled: true,
//                             fillColor: newSurfaceColor,
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 11),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(color: newBorderColor)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(color: newBorderColor)),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                     color: newBlueColor, width: 1.5)),
//                           ),
//                           onFieldSubmitted: (_) => ctrl.addBarcodeItem(),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: ctrl.addBarcodeItem,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: newBlueColor,
//                           foregroundColor: Colors.white,
//                           elevation: 0,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 14),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: const Text('Add',
//                             style: TextStyle(
//                                 fontSize: 13, fontWeight: FontWeight.w700)),
//                       ),
//                     ]),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Try: 6901234567890 · 6901234599001 · 4901234512345',
//                       style: const TextStyle(fontSize: 10, color: newTextHint),
//                     ),
//                   ],
//                 ),
//               ),
//
//               //  Scanned items list
//               if (ctrl.scannedItems.isNotEmpty)
//                 MrnCard(
//                   child: Column(children: [
//                     MrnSectionHead(
//                       'Scanned Items',
//                       trailing: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                         decoration: BoxDecoration(
//                             color: newGreenLightColor,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Text(
//                           '${ctrl.scannedItems.length} added',
//                           style: const TextStyle(
//                               fontSize: 10, fontWeight: FontWeight.w700,
//                               color: newGreenColor),
//                         ),
//                       ),
//                     ),
//                     ...ctrl.scannedItems.map((item) => _scannedRow(ctrl, item)),
//                   ]),
//                 ),
//             ]),
//           ),
//         ),
//
//         //  Bottom CTA
//         _bottomBar(ctrl),
//       ]);
//     });
//   }
//
//   Widget _scannedRow(MrnController ctrl, MrnScannedItem item) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: item.isUnknown ? newOrangeLightColor : newSurfaceColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: item.isUnknown ? newOrangeColor : newBorderColor,
//           width: item.isUnknown ? 1.5 : 1,
//         ),
//       ),
//       child: Row(children: [
//         // Status dot
//         Container(
//           width: 24, height: 24,
//           decoration: BoxDecoration(
//             color: item.isUnknown ? newOrangeLightColor : newGreenLightColor,
//             borderRadius: BorderRadius.circular(7),
//             border: Border.all(
//                 color: item.isUnknown ? newOrangeColor : newGreenColor),
//           ),
//           alignment: Alignment.center,
//           child: Icon(
//             item.isUnknown ? Icons.help_outline_rounded : Icons.check_rounded,
//             size: 14,
//             color: item.isUnknown ? newOrangeColor : newGreenColor,
//           ),
//         ),
//         const SizedBox(width: 8),
//         // Info
//         Expanded(
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(item.itemName,
//                 style: TextStyle(
//                     fontSize: 12, fontWeight: FontWeight.w700,
//                     color: item.isUnknown ? newOrangeColor : newTextPrimary)),
//             Text('${item.barcode} · ${item.itemCode}',
//                 style: const TextStyle(
//                     fontSize: 10, color: newTextSecondary,
//                     fontFamily: 'monospace')),
//           ]),
//         ),
//         // Qty / Map
//         if (item.isUnknown)
//           TextButton(
//             onPressed: () {},
//             style: TextButton.styleFrom(
//               backgroundColor: newOrangeColor,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               minimumSize: Size.zero,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(7)),
//             ),
//             child: const Text('Map Item',
//                 style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
//           )
//         else
//           MrnQtyControl(
//             qty: item.qty,
//             onIncrease: () => ctrl.increaseScannedQty(item),
//             onDecrease: () => ctrl.decreaseScannedQty(item),
//           ),
//         if (!item.isUnknown) ...[
//           const SizedBox(width: 6),
//           SizedBox(
//             width: 48,
//             child: Text('₹${item.rate.toStringAsFixed(0)}',
//                 textAlign: TextAlign.right,
//                 style: const TextStyle(
//                     fontSize: 11, fontWeight: FontWeight.w700,
//                     color: newBlueColor)),
//           ),
//         ],
//       ]),
//     );
//   }
//
//   Widget _bottomBar(MrnController ctrl) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: newBorderColor))),
//       child: SafeArea(
//         top: false,
//         child: MrnPrimaryBtn(
//           label: 'Done Scanning → Review MRN',
//           icon: Icons.arrow_forward_rounded,
//           onTap: () => ctrl.goToStep(3),
//         ),
//       ),
//     );
//   }
// }
//
// //  Animated scanner frame
// class _ScannerFrame extends StatefulWidget {
//   @override
//   State<_ScannerFrame> createState() => _ScannerFrameState();
// }
//
// class _ScannerFrameState extends State<_ScannerFrame>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _anim;
//   late Animation<double> _pos;
//
//   @override
//   void initState() {
//     super.initState();
//     _anim = AnimationController(
//         vsync: this, duration: const Duration(seconds: 2))
//       ..repeat(reverse: true);
//     _pos = Tween<double>(begin: 0.1, end: 0.85).animate(
//         CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
//   }
//
//   @override
//   void dispose() {
//     _anim.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: const Color(0xFF0F172A),
//           borderRadius: BorderRadius.circular(16)),
//       padding: const EdgeInsets.all(20),
//       child: Column(children: [
//         SizedBox(
//           width: 200, height: 140,
//           child: Stack(children: [
//             // Corners
//             ..._corners(),
//             // Scan line
//             AnimatedBuilder(
//               animation: _anim,
//               builder: (_, __) => Positioned(
//                 top: _pos.value * 140,
//                 left: 12, right: 12,
//                 child: Container(
//                   height: 2.5,
//                   decoration: BoxDecoration(
//                     color: newBlueColor,
//                     borderRadius: BorderRadius.circular(2),
//                     boxShadow: [
//                       BoxShadow(
//                           color: newBlueColor.withValues(alpha: 0.6),
//                           blurRadius: 8)
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         ),
//         const SizedBox(height: 12),
//         const Text('Point camera at barcode or QR code',
//             style: TextStyle(
//                 fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500)),
//       ]),
//     );
//   }
//
//   List<Widget> _corners() {
//     const c = Color(0xFF4361EE);
//     const sz = 22.0;
//     const th = 3.0;
//     return [
//       Positioned(top: 0, left: 0,
//           child: _Corner(sz, th, c, true, true)),
//       Positioned(top: 0, right: 0,
//           child: _Corner(sz, th, c, true, false)),
//       Positioned(bottom: 0, left: 0,
//           child: _Corner(sz, th, c, false, true)),
//       Positioned(bottom: 0, right: 0,
//           child: _Corner(sz, th, c, false, false)),
//     ];
//   }
// }
//
// class _Corner extends StatelessWidget {
//   final double sz, th;
//   final Color color;
//   final bool top, left;
//
//   const _Corner(this.sz, this.th, this.color, this.top, this.left);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: sz, height: sz,
//       decoration: BoxDecoration(
//         border: Border(
//           top: top ? BorderSide(color: color, width: th) : BorderSide.none,
//           bottom: !top ? BorderSide(color: color, width: th) : BorderSide.none,
//           left: left ? BorderSide(color: color, width: th) : BorderSide.none,
//           right: !left ? BorderSide(color: color, width: th) : BorderSide.none,
//         ),
//         borderRadius: BorderRadius.only(
//           topLeft: (top && left) ? const Radius.circular(4) : Radius.zero,
//           topRight: (top && !left) ? const Radius.circular(4) : Radius.zero,
//           bottomLeft: (!top && left) ? const Radius.circular(4) : Radius.zero,
//           bottomRight: (!top && !left) ? const Radius.circular(4) : Radius.zero,
//         ),
//       ),
//     );
//   }
// }
