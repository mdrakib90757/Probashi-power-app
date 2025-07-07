





import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:probashi_power_project/Provider/auth_provider.dart';
import 'package:probashi_power_project/utils/color.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyRateScreen extends StatefulWidget {
  const MoneyRateScreen({super.key});

  @override
  State<MoneyRateScreen> createState() => _MoneyRateScreenState();
}

class _MoneyRateScreenState extends State<MoneyRateScreen> {

  List<MoneyData>moneyrateList=[];
  String?_token;
  String? get token => _token;

  Future<void> fetchMoneyRate()async{
    final prefs=await SharedPreferences.getInstance();
    _token= prefs.getString("token");

    final response=await http.get(Uri.parse("https://probashipower.com/api/money-rate"),
      headers: {
      "Authorization":"Bearer${token}",
        'Content-Type': 'application/json',
      });
      if(response.statusCode==200){
       final jsonData=jsonDecode(response.body);
       print(jsonData);
       final moneyModel=MoneyModel.fromJson(jsonData);
       setState(() {
          moneyrateList=moneyModel.data;
       });
    }else{
       print("Error ${response.statusCode}");
       print("Error ${response.body}");
      }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMoneyRate();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Container(
        height: MediaQuery.of(context).size.height/1.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor().ScendaryColor,
          border: Border.all(color: AppColor().colorBlue,width: 3)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Image.asset("assets/homepageicon/inflation-rate.png",
              height: 60,
                width: 60,
                color: Colors.deepOrange,
              ),
              SizedBox(height: 15,),
              Text("আজকের টাকার রেট",style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),),

              SizedBox(height: 20,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: moneyrateList.length,
                itemBuilder: (context, index) {
                  final data=moneyrateList[index];
                return Container(
                  height: 170,
                  width: double.infinity,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColor().colorWhit,
                    border: Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${data.title} - ${data.date}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.underline
                      ),),
                      Text("${data.rateDetails}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),)
                    ],
                  ),
                );
              },)

            ],
          ),
        ),
      ),
    );

  }
}
