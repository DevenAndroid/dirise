import 'package:dirise/e-book/ebookcategory_screen.dart';
import 'package:dirise/screens/my_account_screens/about_us_screen.dart';
import 'package:dirise/bottomavbar.dart';
import 'package:dirise/screens/my_account_screens/editprofile_screen.dart';
import 'package:dirise/screens/auth_screens/forgetpass_screen.dart';
import 'package:dirise/screens/auth_screens/newpasswordscreen.dart';
import 'package:dirise/screens/officefurniture_sceen/singlechair_screen.dart';
import 'package:dirise/screens/my_account_screens/profile_screen.dart';
import 'package:dirise/screens/my_account_screens/return_policy_screen.dart';
import 'package:dirise/screens/schoolnursery_screen.dart';
import 'package:dirise/screens/my_account_screens/termsconditions_screen.dart';
import 'package:dirise/screens/whishlist_screen.dart';
import 'package:dirise/vendorflow/vendor_order_list_screen.dart';
import 'package:get/get.dart';
import '../e-book/singlecategory_screen.dart';
import '../screens/Authors/authors_screen.dart';
import '../e-book/e-book_screen.dart';
import '../screens/Authors/singel_teacher_screen.dart';
import '../screens/Authors/single_author_screen.dart';
import '../screens/Authors/teacher_screen.dart';
import '../screens/auth_screens/createacc_screen.dart';
import '../screens/auth_screens/otp_screen.dart';
import '../screens/calender.dart';
import '../screens/check_out/add_bag_screen.dart';
import '../screens/categores/categories_screen.dart';
import '../screens/check_out/check_out_screen.dart';
import '../screens/categores/general_library.dart';
import '../screens/check_out/order_completed_screen.dart';
import '../screens/categores/single_categorie.dart';
import '../screens/my_account_screens/faqs_screen.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/order_screens/my_orders_screen.dart';
import '../screens/officefurniture_sceen/officefurniture_screen.dart';
import '../screens/my_account_screens/privacy_policy_screen.dart';
import '../screens/public_speaker_screen/publicspeaker_screen.dart';
import '../screens/public_speaker_screen/single_public_speaker_screen.dart';
import '../screens/school_nursery_category.dart';
import '../screens/order_screens/selectd_order_screen.dart';
import '../vendorflow/add_money_screen.dart';
import '../vendorflow/add_product_screen.dart';
import '../vendorflow/all_product_screen.dart';
import '../vendorflow/dashboard_screen.dart';
import '../vendorflow/bank_account_screen.dart';
import '../vendorflow/orderdetailsscreen.dart';
import '../vendorflow/store_open_time_screen.dart';
import '../vendorflow/thanku_screen.dart';
import '../vendorflow/vendor_registration_screen.dart';
import '../vendorflow/verify_vendor_otp.dart';

class MyRouters {
  static var splash = "/splash";
  static var createAccScreen = "/createAccScreen";
  static var forgetPassword = "/forgetPassword";

  // static var bottomNavBar = "/bottomNavBar";
  static var categoryScreen = "/categoryScreen";
  static var whishlistScreen = "/whishlistScreen";
  static var profileScreen = "/profileScreen";
   static var loginScreen = "/loginScreen";
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
  static var dashBoardScreen = "/dashBoardScreen";
  static var storeOpenScreen = "/storeOpenScreen";
  static var vendorRegistration = "/vendorRegistration";
  // static var thankUScreen = "/thankUScreen";
  static var allProductScreen = "/allProductScreen";
  static var addProductScreen = "/addProductScreen";
  static var orderListScreen = "/orderListScreen";
  static var addMoneyScreen = "/addMoneyScreen";
  static var bankAccount = "/bankAccount";
  static var orderDetails = "/orderDetails";
  static var returnPolicy = "/returnPolicy";
  static var aboutUs = "/aboutUs";
  static var privacyPolicy = "/privacyPolicy";
  static var schoolNursery = "/schoolNursery";
  static var publicSpeaker = "/publicSpeaker";
  static var singlePublicCategory = "/singlePublicCategory";

