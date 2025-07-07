import 'package:flutter/material.dart';

import '../../Layout/main_layout.dart';
import '../../utils/color.dart';

class RefarIncomeScreen extends StatefulWidget {
  const RefarIncomeScreen({super.key});

  @override
  State<RefarIncomeScreen> createState() => _RefarIncomeScreenState();
}

class _RefarIncomeScreenState extends State<RefarIncomeScreen> {
  List<Map<String,dynamic>>refarlist=[
    {
      "প্যাকেজ":"Package-",
      "মূল্য":"2 রিয়াল ",
      "কোয়ান্টিটি":"2"
    },
    {
      "প্যাকেজ":"Package-",
      "মূল্য":"7 রিয়াল ",
      "কোয়ান্টিটি":"1"
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
              border: Border.all(color: AppColor().colorBlue,width: 3)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
                children: [
                  Image.asset("assets/homepageicon/gift-box.png",height: 50,width: 50,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(height: 20,),
                  Text("মেম্বার প্যাকেজ",style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSansBengali",
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                        ),
                        filled: true,
                        fillColor: AppColor().colorWhit,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/homepageicon/search.png",
                            height: 30,width: 30,),
                        ),
                        hintText: "খুঁজুন....",
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text("সঠিক প্যাকেজ ক্রয় করুণ!",style: TextStyle(
                            fontFamily: "NotoSansBengali",
                            color: Colors.green.shade800,
                            fontSize: 18
                        ),),
                      ),
                    ),
                  ),//
                  SizedBox(height: 10,),
                  ListView.builder(
                    itemCount: refarlist.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {

                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColor().colorWhit
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("প্যাকেজ:${refarlist[index]["প্যাকেজ"]}",style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                                Text("মূল্য:${refarlist[index]["মূল্য"]}",
                                  style: TextStyle(
                                      fontFamily: "NotoSansBengali",
                                      fontSize: 15,color: Colors.black
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(refarlist[index]["কোয়ান্টিটি"],
                                  style: TextStyle(
                                      fontFamily: "NotoSansBengali",
                                      fontSize: 15,color: Colors.black
                                  ),),
                              ],
                            ),
                            SizedBox(height: 15,),
                            ElevatedButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MainLayout(initialScreen: 25,)));
                            },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor().colorBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minimumSize: Size(140, 40)
                                ), child: Text("বিস্তারিত",style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    color: Colors.white,
                                    fontSize: 16
                                )))

                          ],
                        ),
                      );
                    },
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
