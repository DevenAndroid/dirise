import 'package:dirise/screens/bottomavbar.dart';

import 'package:dirise/screens/createacc_screen.dart';
import 'package:dirise/screens/editprofile_screen.dart';
import 'package:dirise/screens/forgetpass_screen.dart';
import 'package:dirise/screens/homepage_screen.dart';
import 'package:dirise/screens/newpasswordscreen.dart';
import 'package:dirise/screens/otp_screen.dart';
import 'package:dirise/screens/profile_screen.dart';
import 'package:dirise/screens/whishlist_screen.dart';
import 'package:get/get.dart';


import '../screens/Authors/authors_screen.dart';
import '../screens/categores/add_bag_screen.dart';
import '../screens/categores/categories_screen.dart';
import '../screens/categores/check_out_screen.dart';
import '../screens/categores/general_library.dart';
import '../screens/categores/order_completed_screen.dart';
import '../screens/categores/single_categorie.dart';
import '../screens/login_screen.dart';
import '../splash.dart';

class MyRouters {
  static var splash = "/splash";
  static var loginScreen = "/loginScreen";
  static var createAccScreen = "/createAccScreen";
  static var forgetPassword = "/forgetPassword";

  static var bottomNavBar = "/bottomNavBar";
  static var categoryScreen = "/categoryScreen";
  static var whishlistScreen = "/whishlistScreen";
  static var profileScreen = "/profileScreen";
  static var otpScreen = "/otpScreen";
  static var newPasswordScreen = "/newPasswordScreen";
  static var editprofileScreen = "/editprofileScreen";


  static var route = [

    GetPage(name: '/', page: () => const Splash()),
    GetPage(name: '/loginScreen', page: () => const LoginScreen()),
    GetPage(name: '/createAccScreen', page: () => const CreateAcc()),
    GetPage(name: '/forgetPassword', page: () => const ForgetPassword()),
    GetPage(name: '/bottomNavBar', page: () => const BottomNavbar()),
    GetPage(name: '/whishlistScreen', page: () => const Whishlist()),
    GetPage(name: '/profileScreen', page: () => const Profile()),
    GetPage(name: '/otpScreen', page: () => const OtpScreen()),
    GetPage(name: '/editprofileScreen', page: () => const EditProfile()),
    GetPage(name: '/newPasswordScreen', page: () => const NewPassword()),
    GetPage(
        name: CategoriesScreen.categoriesScreen,
        page: () => const CategoriesScreen()),
    GetPage(
        name: SingleCategories.singleCategoriesScreen,
        page: () => const SingleCategories()),
    GetPage(name: GeneralLibrary.generalLibrary, page: () =>  const GeneralLibrary()),
    GetPage(name: AddBagScreen.addBagScreen, page: () =>  const AddBagScreen()),
    GetPage(name: CheckOutScreen.checkOutScreen, page: () =>  const CheckOutScreen()),
    GetPage(name: OrderCompleteScreen.orderCompleteScreen, page: () =>  const OrderCompleteScreen()),
    GetPage(name: AuthorsScreen.authorsScreen, page: () =>  const AuthorsScreen()),


  ];
}
