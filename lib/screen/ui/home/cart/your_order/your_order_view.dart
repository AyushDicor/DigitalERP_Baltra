import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/your_order_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:digitalerp/utils/dottedline.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/safeAreaWrapper.dart';
import 'package:digitalerp/utils/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../base/base_controller.dart';

class YourOrderView extends StatelessWidget {
  const YourOrderView({Key? key}) : super(key: key);

  // Local UI tokens (reuse app tokens where they exist).
  static const _ink = Color(0xFF0F172A);
  static const _fieldFill = Color(0xFFF4F5F7);

  double _num(String? s) => double.tryParse(s ?? '') ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<YourOrderController>(
      init: YourOrderController(),
      builder: (controller) {
        final isCustomer = controller.isCustomer ?? false;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              // Background + app bar.
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dashboardBg),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SafeArea(
                    child: MyAppBar(
                      title: 'Your Order',
                      onBackTap: () => controller.backTap(),
                    ),
                  ),
                ),
              ),

              // Scrolling content.
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Get.height * 0.135,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer / company selector.
                      isCustomer
                          ? _companyCard2(controller)
                          : _searchField(controller),
                      if (!isCustomer && controller.selectCompany != null) ...[
                        const SizedBox(height: 6),
                        _companyCard2(controller),
                      ],
                      const SizedBox(height: 18),

                      // Products.
                      _sectionTitle('Products'),
                      _productList(controller),
                      const SizedBox(height: 18),

                      // Bill summary.
                      _sectionTitle('Bill Summary'),
                      _summaryCard(controller),

                      const SizedBox(height: 90),
                      if (Shared.keyboardIsVisible(context))
                        const SizedBox(height: 170),
                    ],
                  ),
                ),
              ),

              // Sticky action bar.
              Align(
                alignment: Alignment.bottomCenter,
                child: _bottomBtn(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------ shared bits

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          text,
          style: const TextStyle().bold.copyWith(fontSize: 15, color: _ink),
        ),
      );

  Widget _searchField(YourOrderController controller) => TextFormField(
        readOnly: true,
        onTap: () => controller.tapOnSearch(),
        decoration: const InputDecoration()
            .searchTxtFieldStyle(hint: 'Search Customer'),
      );

  Widget _card({required Widget child, EdgeInsets? padding}) => Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: child,
      );

  // -------------------------------------------------------------- products

  Widget _productList(YourOrderController controller) {
    final items = controller.cartController.cartList;
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => _productCard(controller, index),
    );
  }

  Widget _productCard(YourOrderController controller, int index) {
    final item = controller.cartController.cartList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppNetworkImage(
              image: item.productimage ?? '',
              fit: BoxFit.cover,
              height: 66,
              width: 66,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productname ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle()
                      .bold
                      .copyWith(fontSize: 14, color: _ink),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _metric('Qty', item.quantity?.toString() ?? '0'),
                    _metric('Unit', item.unit ?? '-'),
                    _metric('Rate', item.itemrate?.toStringAsFixed(2) ?? '0',
                        money: true),
                    _metric('Amount', item.total?.toStringAsFixed(2) ?? '0',
                        money: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, {bool money = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle()
                .bold
                .copyWith(fontSize: 11, color: medGreyColor),
          ),
          const SizedBox(height: 4),
          Text(
            money ? '\u{20B9}$value' : value,
            style: const TextStyle().bold.copyWith(fontSize: 13, color: _ink),
          ),
        ],
      );

  // --------------------------------------------------------------- summary

  Widget _summaryCard(YourOrderController controller) {
    final amount = controller.cartController.cartList.isNotEmpty
        ? controller.cartController.cartList.first.subtotal?.toString()
        : '0';
    return _card(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          _amountRow('Amount', _num(amount)),
          const SizedBox(height: 14),
          _percentRow(
            'Discount %',
            controller.discountController,
            controller.discountFocus,
            controller.discountCalculate,
          ),
          const SizedBox(height: 14),
          _amountRow('Subtotal', controller.subTotal),
          const SizedBox(height: 14),
          _percentRow(
            'Cash Discount %',
            controller.cashDiscountController,
            controller.cashDiscountFocus,
            controller.cashDiscountCalculate,
          ),
          const SizedBox(height: 16),
          DottedLine(
            color: medGreyColor,
            width: double.maxFinite,
            space: 3,
            strokeWidth: 1,
          ),
          const SizedBox(height: 16),
          _amountRow('Grand Total', controller.grandTotal, emphasize: true),
        ],
      ),
    );
  }

  Widget _amountRow(String name, double amount, {bool emphasize = false}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle().bold.copyWith(
                  fontSize: emphasize ? 16 : 14,
                  color: emphasize ? _ink : medGreyColor,
                ),
          ),
          Text(
            '\u{20B9}${amount.toStringAsFixed(2)}',
            style: const TextStyle().bold.copyWith(
                  fontSize: emphasize ? 18 : 14,
                  color: emphasize ? red2Color : _ink,
                ),
          ),
        ],
      );

  Widget _percentRow(String name, TextEditingController c, FocusNode f,
          void Function(String) onChanged) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle()
                .bold
                .copyWith(fontSize: 14, color: medGreyColor),
          ),
          Container(
            width: 96,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: _fieldFill,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.06)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: c,
                    focusNode: f,
                    onChanged: onChanged,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      counterText: '',
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: '0',
                    ),
                    style: const TextStyle()
                        .bold
                        .copyWith(fontSize: 15, color: _ink),
                  ),
                ),
                Text(
                  '%',
                  style: const TextStyle()
                      .bold
                      .copyWith(fontSize: 14, color: medGreyColor),
                ),
              ],
            ),
          ),
        ],
      );

  // --------------------------------------------------------------- company

  Widget _companyCard2(YourOrderController controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Company Name',
            style: const TextStyle().bold.copyWith(fontSize: 14, color: _ink),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: orangeDropdownGr(.19),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                ProfileImageView(
                  size: 40,
                  imageUrl: controller.selectCompany?.partyid.toString() ?? '',
                  borderSize: 2,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    (controller.isCustomer ?? false)
                        ? (controller.companyName ?? '')
                        : (controller.selectCompany?.partyname ?? ''),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle().bold.copyWith(color: _ink),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  // Kept for the manager/executive flow — re-enable in build() when needed.
  Widget _dropdown(YourOrderController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<ExecutiveDropdownData>(
          buttonHeight: 40,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: dropdownBoxColor,
          ),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: blueDropdownGr,
          ),
          isExpanded: true,
          value: controller.selectedDropdownValue,
          hint: Text(
            'Select Executive name',
            style: const TextStyle().normal.copyWith(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          icon: Image.asset(AppAssets.dropdownIcon, width: 15, height: 15),
          items: controller.orderController.executiveList.map((items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items.executiveName.toString()),
            );
          }).toList(),
          onChanged: (ExecutiveDropdownData? newValue) {
            controller.setDropdownValue(newValue!);
          },
        ),
      );

  // ---------------------------------------------------------------- bottom

  Widget _bottomBtn(YourOrderController controller) {
    final fallback = controller.cartController.cartList.isNotEmpty
        ? (controller.cartController.cartList.first.subtotal ?? 0).toDouble()
        : 0.0;
    final total =
        controller.grandTotal == 0.0 ? fallback : controller.grandTotal;
    return SafeAreaWrapper(
      child: Container(
        width: Get.width,
        height: 64,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
         color: purpleColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payable',
                  style: const TextStyle()
                      .normal
                      .copyWith(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '\u{20B9}${total.toStringAsFixed(2)}',
                  style: const TextStyle()
                      .bold
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () => controller.tapOnPlaceOrder(),
              shape: const StadiumBorder(),
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: Text(
                'Place order',
                style: const TextStyle().bold.copyWith(color: red2Color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
