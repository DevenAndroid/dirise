import 'package:dirise/screens/my_account_screens/about_us_screen.dart';
import 'package:dirise/bottomavbar.dart';
import 'package:dirise/screens/my_account_screens/editprofile_screen.dart';
import 'package:dirise/screens/auth_screens/forgetpass_screen.dart';
import 'package:dirise/screens/auth_screens/newpasswordscreen.dart';
import 'package:dirise/screens/my_account_screens/profile_screen.dart';
import 'package:dirise/screens/my_account_screens/return_policy_screen.dart';
import 'package:dirise/screens/my_account_screens/termsconditions_screen.dart';
import 'package:dirise/vendorflow/orders/vendor_order_list_screen.dart';
import 'package:get/get.dart';
import '../screens/auth_screens/createacc_screen.dart';
import '../screens/auth_screens/otp_screen.dart';
import '../screens/calender.dart';
import '../screens/check_out/add_bag_screen.dart';
import '../screens/categores/categories_screen.dart';
import '../screens/check_out/check_out_screen.dart';
import '../screens/check_out/direct_check_out.dart';
import '../screens/check_out/order_completed_screen.dart';
import '../screens/my_account_screens/faqs_screen.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/order_screens/my_orders_screen.dart';
import '../screens/my_account_screens/privacy_policy_screen.dart';
import '../screens/public_speaker_screen/publicspeaker_screen.dart';
import '../screens/public_speaker_screen/single_public_speaker_screen.dart';
import '../screens/school_nursery_category.dart';
import '../screens/order_screens/selectd_order_screen.dart';
import '../screens/virtual_assets/ebookcategory_screen.dart';
import '../screens/virtual_assets/singlecategory_screen.dart';
import '../screens/virtual_assets/virtual_assets_screen.dart';
import '../vendorflow/add_money_screen.dart';
import '../vendorflow/dashboard/dashboard_screen.dart';
import '../vendorflow/bank_account_screen.dart';
import '../vendorflow/orders/orderdetailsscreen.dart';
import '../vendorflow/products/add_product/add_product_screen.dart';
import '../vendorflow/products/all_product_screen.dart';
import '../vendorflow/dashboard/store_open_time_screen.dart';
import '../vendorflow/authenthication/thanku_screen.dart';
import '../vendorflow/authenthication/vendor_registration_screen.dart';
import '../vendorflow/authenthication/verify_vendor_otp.dart';
import '../vendorflow/profile/vendor_profile_screen.dart';

class MyRouters {
  static var route = [
    GetPage(name: '/', page: () => const BottomNavbar()),
    GetPage(name: LoginScreen.route, page: () => const LoginScreen()),
    GetPage(name: VendorOTPVerification.route, page: () => const VendorOTPVerification()),
    GetPage(name: CreateAccountScreen.route, page: () => const CreateAccountScreen()),
    GetPage(name: ForgetPasswordScreen.route, page: () => const ForgetPasswordScreen()),
    GetPage(name: BottomNavbar.route, page: () => const BottomNavbar()),
    GetPage(name: PrivacyPolicy.route, page: () => const PrivacyPolicy()),
    GetPage(name: ProfileScreen.route, page: () => const ProfileScreen()),
    GetPage(name: OtpScreen.route, page: () => const OtpScreen()),
    GetPage(name: FrequentlyAskedQuestionsScreen.route, page: () => const FrequentlyAskedQuestionsScreen()),
    GetPage(name: VendorOrderList.route, page: () => const VendorOrderList()),
    GetPage(name: VendorProductScreen.route, page: () => const VendorProductScreen()),
    GetPage(name: AboutUsScreen.route, page: () => const AboutUsScreen()),
    GetPage(name: PublicSpeakerCategoryScreen.route, page: () => const PublicSpeakerCategoryScreen()),
    // GetPage(name: SchoolNurseryScreen.route, page: () => const SchoolNurseryScreen()),
    GetPage(name: BankDetailsScreen.route, page: () => const BankDetailsScreen()),
    GetPage(name: OrderDetails.route, page: () => const OrderDetails()),
    GetPage(name: ReturnPolicyScreen.route, page: () => const ReturnPolicyScreen()),
    GetPage(name: PublicSpeakerScreen.route, page: () => const PublicSpeakerScreen()),
    GetPage(name: ThankYouVendorScreen.route, page: () => const ThankYouVendorScreen()),
    GetPage(name: EditProfileScreen.route, page: () => const EditProfileScreen()),
    GetPage(name: AddProductScreen.route, page: () => const AddProductScreen()),
    GetPage(name: NewPasswordScreen.route, page: () => const NewPasswordScreen()),
    GetPage(name: TermConditionScreen.route, page: () => const TermConditionScreen()),
    GetPage(name: EventCalendarScreen.route, page: () => const EventCalendarScreen()),
    GetPage(name: VirtualAssetsScreen.route, page: () => const VirtualAssetsScreen()),
    GetPage(name: WithdrawMoney.route, page: () => const WithdrawMoney()),
    // GetPage(name: SingleChairScreen.route, page: () => const SingleChairScreen()),
    GetPage(name: VendorDashBoardScreen.route, page: () => const VendorDashBoardScreen()),
    GetPage(name: VendorRegistrationScreen.registrationScreen, page: () => const VendorRegistrationScreen()),
    GetPage(name: EBookCategoryScreen.route, page: () => const EBookCategoryScreen()),
    // GetPage(name: SingleCategoryScreen.route, page: () => const SingleCategoryScreen()),
    GetPage(name: SchoolNurseryCategory.route, page: () => const SchoolNurseryCategory()),
    GetPage(name: SetTimeScreen.setTimeScreen, page: () => const SetTimeScreen()),
    // GetPage(name: OfficeFurnitureScreen.route, page: () => const OfficeFurnitureScreen()),
    GetPage(name: CategoriesScreen.categoriesScreen, page: () => const CategoriesScreen()),
    GetPage(name: BagsScreen.addBagScreen, page: () => const BagsScreen()),
    // GetPage(name: SingleCategories.route, page: () => const SingleCategories()),
    // GetPage(name: GeneralLibrary.generalLibrary, page: () => const GeneralLibrary()),
    GetPage(name: CheckOutScreen.checkOutScreen, page: () => const CheckOutScreen()),
    GetPage(name: CheckOutScreen.checkOutScreen, page: () => const CheckOutScreen()),
    GetPage(name: OrderCompleteScreen.route, page: () => const OrderCompleteScreen()),
    // GetPage(name: AuthorsScreen.authorsScreen, page: () => const AuthorsScreen()),
    // GetPage(name: SingleAuthorScreen.singleAuthorScreen, page: () => const SingleAuthorScreen()),
    // GetPage(name: TeacherScreen.teacherScreen, page: () => const TeacherScreen()),
    // GetPage(name: SelectedTeacher.selectedTeacher, page: () => const SelectedTeacher()),
    GetPage(name: MyOrdersScreen.myOrdersScreen, page: () => const MyOrdersScreen()),
    GetPage(name: SelectedOrderScreen.route, page: () => const SelectedOrderScreen()),
    GetPage(name: DirectCheckOutScreen.route, page: () => const DirectCheckOutScreen()),
    GetPage(name: VendorProfileScreen.route, page: () => const VendorProfileScreen()),
  ];
}
