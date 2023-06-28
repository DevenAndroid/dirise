import 'dart:async';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
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
          color: AppTheme.buttonColor,
      height: size.height,
      width: size.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(color: Colors.white,height: 90,
            ('assets/images/diriselogo.png'),
            fit: BoxFit.fill,
          ),
        ],
      ),
    ));
  }
}
