import 'dart:io';
import 'package:get/get.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../response/order_detail_response.dart';
import 'extra_file/utils_pdf.dart';
import 'pdf_api.dart';

class PdfReportAnalysisApi {
  static const cgstPercent = 9;
  double cgst = 0.0;
  double sgst = 0.0;
  double netTotal = 0.0;
  double total = 0.0;

  Future<File> generate(OrderDetailData invoice) async {
    //var data = await rootBundle.load("fonts/comfortaa_bold.ttf");
    //var myFont = Font.ttf(data);
    var myStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    final pdf = Document();

    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      margin: const EdgeInsets.all(20),
      build: (context) => [
        buildHeader(invoice),
        buildTable(invoice, myStyle),
        buildQuantityTable(invoice),
        buildTotalTable(invoice),
        //buildNewContainer(invoice),
        //buildTable1(invoice),
        Container(
            decoration: BoxDecoration(border: Border.all()),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              /*SizedBox(height: 10),
              buildTotal(invoice),*/
              SizedBox(height: 20),
              buildfotter(invoice),
              buildfotter2(invoice),
              SizedBox(height: 40),
              buildNumberConvert(invoice),
              SizedBox(height: 50),
              buildLastContaner(invoice),
            ])),
      ],
    ));
    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(OrderDetailData invoice) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "GSTIN: 0000000000",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text('Original Copy', style: const TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 18),
            Text('Sales order',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                '${invoice.partyname}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.center,
              child: Text('${invoice.orderno}', style: const TextStyle(fontSize: 14)),
            ),
          ]),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 5, top: 5),
                height: 150,
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Party Details :',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('${invoice.executivename}',
                          style: const TextStyle(fontSize: 14)),
                      Text('', style: const TextStyle(fontSize: 14)),
                      SizedBox(height: 30),
                      Text('GSTIN/UIN : ${invoice.partyid}',
                          style: const TextStyle(fontSize: 14)),
                    ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 5, top: 5),
                height: 150,
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order No.  :   ${invoice.orderno}',
                        style: const TextStyle(fontSize: 14)),
                    SizedBox(height: 20),
                    Text('Dated        :   ${invoice.orderdate}',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 15,
          decoration: BoxDecoration(border: Border.all()),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'We are pleased to receive the order for the following items :',
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ]);

  static Widget buildTable(OrderDetailData invoice, TextStyle myStyle) {
    final headers = [
      'S.N',
      'Description of Goods',
      'HSN Code',
      'Quantity',
      'Unit',
      'Mrp',
      'Price',
      'Amount(Rs.)'
    ];
    final data = invoice.details!.map((item) {
      final total = item.rate! * item.quantity!.toInt();
      var index = invoice.details!.indexOf(item) + 1;

      return [
        '$index',
        item.productname,
        'hsn',
        '${item.quantity}',
        '${item.unit}',
        'mrp',
        ' ${item.rate}',
        ' ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      cellStyle: const TextStyle(fontSize: 8),
      headers: headers,
      headerAlignment: Alignment.center,
      data: data,
      border: TableBorder.all(),
      headerStyle: myStyle,
      /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
      cellHeight: 30,
      columnWidths: {
        1: const IntrinsicColumnWidth(flex: 0.263),
        2: const IntrinsicColumnWidth(flex: 0.1),
        3: const IntrinsicColumnWidth(flex: 0.1),
        4: const IntrinsicColumnWidth(flex: 0.1),
        5: const IntrinsicColumnWidth(flex: 0.1),
        6: const IntrinsicColumnWidth(flex: 0.1),
      },
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.topLeft,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.center,
      },
    );
  }

  static Widget buildQuantityTable(OrderDetailData invoice) {
    final table = [
      'Total Quantity',
    ];
    final data = table.map((item) {
      final totalQuantity = invoice.details!
          .map((item) => item.quantity)
          .reduce((value, element) => value! + element!);

      return [
        '',
        '',
        item,
        '       $totalQuantity',
        '',
        '',
        '',
        '',
      ];
    }).toList();
    return Table.fromTextArray(
      cellStyle: const TextStyle(fontSize: 8),
      data: data,
      headerStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
      border: TableBorder.all(),
      /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
      cellHeight: 20,
      columnWidths: {
        0: const IntrinsicColumnWidth(flex: 0),
        1: const IntrinsicColumnWidth(flex: 0),
        2: const IntrinsicColumnWidth(flex: 0.40),
        3: const IntrinsicColumnWidth(flex: 0.493),
        4: const IntrinsicColumnWidth(flex: 0.0),
        5: const IntrinsicColumnWidth(flex: 0.0),
        6: const IntrinsicColumnWidth(flex: 0.0),
        7: const IntrinsicColumnWidth(flex: 0.0),
      },
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.topRight,
        3: Alignment.topLeft,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.center,
      },
    );
  }

  Widget buildTotalTable(OrderDetailData invoice) {
    final table = ['Taxable Amount'];
    final table2=['CGST @9 %'];
    final table3=['SGST @9 %'];
    final table4=['Rounded Off'];
    final table5=['Grand Total'];
    netTotal = invoice.details!
        .map((item) => item.rate! * item.quantity!.toInt())
        .reduce((item1, item2) => item1 + item2);
    const cgstPercent = 0 /*invoice.items.first.vat*/;
    cgst = netTotal * cgstPercent / 100;
    sgst = netTotal * cgstPercent / 100;
    total = netTotal + cgst + sgst;
    final data1 = table.map((item) {

      return [
        item,
        '$netTotal'
      ];
    }).toList();
    final data2 = table2.map((item) {

      return [
        item,
        '$cgst'
      ];
    }).toList();
    final data3 = table3.map((item) {

      return [
        item,
        '$sgst'
      ];
    }).toList();
    final data4 = table4.map((item) {

      return [
        item,
        '0.0'
      ];
    }).toList();
    final data5 = table5.map((item) {

      return [
        item,
        '$total'
      ];
    }).toList();
    return Column(children: [
    Table.fromTextArray(
          cellStyle: const TextStyle(fontSize: 8),
          data: data1,
          headerStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          border: TableBorder.all(),
          /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
          cellHeight: 10,
          columnWidths: {
            0: const IntrinsicColumnWidth(flex: 0.8),
            1: const IntrinsicColumnWidth(flex: 0.1),
          },
           cellAlignments: {
            0: Alignment.topRight,
            1: Alignment.topRight,
          },
    ),
      Table.fromTextArray(
        cellStyle: const TextStyle(fontSize: 8),
        data: data2,
        headerStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        border: TableBorder.all(),
        /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
        cellHeight: 10,
        columnWidths: {
          0: const IntrinsicColumnWidth(flex: 0.8),
          1: const IntrinsicColumnWidth(flex: 0.1),
        },
        cellAlignments: {
          0: Alignment.topRight,
          1: Alignment.topRight,
        },
      ),
      Table.fromTextArray(
        cellStyle: const TextStyle(fontSize: 8),
        data: data3,
        headerStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        border: TableBorder.all(),
        /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
        cellHeight: 10,
        columnWidths: {
          0: const IntrinsicColumnWidth(flex: 0.8),
          1: const IntrinsicColumnWidth(flex: 0.1),
        },
        cellAlignments: {
          0: Alignment.topRight,
          1: Alignment.topRight,
        },
      ),
      Table.fromTextArray(
        cellStyle: const TextStyle(fontSize: 8),
        data: data4,
        headerStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        border: TableBorder.all(),
        /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
        cellHeight: 10,
        columnWidths: {
          0: const IntrinsicColumnWidth(flex: 0.8),
          1: const IntrinsicColumnWidth(flex: 0.1),
        },
        cellAlignments: {
          0: Alignment.topRight,
          1: Alignment.topRight,
        },
      ),
      Table.fromTextArray(
        cellStyle: const TextStyle(fontSize: 8),
        data: data5,
        headerStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        border: TableBorder.all(),
        /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
        cellHeight: 10,
        columnWidths: {
          0: const IntrinsicColumnWidth(flex: 0.8),
          1: const IntrinsicColumnWidth(flex: 0.1),
        },
        cellAlignments: {
          0: Alignment.topRight,
          1: Alignment.topRight,
        },
      ),


    ]);
  }

