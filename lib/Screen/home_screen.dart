import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Apiservice/api_service.dart';
import '../Data_Models/post_models.dart';
import '../Widget/custom_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<SliderPostModel>image=[];
  final ApiService _apiService=ApiService();



  @override
  void initState() {
    super.initState();
    loadSlider();
  }


  void loadSlider()async{
    final fetchSliders = await _apiService.sliderfetch();
    if(fetchSliders!=null){
      setState(() {
        image=fetchSliders;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           image.isEmpty?Center(child: CircularProgressIndicator(),):
           CarouselSlider(
                items: image.map((item)=>Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(item.slider_img),fit: BoxFit.cover)
                  ),
              )).toList(),
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8
                )
            ),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(child: Text("Amar sonar bangla ami tomay bhalobashi",style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),)),
            ),
            SizedBox(height: 30,),
            Text("আমাদের সেবা সমূহ ",style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              decoration:TextDecoration.underline
            ),),
            SizedBox(height: 15,),
            CustomService(),
            Text("আরও জানুন",style: TextStyle(
              fontFamily: "",
              fontSize: 20,
              decoration: TextDecoration.underline,
            ),),
            SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Column(
               children: [
                 ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: Image.asset("assets/homepageicon/6791e39f12c615.56228697.jpg")),
                 SizedBox(height: 10,),
                 Divider(thickness: 1,
                   height: 1,),
                 SizedBox(height: 10,),
                 ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: Image.asset("assets/homepageicon/67f874c8577096.57313002.jpg")),
                 SizedBox(height: 10,),
                 Divider(thickness: 1,
                   height: 1,),
                 SizedBox(height: 10,),
                 ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: Image.asset("assets/homepageicon/67f874e1b40a46.24330165.jpg")),
                 SizedBox(height: 10,),
                 Divider(thickness: 1,
                   height: 1,),
                 SizedBox(height: 10,),
                 ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: Image.asset("assets/homepageicon/67f8746d4d4ad9.24803066.jpg")),
                 SizedBox(height: 10,),
                 Divider(thickness: 1,
                   height: 1,),
                 SizedBox(height: 10,),
                 ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: Image.asset("assets/homepageicon/67f8734251dd18.99838950.jpg")),
                 SizedBox(height: 10,),
                 Divider(thickness: 1,
                   height: 1,),
                 SizedBox(height: 10,),
                 ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: Image.asset("assets/homepageicon/67f87501910950.99256278.jpg")),

               ],
             ),
           ),
          ],
        ),
      ),
    );



  }
}
