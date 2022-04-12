import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import '../../../../utils/widget/input_field_create.dart';
import '../controller/update_workspace_controller.dart';

class UpdateWorkspacePage extends StatelessWidget {
  UpdateWorkspacePage({Key? key}) : super(key: key);
  final updateWorkspaceController = Get.find<UpdateWorkspaceController>();
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
                      updateWorkspaceController.workspaceNameIsEmpty.value =
                          true;
                    } else {
                      updateWorkspaceController.workspaceNameIsEmpty.value =
                          false;
                    }
                  },
                  title: "workspace_name".tr,
                  controller: updateWorkspaceController.workspaceNameController,
                  autoFocus: true,
                  primaryColor: Colors.green,
                ),
                // TextFormField(
                //   autofocus: false,
                //   controller: updateWorkspaceController.workspaceNameController,
                //   decoration: InputDecoration(
                //     labelText: "workspace_name".tr,
                //     labelStyle: const TextStyle(color: Colors.green),
                //     enabledBorder: const UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.green, width: 2),
                //     ),
                //     focusedBorder: const UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.green, width: 2),
                //     ),
                //   ),
                //   cursorColor: Colors.green,
                //   cursorHeight: 25,
                //   onChanged: (value) {
                //     if (value.isEmpty) {
                //       updateWorkspaceController.workspaceNameIsEmpty.value =
                //           true;
                //     } else {
                //       updateWorkspaceController.workspaceNameIsEmpty.value =
                //           false;
                //     }
                //   },
                // ),
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
        "update_workspace".tr,
        style: TextStyle(color: Colors.white, fontSize: 72.sp),
      ),
      actions: [
        Obx(() {
          return IconButton(
            onPressed: () {
              updateWorkspaceController.workspaceNameIsEmpty.value
                  ? null
                  : updateWorkspaceController.updateWorkspace();
            },
            icon: Icon(
              Icons.done,
              color: updateWorkspaceController.workspaceNameIsEmpty.value
                  ? Colors.grey
                  : Colors.white,
            ),
          );
        })
      ],
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      autofocus: false,
      controller: updateWorkspaceController.descriptionController,
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

  Widget _buildDropdownWorkspaceType() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: Text(
        updateWorkspaceController.selectedType.value.toString().tr,
        style: const TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {
        updateWorkspaceController.selectedType.value = value.toString();
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

  updateWorkspace() {}
}
