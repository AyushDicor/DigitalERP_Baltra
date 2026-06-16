// import 'package:digitalerp/response/get_parentgroup_resp.dart';
// import 'package:digitalerp/response/get_party_for_parent_resp.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/items.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'mis_outstanding_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
//
// class MisOutstandingView extends StatelessWidget {
//   const MisOutstandingView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MisOutstandingController>(
//       init: MisOutstandingController(),
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
//                       title: AppString.outstanding,
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
//                               _dropdownParentGroup(controller),
//                               const SizedBox(height: 15),
//                               _dropdownPartyName(controller),
//                               const SizedBox(height: 15),
//                               SizedBox(
//                                 height: 40,
//                                 child: TextField(
//                                   controller: controller.daysCtr,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: grBottomColor.withValues(alpha:0.2),
//                                     hintText: 'Days',
//                                     hintStyle: const TextStyle().normal.copyWith(fontSize: 14),
//                                     contentPadding:
//                                         const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                   ),
//                                 ),
//                               ),
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
//                                 itemCount: controller.list?.length ?? 0,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   var item = controller.list![index];
//                                   return CommonItem(
//                                     isCardShow: true,
//                                     data: [
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.partyName,
//                                         leftValue: item.partyname,
//                                         rightTitle: AppString.mobileNo,
//                                         rightValue: item.mobileno,
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.addressTxt,
//                                         leftValue: item.address,
//                                         rightTitle: AppString.executive,
//                                         rightValue: item.executivename,
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.balance,
//                                         leftValue: item.balance,
//                                         rightTitle: AppString.balanceType,
//                                         rightValue: item.balancetype,
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
//   Widget _dropdownParentGroup(MisOutstandingController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<GetParentGroupData>(
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
//         value: controller.parent,
//         hint: Text(
//           'Select Parent Group',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.parentGroupList.map((items) {
//           return DropdownMenuItem<GetParentGroupData>(
//             value: items,
//             child: Text(items.parentgroup ?? ''),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setGroupParty(newValue);
//         },
//       ),
//     );
//   }
//
//   Widget _dropdownPartyName(MisOutstandingController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<GetPartyForParentData>(
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
//         value: controller.party,
//         hint: Text(
//           'Select Party Name',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.partyNameList.map((items) {
//           return DropdownMenuItem<GetPartyForParentData>(
//             value: items,
//             child: Text(items.partyname ?? ''),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setPartyName(newValue);
//         },
//       ),
//     );
//   }
// }

import 'package:digitalerp/response/get_parentgroup_resp.dart';
import 'package:digitalerp/response/get_party_for_parent_resp.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../fab/menu_fab.dart';
import 'mis_outstanding_controller.dart';

class MisOutstandingView extends StatelessWidget {
  const MisOutstandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MisOutstandingController>(
      init: MisOutstandingController(),
      builder: (controller) => Scaffold(
        backgroundColor: lightGreyColor,
        body: Column(
          children: [
            MyAppBar(
              title: AppString.outstanding,
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
                          if (controller.list?.isNotEmpty ?? false) ...[
                            const SizedBox(height: 24),
                            _sectionTitle(
                                'Results (${controller.list!.length})'),
                            const SizedBox(height: 12),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.list!.length,
                              itemBuilder: (_, i) =>
                                  _outstandingCard(controller.list![i]),
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

  Widget _filterCard(MisOutstandingController controller) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Parent Group'),
          const SizedBox(height: 8),
          _dropdown<GetParentGroupData>(
            value: controller.parent,
            hint: 'Select Parent Group',
            items: controller.parentGroupList
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.parentgroup ?? '', style: _itemStyle())))
                .toList(),
            onChanged: controller.setGroupParty,
          ),
          const SizedBox(height: 16),
          _label('Party Name'),
          const SizedBox(height: 8),
          _dropdown<GetPartyForParentData>(
            value: controller.party,
            hint: 'Select Party Name',
            items: controller.partyNameList
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.partyname ?? '', style: _itemStyle())))
                .toList(),
            onChanged: controller.setPartyName,
          ),
          const SizedBox(height: 16),
          _label('Days'),
          const SizedBox(height: 8),
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
            child: TextField(
              controller: controller.daysCtr,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: newTextPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                hintText: 'Enter number of days',
                hintStyle: TextStyle(color: newTextHint, fontSize: 14),
                prefixIcon: Icon(Icons.calendar_today_rounded,
                    color: purpleColor, size: 18),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _searchBtn(controller.onSearch),
        ],
      ),
    );
  }

  Widget _outstandingCard(dynamic item) {
    final bool isDebit =
        (item.balancetype?.toString().toLowerCase() ?? '') == 'dr';
    final Color balColor = isDebit ? newRedColor : newGreenColor;
    final Color balBg = isDebit ? newRedLightColor : newGreenLightColor;

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
                const Icon(Icons.business_rounded,
                    color: purpleColor, size: 15),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(item.partyname ?? '—',
                      style: const TextStyle(
                          color: purpleColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                // Balance badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: balBg, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    '${item.balance ?? '—'} ${item.balancetype ?? ''}',
                    style: TextStyle(
                        color: balColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _rowInfo(AppString.mobileNo, item.mobileno, AppString.executive,
                    item.executivename),
                Divider(height: 16, color: newBorderColor),
                _rowInfo(AppString.addressTxt, item.address,
                    AppString.balanceType, item.balancetype),
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

  TextStyle _itemStyle() => const TextStyle(
      color: newTextPrimary, fontSize: 14, fontWeight: FontWeight.w500);

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
