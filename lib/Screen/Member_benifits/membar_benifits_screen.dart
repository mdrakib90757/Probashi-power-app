import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Data_Models/post_models.dart';
import 'package:http/http.dart'as http;

import '../../Layout/main_layout.dart';
import '../../Provider/auth_provider.dart';
import '../../utils/color.dart';
import '../auth_screen/login_screen.dart';

class MembarBenifitsScreen extends StatefulWidget {
  const MembarBenifitsScreen({super.key});

  @override
  State<MembarBenifitsScreen> createState() => _MembarBenifitsScreenState();
}

class _MembarBenifitsScreenState extends State<MembarBenifitsScreen> {
  List<MemberBenifitsModel>memberBenifitsList=[];

  Future<List<MemberBenifitsModel>?>fetchMembarBenifts()async{
    try{
      final responose=await http.get(Uri.parse(
          "https://probashipower.com/api/member-benefit-list"));
      if(responose.statusCode==200){
        final List<dynamic>jsonData=jsonDecode(responose.body);
        print(responose.body);
        print(jsonData);
        return jsonData.map((Benifits)=>MemberBenifitsModel.fromJson(Benifits)).toList();

      }else{
        print("Failed the package${responose.body}");
        return null;
      }
    }catch(e){
      print("Error ${e}");
      return null;
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMembarBenifts().then((data){
      if(data!=null){
        setState(() {
          memberBenifitsList=data;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                child: Image.asset("assets/homepageicon/growth.png",
                  height: 60,width: 60,),
              ),
              Text("মেম্বার বেনিফিটস",style: TextStyle(
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
              memberBenifitsList.isEmpty?Center(child: CircularProgressIndicator(),):
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: memberBenifitsList.length,
                itemBuilder: (context, index) {
                  final memberData =memberBenifitsList[index];
                  return Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                        color: AppColor().colorWhit
                    ),
                    child: Column(
                      children: [
                        Text("নাম:${memberBenifitsList[index].title}",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18

                        ),),
                        Text("ডিটেলস:${memberBenifitsList[index].details} ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,

                          ),),

                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: () {
                          final authProvider=Provider.of<AuthProvider>(context,listen: false);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
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
    );
  }
}
