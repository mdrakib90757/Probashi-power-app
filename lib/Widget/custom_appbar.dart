

import 'package:flutter/material.dart';
import 'package:probashi_power_project/Layout/main_layout.dart';
import 'package:probashi_power_project/Provider/auth_provider.dart';
import 'package:probashi_power_project/Screen/auth_screen/login_screen.dart';
import 'package:provider/provider.dart';

import '../utils/color.dart';




AppBar buildAppBar(BuildContext context){
  final authProvider=Provider.of<AuthProvider>(context);
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 60,
    backgroundColor: AppColor().primaryColors,
    title: Text("প্রবাসী পাওয়ার",style: TextStyle(
        fontFamily: 'NotoSansBengali',
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w700
    ),),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if(authProvider.isLoggedIn){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder:(context) => MainLayout(initialScreen: 34,)),
                    (route) => false,
              );
            }else{
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen(),));
            }

          },
          child: Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/homepageicon/search.png",
                  height: 25,width: 25,),
                SizedBox(width: 10,),
                Text("মানি",style: TextStyle(
                    fontSize: 18
                ),)
              ],
            ),
          ),
        ),
      )
    ],
  );
}