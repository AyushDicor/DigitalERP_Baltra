// // lib/screens/mrn/add_mrn_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../model/mrn_models.dart';
// import '../widgets/app_theme.dart';
//
//
//
// //  Local design tokens 
// class _C {
//   static const bg           = Color(0xFFF5F5F7);
//   static const fieldShadow  = Color(0x12000000);
//   static const appBarShadow = Color(0x0F000000);
// }
//
// // 
// class AddMRNScreen extends StatefulWidget {
//   const AddMRNScreen({super.key});
//   @override
//   State<AddMRNScreen> createState() => _AddMRNScreenState();
// }
//
// class _AddMRNScreenState extends State<AddMRNScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Header fields
//   DateTime  _mrnDate   = DateTime.now();
//   int?      _mrnTypeId;
//   int?      _partyId;
//   int?      _siteId;
//   int?      _paidById;
//   int?      _jobTypeId;
//   int?      _godownId;
//   DateTime? _billDate;
//   bool      _submitting = false;
//   bool      _submitted  = false;
//
//   final _billNoCtrl     = TextEditingController();
//   final _customerPOCtrl = TextEditingController();
//   final _deliveryCtrl   = TextEditingController(text: '0');
//   final _remarksCtrl    = TextEditingController();
//
//   // Uploaded files (mock)
//   final List<_UploadedFile> _uploadedFiles = [];
//
//   // Line items
//   final List<_LineItemRow> _items = [];
//
//   // Dropdown data from shared dummy data
//   final _parties  = MRNDummyData.parties;
//   final _sites    = MRNDummyData.sites;
//   final _jobTypes = MRNDummyData.jobTypes;
//   final _godowns  = MRNDummyData.godowns;
//
//   @override
//   void initState() {
//     super.initState();
//     _addItem();
//   }
//
//   @override
//   void dispose() {
//     _billNoCtrl.dispose();
//     _customerPOCtrl.dispose();
//     _deliveryCtrl.dispose();
//     _remarksCtrl.dispose();
//     for (final item in _items) {
//       item.dispose();
//     }
//     super.dispose();
//   }
//
//   void _addItem() => setState(() => _items.add(_LineItemRow()));
//
//   void _removeItem(int index) {
//     if (_items.length <= 1) return;
//     setState(() {
//       _items[index].dispose();
//       _items.removeAt(index);
//     });
//   }
//
//   Future<void> _pickDate(bool isMrnDate) async {
//     final initial =
//     isMrnDate ? _mrnDate : (_billDate ?? DateTime.now());
//     final d = await showDatePicker(
//       context:     context,
//       initialDate: initial,
//       firstDate:   DateTime(2020),
//       lastDate:    DateTime.now().add(const Duration(days: 365)),
//       builder: (ctx, child) => Theme(
//         data: Theme.of(ctx).copyWith(
//             colorScheme:
//             const ColorScheme.light(primary: AppColors.purple)),
//         child: child!,
//       ),
//     );
//     if (d != null) {
//       setState(() => isMrnDate ? _mrnDate = d : _billDate = d);
//     }
//   }
//
//   void _mockUploadFile() {
//     setState(() => _uploadedFiles.add(
//       _UploadedFile(name: 'Global user.pdf', size: '2.4 MB'),
//     ));
//   }
//
//   void _snack(String msg, {required bool isError}) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(msg),
//       backgroundColor:
//       isError ? AppColors.error : AppColors.success,
//       behavior: SnackBarBehavior.floating,
//     ));
//   }
//
//   Future<void> _submit() async {
//     setState(() => _submitted = true);
//     if (!_formKey.currentState!.validate()) return;
//     if (_partyId == null) return;
//
//     for (final item in _items) {
//       if (item.erpItemId == null || item.erpItemId! <= 0) {
//         _snack('Please select a valid item for all rows', isError: true);
//         return;
//       }
//       if ((double.tryParse(item.qtyCtrl.text) ?? 0) <= 0) {
//         _snack('Quantity must be greater than 0', isError: true);
//         return;
//       }
//     }
//
//     setState(() => _submitting = true);
//
//     // Simulate network delay
//     await Future.delayed(const Duration(seconds: 1));
//
//     if (!mounted) return;
//     setState(() => _submitting = false);
//
//     _snack('MRN created successfully', isError: false);
//     Navigator.pop(context);
//   }
//
//   String _fmtDate(DateTime d) =>
//       '${d.day.toString().padLeft(2, '0')}/'
//           '${d.month.toString().padLeft(2, '0')}/${d.year}';
//
//   @override
//   Widget build(BuildContext context) {
//     final subTotal = _items.fold<double>(0, (sum, item) {
//       final qty  = double.tryParse(item.qtyCtrl.text)  ?? 0;
//       final rate = double.tryParse(item.rateCtrl.text) ?? 0;
//       return sum + (qty * rate);
//     });
//     final delivery = double.tryParse(_deliveryCtrl.text) ?? 0;
//
//     return Scaffold(
//       backgroundColor: _C.bg,
//
//       //  AppBar 
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(100),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.background,
//             borderRadius: BorderRadius.only(
//               bottomLeft:  Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//             boxShadow: [
//               BoxShadow(
//                   color: Color(0x14000000),
//                   blurRadius: 12,
//                   offset: Offset(0, 4)),
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
//                     child: Text('Add MRN',
//                         style: AppTextStyles.h2.copyWith(
//                             fontSize: 22, fontWeight: FontWeight.w800)),
//                   ),
//                   // Cart icon with item count badge
//                   Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.shopping_cart_outlined,
//                             size: 20, color: AppColors.purple),
//                         onPressed: () {},
//                         // Cart navigation would go here once route is set up
//                         padding: EdgeInsets.zero,
//                       ),
//                       Positioned(
//                         top: 6,
//                         right: 6,
//                         child: Container(
//                           width: 16,
//                           height: 16,
//                           decoration: const BoxDecoration(
//                             color: AppColors.purple,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             '${_items.length}',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
//           children: [
//             //  MRN Details 
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 1. MRN Type
//                 _TDropdown<int>(
//                   hint: 'Select MRN type',
//                   value: _mrnTypeId,
//                   items: const [
//                     DropdownMenuItem<int>(
//                         value: null, child: Text('None')),
//                     DropdownMenuItem(value: 1, child: Text('Direct')),
//                     DropdownMenuItem(value: 2, child: Text('Indent')),
//                     DropdownMenuItem(
//                         value: 3, child: Text('Purchase Order')),
//                   ],
//                   onChanged: (v) => setState(() => _mrnTypeId = v),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 2. Party Type
//                 _TLabel('Party Type'),
//                 const SizedBox(height: 6),
//                 _TDropdown<int>(
//                   hint: 'Enter party type',
//                   value: _partyId,
//                   items: [
//                     const DropdownMenuItem<int>(
//                         value: null, child: Text('None')),
//                     ..._parties.map((p) => DropdownMenuItem<int>(
//                       value: p['PartyID'] as int,
//                       child: Text(p['PartyName']?.toString() ?? ''),
//                     )),
//                   ],
//                   onChanged: (v) => setState(() => _partyId = v),
//                   hasError: _submitted && _partyId == null,
//                 ),
//                 if (_submitted && _partyId == null)
//                   _TErrorText('Party is required'),
//                 const SizedBox(height: 16),
//
//                 // 3. Site Name
//                 _TLabel('Site Name'),
//                 const SizedBox(height: 6),
//                 _TDropdown<int>(
//                   hint: 'Enter site name',
//                   value: _siteId,
//                   items: [
//                     const DropdownMenuItem<int>(
//                         value: null, child: Text('None')),
//                     ..._sites.map((s) => DropdownMenuItem<int>(
//                       value: s['SiteID'] as int,
//                       child: Text(s['SiteName']?.toString() ?? '',
//                           style: AppTextStyles.body),
//                     )),
//                   ],
//                   onChanged: (v) => setState(() => _siteId = v),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 4. Customer PO
//                 _TLabel('Customer PO'),
//                 const SizedBox(height: 6),
//                 _TInput(
//                   controller: _customerPOCtrl,
//                   hint: 'Enter customer PO',
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 5. Job Type
//                 _TLabel('Job Type'),
//                 const SizedBox(height: 6),
//                 _TDropdown<int>(
//                   hint: 'Enter job type',
//                   value: _jobTypeId,
//                   items: [
//                     const DropdownMenuItem<int>(
//                         value: null, child: Text('None')),
//                     ..._jobTypes.map((j) => DropdownMenuItem<int>(
//                       value: j['JobTypeID'] as int,
//                       child: Text(j['JobTypeName']?.toString() ?? ''),
//                     )),
//                   ],
//                   onChanged: (v) => setState(() => _jobTypeId = v),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 6. Godown
//                 _TLabel('Godown'),
//                 const SizedBox(height: 6),
//                 _TDropdown<int>(
//                   hint: 'Enter Godown',
//                   value: _godownId,
//                   items: [
//                     const DropdownMenuItem<int>(
//                         value: null, child: Text('None')),
//                     ..._godowns.map((g) => DropdownMenuItem<int>(
//                       value: g['GodownID'] as int,
//                       child: Text(g['GodownName']?.toString() ?? ''),
//                     )),
//                   ],
//                   onChanged: (v) => setState(() => _godownId = v),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 7. Bill No.
//                 _TLabel('Bill No.'),
//                 const SizedBox(height: 6),
//                 _TInput(controller: _billNoCtrl, hint: '101'),
//                 const SizedBox(height: 16),
//
//                 // 8. Paid By
//                 _TLabel('Paid By'),
//                 const SizedBox(height: 6),
//                 _TDropdown<int>(
//                   hint: 'Enter name',
//                   value: _paidById,
//                   items: [
//                     const DropdownMenuItem<int>(
//                         value: null, child: Text('None')),
//                     ..._parties.map((p) => DropdownMenuItem<int>(
//                       value: p['PartyID'] as int,
//                       child: Text(p['PartyName']?.toString() ?? ''),
//                     )),
//                   ],
//                   onChanged: (v) => setState(() => _paidById = v),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 9. Delivery Charges
//                 _TLabel('Delivery Charges'),
//                 const SizedBox(height: 6),
//                 _TInput(
//                   controller: _deliveryCtrl,
//                   hint: '1500',
//                   keyboardType: const TextInputType.numberWithOptions(
//                       decimal: true),
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(
//                         RegExp(r'^\d+\.?\d{0,2}'))
//                   ],
//                   onChanged: (_) => setState(() {}),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // 10. File Upload
//                 _TLabel('File Upload Multiple'),
//                 const SizedBox(height: 6),
//                 _FileUploadBox(onBrowse: _mockUploadFile),
//               ],
//             ),
//
//             //  Proceed button 
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               height: 54,
//               child: ElevatedButton(
//                 onPressed: _submitting ? null : _submit,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.purple,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                 ),
//                 child: _submitting
//                     ? const SizedBox(
//                     width: 22,
//                     height: 22,
//                     child: CircularProgressIndicator(
//                         color: Colors.white, strokeWidth: 2))
//                     : Text('Proceed',
//                     style:
//                     AppTextStyles.button(color: Colors.white)),
//               ),
//             ),
//
//             //  Uploaded documents 
//             if (_uploadedFiles.isNotEmpty) ...[
//               const SizedBox(height: 24),
//               Text('Uploaded document',
//                   style: AppTextStyles.h2
//                       .copyWith(fontWeight: FontWeight.w800)),
//               const SizedBox(height: 12),
//               ..._uploadedFiles.asMap().entries.map((e) =>
//                   _UploadedFileTile(
//                     file: e.value,
//                     onRemove: () =>
//                         setState(() => _uploadedFiles.removeAt(e.key)),
//                   )),
//             ],
//
//             const SizedBox(height: 24),
//
//             //  Item Details 
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Item Details', style: AppTextStyles.h3),
//                 GestureDetector(
//                   onTap: _addItem,
//                   child: Row(
//                     children: [
//                       Icon(Icons.add_rounded,
//                           size: 16, color: AppColors.purple),
//                       const SizedBox(width: 2),
//                       Text('Add Item',
//                           style: AppTextStyles.body.copyWith(
//                               color: AppColors.purple,
//                               fontWeight: FontWeight.w600)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             ...List.generate(
//               _items.length,
//                   (i) => _LineItemCard(
//                 row: _items[i],
//                 index: i,
//                 godowns: _godowns,
//                 canRemove: _items.length > 1,
//                 onRemove: () => _removeItem(i),
//                 onChanged: () => setState(() {}),
//               ),
//             ),
//
//             //  Totals 
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: AppColors.purpleLight,
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(
//                     color: AppColors.purple.withValues(alpha: 0.2)),
//               ),
//               child: Column(children: [
//                 _TotalRow(label: 'Sub Total',        value: subTotal),
//                 const SizedBox(height: 4),
//                 _TotalRow(label: 'Delivery Charges', value: delivery),
//                 const Divider(height: 16),
//                 _TotalRow(
//                   label: 'Total',
//                   value: subTotal + delivery,
//                   isTotal: true,
//                 ),
//               ]),
//             ),
//
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //  Line Item Row (data holder) 
// class _LineItemRow {
//   int?   erpItemId;
//   String nameDisplay = '';
//   final qtyCtrl     = TextEditingController();
//   final rateCtrl    = TextEditingController();
//   final gstCtrl     = TextEditingController(text: '0');
//   final unitCtrl    = TextEditingController();
//   final makeCtrl    = TextEditingController();
//   final remarksCtrl = TextEditingController();
//   int?  godownId;
//
//   void dispose() {
//     qtyCtrl.dispose();
//     rateCtrl.dispose();
//     gstCtrl.dispose();
//     unitCtrl.dispose();
//     makeCtrl.dispose();
//     remarksCtrl.dispose();
//   }
// }
//
// //  Uploaded File model 
// class _UploadedFile {
//   final String name;
//   final String size;
//   _UploadedFile({required this.name, required this.size});
// }
//
// //  Line Item Card 
// class _LineItemCard extends StatelessWidget {
//   final _LineItemRow               row;
//   final int                        index;
//   final List<Map<String, dynamic>> godowns;
//   final bool                       canRemove;
//   final VoidCallback               onRemove;
//   final VoidCallback               onChanged;
//
//   const _LineItemCard({
//     required this.row,
//     required this.index,
//     required this.godowns,
//     required this.canRemove,
//     required this.onRemove,
//     required this.onChanged,
//   });
//
//   double get _lineTotal {
//     final qty  = double.tryParse(row.qtyCtrl.text)  ?? 0;
//     final rate = double.tryParse(row.rateCtrl.text) ?? 0;
//     return qty * rate;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//             color: AppColors.purple.withValues(alpha: 0.18), width: 1.2),
//         boxShadow: const [
//           BoxShadow(
//               color: Color(0x12000000),
//               blurRadius: 8,
//               offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header row
//           Row(children: [
//             Container(
//               width: 26,
//               height: 26,
//               decoration: BoxDecoration(
//                 color: AppColors.purple,
//                 borderRadius: BorderRadius.circular(7),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 '${index + 1}',
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             const Spacer(),
//             if (canRemove)
//               GestureDetector(
//                 onTap: onRemove,
//                 child: const Icon(Icons.remove_circle_outline_rounded,
//                     size: 20, color: AppColors.error),
//               ),
//           ]),
//           const SizedBox(height: 10),
//
//           // Item Name search field
//           _TLabel('Item Name *'),
//           GestureDetector(
//             onTap: () async {
//               final ctrl =
//               TextEditingController(text: row.erpItemId?.toString() ?? '');
//               final nameCtrl =
//               TextEditingController(text: row.nameDisplay);
//               await showDialog(
//                 context: context,
//                 builder: (ctx) => AlertDialog(
//                   title: const Text('Search Item'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: ctrl,
//                         keyboardType: TextInputType.number,
//                         decoration:
//                         const InputDecoration(labelText: 'Item ID'),
//                       ),
//                       const SizedBox(height: 8),
//                       TextField(
//                         controller: nameCtrl,
//                         decoration:
//                         const InputDecoration(labelText: 'Item Name'),
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                         onPressed: () => Navigator.pop(ctx),
//                         child: const Text('Cancel')),
//                     ElevatedButton(
//                       onPressed: () {
//                         row.erpItemId =
//                             int.tryParse(ctrl.text.trim());
//                         row.nameDisplay = nameCtrl.text.trim();
//                         Navigator.pop(ctx);
//                         onChanged();
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.purple),
//                       child: const Text('Set'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 14, vertical: 14),
//               decoration: BoxDecoration(
//                 color: row.erpItemId != null
//                     ? AppColors.purpleLight
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Color(0x12000000),
//                       blurRadius: 8,
//                       offset: Offset(0, 2)),
//                 ],
//                 border: row.erpItemId != null
//                     ? Border.all(
//                     color: AppColors.purple.withValues(alpha: 0.3))
//                     : null,
//               ),
//               child: Row(children: [
//                 Icon(
//                   row.erpItemId != null
//                       ? Icons.check_circle_outline_rounded
//                       : Icons.search_rounded,
//                   size: 18,
//                   color: row.erpItemId != null
//                       ? AppColors.purple
//                       : AppColors.textTertiary,
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     row.erpItemId != null
//                         ? row.nameDisplay
//                         : 'Search item name',
//                     style: AppTextStyles.body.copyWith(
//                       color: row.erpItemId != null
//                           ? AppColors.textPrimary
//                           : AppColors.textTertiary,
//                     ),
//                   ),
//                 ),
//                 const Icon(Icons.arrow_forward_ios_rounded,
//                     size: 14, color: AppColors.textTertiary),
//               ]),
//             ),
//           ),
//           const SizedBox(height: 12),
//
//           // QTY | Rate
//           Row(children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _TLabel('QTY *'),
//                   _TInput(
//                     controller: row.qtyCtrl,
//                     hint: '0',
//                     keyboardType: const TextInputType.numberWithOptions(
//                         decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                           RegExp(r'^\d+\.?\d{0,3}'))
//                     ],
//                     onChanged: (_) => onChanged(),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _TLabel('Rate ₹'),
//                   _TInput(
//                     controller: row.rateCtrl,
//                     hint: '0.00',
//                     keyboardType: const TextInputType.numberWithOptions(
//                         decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                           RegExp(r'^\d+\.?\d{0,2}'))
//                     ],
//                     onChanged: (_) => onChanged(),
//                   ),
//                 ],
//               ),
//             ),
//           ]),
//           const SizedBox(height: 12),
//
//           // GST% | Unit
//           Row(children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _TLabel('GST %'),
//                   _TInput(
//                     controller: row.gstCtrl,
//                     hint: '0',
//                     keyboardType: const TextInputType.numberWithOptions(
//                         decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                           RegExp(r'^\d+\.?\d{0,2}'))
//                     ],
//                     onChanged: (_) => onChanged(),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _TLabel('Unit'),
//                   _TInput(
//                     controller: row.unitCtrl,
//                     hint: 'e.g. Pcs, Kg',
//                   ),
//                 ],
//               ),
//             ),
//           ]),
//           const SizedBox(height: 12),
//
//           // Make
//           _TLabel('Make'),
//           _TInput(
//               controller: row.makeCtrl,
//               hint: 'e.g. Samsung, Bosch'),
//           const SizedBox(height: 12),
//
//           // Remark
//           _TLabel('Remark'),
//           _TInput(
//               controller: row.remarksCtrl,
//               hint: 'Item remarks (optional)'),
//
//           // Godown per item
//           if (godowns.isNotEmpty) ...[
//             const SizedBox(height: 12),
//             _TLabel('Godown'),
//             _TDropdown<int>(
//               hint: 'Select godown',
//               value: row.godownId,
//               items: [
//                 const DropdownMenuItem<int>(
//                     value: null, child: Text('None')),
//                 ...godowns.map((g) => DropdownMenuItem<int>(
//                   value: g['GodownID'] as int,
//                   child: Text(g['GodownName']?.toString() ?? ''),
//                 )),
//               ],
//               onChanged: (v) {
//                 row.godownId = v;
//                 onChanged();
//               },
//             ),
//           ],
//
//           // Line subtotal
//           if (_lineTotal > 0) ...[
//             const SizedBox(height: 10),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text(
//                 'Subtotal : ₹${_lineTotal.toStringAsFixed(2)}',
//                 style: AppTextStyles.body.copyWith(
//                     color: AppColors.purple,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
//
// //  TLabel 
// class _TLabel extends StatelessWidget {
//   final String text;
//   const _TLabel(this.text);
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.only(bottom: 8),
//     child: Text(text,
//         style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimary)),
//   );
// }
//
// //  TErrorText 
// class _TErrorText extends StatelessWidget {
//   final String text;
//   const _TErrorText(this.text);
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.only(top: 4, left: 4),
//     child: Text(text,
//         style: AppTextStyles.bodySmall(color: AppColors.error)),
//   );
// }
//
// //  TInput 
// class _TInput extends StatelessWidget {
//   final TextEditingController       controller;
//   final String                      hint;
//   final TextInputType?              keyboardType;
//   final List<TextInputFormatter>?   inputFormatters;
//   final ValueChanged<String>?       onChanged;
//   final int                         maxLines;
//
//   const _TInput({
//     required this.controller,
//     required this.hint,
//     this.keyboardType,
//     this.inputFormatters,
//     this.onChanged,
//     this.maxLines = 1,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.04),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller:       controller,
//         keyboardType:     keyboardType,
//         inputFormatters:  inputFormatters,
//         onChanged:        onChanged,
//         maxLines:         maxLines,
//         style:            AppTextStyles.body,
//         decoration: InputDecoration(
//           hintText:  hint,
//           hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: BorderSide.none),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: BorderSide.none),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide:
//               const BorderSide(color: AppColors.purple, width: 1.5)),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide:
//               const BorderSide(color: AppColors.error, width: 1.5)),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide:
//               const BorderSide(color: AppColors.error, width: 1.5)),
//           filled:          true,
//           fillColor:       Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//               horizontal: 14, vertical: 14),
//         ),
//       ),
//     );
//   }
// }
//
// //  TDropdown 
// class _TDropdown<T> extends StatelessWidget {
//   final String                    hint;
//   final T?                        value;
//   final List<DropdownMenuItem<T>> items;
//   final ValueChanged<T?>?         onChanged;
//   final bool                      hasError;
//
//   const _TDropdown({
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
//       height: 52,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//               color: Color(0x12000000),
//               blurRadius: 8,
//               offset: Offset(0, 2)),
//         ],
//         border: hasError
//             ? Border.all(color: AppColors.error, width: 1.5)
//             : null,
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<T>(
//           value:      value,
//           isExpanded: true,
//           isDense:    true,
//           hint: Text(hint,
//               style: AppTextStyles.body
//                   .copyWith(color: AppColors.textTertiary)),
//           icon: const Icon(Icons.keyboard_arrow_down_rounded,
//               size: 22, color: AppColors.textSecondary),
//           items:      items.isEmpty ? [] : items,
//           onChanged:  items.isEmpty ? null : onChanged,
//           style: AppTextStyles.body
//               .copyWith(color: AppColors.textPrimary),
//           dropdownColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }
//
// //  File Upload Box 
// class _FileUploadBox extends StatelessWidget {
//   final VoidCallback onBrowse;
//   const _FileUploadBox({required this.onBrowse});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding:
//       const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: AppColors.purple.withValues(alpha: 0.2),
//           width: 1.5,
//         ),
//         boxShadow: const [
//           BoxShadow(
//               color: Color(0x12000000),
//               blurRadius: 8,
//               offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(Icons.cloud_upload_outlined,
//               size: 40, color: AppColors.textTertiary),
//           const SizedBox(height: 8),
//           RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(children: [
//               TextSpan(
//                 text: 'Drag & drop files or ',
//                 style: AppTextStyles.body
//                     .copyWith(color: AppColors.textSecondary),
//               ),
//               WidgetSpan(
//                 child: GestureDetector(
//                   onTap: onBrowse,
//                   child: Text('Browse',
//                       style: AppTextStyles.body.copyWith(
//                           color: AppColors.purple,
//                           fontWeight: FontWeight.w600)),
//                 ),
//               ),
//             ]),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Supported formats: EXCEL, PDF, JPG, JPEG, PNG',
//             style: AppTextStyles.bodySmall()
//                 .copyWith(color: AppColors.textTertiary),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //  Uploaded File Tile 
// class _UploadedFileTile extends StatelessWidget {
//   final _UploadedFile file;
//   final VoidCallback  onRemove;
//   const _UploadedFileTile(
//       {required this.file, required this.onRemove});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding:
//       const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//               color: Color(0x12000000),
//               blurRadius: 8,
//               offset: Offset(0, 2)),
//         ],
//       ),
//       child: Row(children: [
//         Container(
//           width: 38,
//           height: 38,
//           decoration: BoxDecoration(
//             color: AppColors.errorLight,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Icon(Icons.picture_as_pdf_rounded,
//               color: AppColors.error, size: 20),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(file.name,
//                   style: AppTextStyles.body
//                       .copyWith(fontWeight: FontWeight.w600),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis),
//               Text(file.size,
//                   style: AppTextStyles.bodySmall()
//                       .copyWith(color: AppColors.textSecondary)),
//             ],
//           ),
//         ),
//         GestureDetector(
//           onTap: onRemove,
//           child: Container(
//             width: 28,
//             height: 28,
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.border),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.close_rounded,
//                 size: 16, color: AppColors.textSecondary),
//           ),
//         ),
//       ]),
//     );
//   }
// }
//
// //  Total row 
// class _TotalRow extends StatelessWidget {
//   final String label;
//   final double value;
//   final bool   isTotal;
//   const _TotalRow(
//       {required this.label, required this.value, this.isTotal = false});
//
//   @override
//   Widget build(BuildContext context) => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(label,
//           style: isTotal
//               ? AppTextStyles.body
//               .copyWith(fontWeight: FontWeight.w600)
//               : AppTextStyles.body
//               .copyWith(color: AppColors.textSecondary)),
//       Text(
//         '₹${value.toStringAsFixed(2)}',
//         style: isTotal
//             ? AppTextStyles.h3.copyWith(
//             color: AppColors.purple,
//             fontWeight: FontWeight.bold)
//             : AppTextStyles.body
//             .copyWith(fontWeight: FontWeight.w500),
//       ),
//     ],
//   );
// }