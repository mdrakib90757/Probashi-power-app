import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:provider/provider.dart';

import '../../Layout/main_layout.dart';
import '../../Provider/auth_provider.dart';
import '../../utils/color.dart';
import 'package:http/http.dart'as http;

class ProbashiInformationScreen extends StatefulWidget {
  const ProbashiInformationScreen({super.key});

  @override
  State<ProbashiInformationScreen> createState() => _ProbashiInformationScreenState();
}

class _ProbashiInformationScreenState extends State<ProbashiInformationScreen> {

  List<ProbashiInfoModel>ProbashiInfolist=[];



  Future<List<ProbashiInfoModel>?>fetchProbashiInfo()async {
    final response = await http.get(Uri.parse(
        "https://probashipower.com/api/probash-info-list"));
    try {
      if (response.statusCode == 200) {
        final List<dynamic>infoData = jsonDecode(response.body);
        print(response.body);
        print(infoData);
        return infoData.map((data) => ProbashiInfoModel.fromJson(data))
            .toList();
      } else {
        print("Error${response.body}");
        return null;
      }
    }catch(e){
      print("Error${e}");
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProbashiInfo().then((data){
      if(data!=null){
        setState(() {
          ProbashiInfolist=data;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
              child: Image.asset("assets/homepageicon/news.png",
                height: 60,width: 60,),
            ),
            Text("প্রবাস খবর",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 30,),

            SizedBox(height: 20,),
           ProbashiInfolist.isEmpty?Center(child: CircularProgressIndicator(),):
               ListView.builder(
                 shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                 itemCount: ProbashiInfolist.length,
                   itemBuilder: (context, index) {
                   final data=ProbashiInfolist[index];
               return Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    color: AppColor().colorWhit
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text("${data.newstitle}",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),)),
                      SizedBox(height: 20,),
                      Center(child: Image.network("${data.newsimg}",height: 200,width: 200,)),
                      SizedBox(height: 15,),
                      Stack(children: [
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColor().ScendaryColor,
                            border: Border.all(color: Colors.black.withOpacity(0.5))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(

                            children: [
                              FaIcon(FontAwesomeIcons.calendarDays),
                              SizedBox(width: 10,),
                              Text("${data.date}",style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                              ),)
                            ]
                            ),
                          ),
                        )
                      ],),
                      SizedBox(height: 15,),

                      Center(
                        child: ElevatedButton(onPressed: () {
                          },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor().colorBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: Size(100, 40)
                            ), child: Text("বিস্তারিত পড়ুন ",style: TextStyle(
                                fontFamily: "NotoSansBengali",
                                color: Colors.white,
                                fontSize: 16
                            ))),
                      ),


                    ],
                  ),
                ),

             );
               })
          ],
        ),
      ),

      ),
    );

  }
}