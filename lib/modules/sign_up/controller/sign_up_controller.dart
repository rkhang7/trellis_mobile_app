import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    await authService.createUserWithEmailAndPassword(email, password);
  }
}
