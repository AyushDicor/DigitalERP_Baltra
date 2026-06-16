import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_detail/visit_plan_detail_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/dialog_bg_widget.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/dottedline.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/solid_app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitPlanDetailView extends StatelessWidget {
  const VisitPlanDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisitPlanDetailController>(
      init: VisitPlanDetailController(),
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
                      color: Colors.red,
                      image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
                  child: SafeArea(child: MyAppBar(title: 'Visit Plan Detail', onBackTap: () => controller.backTap())),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: Get.height * 0.135,
                child: controller.isBusy
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : controller.visitPlanDetailList.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Center(
                              child: Text(
                                'Not Available',
                                style: const TextStyle().bold,
                              ),
                            ))
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.visitPlanDetailList.length,
                            itemBuilder: (context, index) {
                              return card(controller, index,context);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(VisitPlanDetailController controller, int index , BuildContext context) {
    //bool isCheckIn=index == 0;
    var item = controller.visitPlanDetailList[index];
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Customer Name',
                      style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
                    ),
                    SolidAppButton(
                      onPressed: () {

                        if (item.checkstatus == 'Check In') {
                          controller.tapOnCheckIn(index);

                        } else if (item.checkstatus == 'Check Out' ||
                            (controller.visitCheckInList.isEmpty
                                ? false
                                :
                            controller.visitCheckInList[index].checkstatus == 'Check Out')

                        ) {
                          showRemarkDialog(controller,index,context);
                          // controller.tapOnCheckOut(index);
                        } else {}
                      },
                      name: item.checkstatus??"",
                      topColor: item.checkstatus == 'Check In'
                          ? orangeColor
                          : item.checkstatus == 'Check Out'
                              ? Colors.green
                              : item.checkstatus == "Checked Out"
                             ? Colors.red
                             : Colors.grey,
                      bottomColor: item.checkstatus == 'Check In'
                          ? red2Color
                          : item.checkstatus == 'Check Out'
                              ? Colors.lightGreen
                               : item.checkstatus=="Checked Out"
                         ? Colors.red
                         : Colors.grey,
                      textSize: 7,
                      vPadding: 5,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  item.customername ?? 'N/A',
                  style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.visitdate ?? 'N/A',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Status',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.visitstatus ?? 'N/A',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Timing',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.visittime ?? 'N/A',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Executive',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          controller.argument?.executive ?? 'N/A',
                          style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          DottedLine(
            color: Colors.grey,
            width: double.maxFinite,
            strokeWidth: 1.0,
            dottedLength: 5.0,
            space: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: item.checkstatus == 'Check In' || item.checkstatus == '' ||
                          (controller.visitCheckOutList.isEmpty ? false : controller.visitCheckOutList[index].checkstatus == '')
                      ? null
                      : () {
                          controller.tapOnOrder(index);
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppAssets.cartIcon,
                        height: 14,
                        width: 14,
                        color: item.checkstatus == 'Check In' ||
                                item.checkstatus == '' ||
                                (controller.visitCheckOutList.isEmpty
                                    ? false
                                    : controller.visitCheckOutList[index].checkstatus == '')
                            ? grey
                            : orangeColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Order',
                        style: const TextStyle().bold.copyWith(
                            fontSize: 10,
                            color: item.checkstatus == 'Check In' ||
                                    item.checkstatus == '' ||
                                    (controller.visitCheckOutList.isEmpty
                                        ? false
                                        : controller.visitCheckOutList[index].checkstatus == '')
                                ? grey
                                : orangeColor),
                      )
                    ],
                  ),
                ),
                DottedLine(
                  color: Colors.grey,
                  height: 15,
                  strokeWidth: 1.0,
                  dottedLength: 5.0,
                  space: 0.0,
                ),
                InkWell(
                  onTap: item.checkstatus == 'Check In' ||
                          item.checkstatus == '' ||
                          (controller.visitCheckOutList.isEmpty
                              ? false
                              : controller.visitCheckOutList[index].checkstatus == '')
                      ? null
                      : () {
                          controller.tapOnStock(item);
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppAssets.stockIcon,
                        height: 14,
                        width: 14,
                        color: item.checkstatus == 'Check In' ||
                                item.checkstatus == '' ||
                                (controller.visitCheckOutList.isEmpty
                                    ? false
                                    : controller.visitCheckOutList[index].checkstatus == '')
                            ? grey
                            : purpleColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Stock',
                        style: const TextStyle().bold.copyWith(
                            fontSize: 10,
                            color: item.checkstatus == 'Check In' ||
                                    item.checkstatus == '' ||
                                    (controller.visitCheckOutList.isEmpty
                                        ? false
                                        : controller.visitCheckOutList[index].checkstatus == '')
                                ? grey
                                : purpleColor),
                      )
                    ],
                  ),
                ),
                DottedLine(
                  color: Colors.grey,
                  height: 15,
                  strokeWidth: 1.0,
                  dottedLength: 5.0,
                  space: 0.0,
                ),
                InkWell(
                  onTap: item.checkstatus == 'Check In' ||
                          item.checkstatus == '' ||
                          (controller.visitCheckOutList.isEmpty
                              ? false
                              : controller.visitCheckOutList[index].checkstatus == '')
                      ? null
                      : () {
                          controller.tapOnPayment(item.partyid);
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppAssets.walletIcon,
                        height: 14,
                        width: 14,
                        color: item.checkstatus == 'Check In' ||
                                item.checkstatus == '' ||
                                (controller.visitCheckOutList.isEmpty
                                    ? false
                                    : controller.visitCheckOutList[index].checkstatus == '')
                            ? grey
                            : red2Color,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Collection',
                        style: const TextStyle().bold.copyWith(
                            fontSize: 10,
                            color: item.checkstatus == 'Check In' ||
                                    item.checkstatus == '' ||
                                    (controller.visitCheckOutList.isEmpty
                                        ? false
                                        : controller.visitCheckOutList[index].checkstatus == '')
                                ? grey
                                : red2Color),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showRemarkDialog(VisitPlanDetailController controller , int index, BuildContext context){
   Get.dialog(
       DialogNewWidget(
         onApplyOrDoneButtonTap: (){
           controller.tapOnCheckOut(index);
           Get.back();
         },
         isEdit: true,
           text: "Remark :",
           buttonName: "Check Out",
           children: [
             const SizedBox(height: 30,),
             Container(
               padding: const EdgeInsets.only(left: 10),
              // height:Get.height * 0.04,
               width: Get.width * 0.900,
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   colors: [
                     grBottomColor.withValues(alpha:0.2),
                     grTopColor.withValues(alpha:0.2)
                   ],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                 ),
                 borderRadius: BorderRadius.circular(10),
               ),

               child: TextFormField(
                 controller: controller.remarkController,
                 maxLines: 5,
                 decoration: const InputDecoration(
                     hintText: "Enter Remark....",
                     border: InputBorder.none
                 ),
               ),
             ),
           ],

       )
   ) ;

  }

}
