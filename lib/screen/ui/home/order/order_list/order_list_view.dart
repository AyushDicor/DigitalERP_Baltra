import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_list/order_list_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/custom_clipper.dart';
import 'package:digitalerp/utils/dottedline.dart';
import 'package:digitalerp/utils/gradient_icon_app_button.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderListController>(
      init: OrderListController(),
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
                          title: 'Order List',
                          onBackTap: () => controller.backTap())),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: Get.height * 0.135,
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      _segmentButton(controller),
                      controller.isBusy
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            )
                          : controller.executiveOrderList?.isEmpty ?? true
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: Center(
                                    child: Text(
                                      'Not Available',
                                      style: const TextStyle().bold,
                                    ),
                                  ))
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: double.maxFinite,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: controller
                                                .executiveOrderList?.length ??
                                            3,
                                        itemBuilder: (context, index) =>
                                            orderCard(controller, index),
                                      ),
                                    )
                                  ],
                                ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 18,
                bottom: 95,
                child: GradientIconButton(
                    onPressed: () => controller.tapOnAdd(),
                    radius: 10,
                    vPadding: 20),
              )
            ],
          ),
        ),
      ),
    );
  }

  orderCard(OrderListController controller, int index) {
    var item = controller.executiveOrderList![index];
    return InkWell(
      onTap: () {
        controller.tapOnCard(item.orderid.toString());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                colors: grad2,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.7, 1]),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
            ]),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                item.orderno ?? 'N/A',
                style: const TextStyle().bold.copyWith(color: Colors.white),
              ),
            ),
            ClipPath(
              clipper: CustomClip(),
              child: Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Date',
                                style: const TextStyle()
                                    .bold
                                    .copyWith(fontSize: 12, color: purpleColor),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.orderdate ?? 'N/A',
                                style: const TextStyle().bold.copyWith(
                                    fontSize: 12, color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Executive',
                                style: const TextStyle()
                                    .bold
                                    .copyWith(fontSize: 12, color: purpleColor),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.executivename ?? 'N/A',
                                style: const TextStyle().bold.copyWith(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                          DottedLine(
                            color: Colors.grey,
                            height: 60.0,
                            strokeWidth: 1.2,
                            dottedLength: 4.0,
                            space: 2.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Party Name',
                                style: const TextStyle()
                                    .bold
                                    .copyWith(fontSize: 12, color: purpleColor),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.partyname ?? 'N/A',
                                style: const TextStyle().bold.copyWith(
                                    fontSize: 12, color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Amount',
                                style: const TextStyle()
                                    .bold
                                    .copyWith(fontSize: 12, color: purpleColor),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\u{20B9}${item.amount}',
                                style: const TextStyle().bold.copyWith(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  productCard(OrderDetailController controller, int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(AppAssets.productImage),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pure Milk',
                  style: const TextStyle().bold.copyWith(color: purpleColor),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textColumn('Qty', '2'),
                    textColumn('Unit', '1Kg'),
                    textColumn('Rate', '\u{20B9}50'),
                    textColumn('Amount', '\u{20B9}100'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  textColumn(String title, String subTitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle()
              .bold
              .copyWith(fontSize: 12, color: medGreyColor),
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          style: const TextStyle().bold.copyWith(color: Colors.black),
        )
      ],
    );
  }

  statusView(OrderDetailController controller) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: orangeColor, width: 1),
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      child: Text(
        'Status Pending',
        style: const TextStyle().bold.copyWith(color: orangeColor),
      ),
    );
  }

  Widget _segmentButton(OrderListController controller) => Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: white2Color,
        ),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 35,
                decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: controller.selectedSegmentVal == 0
                            ? [orangeColor, red2Color]
                            : [Colors.transparent, Colors.transparent])),
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () => controller.setSegmentValue(0),
                  child: Text(
                    'Pending',
                    style: const TextStyle().bold.copyWith(
                        fontSize: 12,
                        color: controller.selectedSegmentVal == 0
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 35,
                decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: controller.selectedSegmentVal == 1
                            ? [green3Color, green3Color]
                            : [Colors.transparent, Colors.transparent])),
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () => controller.setSegmentValue(1),
                  child: FittedBox(
                    child: Text(
                      'Approved',
                      style: const TextStyle().bold.copyWith(
                          fontSize: 12,
                          color: controller.selectedSegmentVal == 1
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 35,
                decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: controller.selectedSegmentVal == 2
                            ? [redColor, redColor]
                            : [Colors.transparent, Colors.transparent])),
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () => controller.setSegmentValue(2),
                  child: Text(
                    'Rejected',
                    style: const TextStyle().bold.copyWith(
                        fontSize: 12,
                        color: controller.selectedSegmentVal == 2
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
