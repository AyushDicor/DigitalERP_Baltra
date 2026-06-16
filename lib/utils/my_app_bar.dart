import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final String title;
  final  unApproval;
  final VoidCallback? onDrawerTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onResetTap;
  final VoidCallback? onCartTap;
  final bool? showCartIcon;
  final Widget? deFaultIcon;
  final bool? showApprovalIcon;
  final VoidCallback? defaultTap;


  MyAppBar(
      {Key? key,
         this.unApproval,
      required this.title,
      this.onDrawerTap,
      this.onBackTap,
      this.onFilterTap,
      this.onCartTap,
      this.showCartIcon,
        this.showApprovalIcon,
        this.deFaultIcon,
        this.defaultTap,
      this.onResetTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            InkWell(
              onTap: onDrawerTap ?? onBackTap,
              child: Image.asset(
                onDrawerTap != null ? AppAssets.drawerIcon : AppAssets.backIcon,
                height: 28,
                width: 28,
              ),
            ),

            // const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle().bold.copyWith(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            deFaultIcon??
                Container(
                  child: deFaultIcon,
                ),
            SizedBox(width: 10,),
            if (onFilterTap != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  onResetTap != null
                      ? InkWell(
                          onTap: onResetTap,
                          child: const Icon(Icons.refresh, color: Colors.white, size: 20),
                        )
                      : const SizedBox(),
                  SizedBox(width: onResetTap != null ? 20 : 0),
                  InkWell(
                    onTap: onFilterTap,
                    child: Image.asset(
                      AppAssets.filterIcon,scale: 0.5,
                      color: Colors.white,
                      height: 28,
                      width: 22,
                    ),
                  )
                ],
              ),
            if (showCartIcon ?? false)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: InkWell(
                    onTap: onCartTap ?? () {},
                    child: Stack(
                      children: [
                        Image.asset(
                          AppAssets.cartIcon,
                          color: Colors.white,
                          height: 18,
                          width: 18,
                        ),
                        /*FilterScreanVariable.cartList.isEmpty
                            ? Container()
                            : Positioned(
                                top: 0,
                                left: 0,
                                bottom: 8,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      '${FilterScreanVariable.cartList.length}',
                                      style: TextStyle(color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                ),
                              ),*/
                        Obx(
                          () => Visibility(
                            visible: (homeController.itemInCart.value > 0),
                            child: Positioned(
                              top: 0,
                              left: 0,
                              bottom: 8,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    homeController.itemInCart.value.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),


            if (!(showCartIcon ?? false) && onFilterTap == null)
              const SizedBox(
                width: 20,
              ),

            ///--------
            if (showApprovalIcon ?? false)
              InkWell(
                  onTap: defaultTap ?? () {},
                  child: Column(
                    children: [
                      Badge(
                        smallSize: 12,
                        label: Text(unApproval.toString()),
                        child:  Image.asset(
                          AppAssets.approvalIcon,
                          color: Colors.white,
                          height: 25,
                          width: 30,
                        )
                      )
                    ],
                  )

                  // Image.asset(
                  //   AppAssets.approvalIcon,
                  //   color: Colors.white,
                  //   height: 25,
                  //   width: 30,
                  // )
              ),

          ],
        ),
      ),
    );
  }
}




class MyAppBarNew extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final String title;
  final  unApproval;
  final VoidCallback? onDrawerTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onResetTap;
  final VoidCallback? onCartTap;
  final bool? showCartIcon;
  final bool? showApprovalIcon;
  final VoidCallback? defaultTap;


  MyAppBarNew(
      {Key? key,
        this.unApproval,
        required this.title,
        this.onDrawerTap,
        this.onBackTap,
        this.onFilterTap,
        this.onCartTap,
        this.showCartIcon,
        this.showApprovalIcon,
        this.defaultTap,
        this.onResetTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onDrawerTap ?? onBackTap,
            child: Image.asset(
              onDrawerTap != null ? AppAssets.drawerIcon : AppAssets.backIcon,
              height: 28,
              width: 28,
            ),
          ),
          // const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle().bold.copyWith(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          if (onFilterTap != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                onResetTap != null
                    ? InkWell(
                  onTap: onResetTap,
                  child: const Icon(Icons.refresh, color: Colors.white, size: 20),
                )
                    : const SizedBox(),
                SizedBox(width: onResetTap != null ? 20 : 0),
                InkWell(
                  onTap: onFilterTap,
                  child: Image.asset(
                    AppAssets.filterIcon,scale: 0.5,
                    color: Colors.white,
                    height: 28,
                    width: 22,
                  ),
                )
              ],
            ),
          if (showCartIcon ?? false)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                  onTap: onCartTap ?? () {},
                  child: Stack(
                    children: [
                      Image.asset(
                        AppAssets.cartIcon,
                        color: Colors.white,
                        height: 18,
                        width: 18,
                      ),
                      /*FilterScreanVariable.cartList.isEmpty
                          ? Container()
                          : Positioned(
                              top: 0,
                              left: 0,
                              bottom: 8,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    '${FilterScreanVariable.cartList.length}',
                                    style: TextStyle(color: Colors.white, fontSize: 8),
                                  ),
                                ),
                              ),
                            ),*/
                      Obx(
                            () => Visibility(
                          visible: (homeController.itemInCart.value > 0),
                          child: Positioned(
                            top: 0,
                            left: 0,
                            bottom: 8,
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  homeController.itemInCart.value.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          if (!(showCartIcon ?? false) && onFilterTap == null)
            const SizedBox(
              width: 20,
            ),
          ///--------
          if (showApprovalIcon ?? false)
            InkWell(
                onTap: defaultTap ?? () {},
                child: Column(
                  children: [
                    Badge(
                        smallSize: 12,
                        label: Text(unApproval.toString()),
                        child:  Image.asset(
                          AppAssets.approvalIcon,
                          color: Colors.white,
                          height: 25,
                          width: 30,
                        )
                    )
                  ],
                )

              // Image.asset(
              //   AppAssets.approvalIcon,
              //   color: Colors.white,
              //   height: 25,
              //   width: 30,
              // )
            ),

        ],
      ),
    );
  }
}
