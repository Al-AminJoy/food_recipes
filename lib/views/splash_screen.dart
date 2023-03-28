import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recepie_app/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("images/app_icon.png",height: 100,width: 100,),

      ),
    );
  }
}
