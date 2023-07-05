import 'package:dirise/e-book/ebookcategory_screen.dart';
import 'package:dirise/screens/bottomavbar.dart';

import 'package:dirise/screens/createacc_screen.dart';
import 'package:dirise/screens/editprofile_screen.dart';

import 'package:dirise/screens/forgetpass_screen.dart';

import 'package:dirise/screens/newpasswordscreen.dart';
import 'package:dirise/screens/officefurniture_sceen/singlechair_screen.dart';
import 'package:dirise/screens/otp_screen.dart';
import 'package:dirise/screens/profile_screen.dart';
import 'package:dirise/screens/scoopsnursery_screen.dart';
import 'package:dirise/screens/termsconditions_screen.dart';
import 'package:dirise/screens/whishlist_screen.dart';
import 'package:get/get.dart';




import '../e-book/singlecategory_screen.dart';
import '../screens/Authors/authors_screen.dart';

import '../e-book/e-book_screen.dart';
import '../screens/Authors/singel_teacher_screen.dart';
import '../screens/Authors/single_author_screen.dart';
import '../screens/Authors/teacher_screen.dart';
import '../screens/calender.dart';

import '../screens/categores/add_bag_screen.dart';
import '../screens/categores/categories_screen.dart';
import '../screens/categores/check_out_screen.dart';
import '../screens/categores/general_library.dart';
import '../screens/categores/order_completed_screen.dart';
import '../screens/categores/single_categorie.dart';


import '../e-book/ebooklogin_screen.dart';
import '../screens/faqs_screen.dart';
import '../screens/login_screen.dart';
import '../screens/my_orders_screen.dart';
import '../screens/officefurniture_sceen/officefurniture_screen.dart';
import '../screens/selectd_order_screen.dart';
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
  static var faqsScreen = "/faqsScreen";
  static var termsConditionScreen = "/termsConditionScreen";
  static var calendarScreen = "/calendarScreen";
  static var eBookScreen = "/eBookScreen";
  static var officeFurnitureScreen = "/officeFurnitureScreen";
  static var singleChair = "/singleChair";
  static var eBooKCategoryScreen = "/eBooKCategoryScreen";
  static var scoopsNursery = "/scoopsNursery";
  static var singleCategory = "/singleCategory";




  static var route = [

    GetPage(name: '/', page: () => const Splash()),
    GetPage(name: '/loginScreen', page: () => const LoginScreen()),
    GetPage(name: '/createAccScreen', page: () => const CreateAcc()),
    GetPage(name: '/forgetPassword', page: () => const ForgetPassword()),
    GetPage(name: '/bottomNavBar', page: () => const BottomNavbar()),
    GetPage(name: '/whishlistScreen', page: () => const Whishlist()),
    GetPage(name: '/profileScreen', page: () => const Profile()),
    GetPage(name: '/otpScreen', page: () => const OtpScreen()),
    GetPage(name: '/faqsScreen', page: () => const FaqsScreen()),
    GetPage(name: '/editprofileScreen', page: () => const EditProfile()),
    GetPage(name: '/newPasswordScreen', page: () => const NewPassword()),
    GetPage(name: '/termsConditionScreen', page: () => const TermCondition()),
    GetPage(name: '/calendarScreen', page: () =>   const EventCalendarScreen()),
    GetPage(name: '/eBookScreen', page: () =>  const EBookScreen()),
    GetPage(name: '/singleChair', page: () =>  const SingleChair()),
    GetPage(name: '/eBooKCategoryScreen', page: () =>  const EBook()),
    GetPage(name: '/singleCategory', page: () =>  const SingleCategory()),

    GetPage(name: '/scoopsNursery', page: () =>  const SchoolNursery()),

    GetPage(name: '/officeFurnitureScreen', page: () =>  const OfficeFurniture()),
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
    GetPage(name: SingleAuthorScreen.singleAuthorScreen, page: () =>  const SingleAuthorScreen()),
    GetPage(name: TeacherScreen.teacherScreen, page: () =>  const TeacherScreen()),
    GetPage(name: SelectedTeacher.selectedTeacher, page: () =>  const SelectedTeacher()),
    GetPage(name: MyOrdersScreen.myOrdersScreen, page: () =>  const MyOrdersScreen()),
    GetPage(name: SelectedOrderScreen.selectedOrderScreen, page: () =>  const SelectedOrderScreen()),


  ];
}
