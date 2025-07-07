import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:provider/provider.dart';

import '../../Layout/main_layout.dart';
import '../../Provider/auth_provider.dart';
import '../../utils/color.dart';
import 'package:http/http.dart' as http;

import '../auth_screen/login_screen.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  List<LoanModel>loanlist=[];

  Future<void>fetchLoanModel()async{
    try{
      final response=await http.get(Uri.parse(
          "https://probashipower.com/api/loan-scheme-list"));
      
      if(response.statusCode==200){
        final List<dynamic> jData=jsonDecode(response.body);
        print(response.body);
      setState(() {
        loanlist= List<LoanModel>.from(jData.map((item)=>LoanModel.fromJson(item))).toList();
      });
        
      }else{
        print("Failed the load data");
      }
    }catch(e){
      print("Error${e}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLoanModel();
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
                Image.asset("assets/homepageicon/taka22.png",
                  height: 60,width: 60,),
                SizedBox(height: 20,),
                Text("লোন স্কিম ও সুবিধাসমূহ",style: TextStyle(
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
                loanlist.isEmpty?Center(child: CircularProgressIndicator(),):
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: loanlist.length,
                  itemBuilder: (context, index) {
                    final loan=loanlist[index];
                    return Container(
                      height: 220,
                      width: double.infinity,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor().colorWhit
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          children: [
                            Text("লোনের নাম:${loan.loanName}",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "NotoSansBengali",
                                fontSize: 18,
                            ),),
                            Text("প্রদেয় অর্থ:${loan.loanAmount} }",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "NotoSansBengali"
                              ),),
                            Text("ইন্টারেষ্ট:${loan.loadInterest}",style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "NotoSansBengali",
                            ),),
                            Text("পরিশোধের সময়:${loan.loadDuation}",
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
                                    builder:(context) => MainLayout(initialScreen: 24,)),
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
