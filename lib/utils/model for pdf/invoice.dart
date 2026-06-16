import 'package:digitalerp/utils/model%20for%20pdf/suplier.dart';

import 'customer.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final int sn;
  final String description;
  final String hsn;
  final String unit;
  final int quantity;
  final double mrp;
  final double price;
  final double amount;

  const InvoiceItem({
    required this.sn,
    required this.description,
    required this.hsn,
    required this.unit,
    required this.quantity,
    required this.mrp,
    required this.price,
    required this.amount,
  });
}
