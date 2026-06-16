// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../response/customer_detail_response.dart';
// import '../../response/get_branchand_sit_res_model.dart';
// import '../payment_request_model/payment_request_model.dart';
// import 'payment_request_list_controller.dart';
//
// class PaymentRequestListBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<PaymentRequestListController>(
//           () => PaymentRequestListController(),
//     );
//   }
// }
//
// class PaymentRequestListScreen extends StatelessWidget {
//   const PaymentRequestListScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PaymentRequestListController>(
//       init: PaymentRequestListController(),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF5F6FA),
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 3,
//             shadowColor: const Color(0x12000000),
//             surfaceTintColor: Colors.white,
//             centerTitle: false,
//             leading: GestureDetector(
//               onTap: () => Get.back(),
//               child: const Icon(Icons.arrow_back_ios_new_rounded,
//                   color: newTextPrimary, size: 20),
//             ),
//             title: const Text('Payment Requests',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: newTextPrimary)),
//             actions: [
//               GestureDetector(
//                 onTap: () => _showFilterBottomSheet(context, controller),
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 16),
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: purpleLightest,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Icon(Icons.filter_list_rounded,
//                       color: purpleColor, size: 20),
//                 ),
//               ),
//             ],
//           ),
//           body: RefreshIndicator(
//             onRefresh: () => controller.getPaymentRequestList(isRefresh: true),
//             child: Column(
//               children: [
//                 // Search bar
//                 _buildSearchBar(controller),
//
//                 // Active filters chips
//                 if (_hasActiveFilters(controller)) _buildActiveFilters(controller),
//
//                 // List
//                 Expanded(
//                   child: controller.isBusy && controller.paymentRequestList.isEmpty
//                       ? const Center(child: CircularProgressIndicator())
//                       : controller.filteredPaymentRequestList.isEmpty
//                       ? _buildEmptyState()
//                       : _buildPaymentRequestList(controller),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () => controller.tapOnAdd(),
//             backgroundColor: purpleColor,
//             shape: const CircleBorder(
//                 side: BorderSide(color: Colors.white, width: 2)),
//             elevation: 4,
//             child: const Icon(Icons.add, color: Colors.white, size: 32),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildSearchBar(PaymentRequestListController controller) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       color: Colors.white,
//       child: TextField(
//         controller: controller.searchController,
//         focusNode: controller.searchFocus,
//         onChanged: controller.onSearchChanged,
//         decoration: InputDecoration(
//           hintText: 'Search by party, reason, request no...',
//           prefixIcon: Icon(Icons.search),
//           suffixIcon: controller.searchController.text.isNotEmpty
//               ? IconButton(
//             onPressed: () {
//               controller.searchController.clear();
//               controller.onSearchChanged('');
//             },
//             icon: Icon(Icons.clear),
//           )
//               : null,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           filled: true,
//           fillColor: Colors.grey[100],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActiveFilters(PaymentRequestListController controller) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       color: Colors.grey[100],
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             if (controller.selectedParty != null)
//               _buildFilterChip(
//                 label: controller.selectedParty!.partyname ?? '',
//                 onDelete: () => controller.setSelectedParty(null),
//               ),
//             if (controller.selectedBranch != null)
//               _buildFilterChip(
//                 label: controller.selectedBranch!.branchname ?? '',
//                 onDelete: () => controller.setSelectedBranch(null),
//               ),
//             if (controller.selectedStatus != null &&
//                 controller.selectedStatus != 'All')
//               _buildFilterChip(
//                 label: controller.selectedStatus!,
//                 onDelete: () => controller.setSelectedStatus(null),
//               ),
//             if (controller.fromDate != null || controller.toDate != null)
//               _buildFilterChip(
//                 label: _getDateRangeLabel(controller),
//                 onDelete: () {
//                   controller.setFromDate(null);
//                   controller.setToDate(null);
//                 },
//               ),
//             TextButton.icon(
//               onPressed: controller.clearFilters,
//               icon: Icon(Icons.clear_all, size: 16),
//               label: Text('Clear All'),
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterChip({
//     required String label,
//     required VoidCallback onDelete,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       child: Chip(
//         label: Text(label),
//         onDeleted: onDelete,
//         deleteIcon: Icon(Icons.close, size: 16),
//         backgroundColor: Colors.blue[50],
//         labelStyle: TextStyle(color: Colors.blue[900]),
//       ),
//     );
//   }
//
//   Widget _buildPaymentRequestList(PaymentRequestListController controller) {
//     return NotificationListener<ScrollNotification>(
//       onNotification: (ScrollNotification scrollInfo) {
//         if (!controller.isBusy &&
//             controller.hasMoreData &&
//             scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//           controller.loadMore();
//         }
//         return false;
//       },
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: controller.filteredPaymentRequestList.length +
//             (controller.hasMoreData ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == controller.filteredPaymentRequestList.length) {
//             return const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//
//           final request = controller.filteredPaymentRequestList[index];
//           return _buildPaymentRequestCard(request, controller);
//         },
//       ),
//     );
//   }
//
//   Widget _buildPaymentRequestCard(
//       PaymentRequestModel request,
//       PaymentRequestListController controller,
//       ) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 14),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       color: Colors.white,
//       child: InkWell(
//         onTap: () => controller.viewPaymentRequestDetails(request),
//         borderRadius: BorderRadius.circular(14),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //  Row 1: Claim No + action icons 
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Payment Request No.: ${request.requestNo ?? 'N/A'}',
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF1A1A2E),
//                     ),
//                   ),
//                   // Status badge (replaces icon row from reference)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: request.getStatusColor().withValues(alpha: 0.12),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(request.getStatusIcon(),
//                             color: request.getStatusColor(), size: 13),
//                         const SizedBox(width: 4),
//                         Text(
//                           request.status ?? 'N/A',
//                           style: TextStyle(
//                             color: request.getStatusColor(),
//                             fontWeight: FontWeight.w700,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 14),
//
//               //  Row 2: Site name box + Request type box 
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildInfoBox(
//                       label: 'Site Name',
//                       value: request.branchName ?? 'N/A',
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: _buildInfoBox(
//                       label: 'Request Type',
//                       value: request.requestType ?? 'N/A',
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 14),
//
//               //  Row 3: Date | Amount | Party type 
//               Row(
//                 children: [
//                   _buildMetaItem(
//                     label: 'Date',
//                     value: request.requestDate != null
//                         ? DateFormat('dd/MM/yyyy').format(request.requestDate!)
//                         : 'N/A',
//                   ),
//                   const SizedBox(width: 24),
//                   _buildMetaItem(
//                     label: 'Amount',
//                     value: '₹${_formatAmount(request.amount)}',
//                     valueColor: const Color(0xFF1B8A4C),
//                   ),
//                   const Spacer(),
//                   // Party type pill
//                   if (request.partyType != null)
//                     Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.indigo[50],
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         request.partyType!,
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.indigo[700],
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//
//               //  Row 4: Description / Reason 
//               if (request.reason != null && request.reason!.isNotEmpty) ...[
//                 const SizedBox(height: 12),
//                 const Divider(height: 1, color: Color(0xFFEEEEEE)),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Description',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF666666),
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F7F7),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     request.reason!,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Color(0xFF444444),
//                       height: 1.4,
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// //  Helpers 
//
//   Widget _buildInfoBox({required String label, required String value}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFFDDDDDD)),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 11,
//               color: Color(0xFF999999),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF1A1A2E),
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMetaItem({
//     required String label,
//     required String value,
//     Color? valueColor,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w700,
//             color: valueColor ?? const Color(0xFF1A1A2E),
//           ),
//         ),
//       ],
//     );
//   }
//
//   String _formatAmount(double? amount) {
//     if (amount == null) return '0.00';
//     final formatter = NumberFormat('#,##,##0.00', 'en_IN');
//     return formatter.format(amount);
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.receipt_long_outlined,
//             size: 80,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No payment requests found',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try adjusting your filters or create a new request',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showFilterBottomSheet(
//       BuildContext context,
//       PaymentRequestListController controller,
//       ) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           children: [
//             // Header
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey[300]!),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Filters',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       controller.clearFilters();
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Clear All'),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Filter options
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: GetBuilder<PaymentRequestListController>(
//                   builder: (controller) => Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Party filter
//                       // _buildFilterSection(
//                       //   title: 'Party',
//                       //   child: DropdownButtonFormField<CustomerListData>(
//                       //     initialValue: controller.selectedParty,
//                       //     decoration: InputDecoration(
//                       //       border: OutlineInputBorder(
//                       //         borderRadius: BorderRadius.circular(8),
//                       //       ),
//                       //       contentPadding: const EdgeInsets.symmetric(
//                       //         horizontal: 12,
//                       //         vertical: 8,
//                       //       ),
//                       //     ),
//                       //     hint: const Text('Select Party'),
//                       //     items: controller.partyListData
//                       //         .map((party) => DropdownMenuItem(
//                       //       value: party,
//                       //       child: Text(party.partyname ?? ''),
//                       //     ))
//                       //         .toList(),
//                       //     onChanged: controller.setSelectedParty,
//                       //   ),
//                       // ),
//                       //
//                       // // Branch filter
//                       // _buildFilterSection(
//                       //   title: 'Branch/Site',
//                       //   child: DropdownButtonFormField<BranchandSit>(
//                       //     initialValue: controller.selectedBranch,
//                       //     decoration: InputDecoration(
//                       //       border: OutlineInputBorder(
//                       //         borderRadius: BorderRadius.circular(8),
//                       //       ),
//                       //       contentPadding: const EdgeInsets.symmetric(
//                       //         horizontal: 12,
//                       //         vertical: 8,
//                       //       ),
//                       //     ),
//                       //     hint: const Text('Select Branch/Site'),
//                       //     items: controller.branchandSit
//                       //         .map((branch) => DropdownMenuItem(
//                       //       value: branch,
//                       //       child: Text(branch.branchname ?? ''),
//                       //     ))
//                       //         .toList(),
//                       //     onChanged: controller.setSelectedBranch,
//                       //   ),
//                       // ),
//                       //
//                       // // Status filter
//                       // _buildFilterSection(
//                       //   title: 'Status',
//                       //   child: DropdownButtonFormField<String>(
//                       //     initialValue: controller.selectedStatus,
//                       //     decoration: InputDecoration(
//                       //       border: OutlineInputBorder(
//                       //         borderRadius: BorderRadius.circular(8),
//                       //       ),
//                       //       contentPadding: const EdgeInsets.symmetric(
//                       //         horizontal: 12,
//                       //         vertical: 8,
//                       //       ),
//                       //     ),
//                       //     hint: const Text('Select Status'),
//                       //     items: controller.statusOptions
//                       //         .map((status) => DropdownMenuItem(
//                       //       value: status,
//                       //       child: Text(status),
//                       //     ))
//                       //         .toList(),
//                       //     onChanged: controller.setSelectedStatus,
//                       //   ),
//                       // ),
//                       //
//                       // _buildFilterSection(
//                       //   title: 'Request Type',
//                       //   child: DropdownButtonFormField<String>(
//                       //     initialValue: controller.requestTypeOptions.contains(controller.selectedRequestType)
//                       //         ? controller.selectedRequestType
//                       //         : null,
//                       //     decoration: InputDecoration(
//                       //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                       //       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       //     ),
//                       //     hint: const Text('Select Request Type'),
//                       //     items: controller.requestTypeOptions
//                       //         .map((type) => DropdownMenuItem<String>(value: type, child: Text(type)))
//                       //         .toList(),
//                       //     onChanged: (val) => controller.setSelectedRequestType(val),
//                       //   ),
//                       // ),
//
//                       // Date range filter
//                       _buildFilterSection(
//                         title: 'Date Range',
//                         child: Column(
//                           children: [
//                             // From date
//                             InkWell(
//                               onTap: () async {
//                                 final date = await showDatePicker(
//                                   context: context,
//                                   initialDate: controller.fromDate ?? DateTime.now(),
//                                   firstDate: DateTime(2020),
//                                   lastDate: DateTime.now(),
//                                 );
//                                 if (date != null) {
//                                   controller.setFromDate(date);
//                                 }
//                               },
//                               child: InputDecorator(
//                                 decoration: InputDecoration(
//                                   labelText: 'From Date',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   suffixIcon: Icon(Icons.calendar_today),
//                                 ),
//                                 child: Text(
//                                   controller.fromDate != null
//                                       ? DateFormat('dd-MM-yyyy')
//                                       .format(controller.fromDate!)
//                                       : 'Select date',
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             // To date
//                             InkWell(
//                               onTap: () async {
//                                 final date = await showDatePicker(
//                                   context: context,
//                                   initialDate: controller.toDate ?? DateTime.now(),
//                                   firstDate: controller.fromDate ?? DateTime(2020),
//                                   lastDate: DateTime.now(),
//                                 );
//                                 if (date != null) {
//                                   controller.setToDate(date);
//                                 }
//                               },
//                               child: InputDecorator(
//                                 decoration: InputDecoration(
//                                   labelText: 'To Date',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   suffixIcon: Icon(Icons.calendar_today),
//                                 ),
//                                 child: Text(
//                                   controller.toDate != null
//                                       ? DateFormat('dd-MM-yyyy')
//                                       .format(controller.toDate!)
//                                       : 'Select date',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // Apply button
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(color: Colors.grey[300]!),
//                 ),
//               ),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: purpleColor,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Apply Filters',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterSection({
//     required String title,
//     required Widget child,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           child,
//         ],
//       ),
//     );
//   }
//
//   bool _hasActiveFilters(PaymentRequestListController controller) {
//     return controller.selectedParty != null ||
//         controller.selectedBranch != null ||
//         (controller.selectedStatus != null &&
//             controller.selectedStatus != 'All') ||
//         controller.fromDate != null ||
//         controller.toDate != null;
//   }
//
//   String _getDateRangeLabel(PaymentRequestListController controller) {
//     if (controller.fromDate != null && controller.toDate != null) {
//       return '${DateFormat('dd-MM-yyyy').format(controller.fromDate!)} - ${DateFormat('dd-MM-yyyy').format(controller.toDate!)}';
//     } else if (controller.fromDate != null) {
//       return 'From ${DateFormat('dd-MM-yyyy').format(controller.fromDate!)}';
//     } else if (controller.toDate != null) {
//       return 'To ${DateFormat('dd-MM-yyyy').format(controller.toDate!)}';
//     }
//     return '';
//   }
// }

import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../response/customer_detail_response.dart';
import '../../response/get_branchand_sit_res_model.dart';
import '../payment_request_filter/payment_request_filter_sheet.dart';
import '../payment_request_model/payment_request_model.dart';
import 'payment_request_list_controller.dart';

class PaymentRequestListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentRequestListController>(
          () => PaymentRequestListController(),
      fenix: true, // ✅ recreates if disposed
    );
  }
}

//  Skeleton shimmer widget 
class _SkeletonBox extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  const _SkeletonBox({
    required this.width,
    required this.height,
    this.radius = 6,
  });

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}

//  Skeleton card 
class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width - 64; // full card content width
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: title + badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SkeletonBox(width: w * 0.55, height: 14),
                _SkeletonBox(width: 70, height: 24, radius: 20),
              ],
            ),
            const SizedBox(height: 14),
            // Row 2: two info boxes
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SkeletonBox(width: 50, height: 10),
                        const SizedBox(height: 6),
                        _SkeletonBox(width: double.infinity, height: 13),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SkeletonBox(width: 60, height: 10),
                        const SizedBox(height: 6),
                        _SkeletonBox(width: double.infinity, height: 13),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Row 3: date / amount / party type
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonBox(width: 30, height: 10),
                    const SizedBox(height: 4),
                    _SkeletonBox(width: 70, height: 13),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonBox(width: 40, height: 10),
                    const SizedBox(height: 4),
                    _SkeletonBox(width: 80, height: 13),
                  ],
                ),
                const Spacer(),
                _SkeletonBox(width: 70, height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//  Main screen 
class PaymentRequestListScreen extends StatelessWidget {
  const PaymentRequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentRequestListController>(
      // init: PaymentRequestListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            shadowColor: const Color(0x12000000),
            surfaceTintColor: Colors.white,
            centerTitle: false,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: newTextPrimary, size: 20),
            ),
            title: const Text(
              'Payment Requests',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary),
            ),
            actions: [
              GestureDetector(
                onTap: () => _showFilterBottomSheet(context, controller),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: purpleLightest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Center(
                        child: Icon(Icons.filter_list_rounded, color: purpleColor, size: 20),
                      ),
                      if (controller.activeFilter.isActive)
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(top: 6, right: 6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.getPaymentRequestList(isRefresh: true),
            child: Column(
              children: [
                _buildSearchBar(controller),
                if (_hasActiveFilters(controller))
                  _buildActiveFilters(controller),
                Expanded(
                  child:
                      controller.isBusy && controller.paymentRequestList.isEmpty
                          ? _buildSkeletonList()
                          : controller.filteredPaymentRequestList.isEmpty
                              ? _buildEmptyState()
                              : _buildPaymentRequestList(controller),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await controller.tapOnAdd(); // ✅ await
            },
            backgroundColor: purpleColor,
            shape: const CircleBorder(
                side: BorderSide(color: Colors.white, width: 2)),
            elevation: 4,
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
        );
      },
    );
  }

  //  Skeleton list (6 placeholder cards) 
  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (_, __) => const _SkeletonCard(),
    );
  }

  Widget _buildSearchBar(PaymentRequestListController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        controller: controller.searchController,
        focusNode: controller.searchFocus,
        onChanged: controller.onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search by party, reason, request no...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.searchController.clear();
                    controller.onSearchChanged('');
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildActiveFilters(PaymentRequestListController controller) {
    final f = controller.activeFilter;
    if (!f.isActive) return const SizedBox.shrink();

    final chips = <Widget>[];

    void addChip(String label, VoidCallback onDelete) {
      chips.add(Container(
        margin: const EdgeInsets.only(right: 8),
        child: Chip(
          label: Text(label, style: const TextStyle(fontSize: 12)),
          onDeleted: onDelete,
          deleteIcon: const Icon(Icons.close, size: 14),
          backgroundColor: purpleColor.withValues(alpha: 0.08),
          labelStyle: const TextStyle(color: purpleColor),
          side: BorderSide.none,
        ),
      ));
    }

    if (f.fromDate != null || f.toDate != null) {
      final from = f.fromDate != null
          ? DateFormat('dd MMM yy').format(f.fromDate!) : '...';
      final to = f.toDate != null
          ? DateFormat('dd MMM yy').format(f.toDate!) : '...';
      addChip('$from – $to', () =>
          controller.applyFilter(f.copyWith(clearFromDate: true, clearToDate: true)));
    }
    if (f.statuses.isNotEmpty) {
      addChip(f.statuses.join(', '), () =>
          controller.applyFilter(f.copyWith(statuses: {})));
    }
    if (f.partyTypes.isNotEmpty) {
      addChip('${f.partyTypes.length} Party Type(s)', () =>
          controller.applyFilter(f.copyWith(partyTypes: {})));
    }
    if (f.requestTypes.isNotEmpty) {
      addChip('${f.requestTypes.length} Req. Type(s)', () =>
          controller.applyFilter(f.copyWith(requestTypes: {})));
    }
    if (f.siteNames.isNotEmpty) {
      addChip('${f.siteNames.length} Site(s)', () =>
          controller.applyFilter(f.copyWith(siteNames: {})));
    }
    if (f.minAmount != null || f.maxAmount != null) {
      final min = f.minAmount != null ? '₹${f.minAmount!.toStringAsFixed(0)}' : '₹0';
      final max = f.maxAmount != null ? '₹${f.maxAmount!.toStringAsFixed(0)}' : '∞';
      addChip('$min – $max', () =>
          controller.applyFilter(f.copyWith(clearMinAmount: true, clearMaxAmount: true)));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[50],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...chips,
            TextButton.icon(
              onPressed: () => controller.resetFilter(),
              icon: const Icon(Icons.clear_all, size: 16),
              label: const Text('Clear All'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
      {required String label, required VoidCallback onDelete}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        onDeleted: onDelete,
        deleteIcon: const Icon(Icons.close, size: 16),
        backgroundColor: Colors.blue[50],
        labelStyle: TextStyle(color: Colors.blue[900]),
      ),
    );
  }

  Widget _buildPaymentRequestList(PaymentRequestListController controller) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!controller.isBusy &&
            controller.hasMoreData &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          controller.loadMore();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.filteredPaymentRequestList.length +
            (controller.hasMoreData ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.filteredPaymentRequestList.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final request = controller.filteredPaymentRequestList[index];
          return _buildPaymentRequestCard(request, controller);
        },
      ),
    );
  }

  //  Card 
  Widget _buildPaymentRequestCard(
    PaymentRequestModel request,
    PaymentRequestListController controller,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          await controller.viewPaymentRequestDetails(request); // ✅ await
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Row 1: Request No + Status badge 
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Payment Request No.: ${request.requestNo ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Status badge — shrinkwrapped, never clips title
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: request.getStatusColor().withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(request.getStatusIcon(),
                            color: request.getStatusColor(), size: 12),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 90),
                          child: Text(
                            request.status ?? 'N/A',
                            style: TextStyle(
                              color: request.getStatusColor(),
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              //  Row 2: Site Name + Request Type boxes 
              Row(
                children: [
                  Expanded(
                    child: _buildInfoBox(
                      label: 'Site Name',
                      value: request.branchName ?? 'N/A',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInfoBox(
                      label: 'Request Type',
                      value: request.requestType ?? 'N/A',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              //  Row 3: Date | Amount | Party type (plain text) 
              //  Row 3: Date | Amount | Party type 
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Date — fixed width
                  SizedBox(
                    width: 100,
                    child: _buildMetaItem(
                      label: 'Date',
                      value: request.requestDate != null
                          ? DateFormat('dd/MM/yyyy').format(request.requestDate!)
                          : 'N/A',
                    ),
                  ),

                  // Amount — fixed width
                  SizedBox(
                    width: 90,
                    child: _buildMetaItem(
                      label: 'Amount',
                      value: '₹${_formatAmount(request.amount)}',
                      valueColor: const Color(0xFF1B8A4C),
                    ),
                  ),

                  // Party type — takes remaining space, never truncates
                  if (request.partyType != null && request.partyType!.isNotEmpty)
                    Expanded(
                      child: _buildMetaItem(
                        label: 'Party Type',
                        value: request.partyType!,
                      ),
                    ),
                ],
              ),

              //  Row 4: Description / Reason 
              if (request.reason != null && request.reason!.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                const SizedBox(height: 10),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    request.reason!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF444444),
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  //  Helpers 

  Widget _buildInfoBox({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF999999),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: valueColor ?? const Color(0xFF1A1A2E),
          ),
          maxLines: 2,              // ← allows wrapping instead of truncating
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatAmount(double? amount) {
    if (amount == null) return '0.00';
    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(amount);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No payment requests found',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or create a new request',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(
      BuildContext context,
      PaymentRequestListController controller,
      ) {
    // Build a draft that pre-fills dates from the controller's current range
    final prefilledFilter = controller.activeFilter.copyWith(
      fromDate: controller.activeFilter.fromDate ??
          DateFormat('dd-MM-yyyy').parse(controller.firstDate),
      toDate: controller.activeFilter.toDate ??
          DateFormat('dd-MM-yyyy').parse(controller.lastDate),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PaymentRequestFilterSheet(
        allItems: controller.paymentRequestList,
        activeFilter: prefilledFilter,          // ← pre-filled dates
        onApply: (filter) => controller.applyFilter(filter),
        onReset: () => controller.resetFilter(),
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  bool _hasActiveFilters(PaymentRequestListController controller) {
    return controller.activeFilter.isActive;
  }

  String _getDateRangeLabel(PaymentRequestListController controller) {
    if (controller.fromDate != null && controller.toDate != null) {
      return '${DateFormat('dd-MM-yyyy').format(controller.fromDate!)} - ${DateFormat('dd-MM-yyyy').format(controller.toDate!)}';
    } else if (controller.fromDate != null) {
      return 'From ${DateFormat('dd-MM-yyyy').format(controller.fromDate!)}';
    } else if (controller.toDate != null) {
      return 'To ${DateFormat('dd-MM-yyyy').format(controller.toDate!)}';
    }
    return '';
  }
}
