import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/board/update_board/update_board_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/widget/input_field_create.dart';

class UpdateBoardPage extends StatelessWidget {
  UpdateBoardPage({Key? key}) : super(key: key);
  final updateBoardController = Get.find<UpdateBoardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InputFieldCreate(
              onChange: (value) {
                if (value.isEmpty) {
                  updateBoardController.boardNameIsEmpty.value = true;
                } else {
                  updateBoardController.boardNameIsEmpty.value = false;
                }
              },
              title: "board_name".tr,
              controller: updateBoardController.boardNameController,
              autoFocus: true,
              primaryColor: Colors.green,
            ),
            30.height,
            Text("visibility".tr),
            Obx(
              () => _buildDropdownViewPermission(),
            ),
            30.height,
            _buildDescription(),
          ]),
        ),
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
              updateBoardController.boardNameIsEmpty.value
                  ? null
                  : updateBoardController.updateBoard();
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

  DropdownButton<int> _buildDropdownViewPermission() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: Text(
        updateBoardController.selectedType.value == 1
            ? "public".tr
            : "private".tr,
        style: const TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {
        updateBoardController.selectedType.value = value;
      },
      items: [
        DropdownMenuItem(
            child: ListTile(
              title: Text("public".tr),
              leading: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
            value: 1),
        DropdownMenuItem(
            child: ListTile(
              leading: const Icon(
                Icons.group_outlined,
                color: Colors.black,
              ),
              title: Text("private".tr),
            ),
            value: 2),
      ],
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      autofocus: false,
      controller: updateBoardController.descriptionController,
      decoration: InputDecoration(
        labelText: "board_description".tr,
        labelStyle: const TextStyle(color: Colors.green),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
      cursorColor: Colors.green,
      cursorHeight: 25,
      onChanged: (value) {},
      maxLines: null,
    );
  }
}
