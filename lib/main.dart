import 'package:flutter/material.dart';
import 'package:probashi_power_project/Layout/main_layout.dart';
import 'package:probashi_power_project/Screen/auth_screen/login_screen.dart';
import 'package:probashi_power_project/Screen/auth_screen/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],child: MyApp(token:token))
  );
}

class MyApp extends StatelessWidget {
  final String?token;
  const MyApp({super.key, this.token,});
  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home:MainLayout()
    );
  }
}


