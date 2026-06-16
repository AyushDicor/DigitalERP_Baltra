import 'dart:async';
import 'dart:io';

import 'package:digitalerp/response/order_detail_response.dart';
import 'package:digitalerp/response/party_balance_detail_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../response/order_detail_pdf_url_response.dart';
import '../../../../../utils/pdf converter/pdf_analysis_report.dart';

class OrderDetailController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  OrderController orderController = Get.find<OrderController>();
  String? orderId;
  OrderDetailData? orderDetailData;
  PdfData? orderDetailPdfDownload;
  PartyBalanceDetailData? partyBalanceDetailData;
  PdfReportAnalysisApi pdfReportAnalysisApi = PdfReportAnalysisApi();
  String? downloadUrl;
  List<String> statusList = [
    'Approved',
    'Pending',
    'Rejected',
  ];
  String? selectedStatusValue = '';
  var dio = Dio();

  final isPressed = RxBool(false);

  @override
  void onInit() async {
    orderId = Get.arguments as String;
    getOrderDetail();
    getPartyBalanceDetail();
    // TODO: implement onInit
    super.onInit();
  }

  void setSelectedStatusValue(String? value) {
    selectedStatusValue = value;
    update();
    debugPrint("------${selectedStatusValue}--------");
  }

  Future<void> getAndShareOrderDetailPdf() async {
    try {
      isPressed.value = true;
      Map<String, String> body = {};
      body[RequestKeys.orderId] = orderId.toString();
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getOrderDetailPdfUrl(body);
      if (res.status == 200) {
        orderDetailPdfDownload = res.data!.first;
        downloadUrl = orderDetailPdfDownload?.url ?? '';

        /// new way
        downloadAndSharePdfFile(
          downloadUrl: downloadUrl ?? '',
          pdfFileName: 'pdfFile${DateTime.now().millisecond}',
        ).then((value) => isPressed.value = false);

        ///old way
        /*
        shareAndDownloadPdfFile(downloadUrl);
         */
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {}

    /*final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));
    final invoice = orderDetailData;
    final pdfFile = await pdfReportAnalysisApi.generate(invoice!);

    Share.shareFiles([pdfFile.path]);*/

    //PdfApi.openFile(pdfFile ?? File(''));
  }

  Future<void> getOrderDetail() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.orderId] = orderId.toString();
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getOrderDetail(body);
      if (res.status == 200) {
        orderDetailData = res.data?.first;
        selectedStatusValue = orderDetailData?.orderstatus;
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getPartyBalanceDetail() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.orderId] = orderId.toString();
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getPartyBalanceDetail(body);

      if (res.status == 200) {
        partyBalanceDetailData = res.data?.first;
        update();
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateOrderStatusApi(String status) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.orderId] = orderId ?? '2422';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.orderStatus] = status;
      var res = await api.updateOrderStatusApi(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar('Success Server Res', res.message.toString());
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {}
  }

  Future<void> sharePdfFromUrl({
    required String url,
    String fileName = 'pdfFile',
  }) async {
    try {
      isPressed.value = true;

      final uri = Uri.tryParse(url);
      if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
        throw Exception('Invalid URL: $url');
      }
      final safeName =
          '${fileName.replaceAll(RegExp(r"[^\w\-. ]+"), "_")}_${DateTime.now().millisecondsSinceEpoch}';

      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 60),
        responseType: ResponseType.bytes,
        followRedirects: true,
        headers: {'Accept': 'application/pdf'},
        validateStatus: (s) => s != null && s >= 200 && s < 400,
      ));

      final res = await dio.getUri(
        uri,
        onReceiveProgress: (count, total) => showDownloadProgress(count, total),
      );

      final data = res.data;
      if (data == null) throw Exception('No data received.');
      final bytes =
          data is Uint8List ? data : Uint8List.fromList(List<int>.from(data));
      if (bytes.isEmpty) throw Exception('Downloaded file is empty.');

      // Share directly from memory (no storage permission required)
      final xfile = XFile.fromData(
        bytes,
        name: '$safeName.pdf',
        mimeType: 'application/pdf',
      );
      await Share.shareXFiles([xfile], text: safeName);
    } catch (e, st) {
      debugPrint('sharePdfFromUrl error: $e\n$st');
      ShowMessage.showSnackBar('PDF Share Error', e.toString());
    } finally {
      isPressed.value = false;
    }
  }
}
