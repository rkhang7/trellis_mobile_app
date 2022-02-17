import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/sign_up/controller/sign_up_controller.dart';
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
                  const Text(
                    signUpAccount,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
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
                  AuthButton(
                      text: signUp,
                      onClick: () {
                        _signUp();
                      })
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
          return "Vui lòng nhập email";
        } else if (!(EmailValidator.validate(value))) {
          return "Email không hợp lệ";
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

  void _signUp() {
    if (signUpUpController.formKey.currentState!.validate()) {}
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
          return "Vui lòng nhập mật khẩu";
        } else if (!(RegExp("^(\\w{6,})\$").hasMatch(value))) {
          return "Mật khẩu ít nhất có 6 kí tự";
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: "Mật khẩu",
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
          )),
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
          return "Vui lòng nhập mật khẩu";
        } else if (!(RegExp("^(\\w{6,})\$").hasMatch(value))) {
          return "Mật khẩu ít nhất có 6 kí tự";
        } else if (!(signUpUpController.passwordController.text ==
            signUpUpController.confirmPasswordController.text)) {
          return "Mật khẩu không khớp";
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: "Nhập lại mật khẩu",
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
          )),
    );
  }
}
