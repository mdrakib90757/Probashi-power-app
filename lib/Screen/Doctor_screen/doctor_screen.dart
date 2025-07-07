import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:provider/provider.dart';

import '../../Layout/main_layout.dart';
import '../../Provider/auth_provider.dart';
import '../../utils/color.dart';
import 'package:http/http.dart'as http;

import '../auth_screen/login_screen.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  List<DoctorModel>Doctorlist=[];


  Future<List<DoctorModel>> fetchDoctorDetails()async{
    final response=await http.get(Uri.parse(
        "https://probashipower.com/api/doctor-list"));

    if(response.statusCode==200){
      final List<dynamic> jsondata=jsonDecode(response.body);
      return jsondata.map((Data)=>DoctorModel.fromJson(Data)).toList();

    }else{
      print("${response.statusCode}");
      print("${response.body}");
      throw Exception("Failed to load doctor data");
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDoctorDetails().then((doctorData) {
      setState(() {
        Doctorlist=doctorData;
      });
    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor().ScendaryColor,
                  border: Border.all(
                      width: 3,
                      color: AppColor().colorBlue),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Image.asset("assets/homepageicon/femaledoctor.png",
                        height: 50,width: 50,),
                    ),
                    Text("ডাক্তার",style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black)
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
                    SizedBox(height: 20,),
                    Doctorlist.isEmpty?Center(child: CircularProgressIndicator(),):
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Doctorlist.length,
                      itemBuilder: (context, index) {
                        final Doctor=Doctorlist[index] ;
                        return Container(
                          height: 150,
                          width: double.infinity,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColor().colorWhit
                          ),
                          child: Column(
                            children: [
                              Text("নাম:${Doctor.doctorname}",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),),
                              SizedBox(height: 10,),
                              Text("স্পেশালটি: ${Doctor.doctorspeciality}",
                                style: TextStyle(
                                    fontSize: 15,

                                    color: Colors.black
                                ),),

                              SizedBox(height: 10,),
                              ElevatedButton(onPressed: () {
                                final authProvider=Provider.of<AuthProvider>(context,listen: false);
                                if(authProvider.isLoggedIn){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                      builder:(context) => MainLayout(initialScreen: 26,)),
                                        (route) => false,
                                  );
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                }


                                },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor().colorBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: Size(100, 40)
                                  ), child: Text("বিস্তারিত দেখুন",style: TextStyle(
                                      fontFamily: "NotoSansBengali",
                                      color: Colors.white,
                                      fontSize: 16
                                  )))
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
