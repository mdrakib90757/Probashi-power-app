

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';

import '../Layout/main_layout.dart';
import '../utils/color.dart';
import 'package:http/http.dart' as http;

class AidmemPackge extends StatefulWidget {
  const AidmemPackge({super.key});

  @override
  State<AidmemPackge> createState() => _AidmemPackgeState();
}



class _AidmemPackgeState extends State<AidmemPackge> {

  List<PackageListModel>Legalhelp_packageList=[];
  Future<PackageListModel?>fetchPackageList()async{
    try{
      final responose=await http.get(Uri.parse(
          "http://probashipower.com/api/package-list"));
      if(responose.statusCode==200){
        final List<dynamic>jsonData=jsonDecode(responose.body);
        print(responose.body);
        setState(() {
          Legalhelp_packageList=List<PackageListModel>.
          from(jsonData.map((item)=>PackageListModel.fromJson(item)));
        });

      }else{
        print("Failed the package${responose.body}");
      }
    }catch(e){
      print("Error ${e}");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPackageList();
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
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
                children: [
                  Image.asset("assets/homepageicon/gift-box.png",height: 50,width: 50,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(height: 20,),
                  Text("মেম্বার প্যাকেজ",style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NotoSansBengali",
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
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
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text("সঠিক প্যাকেজ ক্রয় করুণ!",style: TextStyle(
                            fontFamily: "NotoSansBengali",
                            color: Colors.green.shade800,
                            fontSize: 18
                        ),),
                      ),
                    ),
                  ),//
                  SizedBox(height: 10,),
                  Legalhelp_packageList.isEmpty?Center(
                    child: CircularProgressIndicator(),):
                  ListView.builder(
                    itemCount: Legalhelp_packageList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final LegalData=Legalhelp_packageList[index];
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColor().colorWhit
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("প্যাকেজ:${LegalData.name}",style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                                Text("মূল্য:${LegalData.rate}",
                                  style: TextStyle(
                                      fontFamily: "NotoSansBengali",
                                      fontSize: 15,color: Colors.black
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 15,),
                            ElevatedButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MainLayout(initialScreen: 31,selectedPackage: LegalData,)));
                            },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor().colorBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minimumSize: Size(140, 40)
                                ), child: Text("বিস্তারিত",style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    color: Colors.white,
                                    fontSize: 16
                                )))

                          ],
                        ),
                      );
                    },
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
