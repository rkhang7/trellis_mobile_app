import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/service/auth_service.dart';

class SignUpController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;
  var isLoadingButton = false.obs;

  var authService = Get.find<AuthService>();

  var userRepository = UserRepository();

  void signUp(String email, String password) {
    if (formKey.currentState!.validate()) {
      isLoadingButton.value = true;
      authService.createUserWithEmailAndPassword(email, password).then(
        (value) {
          if (value != null) {
            Color myColor = Color((Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);
            var hexColor = myColor.value.toRadixString(16).substring(2, 8);

            // create user to db
            userRepository
                .createUser(UserRequest(
                    uid: value.uid,
                    email: email,
                    firstName: firstNameController.text.trim(),
                    lastName: lastNameController.text.trim(),
                    avatarBackgroundColor: hexColor))
                .then(
              (value) {
                isLoadingButton.value = false;
                Get.offAllNamed(AppRoutes.DASHBOARD);
                EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
              },
            ).catchError(
              (Object obj) {
                // non-200 error goes here.
                switch (obj.runtimeType) {
                  case DioError:
                    // Here's the sample to get the failed response error code and message
                    final res = (obj as DioError).response;
                    if (obj.type == DioErrorType.connectTimeout) {
                      isLoadingButton.value = false;
                      EasyLoading.showError("error".tr);
                    } else if (obj.type == DioErrorType.receiveTimeout) {
                      EasyLoading.showError("error".tr);
                    }
                    if (res!.statusCode != 200) {
                      isLoadingButton.value = false;
                      EasyLoading.showError("error".tr);
                    }
                    break;
                  default:
                    break;
                }
              },
            );
          } else {
            isLoadingButton.value = false;
          }
        },
      );
    }
  }
}
