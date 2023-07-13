
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/profile_model.dart';
import '../repoistery/profile_repo.dart';
import '../repoistery/repository.dart';
import '../routers/my_routers.dart';
import '../utils/ApiConstant.dart';


class ProfileController extends GetxController {
  Rx<profileModel> model = profileModel().obs;
  final Repositories repositories = Repositories();
  RxBool isDataLoading = false.obs;
  final ImagePicker picker = ImagePicker();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<RxStatus> statusOfProfile = RxStatus.empty().obs;
  @override
  void onInit() {
    super.onInit();
    getDataProfile();
  }

  getDataProfile() {
    userProfileData().then((value) {
      if (value.status == true) {


        model.value = value;

        firstNameController.text = model.value.user!.name.toString();
        lastNameController.text = model.value.user!.lastName.toString();
        emailController.text = model.value.user!.email.toString();
        phoneController.text = model.value.user!.phone.toString();
        addressController.text = model.value.user!.address.toString();

        statusOfProfile.value = RxStatus.success();
        showToast(value.message.toString());
      } else {
        statusOfProfile.value = RxStatus.error();
        showToast(value.message.toString());
      }
    }
      // showToast(value.message.toString());

    );
  }


}
