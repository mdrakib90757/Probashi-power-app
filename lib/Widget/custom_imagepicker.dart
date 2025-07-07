

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CustomImagepicker extends StatefulWidget {
  final Function(File) onImagepicked;
   CustomImagepicker({super.key,required this.onImagepicked});

  @override
  State<CustomImagepicker> createState() => _CustomImagepickerState();
}

class _CustomImagepickerState extends State<CustomImagepicker> {
  File?_image;
  
  Future<void> pickImage ()async{
    final picker=ImagePicker();
    final pickfiled=await picker.pickImage(source: ImageSource.gallery);
    if(pickfiled != null){
      setState(() {
        _image=File(pickfiled.path);
      });
      widget.onImagepicked(_image!);
    }}
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ছবি",style: TextStyle(
            color: Colors.black,
            fontSize: 15
        ),),
        SizedBox(height: 5,),
        Container(
       padding: EdgeInsets.zero,
          decoration: BoxDecoration(
          ),
          child: Row(
            children: [
              ElevatedButton(onPressed: () {
                pickImage();
              },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(10,50),
                    side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(),
                  ),
                  child: Text("Choose file")),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400)
                ),
                child: Center(child: Text(_image!=null?_image!.path.split("/").last:
                "No Choosen file")),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        _image!=null?ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(_image!,height: 150,),
        ):Text("বর্তমান ছবি:"),
        


      ],
    );
  }
}
