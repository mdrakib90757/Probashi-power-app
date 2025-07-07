import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Data_Models/post_models.dart';
import '../../utils/color.dart';
import 'package:http/http.dart ' as http;

class MembenifitsPurchasesScreen extends StatefulWidget {
  final PackageListModel?selectPackage;
  const MembenifitsPurchasesScreen({super.key, this.selectPackage});

  @override
  State<MembenifitsPurchasesScreen> createState() => _MembenifitsPurchasesScreenState();
}

class _MembenifitsPurchasesScreenState extends State<MembenifitsPurchasesScreen> {
  List<BankModel> BankList=[];
  List<PackageListModel>PackList=[];

  Future<void>fetchDobuleData()async{
    try{
      final BankFuture= http.get(Uri.parse("http://probashipower.com/api/bank-ac-info"));
      final PackageFuture=http.get(Uri.parse("http://probashipower.com/api/package-list"));

      final response=await Future.wait([BankFuture,PackageFuture]);
      final Bankresponse=response[0];
      final Packageresponse=response[1];
      if(Bankresponse.statusCode==200 && Packageresponse.statusCode==200) {
        final BankData = jsonDecode(response[0].body) as List;
        final PackageData = jsonDecode(response[1].body) as List;

        setState(() {
          BankList = BankData.map((a) => BankModel.fromJson(a)).toList();
          PackList = PackageData.map((b) => PackageListModel.fromJson(b)).toList();
        });
      }else{
        throw Exception("Api Error:Bank=${Bankresponse.statusCode},"
            "Package=${Packageresponse.statusCode}");
      }
    }catch(e){
      print("Error Loading Data ${e}");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDobuleData();
  }
  @override
  Widget build(BuildContext context) {
    final package=widget.selectPackage;
    if(package==null){
      return Center(
        child: Text("কোনো প্যাকেজ ডেটা পাওয়া যায়নি"),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor().ScendaryColor,
              border: Border.all(color: AppColor().colorBlue,
                  width: 3
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [
                Image.asset("assets/homepageicon/taka.png",
                  height: 60,width: 60,),
                SizedBox(height: 20,),
                Text("প্যাকেজ ক্রয়",
                  style: TextStyle(
                      fontFamily: "NotoSansBengali",
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 20,),
                ...BankList.map((bank)=>Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: Row(
                    children: [
                      Text("${bank.acName}-${bank.acNo}",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansBengali",

                      ),)
                    ],
                  ),
                )),
                SizedBox(height: 20,),
                Container(
                  //height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor().colorWhit,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("প্যাকেজ নাম - ${package.name}",
                          style: TextStyle(
                              fontFamily: "NotoSansBengali",
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("প্যাকেজ মূল্য -${package.rate}",
                          style: TextStyle(
                              fontFamily: "NotoSansBengali",
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        SizedBox(height: 30,),
                        Text("সময়কাল-${package.duration}",
                          style: TextStyle(
                              fontFamily: "NotoSansBengali",
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        SizedBox(height: 25,),
                        Text("সুবিধা -${package.feature}",
                          style: TextStyle(
                              fontFamily: "NotoSansBengali",
                              fontSize: 18
                          ),
                        ),
                        SizedBox(height: 20,),

                        Center(
                          child: ElevatedButton(onPressed: () {
                          },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor().colorBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  minimumSize: Size(140, 40)
                              ), child: Text("ক্রয় করুন ",style: TextStyle(
                                  fontFamily: "NotoSansBengali",
                                  color: Colors.white,
                                  fontSize: 16
                              ))),
                        )
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
