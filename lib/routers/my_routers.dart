
import 'package:dirise/screens/bottomavbar.dart';
import 'package:dirise/screens/category_screen.dart';
import 'package:dirise/screens/createacc_screen.dart';
import 'package:dirise/screens/forgetpass_screen.dart';
import 'package:dirise/screens/homepage_screen.dart';
import 'package:dirise/screens/profile_screen.dart';
import 'package:dirise/screens/whishlist_screen.dart';
import 'package:get/get.dart';

import '../screens/categores/categories_screen.dart';
import '../screens/categores/single_categorie.dart';
import '../screens/login_screen.dart';
import '../splash.dart';

class MyRouters{
  static var splash = "/splash";
  static var loginScreen = "/loginScreen";
  static var createAccScreen = "/createAccScreen";
  static var forgetPassword = "/forgetPassword";

  static var bottomNavBar = "/bottomNavBar";
  static var categoryScreen = "/categoryScreen";
  static var whishlistScreen = "/whishlistScreen";
  static var profileScreen = "/profileScreen";


  static var route = [
    GetPage(name: '/', page: () =>  const Splash()),
    GetPage(name: '/loginScreen', page: () =>  const LoginScreen()),
    GetPage(name: '/createAccScreen', page: () =>  const CreateAcc()),
    GetPage(name: '/forgetPassword', page: () =>  const ForgetPassword()),
    GetPage(name: '/bottomNavBar', page: () =>  const BottomNavbar()),

    GetPage(name: '/whishlistScreen', page: () =>  const Whishlist()),
    GetPage(name: '/profileScreen', page: () =>  const Profile()),

    GetPage(name: CategoriesScreen.categoriesScreen, page: () =>  const CategoriesScreen()),
    GetPage(name: SingleCategories.singleCategoriesScreen, page: () =>  const SingleCategories()),





  ];
}