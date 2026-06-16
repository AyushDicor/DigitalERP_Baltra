// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/response/get_shipping_status_resp.dart';
// import 'package:digitalerp/utils/date_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'pending_shipping_controller.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/items.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:digitalerp/utils/app_assets.dart';
//
// class PendingShippingView extends StatelessWidget {
//   const PendingShippingView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PendingShippingController>(
//       init: PendingShippingController(),
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
//                       title: AppString.pendingShipping,
//                       onBackTap: () => controller.backTap(),
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
//                     ? showLoader()
//                     : SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             children: [
//                               SizedBox(height: Get.height * 0.02),
//                               const SizedBox(height: 30),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: AppDateWidget(
//                                       value: controller.selectFromDate,
//                                       title: 'From date',
//                                       onSelectDate: controller.setSelectedFromDate,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 15),
//                                   Expanded(
//                                     child: AppDateWidget(
//                                       value: controller.selectToDate,
//                                       title: 'To Date',
//                                       onSelectDate: controller.setSelectedToDate,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 30),
//                               _dropdownPartyName(controller),
//                               const SizedBox(height: 15),
//                               _dropdownStatus(controller),
//                               const SizedBox(height: 30),
//                               SolidAppButton(
//                                 onPressed: controller.onSearch,
//                                 name: 'Search',
//                                 topColor: orangeColor,
//                                 bottomColor: red2Color,
//                                 textSize: 16,
//                                 hPadding: 30,
//                               ),
//                               const SizedBox(height: 20),
//                               ListView.builder(
//                                 // itemCount: 5,
//                                 padding: EdgeInsets.zero,
//                                 itemCount: controller.pendingShippingList.length ?? 0,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   var item = controller.pendingShippingList[index];
//                                   return CommonItem(
//                                     isCardShow: true,
//                                     data: [
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.entryNo,
//                                         leftValue: item.entryno,
//                                         rightTitle: AppString.date,
//                                         rightValue: item.date,
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.partyName,
//                                         leftValue: item.partyname,
//                                         rightTitle: AppString.shippingAddressTxt,
//                                         rightValue: item.shippingaddress,
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.deliveredTo,
//                                         leftValue: item.deliveredto,
//                                         rightTitle: AppString.status,
//                                         rightValue: item.shippingstatus,
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _dropdownPartyName(PendingShippingController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<CustomerListData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration:
//             BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
//         isExpanded: true,
//         value: controller.selectedPartyValue,
//         hint: Text(
//           AppString.partyName,
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.partyList.map(
//           (items) {
//             return DropdownMenuItem<CustomerListData>(
//               value: items,
//               child: Text(items.partyname.toString()),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) {
//           controller.setPartyValue(newValue);
//         },
//         dropdownMaxHeight: Get.height * .35,
//       ),
//     );
//   }
//
//   Widget _dropdownStatus(PendingShippingController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<GetShippingStatusData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedStatusValue,
//         hint: Text(
//           'Status',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.statusList.map((items) {
//           return DropdownMenuItem<GetShippingStatusData>(
//             value: items,
//             child: Text(items.statusname ?? ''),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setStatusValue(newValue);
//         },
//       ),
//     );
//   }
// }

import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_shipping_status_resp.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/date_widget.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../fab/menu_fab.dart';
import 'pending_shipping_controller.dart';

class PendingShippingView extends StatelessWidget {
  const PendingShippingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingShippingController>(
      init: PendingShippingController(),
      builder: (controller) => Scaffold(
        backgroundColor: lightGreyColor,
        body: Column(
          children: [
            MyAppBar(
              title: AppString.pendingShipping,
              onBackTap: () => controller.backTap(),
            ),
            Expanded(
              child: controller.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: purpleColor, strokeWidth: 2))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _filterCard(controller),
                          if (controller.pendingShippingList.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            _sectionTitle(
                                'Results (${controller.pendingShippingList.length})'),
                            const SizedBox(height: 12),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.pendingShippingList.length,
                              itemBuilder: (_, i) => _shippingCard(
                                  controller.pendingShippingList[i]),
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: MenuFab(parentMenuId: 2383),
      ),
    );
  }

  Widget _filterCard(PendingShippingController controller) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Date Range'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _dateBox(
                      value: controller.selectFromDate,
                      title: 'From Date',
                      onSelect: controller.setSelectedFromDate)),
              const SizedBox(width: 12),
              Expanded(
                  child: _dateBox(
                      value: controller.selectToDate,
                      title: 'To Date',
                      onSelect: controller.setSelectedToDate)),
            ],
          ),
          const SizedBox(height: 16),
          _label('Party Name'),
          const SizedBox(height: 8),
          _dropdown<CustomerListData>(
            value: controller.selectedPartyValue,
            hint: AppString.partyName,
            items: controller.partyList
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.partyname.toString(),
                        style: const TextStyle(
                            color: newTextPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500))))
                .toList(),
            onChanged: controller.setPartyValue,
          ),
          const SizedBox(height: 16),
          _label('Shipping Status'),
          const SizedBox(height: 8),
          _dropdown<GetShippingStatusData>(
            value: controller.selectedStatusValue,
            hint: 'Select Status',
            items: controller.statusList
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.statusname ?? '',
                        style: const TextStyle(
                            color: newTextPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500))))
                .toList(),
            onChanged: controller.setStatusValue,
          ),
          const SizedBox(height: 20),
          _searchBtn(controller.onSearch),
        ],
      ),
    );
  }

  Widget _shippingCard(dynamic item) {
    final String status = item.shippingstatus?.toString() ?? '';
    final bool isPending = status.toLowerCase().contains('pending');
    final Color statusColor = isPending ? newOrangeColor : newGreenColor;
    final Color statusBg = isPending ? newOrangeLightColor : newGreenLightColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: purpleColor.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(bottom: BorderSide(color: newBorderColor)),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_shipping_rounded,
                    color: purpleColor, size: 15),
                const SizedBox(width: 6),
                Text('Entry #${item.entryno ?? '—'}',
                    style: const TextStyle(
                        color: purpleColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: statusBg, borderRadius: BorderRadius.circular(20)),
                  child: Text(status,
                      style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _rowInfo(AppString.partyName, item.partyname, AppString.date,
                    item.date),
                Divider(height: 16, color: newBorderColor),
                _rowInfo(AppString.shippingAddressTxt, item.shippingaddress,
                    AppString.deliveredTo, item.deliveredto),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  Helpers 
  Widget _card({required Widget child}) => Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 5)),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: child,
      );

  Widget _label(String t) => Text(t,
      style: const TextStyle(
          color: newTextSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3));

  Widget _sectionTitle(String t) => Row(children: [
        Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
                color: purpleColor, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(t,
            style: const TextStyle(
                color: newTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700)),
      ]);

  Widget _dropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) =>
      DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            color: newSurfaceColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: newBorderColor),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2))
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButton2<T>(
            buttonHeight: 46,
            buttonPadding: EdgeInsets.zero,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: whiteColor),
            dropdownMaxHeight: Get.height * .35,
            isExpanded: true,
            value: value,
            hint: Text(hint,
                style: const TextStyle(
                    color: newTextHint,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: purpleColor, size: 22),
            items: items,
            onChanged: onChanged,
          ),
        ),
      );

  Widget _dateBox(
          {required String value,
          required String title,
          required Function(String) onSelect}) =>
      Container(
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child:
            AppDateWidget(value: value, title: title, onSelectDate: onSelect),
      );

  Widget _searchBtn(VoidCallback onPressed) => SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: purpleColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                    color: purpleColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 5))
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_rounded, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('Search',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      );

  Widget _rowInfo(String lt, String? lv, String rt, String? rv) =>
      Row(children: [
        Expanded(child: _infoBlock(lt, lv)),
        Container(
            width: 1,
            height: 36,
            color: newBorderColor,
            margin: const EdgeInsets.symmetric(horizontal: 10)),
        Expanded(child: _infoBlock(rt, rv)),
      ]);

  Widget _infoBlock(String label, String? value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: newTextSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2)),
          const SizedBox(height: 3),
          Text(value ?? '—',
              style: const TextStyle(
                  color: newTextPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      );
}
