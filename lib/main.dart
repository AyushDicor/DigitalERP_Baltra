 import 'package:device_preview/device_preview.dart';
import 'package:digitalerp/app_routes/add_dependencies.dart';
import 'package:digitalerp/app_routes/app_pages.dart';
import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
import 'package:digitalerp/services/api_Inspector/alice.dart';
import 'package:digitalerp/services/notification_service/notificaton_services.dart';
import 'package:digitalerp/utils/safeAreaWrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'firebase_options.dart';
import 'dart:io';

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  debugPrint(message.notification!.title);
}
class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = _MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  LocalNotificationService.initialize();
  await AppDependencies.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("-----------token:-----$token");
  } on FirebaseException {
    debugPrint("-----------FirebaseException:-----$FirebaseException");
  }

  runApp(
    const MyApp(),
  );

  //runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.put(HomeController());

    // Get.put(HomeViewNewController());
    return OverlaySupport.global(
      child: GetMaterialApp(
        navigatorKey: AliceInterceptor.getAlice.getNavigatorKey(),
        smartManagement: SmartManagement.keepFactory,
        debugShowCheckedModeBanner: false,
        title: 'Digital ERP',
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     print("${Get.height}");
//     print("${Get.width}");
//     return OverlaySupport.global(
//       child: GetMaterialApp(
//         navigatorKey: AliceInterceptor.getAlice.getNavigatorKey(),
//         smartManagement: SmartManagement.keepFactory,
//         debugShowCheckedModeBanner: false,
//         title: 'Digital ERP',
//
//         // DevicePreview integration
//         useInheritedMediaQuery: true,
//         locale: DevicePreview.locale(context),
//
//         // Compose DevicePreview.appBuilder with your ScrollBehavior
//         builder: (context, child) {
//           // First apply DevicePreview’s builder (so the simulated device sizing works)
//           final previewed = DevicePreview.appBuilder(context, child);
//           // Then apply your scroll behavior
//           return ScrollConfiguration(
//             behavior: MyBehavior(),
//             child: previewed,
//           );
//         },
//
//         getPages: AppPages.routes,
//         initialRoute: AppPages.initial,
//       ),
//     );
//   }
// }

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
