// import 'package:digitalerp/response/collection_list_response.dart';
// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
// import 'package:digitalerp/screen/ui/home/account_module/list/list_with_filter_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/list_filter/list_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_loader.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ListWithFilterView extends StatelessWidget {
//   final String? voucherType;
//
//   const ListWithFilterView({
//     Key? key,
//     this.voucherType,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String appBarName = 'List';
//     String arg = Get.arguments.toString();
//     if (arg == VoucherType.payment) {
//       appBarName = 'Payment List';
//     } else if (arg == VoucherType.receipt) {
//       appBarName = 'Receipt List';
//     } else if (arg == VoucherType.collection) {
//       appBarName = 'Collection List';
//     } else if (arg == VoucherType.expense) {
//       appBarName = 'Expense List';
//     } else if (arg == VoucherType.contra) {
//       appBarName = 'Contra List';
//     } else if (arg == VoucherType.journal) {
//       appBarName = 'Journal List';
//     }
//     return GetBuilder<ListWithFilterController>(
//       init: ListWithFilterController(),
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(AppAssets.dashboardBg),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   child: SafeArea(
//                     child: MyAppBar(
//                       title: appBarName,
//                       onBackTap: () => controller.backTap(),
//                       onFilterTap: () => Get.dialog(
//                         const ListFilterView(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: controller.isBusy
//                     ? const AppLoader()
//                     : SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: Get.height * 0.02),
//                               Visibility(
//                                 visible: true,
//                                 child: _dropdown(controller),
//                                 replacement: Container(
//                                   width: Get.width,
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                       color: dropdownBoxColor,
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Text(
//                                     controller.customerName,
//                                     style: const TextStyle().bold.copyWith(),
//                                   ),
//                                 ),
//                               ),
//                               Visibility(
//                                 visible: controller.list.isNotEmpty,
//                                 child: ListView.builder(
//                                   itemCount: controller.list.length,
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemBuilder: (c, i) => listCard(controller.list[i]),
//                                 ),
//                                 replacement: SizedBox(
//                                   height: Get.height * .35,
//                                   child: Center(
//                                     child: Text(
//                                       'List not found',
//                                       style: const TextStyle().bold.copyWith(),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//               Positioned(
//                 bottom: 80,
//                 right: 20,
//                 child: InkWell(
//                   onTap: () {
//                     controller.onTabAdd();
//                   },
//                   child: Container(
//                     height: 60,
//                     width: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       gradient: gr2,
//                       boxShadow: const [
//                         BoxShadow(
//                           blurRadius: 10,
//                           color: purpleColor,
//                         )
//                       ],
//                     ),
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     child: Image.asset(
//                       AppAssets.addIcon,
//                       height: 28,
//                       width: 28,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: MenuFab(parentMenuId: 2382),
//       ),
//     );
//   }
//
//   Widget listCard(CollectionData data) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//         color: blueColor.withValues(alpha:0.07),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           rowText(typeName: AppString.voucherNo, value: data.voucherno.toString()),
//           rowText(typeName: AppString.date, value: data.date ?? ''),
//           rowText(typeName: AppString.customerName, value: data.customername ?? ''),
//           rowText(typeName: AppString.amount, value: data.amount ?? ''),
//           rowText(typeName: AppString.remark, value: data.remarks ?? ''),
//         ],
//       ),
//     );
//   }
//
//   Widget rowText({required String typeName, required String value}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           typeName,
//           style: const TextStyle().medium.copyWith(fontSize: 12, color: purpleColor),
//         ),
//         const SizedBox(width: 30,),
//         Flexible(
//           child: Text(
//             value,
//             style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _dropdown(ListWithFilterController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<CustomerListData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         isExpanded: true,
//         value: controller.selectedDropdownValue,
//         hint: Text(
//           controller.getDropDownHint(),
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.customerDataList.map(
//           (items) {
//             return DropdownMenuItem<CustomerListData>(
//               value: items,
//               child: Text(items.partyname.toString()),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) {
//           controller.setDropdownValue(newValue);
//         },
//         dropdownMaxHeight: Get.height * .35,
//       ),
//     );
//   }
// }

import 'package:digitalerp/response/collection_list_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/account_module/list/list_with_filter_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/list_filter/list_filter_view.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/widget_helpers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListWithFilterView extends StatelessWidget {
  final String? voucherType;

  const ListWithFilterView({Key? key, this.voucherType}) : super(key: key);

  String _resolveTitle() {
    final arg = Get.arguments.toString();
    final map = {
      VoucherType.payment: 'Payment list',
      VoucherType.receipt: 'Receipt list',
      VoucherType.collection: 'Collection list',
      VoucherType.expense: 'Expense list',
      VoucherType.contra: 'Contra list',
      VoucherType.journal: 'Journal list',
    };
    return map[arg] ?? 'List';
  }

  @override
  Widget build(BuildContext context) {
    final title = _resolveTitle();

    return GetBuilder<ListWithFilterController>(
      init: ListWithFilterController(),
      builder: (controller) => Scaffold(
        backgroundColor: kBg,
        appBar: buildAppBar(
          title,
          onBack: controller.backTap,
          actions: [
            GestureDetector(
              onTap: () => Get.dialog(const ListFilterView()),
              child: Container(
                margin: const EdgeInsets.only(right: 14),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: purpleLightest,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.filter_list_sharp,
                    color: purpleColor, size: 20),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onTabAdd,
          backgroundColor: kAccent,
          elevation: 4,
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
        ),
        body: MenuFabBody(
          parentMenuId: 2382,
          child: controller.isBusy
              ? const Center(child: CircularProgressIndicator(color: kAccent))
              : Column(
                  children: [
                    // Customer filter + active chips
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Column(children: [
                        dropdownWrap(_customerDropdown(controller)),
                      ]),
                    ),
                    const SizedBox(height: 1),

                    // List
                    Expanded(
                      child: controller.list.isEmpty
                          ? _emptyState()
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 14, 16, 100),
                              itemCount: controller.list.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (_, i) =>
                                  _listCard(controller.list[i]),
                            ),
                    ),

                    // Total footer
                    if (controller.list.isNotEmpty) _totalFooter(controller),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _customerDropdown(ListWithFilterController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<CustomerListData>(
        buttonHeight: 44,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        buttonDecoration: const BoxDecoration(color: Colors.transparent),
        isExpanded: true,
        value: controller.selectedDropdownValue,
        hint: Text(
          controller.getDropDownHint(),
          style: const TextStyle(fontSize: 14, color: kHint),
          overflow: TextOverflow.ellipsis,
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: kMuted, size: 22),
        dropdownMaxHeight: Get.height * .35,
        items: controller.customerDataList.map((item) {
          return DropdownMenuItem<CustomerListData>(
            value: item,
            child: Text(item.partyname.toString(),
                style: const TextStyle(fontSize: 14, color: kText)),
          );
        }).toList(),
        onChanged: controller.setDropdownValue,
      ),
    );
  }

  Widget _listCard(CollectionData data) {
    final amount = data.amount ?? '0';
    final amtNum = double.tryParse(amount.replaceAll(',', '')) ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: [
        // Header row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: const BoxDecoration(
            color: kAccentBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.voucherno?.toString() ?? '—',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kAccentText),
              ),
              statusBadge(
                '₹ $amount',
                amtNum > 10000 ? BadgeVariant.green : BadgeVariant.amber,
              ),
            ],
          ),
        ),

        // Detail rows
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            _detailRow('Date', data.date ?? '—'),
            const SizedBox(height: 6),
            _detailRow('Customer', data.customername ?? '—'),
            const SizedBox(height: 6),
            _detailRow('Remark', data.remarks ?? '—', muted: true),
          ]),
        ),
      ]),
    );
  }

  Widget _detailRow(String key, String value, {bool muted = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(key,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: kMuted)),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: muted ? kMuted : kText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: kAccentBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.inbox_outlined, size: 30, color: kAccent),
          ),
          const SizedBox(height: 14),
          const Text('No records found',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600, color: kText)),
          const SizedBox(height: 4),
          const Text('Try changing the filter or customer',
              style: TextStyle(fontSize: 13, color: kMuted)),
        ],
      ),
    );
  }

  Widget _totalFooter(ListWithFilterController controller) {
    final total = controller.list.fold<double>(
      0,
      (sum, item) =>
          sum +
          (double.tryParse((item.amount ?? '0').replaceAll(',', '')) ?? 0),
    );

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${controller.list.length} records',
            style: const TextStyle(
                fontSize: 13, color: kMuted, fontWeight: FontWeight.w500),
          ),
          Text(
            'Total  ₹ ${total.toStringAsFixed(0)}',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: kText),
          ),
        ],
      ),
    );
  }
}
