

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../Layout/main_layout.dart';
import '../../utils/color.dart';

class RefarPurchacesScreen extends StatefulWidget {
  const RefarPurchacesScreen({super.key});

  @override
  State<RefarPurchacesScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<RefarPurchacesScreen> {
  List<Map<String,dynamic>> refarpackagelist=[
    {
      "প্যাকেজ নাম":"Package-2",
      "প্যাকেজ মূল্য":"2 রিয়াল",
      "সময়কাল":"30 দিন",
      "সুবিধা":" চাকরি,ডাক্তার, চাকরি দিবো, আইনি সহায়তা,প্রবাস ইনফরমেশন"
    },

  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor().ScendaryColor,
              border: Border.all(color: AppColor().colorBlue,
                  width: 3
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [
                Image.asset("assets/homepageicon/taka.png",
                  height: 60,width: 60,),
                SizedBox(height: 20,),
                Text("প্যাকেজ ক্রয়",
                  style: TextStyle(
                      fontFamily: "NotoSansBengali",
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 20,),
                Text("ইসলামী ব্যাংক - 205012502025008",style: TextStyle(
                    color: Colors.black,
                    fontFamily: "NotoSansBengali",
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),),
                Text("বিকাশ - 01333454832",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSansBengali",
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text("DBBL - 896598929789",style: TextStyle(
                    color: Colors.black,
                    fontFamily: "NotoSansBengali",
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),),
                SizedBox(height: 20,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: refarpackagelist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      //height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor().colorWhit,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("প্যাকেজ নাম - ${refarpackagelist[index]["প্যাকেজ নাম"]}",
                              style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("প্যাকেজ মূল্য -${refarpackagelist[index]["প্যাকেজ মূল্য"]}",
                              style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                            SizedBox(height: 30,),
                            Text("সময়কাল-${refarpackagelist[index]["সময়কাল"]}",
                              style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                            SizedBox(height: 25,),
                            Text("সুবিধা -${refarpackagelist[index]["সুবিধা"]}",
                              style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(height: 20,),

                            Center(
                              child: ElevatedButton(onPressed: () {
                              },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor().colorBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: Size(140, 40)
                                  ), child: Text("ক্রয় করুন ",style: TextStyle(
                                      fontFamily: "NotoSansBengali",
                                      color: Colors.white,
                                      fontSize: 16
                                  ))),
                            )
                          ],
                        ),
                      ),
                    );
                  },),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
