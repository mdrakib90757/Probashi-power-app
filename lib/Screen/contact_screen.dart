import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:probashi_power_project/utils/color.dart';
import 'package:http/http.dart'as http;

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Future<void>fetchDownloadPdf()async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isDenied) {
        await[
          Permission.photos,
          Permission.videos,
          Permission.audio,
          Permission.mediaLibrary
        ].request();
      }
    }
if(await Permission.storage.request().isGranted){
  final url="https://probashipower.com/Contract/contract-page.pdf";
  final response=await http.get(Uri.parse(url));
  final bytes=response.bodyBytes;

  final dir=await getExternalStorageDirectory();
  final file=File("${dir!.path}/contract-page.pdf");
  await file.writeAsBytes(bytes);
  OpenFile.open(file.path);
}else{
  print("Permission denied");
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor().ScendaryColor,
            border:Border.all(color: AppColor().colorBlue,width: 3)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Column(
              children: [
                FaIcon(FontAwesomeIcons.filePdf,color: Colors.deepOrange,size: 50,),
                SizedBox(height: 20,),
                Text("চুক্তিপত্র",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                ),),
                SizedBox(height: 20,),
                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder:(context, index) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.1))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Column(
                            children: [
                              Text("চুক্তিপত্র ডাউনলোড করুন",style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 5,),
                              ElevatedButton(onPressed: () {
                                fetchDownloadPdf();
                              },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor().colorBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minimumSize: Size(100, 40)
                                  ), child: Text("ডাউনলোড",style: TextStyle(
                                      fontFamily: "NotoSansBengali",
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                  )
                                  )
                              )
                            ],
                          ),
                        ),
                      );
                    },
                )
                
              ],
            ),
          ),
        ),
      )
    );
  }
}
