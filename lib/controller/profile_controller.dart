import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile_model.dart';
import '../repoistery/repository.dart';
import '../utils/ApiConstant.dart';


class ProfileController extends GetxController {
  ProfileModel model = ProfileModel();
  final Repositories repositories = Repositories();
  bool apiLoaded = false;
  final ImagePicker picker = ImagePicker();
  RxInt refreshInt = 0.obs;
  bool userLoggedIn = false;

  Future<bool> checkUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(Repositories.userInfo) != null) {
      userLoggedIn = true;
    } else {
      userLoggedIn = false;
    }
    return userLoggedIn;
  }

  updateUI(){
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void onInit() {
    super.onInit();
    checkUserLoggedIn().then((value) {
      if(value){
        getDataProfile();
      }
    });
  }

  getDataProfile() {
    repositories.postApi(url: ApiUrls.userProfile).then((value) {
      model = ProfileModel.fromJson(jsonDecode(value));
      apiLoaded = true;
      updateUI();
    });
  }

}
