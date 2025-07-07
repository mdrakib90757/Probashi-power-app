import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:probashi_power_project/Screen/Job_scaker/lobseaker_screen.dart';

import '../../utils/color.dart';
import 'package:http/http.dart'as http;

class LoandetailsScreen extends StatefulWidget {
  final LoanModel?selectData;
  const LoandetailsScreen({super.key, this.selectData});

  @override
  State<LoandetailsScreen> createState() => _LoandetailsScreenState();
}

class _LoandetailsScreenState extends State<LoandetailsScreen> {
  List<LoanModel>loandetails=[];

  Future<void>fetchLoanDetails()async {
    try {
      final response = await http.get(
          Uri.parse("https://probashipower.com/api/loan-scheme-list"));
      if (response.statusCode == 200) {
        final List<dynamic>jsonData = jsonDecode(response.body);

        setState(() {
          loandetails = List<LoanModel>.from(
              jsonData.map((data) => LoanModel.fromJson(data))).toList();
        });
      } else {
        print("Failed the Load Data${response.body}");
      }
    }catch(e){
      print("Error:${e}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLoanDetails();
  }
  @override
  Widget build(BuildContext context) {
    final LoanData=widget.selectData;
    if(LoanData==null){
      return Center(
        child: Text('No Data Found'),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Container(
          //height: MediaQuery.of(context).size.height,
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

                    Container(
                      height:400,
                      width: double.infinity,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor().colorWhit
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("লোনের নাম: ${LoanData.loanName}",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "NotoSansBengali",
                                fontSize: 18
                            ),),
                            Text("ইন্টারেষ্ট: ${LoanData.loadInterest}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "NotoSansBengali"
                              ),),
                            SizedBox(height: 15,),
                            Text("প্রদেয় অর্থ:${LoanData.loanAmount}",style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: "NotoSansBengali",
                            ),),
                            SizedBox(height: 15,),
                            Text("পরিশোধের সময়:${LoanData.loadDuation}",
                              style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  fontSize: 18,
                                  color: Colors.black
                              ),),
                            SizedBox(height: 15,),
                            Text("বিস্তারিত:${LoanData.loadDetails}",
                              style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  fontSize: 18,
                                  color: Colors.black
                              ),),
                          ],
                        ),
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
