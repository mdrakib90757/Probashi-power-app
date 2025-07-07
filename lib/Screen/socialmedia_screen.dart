import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/color.dart';
import 'package:http/http.dart' as http;

class SocialmediaScreen extends StatefulWidget {
  const SocialmediaScreen({super.key});

  @override
  State<SocialmediaScreen> createState() => _SocialmediaScreenState();
}

class _SocialmediaScreenState extends State<SocialmediaScreen> {
  //link
 List<SocialMediaModel>mediaList=[];

 Future<SocialMediaModel?>fetchSocialMedia()async{
   final response =await http.get(Uri.
   parse("https://probashipower.com/api/social-media"));

   if(response.statusCode==200){
     final List<dynamic>data=jsonDecode(response.body);
   setState(() {
     mediaList=data.map((link)=>SocialMediaModel.fromJson(link)).toList();
   });
   }else{
     print("Failed to load social links");

   }
 }

 Future<void>_launchURL(String url)async{
   final Uri uri=Uri.parse(url);
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
    fetchSocialMedia();
 }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: Container(
        height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor().ScendaryColor,
              border: Border.all(color: AppColor().colorBlue,width: 3)
          ),
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
      children: [
        Text("সোশ্যাল মিডিয়া",style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400
        ),),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _launchURL(mediaList[0].facebook);
              },
                child: FaIcon(FontAwesomeIcons.facebook,size: 60,
                  color: Colors.deepOrange,),),

            SizedBox(width: 10,),
            GestureDetector(
              onTap: () {
                _launchURL(mediaList[0].whatsapp);
              },
              child: FaIcon(FontAwesomeIcons.whatsapp,size: 60,
                color: Colors.deepOrange,),),

            SizedBox(width: 10,),
            GestureDetector(
              onTap: () {
                _launchURL("mailto:${mediaList[0].gmail}");
              },
              child: FaIcon(FontAwesomeIcons.envelope,size: 60,
                color: Colors.deepOrange,),),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: () {
                _launchURL(mediaList[0].insta);
              },
              child: FaIcon(FontAwesomeIcons.instagram,size: 60,
                color: Colors.deepOrange,),),
          ],
        ),
      ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: () {
            _launchURL(mediaList[0].youtube);
          },
          child: FaIcon(FontAwesomeIcons.youtube,size: 60,
            color: Colors.deepOrange,),),
      ]
      )
          )
      ),
    );
  }
}
