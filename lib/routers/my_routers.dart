
import 'package:dirise/screens/bottomavbar.dart';
import 'package:dirise/screens/createacc_screen.dart';
import 'package:dirise/screens/forgetpass_screen.dart';
import 'package:dirise/screens/homepage_screen.dart';
import 'package:get/get.dart';

import '../screens/login_screen.dart';
import '../splash.dart';

class MyRouters{
  static var splash = "/splash";
  static var loginScreen = "/loginScreen";
  static var createAccScreen = "/createAccScreen";
  static var forgetPassword = "/forgetPassword";

  static var bottomNavBar = "/bottomNavBar";


  static var route = [
    GetPage(name: '/', page: () =>  const Splash()),
    GetPage(name: '/loginScreen', page: () =>  const LoginScreen()),
    GetPage(name: '/createAccScreen', page: () =>  const CreateAcc()),
    GetPage(name: '/forgetPassword', page: () =>  const ForgetPassword()),

    GetPage(name: '/bottomNavBar', page: () =>  const BottomNavbar()),




  ];
}