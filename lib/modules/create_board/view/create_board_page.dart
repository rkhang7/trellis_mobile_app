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
        body: SingleChildScrollView(
          child: Container(
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
                title: "board_name".tr,
                controller: createBoardController.boardNameController,
                autoFocus: true,
                primaryColor: Colors.green,
              ),
              20.height,
              Text("workspace".tr),
              Obx(
                () => _buildDropdownWorkingSpace(),
              ),
              30.height,
              Text("visibility".tr),
              _buildDropdownViewPermission(),
              30.height,
            ]),
          ),
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
      title: Text('create_board'.tr, style: boldTextStyle(color: Colors.white)),
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
              title: Text("private".tr),
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
              title: Text("workspace".tr),
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
              title: Text("public".tr),
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
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: Text(
        createBoardController.findWorkspaceById(
                    createBoardController.selectedWorkspaceId.value) ==
                null
            ? ""
            : createBoardController
                .findWorkspaceById(
                    createBoardController.selectedWorkspaceId.value)!
                .name,
        style: const TextStyle(color: Colors.black),
      ),
      onChanged: (selectedValue) {
        createBoardController.selectedWorkspaceId.value =
            int.parse(selectedValue.toString());
      },
      items: createBoardController.listDropdownMenuItemWorkspaces.value,
    );
  }
}
