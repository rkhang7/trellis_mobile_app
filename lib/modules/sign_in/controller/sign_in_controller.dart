import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscurePassword = true.obs;

  void signIn() {
    if (formKey.currentState!.validate()) {}
  }
}
