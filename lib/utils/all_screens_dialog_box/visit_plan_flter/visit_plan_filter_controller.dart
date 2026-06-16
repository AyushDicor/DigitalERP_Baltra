
import 'package:digitalerp/response/area_data_response.dart';
import 'package:digitalerp/response/city_data_response.dart';
import 'package:digitalerp/response/executive_list_response.dart';
import 'package:digitalerp/response/state_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VisitPlanFilterController extends AppBaseController {
  VisitPlanController visitPlanController = Get.put(VisitPlanController());
  HomeController homeController = Get.find<HomeController>();

  List<ExecutiveList> filterExecutiveList = [];
  List<StateDataList> filterStateList = [];
  List<CityDataList> filterCityList = [];
  List<AreaDataList> filterAreaList = [];
  ExecutiveList? selectedExecutive;
  StateDataList? selectedState;
  CityDataList? selectedCity;
  AreaDataList? selectedArea;

  @override
  void onInit() {
    // TODO: implement onInit
    if (visitPlanController.fromVisitDate != null && firstDate == AppString.dateTimeEmpty) {
      firstDate = formatDate(visitPlanController.fromVisitDate.toString(), AppString.yyyyMMdd, AppString.ddMMyyyy);
      lastDate = formatDate(visitPlanController.toVisitDate.toString(), AppString.yyyyMMdd, AppString.ddMMyyyy);
    }
    super.onInit();
    getExecutiveList();
    getState();
  }


  String firstDate =  DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day -15,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());

  void onChangedExecutiveListValue(ExecutiveList? newValue) {
    selectedExecutive = newValue;

    if (visitPlanController != null) {
      update();
    }
  }

  void onChangedStateListValue(StateDataList? newValue) {
    selectedState = newValue;

    getCity(selectedState?.stateid.toString() ?? '');
  }

  void onChangedCityListValue(CityDataList? newValue) {
    selectedCity = newValue;
    getArea();
    update();
  }

  void onChangedAreaListValue(newValue) {
    selectedArea = newValue;
    update();

  }

  void setDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDate = value;
    } else {
      lastDate = value;
    }
    update();
  }

  bool dateValidate() {
    if (firstDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
      return false;
    } else if (lastDate == AppString.dateTimeEmpty) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.selectToDateTxt);
      return false;
    } else if (DateFormat(AppString.ddMMyyyy)
        .parse(lastDate)
        .isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate))) {
      ShowMessage.showSnackBar(AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
      return false;
    }
    /*
    else if (DateFormat(ddMMyyyy).parse(lastDate).isAfter(DateTime.now())) {
      ShowMessage.showSnackBar(pleaseCheckTxt, dateGreaterThanTodayTxt);
      return false;
    }
    */
    else {
      return true;
    }
  }

  void onApplyFilter() {
    int currentYear = int.parse('${homeController.currentUserData?.yearId?.split('-').first}');
    String monthFirstDate =
        formatDate(DateTime(currentYear, 4, 1).toString(), AppString.dateTimeFormat, AppString.ddMMyyyy);
    String monthLastDate = formatDate(DateTime(currentYear + 1, (3) + 1).subtract(const Duration(days: 1)).toString(),
        AppString.dateTimeFormat, AppString.ddMMyyyy);
    if (dateValidate()) {
      visitPlanController.fromVisitDate = formatDate(
        firstDate == AppString.dateTimeEmpty ? monthFirstDate : firstDate,
        AppString.ddMMyyyy,
        AppString.yyyyMMdd
      );
      visitPlanController.toVisitDate = formatDate(
        lastDate == AppString.dateTimeEmpty ? monthLastDate : lastDate,
        AppString.ddMMyyyy,
        AppString.yyyyMMdd,
      );
      visitPlanController.selectedExecutiveId = selectedExecutive?.executiveid.toString() ?? '';
      visitPlanController.selectedStateId = selectedState?.stateid.toString() ?? '';
      visitPlanController.selectedCityId = selectedCity?.cityid.toString() ?? '';
      visitPlanController.selectedAreaId = selectedArea?.areaid.toString() ?? '';
      visitPlanController.getVisitPlanList();
      Get.back();
    }
  }

  Future<void> getExecutiveList() async {
    try {
      Map<String, String> body = {
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
      };
      var res = await api.getExecutiveListData(body);
      if (res.status == 200) {
        filterExecutiveList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getExecutiveListData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getState() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
      };
      var res = await api.getStateData(body);
      if (res.status == 200) {
        filterStateList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getStateData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getCity(String stateId) async {
    selectedCity = null;
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.stateId: stateId,
      };
      var res = await api.getCityData(body);
      if (res.status == 200) {
        filterCityList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getCityData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future<void> getArea() async {
    selectedArea = null;
    filterAreaList.clear();
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? ''; //39.toString();
      body[RequestKeys.cityId] = selectedCity?.cityid.toString()??"";
      var res = await api.getAreaData(body);
      if (res.status == 200) {
        filterAreaList = res.data ?? [];
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getAreaData catch', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }
}
