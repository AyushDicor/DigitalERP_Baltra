import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../fab/menu_fab.dart';
import 'mis_module_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';

class MisModuleView extends StatelessWidget {
  const MisModuleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MisModuleController>(
      init: MisModuleController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppAssets.dashboardBg),
                          fit: BoxFit.fill)),
                  child: SafeArea(
                    child: MyAppBar(
                      title: 'MIS Module',
                      onBackTap: () => Get.back(),

                      // false ? MyAppBar(
                      //     title: 'Account Module',
                      //     onBackTap: () => controller.backTap()) : MyAppBar(
                      //     title: 'MIS Module',
                      //     onDrawerTap: () => controller.openDrawer(context)
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: Get.height * 0.16,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  itemCount: controller.menuList.length,
                  itemBuilder: (context, index) {
                    return card(controller, index);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: MenuFab(parentMenuId: 2383),
      ),
    );
  }

  Widget card(MisModuleController controller, int index) {
    return GestureDetector(
      onTap: () => controller.tapOnCard(index),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              controller.menuList[index].color1,
              controller.menuList[index].color2
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          controller.menuList[index].name,
          style: const TextStyle()
              .bold
              .copyWith(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
