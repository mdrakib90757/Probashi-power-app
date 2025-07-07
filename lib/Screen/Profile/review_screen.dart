import 'package:flutter/material.dart';

import '../../utils/color.dart';


class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Container(
        height: MediaQuery.of(context).size.height/2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor().ScendaryColor,
          border: Border.all(color: AppColor().colorBlue,width: 3)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/homepageicon/suitcase.png",
                  color: Colors.deepOrange,height: 60,width: 60,),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("অ্যাপ সম্পর্কে আপনার মতামত",style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500
                ),),
              ),

              SizedBox(height: 20,),
              Text("দেশ",style: TextStyle(
                  color: Colors.black,
                  fontSize: 15
              ),),
              SizedBox(height: 5,),
              TextField(decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade400)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade400
                      )
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "দেশ"
              ),),
              SizedBox(height: 10,),
              Text("রিভিউ",style: TextStyle(
                  color: Colors.black,
                  fontSize: 15
              ),),
              SizedBox(height: 5,),
              TextField(decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade400)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade400
                      )
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "রিভিউ"
              ),),
              SizedBox(height: 30,),

              Center(
                child: ElevatedButton(onPressed: () {
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor().colorBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(140, 40)
                    ), child: Text("সাবমিট করুন ",style: TextStyle(
                        fontFamily: "NotoSansBengali",
                        color: Colors.white,
                        fontSize: 16
                    ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
