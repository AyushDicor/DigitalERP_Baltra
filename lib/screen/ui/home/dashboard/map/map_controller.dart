import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:digitalerp/response/executive_list_with_lat_long_response.dart';
import 'package:digitalerp/response/exicutive_whole_day_location_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();// In map_controller.dart — add this field
  ExecutiveLatLongData? selectedExecutive;


  //Completer<GoogleMapController> mapCtlr = Completer();
  int initialZoom = 13;
  CameraPosition cameraCurrentPosition = const CameraPosition(
    target: LatLng(22.741, 75.852),
    zoom: 13,
  );

  bool mapReady = false;

  List<ExecutiveLatLongData> executivePositionList = [];
  List listOfLat = [];
  List listOfLong = [];

  List<ExecutiveLatLongData> executiveCurrentPosition = [];
  List<LatLng> routePointsList = [];
  List<ExecutiveDayLocationData> newRoutePointsListList = [];

  List<MarkerData> markerList = [];
  Set<Polyline> polyline = {};

  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();

  @override
  void onInit() async {
    // TODO: implement onInit
    await getExecutiveListWithLatLong();
    await exePositionCustom();
    super.onInit();
  }

  Widget _customMarker(String url, int index) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          AppAssets.execPositionIcon,
          // AppAssets.wallet2Icon,
          height: 110,
          width: 65,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ProfileImageView(
            // size: 60,
            size: 45,
            imageUrl: url,
            borderSize: 2,
          ),
        )
      ],
    );
  }

  Future<void> exePositionCustom({bool? isArgument}) async {
    if (isArgument ?? false) {
      for (var element in executiveCurrentPosition) {
        markerList.add(
          MarkerData(
            marker: Marker(
              markerId: MarkerId(element.executiveid.toString()),
              position: LatLng(double.parse(element.latitude.toString()), double.parse(element.longitude.toString())),
              onTap: () {
                selectedExecutive = element; // ← add this
                update();
                customInfoWindowController.addInfoWindow!(
                  InkWell(
                    onTap: () => tapOnSeeDirection(
                      element,
                    ),
                    child: Image.asset(
                      AppAssets.seeDirection,
                      height: 45,
                      width: 190,
                    ),
                  ),
                  LatLng(double.parse(element.latitude.toString()) + 0.00003,
                      double.parse(element.longitude.toString()) - 0.00006),
                );
              },
            ),
            child: _customMarker(element.photo ?? dummyImage2UrlTxt, 0),
          ),
        );
      }
    } else {
      for (var element in executivePositionList) {
        markerList.add(
          MarkerData(
            marker: Marker(
              markerId: MarkerId(element.executiveid.toString()),
              position: LatLng(double.parse(element.latitude.toString()), double.parse(element.longitude.toString())),
              onTap: () {
                selectedExecutive = element; // ← add this
                update();
                //tapOnMarker(i);
                customInfoWindowController.addInfoWindow!(
                  InkWell(
                      onTap: () => tapOnSeeDirection(element),
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.getLocationIcon2,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'See Direction',
                                    style: const TextStyle().bold.copyWith(color: red2Color, fontSize: 13),
                                  )
                                ],
                              ),
                              Text(
                                '      of ${element.executivename} ',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle().bold.copyWith(color: red2Color, fontSize: 10),
                              )
                            ],
                          ))),
                  LatLng(double.parse(element.latitude.toString()) + 0.00003,
                      double.parse(element.longitude.toString()) - 0.00006),
                );
              },
            ),
            child: _customMarker(element.photo ?? dummyImage2UrlTxt, 0),
          ),
        );
      }
    }
    update();
  }

  Future<void> getExecutiveListWithLatLong() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.executiveId] = Get.arguments == null ? '0' : Get.arguments.executiveid.toString();
      var res = await api.getExecutiveListWithLatLong(body);
      if (res.status == 200) {
        executivePositionList.addAll(res.data ?? []);

        /// for adding executive data
        // executivePositionList.addAll([
        //   ExecutiveLatLongData(
        //       executiveid: 101,
        //       executivename: 'DDDD',
        //       attendence: 'Present',
        //       location: 'AAAA',
        //       latitude: 22.741,
        //       longitude: 75.852),
        //   ExecutiveLatLongData(
        //       executiveid: 202,
        //       executivename: 'AAAA',
        //       attendence: 'Present',
        //       location: 'AAAA',
        //       latitude: 23.741,
        //       longitude: 79.852),
        // ]);

        /// for removing absent executive data
        executivePositionList.removeWhere((element) => element.attendence == 'Absent');

        // if (executivePositionList.length == 1) {
        //   cameraCurrentPosition = CameraPosition(
        //     target: LatLng(double.parse(executivePositionList[0].latitude.toString()),
        //         double.parse(executivePositionList[0].longitude.toString())),
        //     zoom: 10,
        //   );
        // } else {
        for (var element in executivePositionList) {
          listOfLat.add(double.parse(element.latitude.toString()));
          listOfLong.add(double.parse(element.longitude.toString()));
        }
        // }
        update();
      } else {
        //ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {}
  }

  /// methode for creating bound
  LatLngBounds boundsFromLatLngList() {
    listOfLat.sort();
    listOfLong.sort();
    double minLat = listOfLat.first;
    double maxLat = listOfLat.last;
    double minLong = listOfLong.first;
    double maxLong = listOfLong.last;
    return LatLngBounds(southwest: LatLng(minLat, minLong), northeast: LatLng(maxLat, maxLong));
  }

  void tapOnSeeDirection(ExecutiveLatLongData data) async {
    //ShowMessage.showSnackBar('Server Res catch', 'Routes Not Available');
    newRoutePointsListList.clear();

    await getExecutiveDayLocation(data.executiveid!);

    /// for executive point add
    // routePointsList.insert(0, LatLng(data.latitude ?? 0, data.longitude ?? 0));

    for (var elment in newRoutePointsListList) {
      debugPrint("-----------lat-----------${elment.latitude}");
      debugPrint("-----------long-----------${elment.longitude}");

      routePointsList.addAll([
        LatLng(double.parse(elment.latitude ?? ''), double.parse(elment.longitude ?? '')),
        //LatLng(22.7177, 75.8545),
      ]);
    }

    /// ADD hard coded points

    listOfLat.clear();
    listOfLong.clear();
    for (var element in routePointsList) {
      listOfLat.add(double.parse(element.latitude.toString()));
      listOfLong.add(double.parse(element.longitude.toString()));
    }

    customInfoWindowController.googleMapController
        ?.animateCamera(CameraUpdate.newLatLngBounds(boundsFromLatLngList(), 10));

    /// create route
    polyline.add(Polyline(
      polylineId: PolylineId(data.executiveid.toString()),
      visible: true,
      points: routePointsList,
      color: purpleColor,
    ));
    update();
  }

  Future<void> getExecutiveDayLocation(int executiveId) async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.executiveId] = executiveId.toString();
      var res = await api.getExecutiveDayLocationData(body);
      if (res.status == 200) {
        newRoutePointsListList = res.data ?? [];
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }
}

class ExecPostionData {
  String executiveid;
  double opacity;
  LatLng lastLatLng, startLatLng;

  ExecPostionData(this.executiveid, this.opacity, this.lastLatLng, this.startLatLng);
}
