import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probashi_power_project/Provider/auth_provider.dart';
import 'package:probashi_power_project/Screen/auth_screen/register_screen.dart';
import 'package:probashi_power_project/Screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Layout/main_layout.dart';
import '../../utils/color.dart';
import 'package:http/http.dart'as http;
import '../../Provider/auth_provider.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController mobileControllar=TextEditingController();
  final TextEditingController passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    //final authProvider=Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor().ScendaryColor,
              border: Border.all(color: AppColor().colorBlue,width: 3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Center(
                     child: Image.asset("assets/homepageicon/ppr.png",
                       height: 120,width: 120,),
                   ),
                    Center(
                      child: Text("Probashi Power",style: TextStyle(
                        color: AppColor().colorBlue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: GestureDetector(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                       },
                      child : RichText(text: TextSpan(
                         children: [
                           TextSpan(
                             text: "অ্যাকাউন্ট নেই?",style: TextStyle(
                             color: Colors.black,
                             fontSize: 20
                           )
                           ),
                           TextSpan(
                             text: "এখানে রেজিস্টার করুন",style: TextStyle(
                             color: AppColor().colorBlue,
                             fontSize: 20,
                             decoration: TextDecoration.underline,
                             decorationColor: AppColor().colorBlue,
                           )
                           )
                         ]
                       ),),
                     ),
                   ),
                   SizedBox(height: 15,),
                   Text("মোবাইল নং",style: TextStyle(
                     fontSize: 20,
                     color: Colors.black
                   ),),
                    TextFormField(
                      validator: (value) {
                        if(value==null || value.isEmpty){
                          return"মোবাইল নম্বর আবশ্যক";
                        }else if(value.length!=13){
                          return"'13 সংখ্যার সঠিক মোবাইল নম্বর দিন";
                        }
                        return null;
                      },
                      controller: mobileControllar,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                        ),
                        fillColor: AppColor().colorWhit,
                        filled: true,
                        hintText: "মোবাইল নং...",
                        hintStyle: TextStyle(
                          fontSize: 18
                        )

                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("পাসওয়ার্ড",style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),),
                    TextFormField(
                      validator: (value) {
                        if(value==null || value.isEmpty){
                          return'পাসওয়ার্ড আবশ্যক';
                        }else if(value.length<6){
                          return"কমপক্ষে ৬ অক্ষরের পাসওয়ার্ড দিন";
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                          ),
                          fillColor: AppColor().colorWhit,
                          filled: true,
                          hintText: "পাসওয়ার্ড...",
                          hintStyle: TextStyle(
                              fontSize: 18
                          )

                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: ElevatedButton(onPressed: () async {
                        final authProvider=Provider.of<AuthProvider>(context,listen: false);
                       final success=await authProvider.login(
                           mobileControllar.text.trim(),
                           passwordController.text.trim(),
                       );
                       if(success){
                         Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (context) => MainLayout(initialScreen: 0,),));
                       }else{
                         ScaffoldMessenger.of(context).
                         showSnackBar(SnackBar(content: Text("Login Failed")));
                       }
                      },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor().colorBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: Size(300, 50)
                          ), child: Text("লগইন",style: TextStyle(
                              fontFamily: "NotoSansBengali",
                              color: Colors.white,
                              fontSize: 18,
                            fontWeight:FontWeight.bold
                          ))),
                    ),
                    SizedBox(height: 30,),
                    Center(child: Text("পাস্ওয়াার্ড মনে নেই?",style: TextStyle(
                      color: AppColor().colorBlue,
                      decorationColor: AppColor().colorBlue,
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),)),
                    SizedBox(height: 50,)
                  ],),
              )),
            ),),
        ),);

  }
}



