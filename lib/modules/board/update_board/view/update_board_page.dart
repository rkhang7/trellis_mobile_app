import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/update_board/controller/update_board_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class UpdateBoardPage extends StatelessWidget {
  UpdateBoardPage({Key? key}) : super(key: key);
  final updateBoardController = Get.find<UpdateBoardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Text("Update board"),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: const CloseButton(),
      title: Text(
        "board_setting".tr,
        style: TextStyle(color: Colors.white, fontSize: 72.sp),
      ),
      actions: [
        Obx(() {
          return IconButton(
            onPressed: () {
              // updateBoardController.boardNameIsEmpty.value
              //     ? null
              //     : updateBoardController.updateWorkspace();
            },
            icon: Icon(
              Icons.done,
              color: updateBoardController.boardNameIsEmpty.value
                  ? Colors.grey
                  : Colors.white,
            ),
          );
        })
      ],
    );
  }
}
