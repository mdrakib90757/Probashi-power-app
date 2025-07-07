import 'package:flutter/material.dart';
import 'package:probashi_power_project/Provider/auth_provider.dart';
import 'package:provider/provider.dart';


import '../Layout/main_layout.dart';
import '../post_model/product_model.dart';
import '../utils/color.dart';


class CustomService extends StatefulWidget {
  const CustomService({super.key});

  @override
  State<CustomService> createState() => _CustomServiceState();
}

class _CustomServiceState extends State<CustomService> {
  int cruurentIndex=0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: service.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
          final item=service[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    final authProvider=Provider.of<AuthProvider>(context,listen: false);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MainLayout(initialScreen: index + 4,),));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor().primaryColors,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 70,
                    width: 80,
                    padding: EdgeInsets.all(10),
                    child: Image.asset(item.icon,height: 20,width: 20,),
                  ),
                ),
                Text(item.label,),
              ],
            );

          },
      );
  }
}
