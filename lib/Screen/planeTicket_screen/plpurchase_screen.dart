import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/color.dart';
import 'package:http/http.dart' as http;

class PlpurchaseScreen extends StatefulWidget {
  final String ticketId;
  const PlpurchaseScreen({super.key, required this.ticketId,});

  @override
  State<PlpurchaseScreen> createState() => _PlpurchaseScreenState();
}

class _PlpurchaseScreenState extends State<PlpurchaseScreen> {
  String?_token;
  String? get token=> _token;
  TicketResponse?ticket;
  
  Future<TicketResponse?>fetchTicketDetails(String tickedid)async {
final prefs=await SharedPreferences.getInstance();
_token=prefs.getString("token");

if(tickedid.isEmpty){
  print("Error Ticket Id IS empty");
  return null;
}
print("Fetching details for ticket ID: ${widget.ticketId}");

final response = await http.get(Uri.parse(
        "https://probashipower.com/api/ticket-detail?id=${widget.ticketId}"),
      headers: {
        "Authorization": "Bearer $_token",
        'Content-Type': 'application/json',
      },
    );
print(response);
    if (response.statusCode == 200){
      final decodedData=jsonDecode(response.body);
      print(response.body);
      final data=decodedData["data"];
      return TicketResponse.fromJson(data);
    }else{
      print(response.body);
      print(response.statusCode);
      return null;
    }
  }

  Future<void>_loadTicketDetails()async{
    // final prefs=await SharedPreferences.getInstance();
    // _token = prefs.getString("token");
      final result=await fetchTicketDetails(widget.ticketId);
      if(result!=null){
        setState(() {
          ticket=result;
        });
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTicketDetails();

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
              border: Border.all(color: AppColor().colorBlue,
                  width: 3
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [
                Image.asset("assets/homepageicon/libra.png",
                  height: 60,width: 60,),
                SizedBox(height: 20,),
                Text("প্লেন টিকেট",
                  style: TextStyle(
                      fontFamily: "NotoSansBengali",
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 20,),
                ticket==null?Center(child: CircularProgressIndicator(),):
                     Container(
                      //height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor().colorWhit,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("পটিকেট - ${ticket!.ticketname}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("পএয়ারপোর্ট থেকে-${ticket!.airportfrom}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ),),
                              SizedBox(height: 30,),
                              Text("এয়ারপোর্ট পর্যন্ত-${ticket!.airportto}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ),),
                              SizedBox(height: 25,),
                              Text("তারিখ ও সময় -${ticket!.flydatetime}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("যাত্রার সময়কাল-${ticket!.flyduration}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("টিকেট মূল্য-${ticket!.ticketfare}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("এয়ারলাইন নাম-${ticket!.airlinename}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("এয়ারলাইন কন্টাক্ট-${ticket!.airlinecontact}",
                                style: TextStyle(
                                    fontFamily: "NotoSansBengali",
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(height: 20,),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 4),
                                  child: Text("ট্রাভেল এজেন্সী তথ্য",style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.black
                                  ),),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,

                                ),
                                child: Column(
                                  children: [
                                    Text("এজেন্সী নাম:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.black
                                      ),
                                    ),
                                    Text("মোবাইল নং:",style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black
                                    ),),
                                    Text("ঠিকানা",style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black
                                    ),)
                                  ],
                                ),
                              )


                            ],
                          ),
                        ),
                      ),
                  ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
