import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/color.dart';
import 'login_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void _handleHttpError(int statusCode, String? message) {
    String errorMsg;

    switch(statusCode) {
      case 400:
        errorMsg = message ?? "অনুরোধটি ভুল ফরম্যাটে পাঠানো হয়েছে";
        break;
      case 404:
        errorMsg = "API এন্ডপয়েন্ট খুঁজে পাওয়া যায়নি";
        break;
      default:
        errorMsg = "সার্ভার ত্রুটি ($statusCode)";
    }

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg))
    );
  }

  bool isLoading=false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController userControllar=TextEditingController();
  final TextEditingController mobileControllar=TextEditingController();
  final TextEditingController refcodeController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();


  final String URL="https://probashipower.com/api/user-register";
  Future<void> fetchRegister() async {
    if(_formkey.currentState!.validate()) {
      try {
        final username=userControllar.text.trim();
        final mobile=mobileControllar.text.trim();
        final password=passwordController.text.trim();
        if (username.isEmpty || mobile.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("সব ফিল্ড পূরণ করুন"),
          ));
          return;
        }
        final response = await http.post(Uri.parse(URL),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            },
            body: {
          "username": username,
            "mobile": mobile,
            "password": password,
            if (refcodeController.text.trim().isNotEmpty)
    "refcode": refcodeController.text.trim(),
    },
    ).timeout(Duration(seconds: 10));
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
        if (response.statusCode == 200) {
         var responseDate=jsonDecode(response.body);
         print(response.body);
         if (responseDate["status"] == "success") {
           final prefs = await SharedPreferences.getInstance();
           prefs.setString("token", responseDate["data"]["token"]);
           prefs.setString("userid", responseDate["data"]["userid"].toString());
           prefs.setString("username", responseDate["data"]["name"]);
           prefs.setString("mobile", responseDate["data"]["mobile"]);
           prefs.setString("ref_id",responseDate["data"]["ref_id"]);

           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (context) => LoginScreen()),
                 (route) => false,
           );

          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(responseDate["message"]??"Registration Failed")));
          }
        } else {
          _handleHttpError(response.statusCode, jsonDecode(response.body)['message']);
        }

      } catch (e) {
        _handleHttpError(500, "নেটওয়ার্ক ত্রুটি");

      }finally {
        setState(() => isLoading = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor().ScendaryColor,
              border: Border.all(color: AppColor().colorBlue,width: 3)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
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
                      child: Text("probashi power Register",style: TextStyle(
                        color: AppColor().colorBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),),
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                        },
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "অ্যাকাউন্ট আছে?",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22
                              )
                              ),
                              TextSpan(
                                  text: "লগইন করুন",style: TextStyle(
                                color: AppColor().colorBlue,
                                fontSize: 22,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor().colorBlue,
                              )
                              )
                            ]
                        ),),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text("ইউজার নাম",style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),),
                    TextFormField(
                      validator: (value) {
                        if(value==null || value.isEmpty){
                          return"ইউজার নাম আবশ্যক";
                        }
                        return null;
                      },
                      controller: userControllar,
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
                          hintText: "ইউজার নাম...",
                          hintStyle: TextStyle(
                              fontSize: 18
                          )

                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("মোবাইল নং",style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),),
                    SizedBox(height: 10,),
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
                          ),


                      ),
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Text("সঠিক মোবাইল নাম্বার লিখুন",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),),
                    ),
                    Text("রেফার কোড",style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),),
                    SizedBox(height: 10,),
                    TextField(
                      controller: refcodeController,
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
                          hintText: "রেফার কোড...",
                          hintStyle: TextStyle(
                              fontSize: 18
                          )

                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("পাসওয়ার্ড",style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),),
                    SizedBox(height: 10,),
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
                        hintText: "পাসওয়ার্ড"
                      ),
                      obscureText: true,
                      obscuringCharacter: "#",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),
                    ),
                    Center(
                      child: Text("কমপক্ষে 6 ক্যারেক্টারের পাসওয়ার্ড প্রদান",style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),),
                    ),
                    Center(
                      child: Text("করুন",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: ElevatedButton(onPressed: () {
                        fetchRegister();
                      },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor().colorBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: Size(250, 50)
                          ), child: Text("পরবর্তী",style: TextStyle(
                              fontFamily: "NotoSansBengali",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:FontWeight.w600
                          ))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

