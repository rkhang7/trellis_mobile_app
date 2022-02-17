import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/service/auth_service.dart';

class SignUpController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;
  var isLoadingButton = false.obs;

  var authService = Get.find<AuthService>();

  void signUp(String email, String password) {
    if (formKey.currentState!.validate()) {
      isLoadingButton.value = true;
      authService.createUserWithEmailAndPassword(email, password).then((value) {
        isLoadingButton.value = false;
        if (value != null) {
          Get.offAllNamed(AppRoutes.DASHBOARD);
        }
      });
    }
  }
}
