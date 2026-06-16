import 'package:digitalerp/response/area_data_response.dart';
import 'package:digitalerp/response/city_data_response.dart';
import 'package:digitalerp/response/distance_details_response.dart';
import 'package:digitalerp/response/nearby_data_response.dart';
import 'package:digitalerp/response/state_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/new_visit_planing/new_visit_planing_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';


class NewVisitPlanningFilterController extends AppBaseController {
  NewVisitPlaningController newVisitPlanController = Get.find<NewVisitPlaningController>();
  HomeController homeController = Get.find<HomeController>();

  var selectedNearByItem;
  var selectedStateNewVisit;
  var selectedCityNewVisit;
  var selectedAreaNewVisit;

  // SfRangeValues values = SfRangeValues(10.0, 80.0,);

  double lowerValue = 0;
  double upperValue = 100;


  List<NearByDataList> nearByDataList = [];
  List<StateDataList> newVisitFilterStateList = [];
  List<CityDataList> newVisitFilterCityList = [];
  List<AreaDataList> newVisitFilterAreaList = [];
  List<DistanceDetailsData> distanceDetailsList=[];


  @override
  void onInit() {
    // TODO: implement onInit
    getNearByData();
    getState();
    getDistanceData();
    super.onInit();
  }


  // void onChangeSliderValue(value){
  //   values =values;
  //   update();
  // }

  void onChangedNearbyListValue(Object? newValue) {
    //indexOfSelectedValue = dropdownList1.indexOf(newValue);
    selectedNearByItem = newValue;
    if (newVisitPlanController != null) {
      update();
    }
  }

  void onChangedStateListValue(Object? newValue) {
    //indexOfSelectedValue = dropdownList1.indexOf(newValue);
    selectedStateNewVisit = newValue;
    getCity(selectedStateNewVisit.stateid.toString());
    if (newVisitPlanController != null) {
      update();
    }
  }

  void onChangedCityListValue(Object? newValue) {
    //indexOfSelectedValue = dropdownList1.indexOf(newValue);
    selectedCityNewVisit = newValue;
    newVisitPlanController.newVisitCityFilterSelectedValue = selectedCityNewVisit;
    getArea(selectedCityNewVisit.cityid.toString());
    if (newVisitPlanController != null) {
      update();
    }
  }

  void onChangedAreaListValue(Object? newValue) {
    //indexOfSelectedValue = dropdownList1.indexOf(newValue);
    //newVisitPlanController.statusListPreviewsSelectedValue = newValue;
    selectedAreaNewVisit = newValue;
    newVisitPlanController.newVisitAreaFilterSelectedValue = newValue;
    if (newVisitPlanController != null) {
      update();
    }
  }


  Future<void> getDistanceData() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? ''; //39.toString();
      var res = await api.distanceDetailsData(body);
      if (res.status == 200) {
        distanceDetailsList = res.data ?? [];
        update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getNearByData() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? ''; //342613.toString();
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      var res = await api.nearByData(body);
      if (res.status == 200) {
        nearByDataList = res.data ?? [];

        update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }


  Future<void> getState() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      var res = await api.getStateData(body);
      if (res.status == 200) {
        newVisitFilterStateList = res.data ?? [];
        //update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getCity(String stateId) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      body[RequestKeys.stateId] = stateId;
      var res = await api.getCityData(body);
      if (res.status == 200) {
        newVisitFilterCityList = res.data ?? [];
        selectedCityNewVisit = newVisitFilterCityList.first;
        //update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getArea(String cityId) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      body[RequestKeys.cityId] = cityId;
      var res = await api.getAreaData(body);
      if (res.status == 200) {
        newVisitFilterAreaList = res.data ?? [];
        selectedAreaNewVisit = newVisitFilterAreaList.first;
        //update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  void onApplyFilter() {
    newVisitPlanController.newVisitnearbyFilterSelectedValue = selectedNearByItem;
    newVisitPlanController.newVisitAreaFilterSelectedValue = selectedAreaNewVisit;
    if (selectedNearByItem == null &&
        selectedStateNewVisit == null &&
        selectedCityNewVisit == null &&
        selectedAreaNewVisit == null) {
      ShowMessage.showSnackBar('msg', 'please select any filter value ');
    } else {
      newVisitPlanController.getCustomerList(upperValue.toInt());
      Get.back();
    }
  }
}
/*  void setSelectDropdownValue(var newValue) {
    //FilterScreanVariable.selectedDropdown1Value = newValue;

  }*/