/*
  static Widget buildNewContainer(OrderDetailData invoice) {
    final totalQuantity = invoice.details!
        .map((item) => item.quantity)
        .reduce((value, element) => value! + element!);

    return Row(children: [
      Container(
        width: Get.width * 0.605,
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Text('Total Quantity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 25),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            '${totalQuantity}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ),
      */
/*Container(
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(), top: BorderSide(), bottom: BorderSide()),
          ),
          width: 11,
          height: 14)*/ /*

    ]);
  }
*/

/*
  static Widget buildTable1(Invoice invoice) {
    final totalQuantity = invoice.items
        .map((item) => item.quantity)
        .reduce((value, element) => value + element);

    List<String> arr = [];
    List<String> asd = ['Total Quantity', "${totalQuantity}"];

    var a = arr.map((e) {
      return [e];
    }).toList();

    return Table.fromTextArray(
      data: a,
      headers: asd,
      border: TableBorder.all(),
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      */
/*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/ /*

      cellHeight: 30,
      cellAlignments: {
        0: Alignment.topCenter,
        1: Alignment.topCenter,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }
*/

  Widget buildTotal(OrderDetailData invoice) {
    netTotal = invoice.details!
        .map((item) => item.rate! * item.quantity!.toInt())
        .reduce((item1, item2) => item1 + item2);
    const cgstPercent = 0 /*invoice.items.first.vat*/;
    cgst = netTotal * cgstPercent / 100;
    sgst = netTotal * cgstPercent / 100;
    total = netTotal + cgst + sgst;

    return Container(
      padding: const EdgeInsets.only(right: 8),
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Taxable Amount  ',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'CGST @9 %',
                  value: Utils.formatPrice(cgst),
                  unite: true,
                ),
                buildText(
                  title: 'SGST @9 %',
                  value: Utils.formatPrice(sgst),
                  unite: true,
                ),
                buildText(
                  title: 'Rounded off',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Grand Total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                /*SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  buildfotter(OrderDetailData invoice) {
    List<String> arr = [];
    List<String> asd = [
      'Tax Rate',
      "Taxable Amount",
      'CGST Amt.',
      'SGST Amt.',
      'IGST Amt.',
      'Total Tax'
    ];

    var a = arr.map((e) {
      return [e];
    }).toList();

    return Table.fromTextArray(
      data: a,
      headers: asd,
      border: const TableBorder(bottom: BorderSide()),
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.topCenter,
        1: Alignment.topCenter,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  buildfotter2(OrderDetailData invoice) {
    List<Info> asd = [
      Info(
          '0%',
          netTotal.toStringAsFixed(2),
          cgst.toStringAsFixed(2),
          sgst.toStringAsFixed(2),
          '0',
          (cgst + sgst).toStringAsFixed(2))
    ];

    var a = asd.map((e) {
      return [e.taxRate, e.tAmount, e.cgst, e.sgst, e.igst, e.totaltax];
    }).toList();

    return Table.fromTextArray(
      data: a,
      border: TableBorder.symmetric(
          inside: BorderSide.none, outside: BorderSide.none),
      headerStyle: const TextStyle(),
      /*headerDecoration: BoxDecoration(color: PdfColors.grey300)*/
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.topCenter,
        1: Alignment.topCenter,
        2: Alignment.topCenter,
        3: Alignment.topCenter,
        4: Alignment.topRight,
        5: Alignment.topRight,
      },
    );
  }

  buildNumberConvert(OrderDetailData invoice) {
    String digit = NumberToWord().convert('en-in', netTotal.toInt());
    return Text(
      'Rupees: ${digit.capitalize.toString()} Only',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  buildLastContaner(OrderDetailData invoice) {
    return Align(
        //alignment: Alignment.topRight,

        child: Container(
      width: double.maxFinite,
      decoration: BoxDecoration(border: Border.all()),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'For:  ${invoice.partyname}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Authorised Signatory',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
  }
}

class Info {
  String? taxRate;
  String? tAmount;
  String? cgst;
  String? sgst;
  String? igst;
  String? totaltax;

  Info(this.taxRate, this.tAmount, this.cgst, this.sgst, this.igst,
      this.totaltax);
}
