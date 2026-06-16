import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/customer_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewVisitPlaningController extends AppBaseController {
  final TextEditingController searchController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();
  final FocusNode searchFocus = FocusNode();

  var defaultDate = 'Select Date'.obs;

  var newVisitnearbyFilterSelectedValue;
  var newVisitAreaFilterSelectedValue;
  var newVisitCityFilterSelectedValue;

  DateTime? dateTime;
  List<VisitCustomerListData> visitPlanCustomerList = [];
  String? executiveName;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    executiveName = homeController.currentUserData?.name;
    getCustomerList(100);
  }

  void tapOnCard() {
    Get.toNamed(AppRoutes.visitPlanDetail);
  }

  void tapOnChecked(int index) {
    if (dateTime == null) {
      ShowMessage.showSnackBar(
        AppString.pleaseCheckTxt,
        AppString.pleaseSelectDate,
      );
    } else {
      if (visitPlanCustomerList[index].isChecked ?? false) {
        deleteVisit(visitPlanCustomerList[index]);
      } else {
        addInVisit(visitPlanCustomerList[index]);
      }
    }
  }

  void tapOnPreview() {
    int count = 0;
    if (dateTime == null) {
      ShowMessage.showSnackBar(
        'Message',
        'Please select date',
      );
    } else {
      for (var element in visitPlanCustomerList) {
        if (element.isChecked ?? false) {
          count++;
        }
      }
      if (count == 0) {
        ShowMessage.showSnackBar(
          'Message',
          'Please check any customer',
        );
      } else {
        Get.toNamed(AppRoutes.preview)?.then((value) {
          if ((value ?? '').toString().isNotEmpty) {
            Get.back();

            ShowMessage.showSnackBar('Server Res', value.toString());
          }
        });
      }
    }
  }

  void onSearch(String text) {
    if (text.isEmpty) {
      getCustomerList(100);
      update();
    } else {
      final suggestions = visitPlanCustomerList.where((element) {
        final productTitle = element.customername!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      visitPlanCustomerList = suggestions;
      update();
    }
  }

  Future<void> getCustomerList(int distanceValue) async {
    isBusy = true;
    final location = await getUserCurrentPosition();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print("Current lat ${position.latitude}");
    final address = await getUserCurrentAddress();
    print("Current addRess ==>${address}");
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '39';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
      body[RequestKeys.partyId] = '0';
      body[RequestKeys.nearby] =
      distanceValue==null ? '0' : distanceValue.toString();
      body[RequestKeys.areaId] =
          newVisitAreaFilterSelectedValue == null ? '0' : newVisitAreaFilterSelectedValue.areaid.toString();
      body[RequestKeys.latitude] = location.latitude.toString();
      body[RequestKeys.longitude] = location.longitude.toString();

      var res = await api.customerListData(body);
      if (res.status == 200) {
        visitPlanCustomerList = res.data ?? [];
        update();
      } else {
        visitPlanCustomerList = res.data??[];
        update();
        // ShowMessage.showSnackBar('customerListData res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
    }
  }

  Future<void> addInVisit(VisitCustomerListData element) async {
    String date = DateFormat('yyyy-MM-dd').format(dateTime ?? DateTime.now());
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '39';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
      body[RequestKeys.partyId] = element.partyid.toString();
      body[RequestKeys.clientName] = element.customername ?? '';
      body[RequestKeys.areaId] = element.areaid.toString();
      body[RequestKeys.areaName] = element.area.toString().isEmpty ? 'N/A' : element.area ?? '';
      body[RequestKeys.distance] = element.distance ?? '';
      body[RequestKeys.visitDate] = date;

      var res = await api.addVisitDataToVisit(body);
      if (res.status == 200) {
        for (var e in visitPlanCustomerList) {
          if (e == element) {
            e.isChecked = !(e.isChecked ?? false);
          }
        }
      } else {
        ShowMessage.showSnackBar('addVisitDataToVisit res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> deleteVisit(VisitCustomerListData element) async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.id: element.partyid.toString(),
      };

      var res = await api.deleteVisitData(body);
      if (res.status == 200) {
        for (var e in visitPlanCustomerList) {
          if (e == element) {
            e.isChecked = !(e.isChecked ?? false);
          }
        }
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }
}
