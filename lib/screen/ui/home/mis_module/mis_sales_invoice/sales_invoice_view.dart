//
//
// import 'dart:io';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/screen/ui/home/mis_module/mis_sales_invoice/sales_invoice_controller/sales_invoice_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/items.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/pdf%20converter/extra_file/open_file.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:path_provider/path_provider.dart';
// import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:syncfusion_flutter_xlsio/xlsio.dart'as excel;
//
// import 'sales_invoce_filter_screen.dart';
//
// class SalesInvoiceView extends StatelessWidget {
//   SalesInvoiceView({Key? key}) : super(key: key);
//
//   HomeController homeController = Get.put<HomeController>(HomeController());
//
//   int counter = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SalesInvoiceController>(
//         init: SalesInvoiceController(),
//         builder: (SalesInvoiceController controller) {
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: Center(
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/dashboard_bg.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       child: SafeArea(
//                         child: MyAppBar(
//                           onFilterTap: () {
//                             Get.dialog(SalesInvoiceFilterScreen());
//                           },
//                           deFaultIcon: GestureDetector(
//                             onTap: () {
//                                 counter++;
//                               generateExcel(controller);
//                               controller.update();
//                               print("Print Excel");
//                             },
//                             child: Image.asset(
//                               AppAssets.excelIcon, scale: 19,),),
//                           title: 'Sales Invoice',
//                           onBackTap: () => Get.back(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       right: 0,
//                       left: 0,
//                       bottom: Get.height * 0.0,
//                       top: Get.height * 0.140,
//                       child:
//                         controller.isBusy
//                     ? showLoader()
//                      :  controller.salesInvoiceData?.isEmpty==true || controller.salesInvoiceData==null
//                     ? centerText("No Data Found")
//                      :   SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Column(children: [
//                           SizedBox(
//                             height: Get.height * 0.0100,
//                           ),
//                           ListView.builder(
//                               itemCount: controller.salesInvoiceData?.length??0,
//                               padding: EdgeInsets.zero,
//                               // itemCount: controller
//                               //     .stockReconciliationReportList.length,
//                               shrinkWrap: true,
//                               scrollDirection: Axis.vertical,
//                               physics:
//                               const NeverScrollableScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 var data = controller.salesInvoiceData![index];
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 13, vertical: 5),
//                                   child: CommonItem(
//                                     isCardShow: true,
//                                     data: [
//                                       CommonItemRowModel(
//                                         leftTitle: "InvoiceNo",
//                                         leftValue: data.invoiceno??"N/A",
//                                         rightTitle: "InvoiceDate",
//                                         rightValue: data.invoicedate??"N/A",
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: "BuyerName",
//                                         leftValue:  data.buyername??"N/A",
//                                         rightTitle: "ItemName",
//                                         rightValue: data.itemname??"N/A",
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.rate,
//                                         leftValue: data.rate.toString()??"",
//                                         rightTitle: AppString.qty,
//                                         rightValue:  data.qty.toString()??"",
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: "Gst ℅",
//                                         leftValue: " ${data.gstpercent??"N/A"} %",
//                                         rightTitle: "GstAmount",
//                                         rightValue: data.gstamt.toString()??"",
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: "Taxable Amount",
//                                         leftValue: data.taxableamt.toString()??"",
//                                         rightTitle: AppString.amount,
//                                         rightValue: data.amount.toString()??"",
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//                           ),
//
//
//                         ]),
//                       )),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Future<void> generateExcel(SalesInvoiceController controller) async {
//     {
//       final excel.Workbook workbook = excel.Workbook();
//     final excel.Worksheet sheet = workbook.worksheets[0];
//       sheet.enableSheetCalculations();
//       sheet
//           .getRangeByIndex(
//         1,
//         1,
//       )
//           .setText('Invoice No');
//       sheet
//           .getRangeByIndex(
//         1,
//         1,
//       )
//           .columnWidth = 15;
//       sheet
//           .getRangeByIndex(
//         1,
//         2,
//       )
//           .setText('Invoice Date');
//       sheet
//           .getRangeByIndex(
//         1,
//         2,
//       )
//           .columnWidth = 15;
//       sheet
//           .getRangeByIndex(
//         1,
//         3,
//       )
//           .setText('Buyer Name');
//       sheet
//           .getRangeByIndex(
//         1,
//         3,
//       )
//           .columnWidth = 40;
//
//       sheet
//           .getRangeByIndex(
//         1,
//         4,
//       )
//           .setText('Item Name');
//       sheet
//           .getRangeByIndex(
//         1,
//         4,
//       )
//           .columnWidth = 35;
//       sheet
//           .getRangeByIndex(
//         1,
//         5,
//       )
//           .setText('Rate');
//
//       sheet
//           .getRangeByIndex(
//         1,
//         5,
//       )
//           .columnWidth = 15;
//       sheet
//           .getRangeByIndex(
//         1,
//         6,
//       )
//           .setText('Quantity');
//       sheet
//           .getRangeByIndex(
//         1,
//         6,
//       )
//           .columnWidth = 15;
//
//       sheet
//           .getRangeByIndex(
//         1,
//         7,
//       )
//           .setText('GST %');
//
//       sheet.getRangeByIndex(1, 7).columnWidth=15;
//       sheet
//           .getRangeByIndex(
//         1,
//         8,
//       )
//           .setText('GST Amount');
//       sheet.getRangeByIndex(1, 8).columnWidth=15;
//
//       sheet
//           .getRangeByIndex(
//         1,
//         9,
//       )
//           .setText('Texable Amount');
//       sheet.getRangeByIndex(1, 9).columnWidth=15;
//       sheet
//           .getRangeByIndex(
//         1,
//         10,
//       )
//           .setText('Amount');
//       sheet
//           .getRangeByIndex(
//         1,
//         10,
//       )
//           .columnWidth = 15;
//
//       int columnIndex = 1;
//       for (int index = 2; index < controller.salesInvoiceData!.length + 2; index++) {
//         final key = controller.salesInvoiceData?[index - 2];
//         columnIndex += 1;
//
//         for (int innerIndex = 2; innerIndex <
//             controller.salesInvoiceData!.length + 1; innerIndex++) {
//           // columnIndex += 1;
//           final user = controller.salesInvoiceData![innerIndex-2];
//
//           sheet.getRangeByIndex(innerIndex, 1).setText(user.invoiceno.toString());
//           sheet.getRangeByIndex(innerIndex, 2).setText(user.invoicedate.toString());
//           sheet.getRangeByIndex(innerIndex, 3).setText(user.buyername);
//           sheet.getRangeByIndex(innerIndex, 4).setText(user.itemname);
//           sheet.getRangeByIndex(innerIndex, 5).setText(user.rate.toString());
//           sheet.getRangeByIndex(innerIndex, 6,).setText(user.qty.toString());
//           sheet.getRangeByIndex(innerIndex, 7,).setText(user.gstpercent.toString());
//           sheet.getRangeByIndex(innerIndex, 8,).setText(user.gstamt.toString());
//           sheet.getRangeByIndex(innerIndex, 9,).setText(user.taxableamt.toString());
//           sheet.getRangeByIndex(innerIndex, 10,).setText(user.amount.toString());
//
//           // sheet.getRangeByIndex(columnIndex, 7).setText(user.dob);
//           // sheet.getRangeByIndex(columnIndex, 8).setText(user.gender);
//           // sheet.getRangeByIndex(columnIndex, 9).setText(user.interestedIn);
//           // sheet.getRangeByIndex(columnIndex, 10).setText(user.deviceId);
//           // sheet.getRangeByIndex(columnIndex, 11).setText(
//           //     activeTime.join(',\n'));
//         }
//         controller.salesInvoiceData;
//       }
//
//
//       sheet
//           .getRangeByName('A1:K1')
//           .cellStyle
//           .hAlign = excel.HAlignType.justify;
//       sheet
//           .getRangeByName('A1:K1')
//           .cellStyle
//           .fontSize = 10;
//       sheet
//           .getRangeByName('A1:K1')
//           .cellStyle
//           .bold = true;
//
//
//       final List<int> bytes = workbook.saveAsStream();
//
//       final Directory? directory = await getExternalStorageDirectory();
//       if (directory == null) {
//         print("Could not get the external storage directory.");
//         return;
//       }
//
//       final String path = directory.path;
//       final String filePath = '$path/DailyReport-${counter}_${DateFormat('ddMMMyyyy').format(DateTime.now())}.xlsx';
//
//       final File file = File(filePath);
//       await file.writeAsBytes(bytes, flush: true);
//
//       final result = await OpenFile.open(filePath);
//       switch (result.type) {
//         case ResultType.done:
//           print("File opened successfully.");
//           break;
//         case ResultType.error:
//           ShowMessage.showSnackBar("Error opening file:", result.message);
//           break;
//         default:
//           ShowMessage.showSnackBar("Unknown result type:", result.message,);
//       }
//
//
//     /// invoice View
//     //   final List<int> bytes = workbook.saveAsStream();
//     //   // final filePath = await saveAndLaunchFile();
//     //   final Directory? directory = await getExternalStorageDirectory();
//     //   // final Directory? newDirectory = Directory('/storage/emulated/0/Download');
//     //   final String path = directory!.path;
//     //   // final String newPath = newDirectory!.path;
//     //   final File file = File('$path/DailyReport-${counter}_${DateFormat('ddMMMyyyy').format(DateTime.now())}.xlsx');
//     //   await file.writeAsBytes(bytes, flush: true);
//     //   await OpenFile.open('$path/DailyReport-${counter}_${DateFormat('ddMMMyyyy').format(DateTime.now())}.xlsx');
//
//       // print("succesd");
//       // workbook.dispose();
// ///-------------------------------------------------------
//
//       // final List<int> bytes = workbook.saveAsStream();
//       final String fileNameBase = 'DailyReport_${DateFormat('ddMMMyyyy').format(DateTime.now())}-${counter}.xlsx';
//       // final String filePath = await saveAndLaunchFile(bytes, fileNameBase);
//
//       print("Counter ${counter}");
//     // workbook.dispose();
//       print("Sucessed");
//     //   if (filePath != '') {
//     //   ShowMessage.showSnackBar("","Invoice saved successfully");
//     //   // Helper.showBottomFlash(true, 'Alert', "Report saved successfully");
//     //
//     // } else {
//     //   ShowMessage.showSnackBar("","Invoice not saved,please try again");
//     //   // Helper.showBottomFlash(
//     //   //     false, 'Alert', "Report not saved,please try again");
//     // }
//
//     }
//   }
//
// Future<String> saveAndLaunchFile(List<int> bytes, String fileNameBase) async {
//   try {
//     final permission = Permission.storage;
//     // final permissionStatus = await Helper.isPhotoPermissionGranted();
//
//     // final storageStatus = await getStoragePermission();
//     print("Permisson ${permission}");
//
//     if (permission.value!=15) {
//       ShowMessage.showSnackBar("","Enable Storage Permission");
//       // Helper.showBottomFlash(false, 'Alert', "Enable Storage Permission");
//     }
//
//     // return saveFile(fileName, bytes);
//
//     String? path;
//     if (Platform.isAndroid ||
//         Platform.isIOS ||
//         Platform.isLinux ||
//         Platform.isWindows) {
//       path = await getDownloadPath();
//       if (path == null) {
//         final Directory directory =
//             await path_provider.getApplicationSupportDirectory();
//         path = directory.path;
//
//       }
//
//
//     } else {
//       path = (await PathProviderPlatform.instance.getApplicationSupportPath())!;
//     }
//     final File file =
//         File(Platform.isWindows ? '$path\\$fileNameBase' : '$path/$fileNameBase');
//
//     await file.writeAsBytes(
//       bytes,
//     );
//
//     return file.path;
//   } catch (e) {
//     return "";
//   }
// }
//
//   // Future<String> saveAndLaunchFile(List<int> bytes, String fileNameBase) async {
// Future<String> saveFile(String fileName, List<int> bytes) async {
//   Directory? directory;
//   File? file;
//   try {
//     if (Platform.isAndroid) {
//       directory = Directory('/storage/emulated/0/Download');
//     } else {
//       directory = await path_provider.getApplicationDocumentsDirectory();
//     }
//
//     bool hasExisted = await directory.exists();
//     if (!hasExisted) {
//       directory.create();
//     }
//     file = File("${directory.path}${Platform.pathSeparator}$fileName");
//     if (!file.existsSync()) {
//       await file.create();
//     }
//     await file.writeAsBytes(bytes);
//     return file.path;
//   } catch (e) {
//     if (file != null && file.existsSync()) {
//       file.deleteSync();
//     }
//     return "";
//   }
// }
//
// Future<String?> getDownloadPath() async {
//   Directory? directory;
//   try {
//     if (Platform.isIOS) {
//       directory = await path_provider.getApplicationDocumentsDirectory();
//       // directory = await path_provider.getDownloadsDirectory();
//     } else {
//       directory = Directory('/storage/emulated/0/Download');
//       final existsPathStatus = await directory.exists();
//
//       if (!existsPathStatus) {
//         directory = (await path_provider.getExternalStorageDirectory())!;
//       }
//     }
//   } catch (err) {
//   }
//   return directory?.path;
// }
//
//
// }

import 'dart:io';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/mis_module/mis_sales_invoice/sales_invoice_controller/sales_invoice_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/pdf%20converter/extra_file/open_file.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:path_provider/path_provider.dart' as path_provider;
import '../../../fab/menu_fab.dart';
import 'sales_invoce_filter_screen.dart';

class SalesInvoiceView extends StatelessWidget {
  SalesInvoiceView({Key? key}) : super(key: key);

  final HomeController homeController =
      Get.put<HomeController>(HomeController());
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesInvoiceController>(
      init: SalesInvoiceController(),
      builder: (controller) => Scaffold(
        backgroundColor: lightGreyColor,
        body: Column(
          children: [
            //  AppBar 
            MyAppBar(
              title: 'Sales Invoice',
              onBackTap: () => Get.back(),
              onFilterTap: () => Get.dialog(SalesInvoiceFilterScreen()),
              deFaultIcon: GestureDetector(
                onTap: () {
                  counter++;
                  generateExcel(controller);
                  controller.update();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: newGreenLightColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(AppAssets.excelIcon, scale: 19),
                ),
              ),
            ),

            //  Body 
            Expanded(
              child: controller.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: purpleColor, strokeWidth: 2))
                  : (controller.salesInvoiceData?.isEmpty == true ||
                          controller.salesInvoiceData == null)
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.receipt_long_rounded,
                                  size: 48,
                                  color:
                                      newTextSecondary.withValues(alpha: 0.3)),
                              const SizedBox(height: 12),
                              const Text('No Data Found',
                                  style: TextStyle(
                                      color: newTextSecondary, fontSize: 14)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                          itemCount: controller.salesInvoiceData?.length ?? 0,
                          itemBuilder: (_, index) {
                            final data = controller.salesInvoiceData![index];
                            return _invoiceCard(data);
                          },
                        ),
            ),
          ],
        ),
        floatingActionButton: MenuFab(parentMenuId: 2383),
      ),
    );
  }

  Widget _invoiceCard(dynamic data) {
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
          //  Card header 
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
                const Icon(Icons.receipt_rounded, color: purpleColor, size: 15),
                const SizedBox(width: 6),
                Text('Invoice #${data.invoiceno ?? '—'}',
                    style: const TextStyle(
                        color: purpleColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                Text(data.invoicedate ?? '',
                    style: const TextStyle(
                        color: newTextSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          //  Card body 
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _rowInfo(
                    'Buyer Name', data.buyername, 'Item Name', data.itemname),
                Divider(height: 16, color: newBorderColor),
                _rowInfo(AppString.rate, data.rate?.toString(), AppString.qty,
                    data.qty?.toString()),
                Divider(height: 16, color: newBorderColor),
                _rowInfo('GST %', '${data.gstpercent ?? '—'} %', 'GST Amount',
                    data.gstamt?.toString()),
                Divider(height: 16, color: newBorderColor),
                _rowInfo('Taxable Amount', data.taxableamt?.toString(),
                    AppString.amount, data.amount?.toString()),
              ],
            ),
          ),

          //  Total footer 
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: newBlueLightColor,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Total Amount: ',
                    style: TextStyle(
                        color: newTextSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                Text('₹ ${data.amount ?? '—'}',
                    style: const TextStyle(
                        color: newBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  //  Excel generation (functionality unchanged) 
  Future<void> generateExcel(SalesInvoiceController controller) async {
    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];
    sheet.enableSheetCalculations();

    final headers = [
      'Invoice No',
      'Invoice Date',
      'Buyer Name',
      'Item Name',
      'Rate',
      'Quantity',
      'GST %',
      'GST Amount',
      'Taxable Amount',
      'Amount'
    ];
    final widths = [15.0, 15.0, 40.0, 35.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0];

    for (int i = 0; i < headers.length; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
      sheet.getRangeByIndex(1, i + 1).columnWidth = widths[i];
    }

    for (int i = 0; i < (controller.salesInvoiceData?.length ?? 0); i++) {
      final user = controller.salesInvoiceData![i];
      final row = i + 2;
      sheet.getRangeByIndex(row, 1).setText(user.invoiceno.toString());
      sheet.getRangeByIndex(row, 2).setText(user.invoicedate.toString());
      sheet.getRangeByIndex(row, 3).setText(user.buyername);
      sheet.getRangeByIndex(row, 4).setText(user.itemname);
      sheet.getRangeByIndex(row, 5).setText(user.rate.toString());
      sheet.getRangeByIndex(row, 6).setText(user.qty.toString());
      sheet.getRangeByIndex(row, 7).setText(user.gstpercent.toString());
      sheet.getRangeByIndex(row, 8).setText(user.gstamt.toString());
      sheet.getRangeByIndex(row, 9).setText(user.taxableamt.toString());
      sheet.getRangeByIndex(row, 10).setText(user.amount.toString());
    }

    sheet.getRangeByName('A1:J1').cellStyle.bold = true;
    sheet.getRangeByName('A1:J1').cellStyle.fontSize = 10;

    final List<int> bytes = workbook.saveAsStream();
    final Directory? directory = await getExternalStorageDirectory();
    if (directory == null) return;

    final String filePath =
        '${directory.path}/SalesInvoice-${counter}_${DateFormat('ddMMMyyyy').format(DateTime.now())}.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);

    final result = await OpenFile.open(filePath);
    if (result.type == ResultType.error) {
      ShowMessage.showSnackBar('Error opening file:', result.message);
    }
  }

  Future<String> saveAndLaunchFile(List<int> bytes, String fileNameBase) async {
    try {
      String? path;
      if (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isLinux ||
          Platform.isWindows) {
        path = await getDownloadPath();
        if (path == null) {
          final Directory directory =
              await path_provider.getApplicationSupportDirectory();
          path = directory.path;
        }
      } else {
        path =
            (await PathProviderPlatform.instance.getApplicationSupportPath())!;
      }
      final File file = File(
          Platform.isWindows ? '$path\\$fileNameBase' : '$path/$fileNameBase');
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e) {
      return '';
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await path_provider.getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await path_provider.getExternalStorageDirectory();
        }
      }
    } catch (_) {}
    return directory?.path;
  }
}
