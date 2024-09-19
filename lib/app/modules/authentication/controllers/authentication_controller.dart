import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/get_storage/get_storage.dart';
import 'package:task_app/app/data/models/user_model.dart';
import 'package:task_app/app/routes/app_pages.dart';
import 'package:task_app/const/app_const/app_keys.dart';

class AuthenticationController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    initialise();
  }

  void initialise() async {
    final firebaseAuth = FirebaseAuth.instance;

    final userString = await Storage.getValue(AppKeys.users);

    if (firebaseAuth.currentUser != null && userString != null) {
      final decodedUser = json.decode(userString);

      Get.put(UserModel.fromJson(decodedUser), permanent: true);

      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
