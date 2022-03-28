import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/add_member/controller/add_member_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class AddMemberPage extends StatelessWidget {
  AddMemberPage({Key? key}) : super(key: key);
  final addMemberController = Get.find<AddMemberController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 64.sp),
                  children: [
                    TextSpan(text: "${"add_user_to_workspace".tr}: "),
                    TextSpan(
                        text: addMemberController.currentWorkspace!.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: addMemberController.emailController,
                cursorColor: Colors.green,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        "add_members".tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
    );
  }
}
