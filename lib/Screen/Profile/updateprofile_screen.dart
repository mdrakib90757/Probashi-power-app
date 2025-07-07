import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../Layout/main_layout.dart';
import '../../Widget/custom_imagepicker.dart';
import '../../utils/color.dart';

class UpdateprofileScreen extends StatefulWidget {
  const UpdateprofileScreen({super.key});

  @override
  State<UpdateprofileScreen> createState() => _UpdateprofileScreenState();
}

class _UpdateprofileScreenState extends State<UpdateprofileScreen> {
  File?seleectImage;

  void UpdateProfile(){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MainLayout(initialScreen: 1,
      profileImage: seleectImage,
      ),));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor().ScendaryColor,
            border: Border.all(color: AppColor().colorBlue,width: 3)
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Column(
      
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("প্রোফাইল আপডেট",style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSansBengali",
                      fontWeight: FontWeight.w600,
                      fontSize: 22
                    ),),
                  ),
                  Text("নাম",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15
                  ),),
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
                    hintText: "নাম"
                  ),),
                  SizedBox(height: 10,),
                  Text("মোবাইল নং (লগ ইন)",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),),
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
                      hintText: "মোবাইল নং"
                  ),),
                  SizedBox(height: 10,),
                  Text("ঠিকানা)",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),),
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
                      hintText: "ঠিকানা"
                  ),),
                  SizedBox(height: 10,),
                  Text("হোয়াটস অ্যাপ নং)",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),),
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
                      hintText: "হোয়াটসঅ্যাপ নং"
                  ),),
                  SizedBox(height: 10,),
                  Text("ই-মেইল)",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),),
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
                      hintText: "ই-মেইল"
                  ),),
                  SizedBox(height: 10,),
                  CustomImagepicker(onImagepicked: (image) {
                    setState(() {
                      seleectImage=image;
                    });
                  },),
                  SizedBox(height: 20,),

                  Center(
                    child: ElevatedButton(onPressed: () {
                      UpdateProfile();
                    },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor().colorBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minimumSize: Size(140, 40)
                        ), child: Text("আপডেট করুন",style: TextStyle(
                            fontFamily: "NotoSansBengali",
                            color: Colors.white,
                            fontSize: 16
                        ))),
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
