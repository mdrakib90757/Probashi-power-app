

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:probashi_power_project/Data_Models/post_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AuthProvider extends ChangeNotifier {
  ProfileModel?_ProfileData;
  ProfileModel? get profileData => _ProfileData;

  String? get name => _ProfileData?.data.name;
  String? get mobile => _ProfileData?.data.mobile;
  String? get email => _ProfileData?.data.email;
  String? get refcode=> _ProfileData?.data.refid;
  bool isLoading = false;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  String? _token;

  String? get token => _token;


  //login Function
  Future<bool> login(String mobile, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final Url = Uri.parse("https://probashipower.com/api/user-login");
      final response = await http.post(Url,
          body: {
            "mobile": mobile,
            "password": password
          });
      final data = jsonDecode(response.body);
      print(data);
      if (data["status"] == "success") {
        _isLoggedIn=true;
        final userData = data["data"]["token"];
        print( '${data["data"]["token"]}');
        _token=userData;
       // _Profile = ProfileModel.fromJson(data["data"]);
        // SharedPreferences-এ সেভ করুন
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token",_token!);
        print(_token);
        await prefs.setString("userData", jsonEncode(data["data"]));

        isLoading = false;
        notifyListeners();
        return true;

      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Login error: $e");
      return false;
    }
  }


  //Fetch Profile
  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    if (_token == null) return;

    try {
      final response = await http.get(Uri.parse(
          "http://probashipower.com/api/profile"),
          headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json",
          }

      );
      final data = jsonDecode(response.body);
      print(data);
      if (data["status"] == "success") {
        _ProfileData = ProfileModel.fromJson(data);
        notifyListeners();
      }
      return null;
    }catch(e){
      print("Profile fetch error : $e");
    }
  }



 Future<void> logout() async {
   final prefs = await SharedPreferences.getInstance();
  await prefs.remove("token");
   _isLoggedIn=false;
   final token=prefs.getString("token");
   if(token==null){
     print("Logout Successful : token removed");
   }else{
     print("Logout Failed:token still exists");
   }
   print("User is logged out IsLoading $isLoggedIn");
   notifyListeners();
 }

 
}