import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';

class CommonItemRowModel {
  String? rightValue, rightTitle;
  String? leftValue, leftTitle;

  CommonItemRowModel({
    this.rightValue,
    this.rightTitle,
    this.leftValue,
    this.leftTitle,
  });
}

class CommonItem extends StatelessWidget {
   CommonItem({Key? key, this.data = const [],this.isCardShow}) : super(key: key);
  final List<CommonItemRowModel> data;
  bool? isCardShow;

  @override
  Widget build(BuildContext context) {
    return isCardShow==true
      ?Card(
       margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 5,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,20,30,10),
        child: Column(
          children: data.map((e) => rowItem(e)).toList(),
        ),
      ),
    )
    : Padding(
      padding: const EdgeInsets.fromLTRB(30,20,30,10),
      child: Column(
        children: data.map((e) => rowItem(e)).toList(),
      ),
    );
  }
  Widget rowItem(CommonItemRowModel value) {
    return Row(
      children: [
        columnItem(name: value.leftTitle, value: value.leftValue),
        const Spacer(),
        if(value.rightTitle!=null)
          columnItem(name: value.rightTitle, value: value.rightValue),
      ],
    );
  }

  Widget columnItem({String? name, String? value}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? '',
            style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
          ),
          const SizedBox(height: 5),
          Text(
            value ?? 'N/A',
            style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
