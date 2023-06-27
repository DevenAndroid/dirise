import 'dart:async';
import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      Get.offAllNamed(MyRouters.loginScreen);
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: Image.asset(
        ('assets/images/Splash.png'),
        fit: BoxFit.fill,
      ),
    ));
  }
}
