import 'dart:convert';

class OfflineCart {
  int? itemId;
  String? itemName;
  String? itemCode;
  String? itemDescription;
  String? itemImage;
  String? unit;
  double? rate;
  double? requiredPoint;
  double? quantity;
  bool? isInCart;

  OfflineCart({
    this.itemId,
    this.itemName,
    this.itemCode,
    this.itemDescription,
    this.itemImage,
    this.unit,
    this.rate,
    this.requiredPoint,
    this.quantity,
    this.isInCart,
  });

  factory OfflineCart.fromJson(Map<String, dynamic> json) {
    return OfflineCart(
      itemId: json["itemid"],
      itemName: json["itemname"],
      itemCode: json["itemcode"],
      itemDescription: json["itemdescription"],
      itemImage: json["itemimage"],
      unit: json["unit"],
      rate: json["rate"],
      requiredPoint: json["requiredpoint"],
      quantity: json["quantity"],
      isInCart: false,
    );
  }

  Map<String, dynamic> toJson() => {
        "itemid": itemId,
        "itemname": itemName,
        "itemcode": itemCode,
        "itemdescription": itemDescription,
        "itemimage": itemImage,
        "unit": unit,
        "rate": rate,
        "requiredpoint": requiredPoint,
        "quantity": quantity,
      };

  static List<OfflineCart> decode(String musics) =>
      (json.decode(musics) as List<dynamic>).map<OfflineCart>((item) => OfflineCart.fromJson(item)).toList();
}
