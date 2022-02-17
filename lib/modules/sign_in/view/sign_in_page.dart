import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/sign_in/controller/sign_in_controller.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/constants.dart';
import 'package:trellis_mobile_app/utils/widget/auth_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  final signInController = Get.find<SignInController>();
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
          key: signInController.formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(36),
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    logIn,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildEmailField(signInController.emailController),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildPasswordField(
                        signInController.passwordController),
                  ),
                  const SizedBox(height: 20),
                  _buildResetPassword(),
                  const SizedBox(height: 40),
                  _buildSignInButton(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bạn chưa có tài khoản? ",
                        style: primaryTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed(AppRoutes.SIGN_UP);
                        },
                        child: Text(
                          "Đăng kí",
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

  Obx _buildSignInButton() {
    return Obx(
      () => AuthButton(
        widget: signInController.isButtonLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text(
                logIn,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        onClick: () {
          String email = signInController.emailController.text;
          String password = signInController.passwordController.text;
          signInController.signIn(email, password);
        },
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

  _buildPasswordField(TextEditingController controller) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      obscureText: signInController.isObscurePassword.value,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.text,
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
                signInController.isObscurePassword.value =
                    !signInController.isObscurePassword.value;
              },
              icon: signInController.isObscurePassword.isTrue
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  _buildResetPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () async {
            await Get.defaultDialog(
              contentPadding: const EdgeInsets.all(8),
              title: resetPassword,
              titleStyle: const TextStyle(color: Colors.blue, fontSize: 20),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Vui lòng nhập email"),
                  10.height,
                  Form(
                    key: signInController.formKeyDialog,
                    child: _buildEmailField(
                        signInController.emailResetPasswordController),
                  )
                ],
              ),
              confirm: Obx(
                () => InkWell(
                  onTap: () {
                    signInController.resetPassword(
                        signInController.emailResetPasswordController.text);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: signInController.isButtonLoadingDialog.isTrue
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : const Text(
                            resetPassword,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                  ),
                ),
              ),
            );
          },
          child: Text(
            "Quên mật khẩu? ",
            style: primaryTextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
