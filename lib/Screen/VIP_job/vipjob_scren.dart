import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:provider/provider.dart';


import '../../Layout/main_layout.dart';
import '../../Provider/auth_provider.dart';
import '../../utils/color.dart';
import 'package:http/http.dart' as http;

import '../auth_screen/login_screen.dart';

class VipjobScren extends StatefulWidget {
  const VipjobScren({super.key});

  @override
  State<VipjobScren> createState() => _VipjobScrenState();
}

class _VipjobScrenState extends State<VipjobScren> {
  List<VipOffers>vipjobData=[];
  Future<void>fetchVipjob()async{
    try{
    final response=await http.get(Uri.parse("https://probashipower.com/api/vip-job-list"));

    if(response.statusCode==200){
      final jsonData=jsonDecode(response.body);
      print(response.body);
      final offerjob=Vipjoblist.fromJson(jsonData);
      setState(() {
        vipjobData=offerjob.offers;

      });
    }else{
      throw Exception("fetchData Error");
    }
  }catch(e){
      print("Error fetchingJob ${e}");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVipjob();
  }
  
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
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              children: [
                Image.asset("assets/homepageicon/suitcase.png",
                  height: 60,width: 60,color: Colors.deepOrange,),
                SizedBox(height: 20,),
                Text("চাকরি বিজ্ঞাপন",style: TextStyle(
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
                vipjobData.isEmpty?Center(child: CircularProgressIndicator(),):
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vipjobData.length,
                  itemBuilder: (context, index) {
                    final data=vipjobData[index];
                    return Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor().colorWhit
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Text("পদবি:${data.jobTitle}",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "NotoSansBengali",
                              fontSize: 16
                            ),),
                            Text("বেতন:${data.jobSalary}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "NotoSansBengali"
                              ),),
                            SizedBox(height: 10,),
                            Text("কোম্পানি:${data.companyName}",style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "NotoSansBengali",
                            ),),
                            SizedBox(height: 10,),
                            Text("কর্মস্থল:${data.companyAddress}",
                              style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  fontSize: 15,
                                  color: Colors.black
                              ),),
                            SizedBox(height: 20,),
                            ElevatedButton(onPressed: () {
                              final authProvider=Provider.of<AuthProvider>(context,listen: false);
                              if(authProvider.isLoggedIn){
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    builder:(context) => MainLayout(initialScreen: 21,)),
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
                                    fontSize: 16,
                                  fontWeight: FontWeight.w700
                                )))
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