  static var route = [
    GetPage(name: '/', page: () => const BottomNavbar()),
    GetPage(name: LoginScreen.route, page: () => const LoginScreen()),
    GetPage(name: VendorOTPVerification.route, page: () => const VendorOTPVerification()),
    GetPage(name: '/createAccScreen', page: () => const CreateAcc()),
    GetPage(name: '/forgetPassword', page: () => const ForgetPassword()),
    GetPage(name: BottomNavbar.route, page: () => const BottomNavbar()),
    GetPage(name: PrivacyPolicy.route, page: () => const PrivacyPolicy()),
    GetPage(name: '/whishlistScreen', page: () => const Whishlist()),
    GetPage(name: '/profileScreen', page: () => const Profile()),
    GetPage(name: OtpScreen.route, page: () => const OtpScreen()),
    GetPage(name: '/faqsScreen', page: () => const FaqsScreen()),
    GetPage(name: '/orderListScreen', page: () => const VendorOrderList()),
    GetPage(name: ProductScreen.allProductScreen, page: () => const ProductScreen()),
    GetPage(name: AboutUS.aboutUs, page: () => const AboutUS()),
    GetPage(name: PublicSpeakerCategory.singlePublicCategory, page: () => const PublicSpeakerCategory()),
    GetPage(name: SchoolNursery.schoolNursery, page: () => const SchoolNursery()),
    GetPage(name: BankDetailsScreen.bankDetailsScreen, page: () => const BankDetailsScreen()),
    GetPage(name: OrderDetails.orderDetails, page: () => const OrderDetails()),
    GetPage(name: ReturnPolicy.returnPolicy, page: () => const ReturnPolicy()),
    GetPage(name: PublicSpeaker.publicSpeaker, page: () => const PublicSpeaker()),
    GetPage(name: ThankYouVendorScreen.route, page: () => const ThankYouVendorScreen()),
    GetPage(name: '/editprofileScreen', page: () => const EditProfile()),
    GetPage(name: '/addProductScreen', page: () => const AddProduct()),
    GetPage(name: '/newPasswordScreen', page: () => const NewPassword()),
    GetPage(name: '/termsConditionScreen', page: () => const TermCondition()),
    GetPage(name: '/calendarScreen', page: () => const EventCalendarScreen()),
    GetPage(name: '/eBookScreen', page: () => const EBookScreen()),
    GetPage(name: WithdrawMoney.withdrawMoney, page: () => const WithdrawMoney()),
    GetPage(name: '/singleChair', page: () => const SingleChair()),
    GetPage(name: DashboardScreen.dashboardScreen, page: () => const DashboardScreen()),
    GetPage(name: VendorRegistrationScreen.registrationScreen, page: () => const VendorRegistrationScreen()),
    GetPage(name: '/eBooKCategoryScreen', page: () => const EBookCategory()),
    GetPage(name: '/singleCategory', page: () => const SingleCategory()),
    GetPage(name: '/scoopsNursery', page: () => const SchoolNurseryCategory()),
    GetPage(name: SetTimeScreen.setTimeScreen, page: () => const SetTimeScreen()),
    GetPage(name: '/officeFurnitureScreen', page: () => const OfficeFurniture()),
    GetPage(name: CategoriesScreen.categoriesScreen, page: () => const CategoriesScreen()),
    GetPage(name: BagsScreen.addBagScreen, page: () => const BagsScreen()),
    GetPage(name: SingleCategories.singleCategoriesScreen, page: () => const SingleCategories()),
    GetPage(name: GeneralLibrary.generalLibrary, page: () => const GeneralLibrary()),
    GetPage(name: CheckOutScreen.checkOutScreen, page: () => const CheckOutScreen()),
    GetPage(name: CheckOutScreen.checkOutScreen, page: () => const CheckOutScreen()),
    GetPage(name: OrderCompleteScreen.route, page: () => const OrderCompleteScreen()),
    GetPage(name: AuthorsScreen.authorsScreen, page: () => const AuthorsScreen()),
    GetPage(name: SingleAuthorScreen.singleAuthorScreen, page: () => const SingleAuthorScreen()),
    GetPage(name: TeacherScreen.teacherScreen, page: () => const TeacherScreen()),
    GetPage(name: SelectedTeacher.selectedTeacher, page: () => const SelectedTeacher()),
    GetPage(name: MyOrdersScreen.myOrdersScreen, page: () => const MyOrdersScreen()),
    GetPage(name: SelectedOrderScreen.route, page: () => const SelectedOrderScreen()),
  ];
}
