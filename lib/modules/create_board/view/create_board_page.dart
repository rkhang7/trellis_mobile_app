import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/create_board/controller/create_board_controller.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/widget/input_field_create.dart';
import 'package:trellis_mobile_app/utils/widgets.dart';

class CreateBoardPage extends StatelessWidget {
  CreateBoardPage({Key? key}) : super(key: key);
  final createBoardController = Get.find<CreateBoardController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InputFieldCreate(
              onChange: (value) {
                if (value.isEmpty) {
                  createBoardController.boardNameIsEmpty.value = true;
                } else {
                  createBoardController.boardNameIsEmpty.value = false;
                }
              },
              title: "Tên bảng",
              controller: createBoardController.boardNameController,
              autoFocus: true,
              primaryColor: Colors.green,
            ),
            20.height,
            const Text("Không gian làm việc"),
            Obx(
              () => _buildDropdownWorkingSpace(),
            ),
            30.height,
            const Text("Quyền xem"),
            _buildDropdownViewPermission(),
            30.height,
          ]),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: const CloseButton(
        color: iconColorPrimary,
      ),
      title: Text('Tạo bảng', style: boldTextStyle(color: Colors.white)),
      actions: [
        Obx(
          () => IconButton(
            icon: Icon(
              Icons.done,
              color: createBoardController.boardNameIsEmpty.value
                  ? Colors.grey
                  : Colors.white,
            ),
            onPressed: () {
              createBoardController.boardNameIsEmpty.value ? null : Get.back();
            },
          ),
        ),
      ],
    );
  }

  DropdownButton<String> _buildDropdownViewPermission() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: const Text(
        "Không gian làm việc",
        style: TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {},
      items: [
        DropdownMenuItem(
            child: ListTile(
              title: const Text("Riêng tư"),
              leading: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              leading: const Icon(
                Icons.group_outlined,
                color: Colors.black,
              ),
              title: const Text("Không gian làm việc"),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              leading: const Icon(
                Icons.public,
                color: Colors.black,
              ),
              title: const Text("Công khai"),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
      ],
    );
  }

  DropdownButton<String> _buildDropdownWorkingSpace() {
    return DropdownButton(
      value: createBoardController.selectedWorkspaceId.toString(),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: const Text(
        "Nhóm 1",
        style: TextStyle(color: Colors.black),
      ),
      onChanged: (selectedValue) {
        createBoardController.selectedWorkspaceId.value =
            int.parse(selectedValue.toString());
      },
      items: createBoardController.listDropdownMenuItemWorkspaces.value,
    );
  }
}
