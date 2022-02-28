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
}
