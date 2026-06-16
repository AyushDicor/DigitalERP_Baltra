import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:flutter/material.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Center(
            child: Container(
             padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              height: 200,
              width: double.infinity,
              // decoration: BoxDecoration(
              //   border: Border.all()
              // ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              Text('10k',style: TextStyle().xstyle,),
                              SizedBox(height: 10,),
                              Text('8k'),
                              SizedBox(height: 10,),
                              Text('6k'),
                              SizedBox(height: 10,),
                              Text('4k'),
                              SizedBox(height: 10,),
                              Text('2k'),
                              SizedBox(height: 10,),
                              Text('0'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 30,),
                            Column(children: [
                              Text('9K',style: TextStyle().xstyle,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
                                    Container(
                                        height: 30,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),color: Colors.green)
                                    ) ,
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('Sat',style: TextStyle().xstyle,),


                            ],),
                            SizedBox(width: 50,),
                            Column(children: [
                              Text('10K',style: TextStyle().xstyle,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
                                    Container(
                                        height: 30,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),color: Colors.green)
                                    ) ,
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('Sun',style: TextStyle().xstyle,),

                            ],),
                            SizedBox(width: 50,),
                            Column(children: [
                              Text('1.8K',style: TextStyle().xstyle,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
                                    Container(
                                        height: 30,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),color: Colors.green)
                                    ) ,
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('Mon',style: TextStyle().xstyle,),


                            ],),
                            SizedBox(width: 50,),
                            Column(children: [
                              Text('3.6K',style: TextStyle().xstyle,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
                                    Container(
                                        height: 30,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),color: Colors.green)
                                    ) ,
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('Thu',style: TextStyle().xstyle,),

                            ],
                            ),
                            SizedBox(width: 50,),
                            Column(children: [
                              Text('4.1K',style: TextStyle().xstyle,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
                                    Container(
                                        height: 30,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),color: Colors.green)
                                    ) ,
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('Wed',style: TextStyle().xstyle,),

                            ],),
                            SizedBox(width: 50,),
                            Column(children: [
                              Text('3K',style: TextStyle().xstyle,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
                                    Container(
                                        height: 30,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),color: Colors.green)
                                    ) ,
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('Thu',style: TextStyle().xstyle,),

                            ],),
                            SizedBox(width: 50,),
                            Column(children: [
                              Text('6.4K',style: TextStyle().xstyle,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),),
                                    Container(
                                        height: 30,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),color: Colors.green)
                                    ) ,
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('Fri',style: TextStyle().xstyle,),

                            ],)
                          ],),
                      ],
                    ),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
