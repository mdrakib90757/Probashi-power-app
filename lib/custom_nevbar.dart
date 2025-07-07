import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:probashi_power_project/utils/color.dart';


import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

class CustomNevbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNevbar({super.key, required this.currentIndex, required this.onTap,});

  @override
  State<CustomNevbar> createState() => _CustomNevbarState();
}

class _CustomNevbarState extends State<CustomNevbar> {
  List<whatsAppModel>whatsAppList=[];

  Future<whatsAppModel?>fetchwhatsapp()async{
    final response =await http.get(Uri.
    parse("https://probashipower.com/api/social-media"));

    if(response.statusCode==200){
      final List<dynamic>data=jsonDecode(response.body);
      setState(() {
        whatsAppList=data.map((link)=>whatsAppModel.fromJson(link)).toList();
      });
    }else{
      print("Failed to load social links");

    }
  }

  void _lanuchWhatsApp(String url)async{
    final Uri uri= Uri.parse(url);
    print("trying to open$url");
    try{
      await launchUrl(uri);

    }catch(e){
      print("Error launching WhatsApp$e");
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  fetchwhatsapp();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        backgroundColor: AppColor().primaryColors,
          selectedLabelStyle: TextStyle(
            color: Colors.black
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.black
          ),
         
          currentIndex: widget.currentIndex,
          onTap:(index) {
            if(index==2){
              _lanuchWhatsApp(whatsAppList[0].whatsapp);
            }else{
              widget.onTap(index);
            }
          },
          type: BottomNavigationBarType.fixed,
          elevation: 50,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,color: Colors.blue),label:"হোম",),
            BottomNavigationBarItem(icon: Icon(Icons.person,size: 30,color: Colors.blue),label: "প্রোফাইল"),
            BottomNavigationBarItem(icon:FaIcon(FontAwesomeIcons.whatsapp,size: 28,color: Colors.blue,),label: "সাপোর্ট",),
            BottomNavigationBarItem(icon: Stack(
              clipBehavior: Clip.none,
    children: [
      Icon(Icons.notifications,color: Colors.blueAccent,size: 30,),
      Positioned(
        right:-10,
          top: -10,
          child: Container(
        padding: EdgeInsets.all(1),

            constraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            child: Text("0",style: TextStyle(
              color: Colors.red.shade600,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
              textAlign: TextAlign.center,
            ),

      ))
    ],

    ),
              label: "নোটিশ",
            )

          ]
      );


  }
}
