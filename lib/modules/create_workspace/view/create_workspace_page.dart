import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/create_board/controller/create_board_controller.dart';
import 'package:trellis_mobile_app/modules/create_workspace/controller/create_workspace_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import '../../../utils/widget/input_field_create.dart';

class CreateWorkspacePage extends StatelessWidget {
  CreateWorkspacePage({Key? key}) : super(key: key);
  final createWorkspaceController = Get.find<CreateWorkspaceController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputFieldCreate(
                  onChange: (value) {
                    if (value.isEmpty) {
                      createWorkspaceController.workspaceNameIsEmpty.value =
                          true;
                    } else {
                      createWorkspaceController.workspaceNameIsEmpty.value =
                          false;
                    }
                  },
                  title: "workspace_name".tr,
                  controller: createWorkspaceController.workspaceNameController,
                  autoFocus: true,
                  primaryColor: Colors.green,
                ),
                20.height,
                Text(
                  "workspace_type".tr,
                ),
                _buildDropdownWorkspaceType(),
                20.height,
                _buildDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: const CloseButton(),
      title: Text(
        "create_workspace".tr,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        Obx(() {
          return IconButton(
            onPressed: () {
              createWorkspaceController.workspaceNameIsEmpty.value
                  ? null
                  : Get.back();
            },
            icon: Icon(
              Icons.done,
              color: createWorkspaceController.workspaceNameIsEmpty.value
                  ? Colors.grey
                  : Colors.white,
            ),
          );
        })
      ],
    );
  }

  DropdownButton<String> _buildDropdownWorkspaceType() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: const Text(
        "Chọn",
        style: TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {},
      items: [
        DropdownMenuItem(
            child: ListTile(
              title: Text("personnel".tr),
              onTap: () {
                Get.back();
              },
            ),
            value: 'Nhân sự'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("small_business".tr),
              onTap: () {
                Get.back();
              },
            ),
            value: 'Doanh nghiệp nhỏ'),
        DropdownMenuItem(
            child: ListTile(
              title: const Text("Marketing"),
              onTap: () {
                Get.back();
              },
            ),
            value: 'Marketing'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("operating".tr),
              onTap: () {
                Get.back();
              },
            ),
            value: 'Điều hành'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("education".tr),
              onTap: () {
                Get.back();
              },
            ),
            value: 'Giáo dục'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("it".tr),
              onTap: () {
                Get.back();
              },
            ),
            value: 'Công nghệ thông tin'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("other".tr),
              onTap: () {
                Get.back();
              },
            ),
            value: 'Khác'),
      ],
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      autofocus: false,
      controller: createWorkspaceController.descriptionController,
      decoration: InputDecoration(
        labelText: "workspace_description".tr,
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
