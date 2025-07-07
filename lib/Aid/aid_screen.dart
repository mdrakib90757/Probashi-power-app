import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:probashi_power_project/Provider/auth_provider.dart';
import 'package:probashi_power_project/Screen/auth_screen/login_screen.dart';
import 'package:provider/provider.dart';

import '../Layout/main_layout.dart';
import '../utils/color.dart';
import 'package:http/http.dart'as http;



class AidScreen extends StatefulWidget {
  const AidScreen({super.key});

  @override
  State<AidScreen> createState() => _AidScreenState();
}

class _AidScreenState extends State<AidScreen> {
  List<LegalHelpModel>LegalHelplist=[];
  
  Future<LegalHelpModel?> fetchLegalHelp()async{
    final response=await http.get(Uri.parse(
        "https://probashipower.com/api/legal-help-list"));
    if(response.statusCode==200){
     // final decodedData=jsonDecode(response.body);
      print(response.body);
      final List<dynamic>decodedData=jsonDecode(response.body);
      setState(() {
        LegalHelplist=List<LegalHelpModel>.from(
            decodedData.map((data)=>LegalHelpModel.fromJson(data)));
      });

    }else{
      print("Error${response.body}");
      print("Error${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLegalHelp();
  }

  @override
  Widget build(BuildContext context) {
    if(LegalHelplist.isEmpty){
      return Center(child: CircularProgressIndicator(),);
    }
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/homepageicon/aid.png",
                    height: 60,width: 60,color: Colors.deepOrange,),
                  SizedBox(height: 20,),
                  Text("আইনি সহায়তা",style: TextStyle(
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
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: LegalHelplist.length,
                    itemBuilder: (context, index) {
                      final legalData=LegalHelplist[index];
                      return Container(
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
                              Center(
                                child: Text("নাম: ${legalData.helpname}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 16
                                ),),
                              ),
                              Center(
                                child: Text("মোবাইল নং: ${legalData.helpcontact}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "NotoSansBengali"
                                  ),),
                              ),
                              SizedBox(height: 20,),
                              ElevatedButton(onPressed: () {
                                final authProvider=Provider.of<AuthProvider>(context,listen: false);
                                if(authProvider.isLoggedIn){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                                      (context) =>MainLayout(initialScreen: 30,)),(route) => false,);
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      ),
    );

  }
}
