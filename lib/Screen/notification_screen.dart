import 'package:flutter/material.dart';
import 'package:probashi_power_project/utils/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Container(
              height: MediaQuery.of(context).size.height/3.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor().ScendaryColor,
                border: Border.all(color: AppColor().colorBlue,width: 3)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                child: Column(
                  children: [
                    Image.asset("assets/profileicon/1247940.png",
                      height: 60,width: 60,color: Colors.deepOrange,),
                    SizedBox(height: 20,),
                    Text("নোটিশ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),)
                  ],
                ),
              ),
            ),
          )
        );
  }
}
