import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import '../../../utils/widget/input_field_create.dart';
import 'create_workspace_controller.dart';

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
                Obx(
                  () => _buildDropdownWorkspaceType(),
                ),
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
              createWorkspaceController.workspaceNameIsEmpty.value ||
                      createWorkspaceController.selectedType.value == "select"
                  ? null
                  : createWorkspace();
            },
            icon: Icon(
              Icons.done,
              color: createWorkspaceController.workspaceNameIsEmpty.value ||
                      createWorkspaceController.selectedType.value == "select"
                  ? Colors.grey
                  : Colors.white,
            ),
          );
        })
      ],
    );
  }

  Widget _buildDropdownWorkspaceType() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: Text(
        createWorkspaceController.selectedType.value.toString().tr,
        style: const TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {
        createWorkspaceController.selectedType.value = value.toString();
      },
      items: [
        DropdownMenuItem(
            child: ListTile(
              title: Text("personnel".tr),
            ),
            value: 'personnel'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("small_business".tr),
            ),
            value: 'small_business'),
        const DropdownMenuItem(
            child: ListTile(
              title: Text("Marketing"),
            ),
            value: 'marketing'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("operating".tr),
            ),
            value: 'operating'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("education".tr),
            ),
            value: 'education'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("it".tr),
            ),
            value: 'it'),
        DropdownMenuItem(
            child: ListTile(
              title: Text("other".tr),
            ),
            value: 'other'),
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

  createWorkspace() {
    String name = createWorkspaceController.workspaceNameController.text.trim();
    String type = createWorkspaceController.selectedType.value;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String description =
        createWorkspaceController.descriptionController.text.trim();
    createWorkspaceController.createWorkspace(
      WorkSpaceRequest(
          name: name,
          workspaceType: type,
          createdBy: uid,
          description: description,
          closed: false),
    );
  }
}
