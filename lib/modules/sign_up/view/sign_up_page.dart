import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/sign_up/controller/sign_up_controller.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/constants.dart';
import 'package:trellis_mobile_app/utils/widget/auth_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final signUpUpController = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Colors.blue,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Form(
          key: signUpUpController.formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(36),
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "register_account".tr,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 200.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width / 2.5,
                        child: _buildFirstNameField(
                            signUpUpController.firstNameController),
                      ),
                      SizedBox(
                        width: Get.width / 2.5,
                        child: _buildLastNameField(
                            signUpUpController.lastNameController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildEmailField(signUpUpController.emailController),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildPasswordField(
                        signUpUpController.passwordController),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildConfirmPasswordField(
                        signUpUpController.confirmPasswordController),
                  ),
                  const SizedBox(height: 40),
                  Obx(
                    () => AuthButton(
                      widget: signUpUpController.isLoadingButton.isTrue
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "sign_up".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                      onClick: () {
                        String email = signUpUpController.emailController.text;
                        String password =
                            signUpUpController.passwordController.text;
                        signUpUpController.signUp(email, password);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "already_account".tr,
                        style: primaryTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed(AppRoutes.SIGN_IN);
                        },
                        child: Text(
                          "sign_in".tr,
                          style: primaryTextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildEmailField(TextEditingController controller) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      obscureText: false,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onSaved: (save) {
        controller.text = save!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "please_enter_email".tr;
        } else if (!(EmailValidator.validate(value))) {
          return "email_invalid".tr;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: const Icon(Icons.email_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  _buildPasswordField(TextEditingController controller) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      obscureText: signUpUpController.isObscurePassword.value,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onSaved: (save) {
        controller.text = save!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "please_enter_password".tr;
        } else if (!(RegExp("^(\\w{6,})\$").hasMatch(value))) {
          return "password_at_least".tr;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "password".tr,
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: IconButton(
            onPressed: () {
              signUpUpController.isObscurePassword.value =
                  !signUpUpController.isObscurePassword.value;
            },
            icon: signUpUpController.isObscurePassword.isTrue
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _buildConfirmPasswordField(TextEditingController controller) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      obscureText: signUpUpController.isObscureConfirmPassword.value,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onSaved: (save) {
        controller.text = save!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "please_re-enter_password".tr;
        } else if (!(RegExp("^(\\w{6,})\$").hasMatch(value))) {
          return "password_at_least".tr;
        } else if (!(signUpUpController.passwordController.text ==
            signUpUpController.confirmPasswordController.text)) {
          return "password_incorrect".tr;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "re-enter_password".tr,
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: IconButton(
            onPressed: () {
              signUpUpController.isObscureConfirmPassword.value =
                  !signUpUpController.isObscureConfirmPassword.value;
            },
            icon: signUpUpController.isObscureConfirmPassword.isTrue
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildFirstNameField(TextEditingController controller) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      obscureText: false,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.name,
      onSaved: (save) {
        controller.text = save!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "please_enter_first_name".tr;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "first_name".tr,
        prefixIcon: const Icon(Icons.border_color),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _buildLastNameField(TextEditingController controller) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      obscureText: false,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.name,
      onSaved: (save) {
        controller.text = save!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "please_enter_last_name".tr;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "last_name".tr,
        prefixIcon: const Icon(Icons.border_color),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
