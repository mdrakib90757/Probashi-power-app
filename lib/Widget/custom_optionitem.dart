import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOptionitem extends StatefulWidget {
  final String image;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const CustomOptionitem({super.key, required this.image, required this.title, this.subtitle, required this.onTap});

  @override
  State<CustomOptionitem> createState() => _CustomOptionitemState();
}

class _CustomOptionitemState extends State<CustomOptionitem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Image.asset(widget.image,height: 40,width: 40,color: Colors.deepOrange,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            height: 3,
            width: 40,
            color: Colors.deepOrange,
          ),
          Text(widget.title,style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w300
          ),),
          SizedBox(height: 10,),
          if(widget.subtitle!=null)
            Text(widget.subtitle!,style: TextStyle(
              fontSize: 15
            ),)

        ],
      ),
    );
  }
}
