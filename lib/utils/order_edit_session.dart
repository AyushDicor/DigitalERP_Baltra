import 'package:digitalerp/utils/shared_pre.dart';

/// The placed order whose items are currently loaded in the server cart.
///
/// Editing works through the normal cart: `orderedittocart` replaces the cart
/// with the order's lines, the user adds/removes/changes qty with the existing
/// cart APIs, and checkout calls `placeorderedit` instead of `orderentry`.
/// This record tells the cart and checkout screens they are in edit mode. It
/// is persisted because the server cart also survives an app restart.
class OrderEditSession {
  final String orderId;
  final String orderNo;
  final String partyId;
  final String partyName;

  const OrderEditSession({
    required this.orderId,
    required this.orderNo,
    required this.partyId,
    required this.partyName,
  });

  static OrderEditSession? get current {
    final m = SharedPre.getObjs(SharedPre.editingOrder);
    if (m == null || (m['orderId'] ?? '').toString().isEmpty) return null;
    return OrderEditSession(
      orderId: m['orderId'].toString(),
      orderNo: (m['orderNo'] ?? '').toString(),
      partyId: (m['partyId'] ?? '').toString(),
      partyName: (m['partyName'] ?? '').toString(),
    );
  }

  static bool get isActive => current != null;

  Future<void> save() => SharedPre.setValue(SharedPre.editingOrder, {
        'orderId': orderId,
        'orderNo': orderNo,
        'partyId': partyId,
        'partyName': partyName,
      });

  static Future<void> clear() => SharedPre.clear(SharedPre.editingOrder);
}
