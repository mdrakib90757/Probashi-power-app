import 'dart:convert';
import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:probashi_power_project/Screen/auth_screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../Layout/main_layout.dart';
import '../../Provider/auth_provider.dart';
import '../../Widget/custom_optionitem.dart';
import '../../utils/color.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final File? profileImage;


  const ProfileScreen({super.key,required this.profileImage,});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {


List<DataModel>packageinfoList=[];
String ? _token;
String? get token=>_token;

//fetchPackaggeInfo
  Future<void>fetchPackageInfo()async{
    final prefs= await SharedPreferences.getInstance();
     _token=await prefs.getString("token");
     print(_token);


    final response=await http.get(
      Uri.parse("http://probashipower.com/api/user-pack-info"),
    headers: {
      "Authorization":"Bearer ${_token}",
      'Content-Type': 'application/json',
    }
    );
    if(response.statusCode==200){
      final jsondata=jsonDecode(response.body);
      print( jsondata);
      final package=PackageInfoModel.fromJson(jsondata);
      setState(() {
        packageinfoList=package.data;
      });
    }else{
      throw Exception("Failed to load package");
    }
  }

  Future<void>_checkLoginStatus()async{
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString("token");
    if(token==null){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authProvider=Provider.of<AuthProvider>(context,listen: false);
    authProvider.fetchProfile();
    _checkLoginStatus();
    fetchPackageInfo();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.profileData == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (authProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
       // height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColor().ScendaryColor,
            border: Border.all(color: AppColor().colorBlue, width: 3)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Text("আপনার প্রোফাইল", style: TextStyle(
                  fontFamily: "NotoSansBengali",
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20,
                  decoration: TextDecoration.underline
              ),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset("assets/profileicon/user.png",
                      height: 28, width: 28, color: Colors.deepOrange,),
                    SizedBox(width: 10,),
                    Text("${authProvider.profileData!.data.name}", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 22
                    ),),
                    SizedBox(width: 150,),
                  ClipOval(
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: widget.profileImage != null
                            ? Image.file(widget.profileImage!, fit: BoxFit.cover)
                            : CachedNetworkImage(
                          imageUrl: authProvider.profileData?.data.Image ?? "",
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: Center(child: Icon(Icons.person, size: 30)),
                          ),
                        ),
                      )

                  )


            ])
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 170),
                child: Divider(thickness: 1.5,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset("assets/profileicon/phone-call.png",
                      height: 28, width: 28, color: Colors.deepOrange,),
                    SizedBox(width: 10,),
                    Text("${authProvider.profileData!.data.mobile}", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 170),
                child: Divider(thickness: 1.5,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset("assets/profileicon/code.png",
                      height: 28, width: 28, color: Colors.deepOrange,),
                    SizedBox(width: 10,),
                    Text(
                      "ID/Refer Code :${authProvider.profileData!.data.refid}", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 170),
                child: Divider(thickness: 1.5,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset("assets/profileicon/whatsapp.png",
                      height: 28, width: 28, color: Colors.deepOrange,),
                    SizedBox(width: 10,),
                    Text("", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 170),
                child: Divider(thickness: 1.5,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset("assets/profileicon/mail.png",
                      height: 28, width: 28, color: Colors.deepOrange,),
                    SizedBox(width: 10,),
                    Text("${authProvider.profileData!.data.email}", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 22
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 170),
                child: Divider(thickness: 1.5,),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOptionitem(
                          image: "assets/profileicon/profile.png",
                          title: "এডিট প্রোফাইল",
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    MainLayout(initialScreen: 32,)));
                          }
                      ),
                      CustomOptionitem(
                          image: "assets/profileicon/star.png",
                          title: "রিভিউ ",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  MainLayout(initialScreen: 33,),));
                          }
                      ),
                      CustomOptionitem(
                          image: "assets/profileicon/sign-out-option.png",
                          title: "লগ আউট  ",
                          onTap: () {
                            authProvider.logout();
                            print("login Out called");
                            Future.microtask(() =>
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                        MainLayout(initialScreen: 0,),)));
                          }
                      )
                    ]
                ),
              ),
              SizedBox(height: 30,),
              Text("প্যাকেজ তথ্য", style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  fontFamily: "NOtoSansBengali"
              ),),
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              packageinfoList.isEmpty?
              Center(child: Text("package not found",style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),),):
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: packageinfoList.length,
                  itemBuilder: (context, index) {
                    final data =packageinfoList[index];
                    return Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10)
                    ),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20,vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("প্যাকেজ নাম:${data.packageName}"
                                " | ${data.packageDuration}",
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 18,
                                fontWeight:FontWeight.bold
                            ),),
                           SizedBox(height: 5,),
                            Text("সময়কাল: ${data.startData} থেকে ${data.endData}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                  fontWeight: FontWeight.w400
                              ),),
                            Text("সুবিধা সমূহ : ${data.packageFeature}",style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                            ),),
                          ],
                        ),
                      ),
                            );
                  }
                ),
              ),
            ],
          )
          
          
            ],
          ),
        ),
      )),
    ) ;

  }

  }




