// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:custom_map_markers/custom_map_markers.dart';
// import 'package:digitalerp/screen/ui/home/dashboard/map/map_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapView extends StatelessWidget {
//   const MapView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MapViewController>(
//       init: MapViewController(),
//       builder: (controller) {
//         if (Get.arguments != null) {
//           controller.executiveCurrentPosition.add(Get.arguments);
//           controller.update();
//           controller.exePositionCustom(isArgument: true);
//         }
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Center(
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 0,
//                   bottom: 0,
//                   right: 0,
//                   left: 0,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                     child: SafeArea(
//                       child: MyAppBar(
//                         title: 'Map',
//                         onBackTap: () => controller.backTap(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   top: Get.height * 0.11,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
//                     clipBehavior: Clip.antiAlias,
//                     child: CustomGoogleMapMarkerBuilder(
//                       // screenshotDelay: const Duration(milliseconds: 500),
//                       customMarkers: controller.markerList,
//                       builder: (BuildContext context, Set<Marker>? markers) {
//                         if (markers == null) {
//                           return const Center(child: CircularProgressIndicator());
//                         }
//                         return Stack(
//                           children: [
//                             GoogleMap(
//                               onTap: (position) {
//                                 controller.customInfoWindowController.hideInfoWindow!();
//                               },
//                               onCameraMove: (position) {
//                                 controller.customInfoWindowController.onCameraMove!();
//                               },
//                               onMapCreated: (GoogleMapController controllerr) async {
//                                 if (Get.arguments == null) {
//                                   controllerr.animateCamera(CameraUpdate.newLatLngBounds(
//                                       controller.boundsFromLatLngList(), 50));
//                                 }
//                                 controller.customInfoWindowController.googleMapController =
//                                     controllerr;
//                               },
//                               markers: markers,
//                               initialCameraPosition: Get.arguments != null
//                                   ? CameraPosition(
//                                       target: LatLng(
//                                           double.parse(controller
//                                               .executiveCurrentPosition[0].latitude
//                                               .toString()),
//                                           double.parse(
//                                             controller.executiveCurrentPosition[0].longitude
//                                                 .toString(),
//                                           )),
//                                       zoom: 15)
//                                   : controller.cameraCurrentPosition,
//                               polylines: controller.polyline,
//                             ),
//                             CustomInfoWindow(
//                               controller: controller.customInfoWindowController,
//                               height: 35,
//                               width: 120,
//                               offset: 50,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// map_view.dart — Figma-matched redesign

import 'package:custom_info_window/custom_info_window.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:digitalerp/screen/ui/home/dashboard/map/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//  Color tokens 
const Color _white = Color(0xFFFFFFFF);
const Color _textPrimary = Color(0xFF1A1A2E);
const Color _textSub = Color(0xFF7B8CAA);
const Color _presentColor = Color(0xFF34C77B);
const Color _borderColor = Color(0xFFE8ECF4);
const Color _dividerColor = Color(0xFFF0F2F7);

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapViewController>(
      init: MapViewController(),
      builder: (controller) {
        if (Get.arguments != null) {
          controller.executiveCurrentPosition.add(Get.arguments);
          controller.update();
          controller.exePositionCustom(isArgument: true);
        }

        return Scaffold(
          backgroundColor: _white,
          body: Column(
            children: [
              //  App Bar 
              _MapAppBar(),

              //  Map (takes remaining space) 
              Expanded(
                child: CustomGoogleMapMarkerBuilder(
                  customMarkers: controller.markerList,
                  builder: (BuildContext context, Set<Marker>? markers) {
                    if (markers == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Stack(
                      children: [
                        GoogleMap(
                          onTap: (_) {
                            controller
                                .customInfoWindowController.hideInfoWindow!();
                          },
                          onCameraMove: (_) {
                            controller
                                .customInfoWindowController.onCameraMove!();
                          },
                          onMapCreated: (GoogleMapController ctrl) async {
                            if (Get.arguments == null) {
                              ctrl.animateCamera(CameraUpdate.newLatLngBounds(
                                  controller.boundsFromLatLngList(), 50));
                            }
                            controller.customInfoWindowController
                                .googleMapController = ctrl;
                          },
                          markers: markers,
                          initialCameraPosition: Get.arguments != null
                              ? CameraPosition(
                                  target: LatLng(
                                    double.parse(controller
                                        .executiveCurrentPosition[0].latitude
                                        .toString()),
                                    double.parse(controller
                                        .executiveCurrentPosition[0].longitude
                                        .toString()),
                                  ),
                                  zoom: 15,
                                )
                              : controller.cameraCurrentPosition,
                          polylines: controller.polyline,
                          // Clean light map style matching Figma
                          mapType: MapType.normal,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          compassEnabled: false,
                          mapToolbarEnabled: false,
                        ),
                        CustomInfoWindow(
                          controller: controller.customInfoWindowController,
                          height: 35,
                          width: 120,
                          offset: 50,
                        ),
                      ],
                    );
                  },
                ),
              ),

              //  Bottom Info Card 
              _BottomInfoCard(controller: controller),
            ],
          ),
        );
      },
    );
  }
}

//  App Bar 
class _MapAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 14,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 34,
              height: 34,
              // decoration: const BoxDecoration(
              //   color: Color(0xFFF4F6FA),
              //   shape: BoxShape.circle,
              // ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: _textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Location',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

//  Bottom Info Card 
class _BottomInfoCard extends StatelessWidget {
  final MapViewController controller;
  const _BottomInfoCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    final exe = controller.selectedExecutive;
    if (exe == null) return const SizedBox.shrink();

    final bool isPresent = exe.attendence?.toString() != 'Absent';

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(top: BorderSide(color: Color(0xFFF0F2F7), width: 1)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              ClipOval(
                child: (exe.photo != null && exe.photo!.isNotEmpty)
                    ? Image.network(exe.photo!, width: 48, height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _defaultAvatar())
                    : _defaultAvatar(),
              ),
              const SizedBox(width: 12),

              // Name + status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exe.executivename?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isPresent ? 'Present' : 'Absent',
                      style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600,
                        color: isPresent
                            ? const Color(0xFF34C77B)
                            : const Color(0xFFFF5A5A),
                      ),
                    ),
                  ],
                ),
              ),

              // Time (from date field — last segment after '-')
              if (exe.date != null && isPresent)
                Text(
                  exe.date!.split('-').last.trim(),
                  style: const TextStyle(
                    fontSize: 13, color: Color(0xFF7B8CAA),
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),

          // Location
          if (exe.location != null && exe.location!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(height: 1, color: const Color(0xFFF0F2F7)),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_rounded,
                    size: 16, color: Color(0xFF7B8CAA)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    exe.location.toString(),
                    style: const TextStyle(
                      fontSize: 13, color: Color(0xFF7B8CAA),
                      fontWeight: FontWeight.w400, height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _defaultAvatar() => Container(
    width: 48, height: 48,
    decoration: const BoxDecoration(
      color: Color(0xFFE8ECF4), shape: BoxShape.circle,
    ),
    child: const Icon(Icons.person_rounded,
        size: 24, color: Color(0xFF7B8CAA)),
  );
}

//  Default avatar fallback 
class _DefaultAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF4),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person_rounded, size: 24, color: _textSub),
    );
  }
}
