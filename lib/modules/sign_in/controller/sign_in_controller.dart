import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/service/auth_service.dart';

class SignInController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscurePassword = true.obs;
  var isButtonLoading = false.obs;

  var authService = Get.find<AuthService>();

  void signIn(String email, String password) {
    if (formKey.currentState!.validate()) {
      isButtonLoading.value = true;
      authService.signInWithEmailAndPassword(email, password).then((value) {
        isButtonLoading.value = false;
        if (value != null) {
          Get.offAllNamed(AppRoutes.DASHBOARD);
        }
      });
    }
  }
}
