import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'paymenfollow up/payment_followup_view.dart';


class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Screen'),
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),

            ElevatedButton(onPressed: ()=> Get.to(PaymentFollowupView()),
                child: Text('Payment Followup')
            ),



          ],
        ),
      ),
    );
  }
}
