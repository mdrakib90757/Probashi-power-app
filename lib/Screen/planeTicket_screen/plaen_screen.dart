import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:probashi_power_project/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../Layout/main_layout.dart';
import '../../utils/color.dart';
import 'package:http/http.dart' as http;

import '../auth_screen/login_screen.dart';

class PlaenScreen extends StatefulWidget {
  const PlaenScreen({super.key});

  @override
  State<PlaenScreen> createState() => _PlaenScreenState();
}

class _PlaenScreenState extends State<PlaenScreen> {

  List<TicketModel>planetktlist=[];


  Future<List<TicketModel>> fetchTicket()async{
    final response=await http.get(Uri.parse(
        "https://probashipower.com/api/ticket-list"));

    if(response.statusCode==200){
      print("Response: ${response.body}");
      final List<dynamic>decodedData=jsonDecode(response.body);
      print("Decoded Data: $decodedData");
      return decodedData.map((data)=>TicketModel.fromJson(data)).toList();
    }else{
      print("Error${response.body}");
      return [];
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTicket().then((data){
      setState(() {
        planetktlist = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Image.asset("assets/homepageicon/plane-ticket.png",
                        height: 50,width: 50,),
                    ),
                    Text("প্লেন টিকেট",style: TextStyle(
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
                    planetktlist.isEmpty?Center(child: CircularProgressIndicator(),):
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: planetktlist.length,
                      itemBuilder: (context, index) {
                        final ticket=planetktlist[index];
                        return Container(
                          height: 200,
                          width: double.infinity,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColor().colorWhit
                          ),
                          child: Column(
                            children: [
                              Text("টিকেট: ${ticket.ticketname}",style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("তারিখ: ${ticket.flydatetime}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),),
                              Text("মূল্য:${ticket.ticketfare}",style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),),
                              Text("সময়কাল:${ticket.flyduration}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 18,
                                    color: Colors.black
                                ),),
                              SizedBox(height: 10,),
                              ElevatedButton(onPressed: () {
                                final authProvider=Provider.of<AuthProvider>(context,listen: false);
                                if(authProvider.isLoggedIn){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                      builder:(context) => MainLayout(initialScreen: 28,selectTicket: ticket,)),
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
                                  ), child: Text("ক্রয় করুন ",style: TextStyle(
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
