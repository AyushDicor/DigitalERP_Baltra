import 'package:digitalerp/response/get_cart_list_response.dart';
import 'package:digitalerp/screen/ui/home/cart/your_order/your_order_controller.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Checkout: customer, items, discounts and the final Place / Update button.
/// Same look as the Cart screen it is opened from.
class YourOrderView extends StatelessWidget {
  const YourOrderView({Key? key}) : super(key: key);

  static const _bg = Color(0xFFF5F6FA);
  static const _ink = Color(0xFF1A1A2E);
  static const _muted = Color(0xFF6B7280);
  static const _line = Color(0xFFEEEEEE);
  static const _accent = Color(0xFF3D4ED8);
  static const _accentSoft = Color(0xFFEEF0FF);
  static const _green = Color(0xFF16A34A);

  static final _inr = NumberFormat.currency(
      locale: 'en_IN', symbol: '₹', decimalDigits: 2);

  static String _money(num v) => _inr.format(v);

  static String _qty(num? v) {
    final q = (v ?? 0).toDouble();
    return q == q.roundToDouble() ? q.toInt().toString() : q.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<YourOrderController>(
      init: YourOrderController(),
      builder: (c) => Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: _ink),
            onPressed: () => Get.back(),
          ),
          titleSpacing: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.isEditing ? 'Update Order' : 'Checkout',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: _ink),
              ),
              if (c.isEditing)
                Text(
                  c.editSession!.orderNo,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              _sectionTitle('Customer'),
              _customerCard(c),
              const SizedBox(height: 20),
              _sectionTitle(
                'Items (${c.cartController.cartList.length})',
                trailing: TextButton(
                  onPressed: () => Get.back(),
                  style: TextButton.styleFrom(
                    foregroundColor: _accent,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text('Edit items',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
              _itemsCard(c),
              const SizedBox(height: 20),
              _sectionTitle('Bill Summary'),
              _summaryCard(c),
            ],
          ),
        ),
        bottomNavigationBar: _bottomBar(c),
      ),
    );
  }

  // ---------------------------------------------------------------- shared

  Widget _sectionTitle(String text, {Widget? trailing}) => Padding(
        padding: const EdgeInsets.only(left: 2, bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700, color: _ink),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      );

  Widget _card({required Widget child, EdgeInsets? padding}) => Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      );

  // -------------------------------------------------------------- customer

  Widget _customerCard(YourOrderController c) {
    final isCustomer = c.isCustomer ?? false;
    final name = isCustomer && !c.isEditing
        ? (c.companyName ?? '')
        : (c.selectCompany?.partyname ?? '');
    final canPick = !c.isEditing && !isCustomer;
    final empty = name.isEmpty;

    return InkWell(
      onTap: canPick ? c.tapOnSearch : null,
      borderRadius: BorderRadius.circular(14),
      child: _card(
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                  color: _accentSoft, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(
                empty ? Icons.person_search_rounded : Icons.storefront_rounded,
                color: _accent,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    empty ? 'Select customer' : name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: empty ? _muted : _ink,
                    ),
                  ),
                  if (c.isEditing)
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        'Customer can\'t be changed on an existing order',
                        style: TextStyle(fontSize: 11, color: _muted),
                      ),
                    )
                  else if (empty)
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        'Tap to choose who this order is for',
                        style: TextStyle(fontSize: 11, color: _muted),
                      ),
                    ),
                ],
              ),
            ),
            if (canPick)
              Text(
                empty ? 'Select' : 'Change',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: _accent),
              )
            else if (c.isEditing)
              const Icon(Icons.lock_outline_rounded, size: 18, color: _muted),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------------- items

  Widget _itemsCard(YourOrderController c) {
    final items = c.cartController.cartList;
    return _card(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: _line),
            _itemRow(items[i]),
          ],
        ],
      ),
    );
  }

  Widget _itemRow(GetCartListData item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppNetworkImage(
                image: item.productimage ?? '',
                fit: BoxFit.cover,
                height: 44,
                width: 44,
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
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _ink,
                        height: 1.3),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${_qty(item.quantity)} ${item.unit ?? ''} × '
                    '${_money(item.itemrate ?? 0)}',
                    style: const TextStyle(fontSize: 12, color: _muted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _money(item.total ?? 0),
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700, color: _ink),
            ),
          ],
        ),
      );

  // --------------------------------------------------------------- summary

  Widget _summaryCard(YourOrderController c) => _card(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          children: [
            _amountRow('Amount', _money(c.amount)),
            const SizedBox(height: 12),
            _percentRow(
              'Discount',
              c.discountController,
              c.discountFocus,
              c.discountCalculate,
              off: c.discountValue,
            ),
            const SizedBox(height: 12),
            _amountRow('Subtotal', _money(c.subTotal)),
            const SizedBox(height: 12),
            _percentRow(
              'Cash Discount',
              c.cashDiscountController,
              c.cashDiscountFocus,
              c.cashDiscountCalculate,
              off: c.cashDiscountValue,
            ),
            if (c.shipping > 0) ...[
              const SizedBox(height: 12),
              _amountRow('Shipping', _money(c.shipping)),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(height: 1, color: _line),
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Grand Total',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _ink)),
                ),
                Text(
                  _money(c.grandTotal),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800, color: _ink),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${_qty(c.totalQty)} units in ${c.cartController.cartList.length} '
                  '${c.cartController.cartList.length == 1 ? 'item' : 'items'}',
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _amountRow(String label, String value) => Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 14, color: _muted)),
          ),
          Text(value,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: _ink)),
        ],
      );

  Widget _percentRow(String label, TextEditingController ctrl, FocusNode focus,
          void Function(String) onChanged,
          {required double off}) =>
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 14, color: _muted)),
                if (off > 0)
                  Text('− ${_money(off)}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _green)),
              ],
            ),
          ),
          Container(
            width: 84,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E5EC)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    focusNode: focus,
                    onChanged: onChanged,
                    onTap: () => ctrl.selection = TextSelection(
                        baseOffset: 0, extentOffset: ctrl.text.length),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      counterText: '',
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: '0',
                    ),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _ink),
                  ),
                ),
                const Text('%',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _muted)),
              ],
            ),
          ),
        ],
      );

  // ---------------------------------------------------------------- bottom

  Widget _bottomBar(YourOrderController c) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payable',
                          style: TextStyle(fontSize: 12, color: _muted)),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _money(c.grandTotal),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: _ink),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: c.isBusy ? null : c.tapOnPlaceOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      disabledBackgroundColor: _accent.withValues(alpha: 0.6),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: c.isBusy
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2.4, color: Colors.white),
                          )
                        : Text(
                            c.isEditing ? 'Update Order' : 'Place Order',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
