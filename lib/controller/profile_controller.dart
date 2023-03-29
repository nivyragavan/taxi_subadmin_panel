
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/profile_view_model.dart';
import '../service/api_service.dart';

class ProfileController extends GetxController {
  var getProfileInfo = <ProfileViewModel>[].obs;
  // var updateProfileInfo = <ProfileUpdateModel>[].obs;
  var isLoading = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  @override
  void onInit() {
    fetchProfileInfo();
    super.onInit();
  }

  void fetchProfileInfo() async {
    try {
      isLoading(true);
      var profileInfo = await ApiService().profileView();
      if (profileInfo != null) {
        getProfileInfo.assign(profileInfo);
        nameController.text = getProfileInfo[0].body!.subadminprofile![0].name!;
        phoneController.text = getProfileInfo[0].body!.subadminprofile![0].phonenumber!;
        designationController.text = getProfileInfo[0].body!.subadminprofile![0].designation!;
        emailController.text = getProfileInfo[0].body!.subadminprofile![0].email!;
      }
    } finally {
      isLoading(false);
    }
  }

// void fetchProfileUpdate() async {
//   try {
//     isLoading(true);
//     var profileUpdateInfo = await APIService().updateProfile(
//         namecontroller.text,
//         phonecontroller.text,
//         emailcontroller.text,
//         passwordcontroller.text);
//     if (profileUpdateInfo != null) {
//       updateProfileInfo.assign(profileUpdateInfo);
//       passwordcontroller.text =
//           profileUpdateInfo.profileEdit[0].password ?? '';
//     }
//     return null;
//   } finally {
//     isLoading(false);
//   }
// }
}
