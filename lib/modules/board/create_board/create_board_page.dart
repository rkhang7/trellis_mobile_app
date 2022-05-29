import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/widget/input_field_create.dart';
import 'package:trellis_mobile_app/utils/widgets.dart';

import 'create_board_controller.dart';

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
              Obx(
                () => _buildDropdownViewPermission(),
              ),
              30.height,
              _buildDescription(),
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
              createBoardController.boardNameIsEmpty.value
                  ? null
                  : createBoardController.createBoard();
            },
          ),
        ),
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
        createBoardController.selectType.value == 1
            ? "public".tr
            : "private".tr,
        style: const TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {
        createBoardController.selectType.value = value;
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

  Widget _buildDescription() {
    return TextFormField(
      autofocus: false,
      controller: createBoardController.descriptionController,
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
