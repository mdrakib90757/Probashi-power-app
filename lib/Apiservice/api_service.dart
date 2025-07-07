
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Data_Models/post_models.dart';

class ApiService{



  Future<List<SliderPostModel>?>sliderfetch()async{
    final String url="https://probashipower.com/api/slider-img";
    final response=await http.get(Uri.parse(url));


    try{
      if(response.statusCode==200){
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);
        List<SliderPostModel>sliders = data .
        map((item)=>SliderPostModel.fromJson(item)).toList();
        return sliders;
      }else{
        print("error${response.body}");
        return null;
      }
    }catch(e){
      print("problem${e}");
      return null;
    }
  }


}