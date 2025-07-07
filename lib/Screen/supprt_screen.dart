import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupprtScreen extends StatefulWidget {
  const SupprtScreen({super.key});

  @override
  State<SupprtScreen> createState() => _SupprtScreenState();
}

class _SupprtScreenState extends State<SupprtScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Supprt_Screen"),),
    );
  }
}

