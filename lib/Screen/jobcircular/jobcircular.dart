import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Screen/auth_screen/login_screen.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;

import '../../Data_Models/post_models.dart';
import '../../Layout/main_layout.dart';
import '../../Provider/auth_provider.dart';
import '../../utils/color.dart';

class Jobcircular extends StatefulWidget {
  const Jobcircular({super.key});
  @override
  State<Jobcircular> createState() => _JobcircularState();
}

class _JobcircularState extends State<Jobcircular> {
  bool isLoading=false;

  List<JobOffer>joblist=[];

  Future<List<dynamic>?>fetchJobcircular()async {
    try {
      final response = await http.get(
          Uri.parse("https://probashipower.com/api/job-list"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final offerResponse = OfferResponse.fromJson(data);
        // return offerResponse.offers;
        setState(() {
          joblist = offerResponse.offers;
          isLoading=false;
        });
      } else {
        throw Exception("Failed to load jobs");
      }
    }catch(e){
      print("Error fetching job${e}");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchJobcircular();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);
    final size=MediaQuery.of(context).size;
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
                    child: Image.asset("assets/homepageicon/suitcase.png",
                      height: 50,width: 50,color: Colors.deepOrange,),
                  ),
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
                  joblist.isEmpty?Center(child: CircularProgressIndicator(),):
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: joblist.length,
                      itemBuilder: (context, index) {
                      final job=joblist[index];
                      return Container(
                        height: 150,
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.1)),
                          color: AppColor().colorWhit
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("পদবি:${job.jobtitle}",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text("বেতন:${job.jobSalary} }",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("কোম্পানি:${job.companyName}",style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),),
                                Text("কর্মস্থল:${job.companyAddress}",
                                  style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                      fontSize: 15,
                                      color: Colors.black
                                  ),),
                              ],
                            ),
                            SizedBox(height: 10,),
                            ElevatedButton(onPressed: () {
                              final authProvider=Provider.of<AuthProvider>(context,listen: false);
                              if(authProvider.isLoggedIn){
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    builder:(context) => MainLayout(initialScreen: 19,)),
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
