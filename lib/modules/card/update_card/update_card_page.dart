import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/update_board/update_board_controller.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_controller.dart';

class UpdateCardPage extends StatelessWidget {
  UpdateCardPage({Key? key}) : super(key: key);
  final updateCardController = Get.find<UpdateCardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => _buildInfoCardArea(),
              ),
              SizedBox(
                height: 40.h,
              ),
              Obx(
                () => _buildEditDescriptionArea(),
              ),
            ],
          ),
        ),
      ),
      appBar: _buildAppBar(),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.white,
      ),
      leading: CloseButton(
        color: Colors.black,
        onPressed: () {
          updateCardController.handleLeading();
        },
      ),
      actions: [
        Obx(() => _buildAction()),
      ],
      title: Obx(() => _buildTitle()),
    );
  }

  Widget _buildTitle() {
    return updateCardController.editingName.isTrue
        ? Text(
            "edit_card_name".tr,
            style: TextStyle(color: Colors.black, fontSize: 64.sp),
          )
        : updateCardController.editingDescription.isTrue
            ? Text(
                "edit_card_description".tr,
                style: TextStyle(color: Colors.black, fontSize: 64.sp),
              )
            : Container();
  }

  Widget _buildAction() {
    return updateCardController.editingName.isTrue
        ? IconButton(
            onPressed: () {
              updateCardController.cardNameIsEmpty.isTrue
                  ? null
                  : updateCardController.updateCardName();
            },
            icon: Icon(Icons.check,
                color: updateCardController.cardNameIsEmpty.isTrue
                    ? Colors.grey
                    : Colors.black),
          )
        : updateCardController.editingDescription.isTrue
            ? IconButton(
                onPressed: () {
                  updateCardController.updateCardDescription();
                },
                icon: const Icon(Icons.check, color: Colors.black),
              )
            : IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.black),
              );
  }

  Widget _buildInfoCardArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          updateCardController.editingName.value = true;
        },
        child: updateCardController.editingName.isFalse
            ? Text(
                updateCardController.cardUpdate.value.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 81.sp,
                ),
                maxLines: null,
              )
            : TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 81.sp,
                ),
                maxLines: null,
                autofocus: true,
                controller: updateCardController.cardNameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                cursorColor: Colors.green,
                cursorHeight: 25,
                onChanged: (value) {
                  if (value.trim().isEmpty) {
                    updateCardController.cardNameIsEmpty.value = true;
                  } else {
                    updateCardController.cardNameIsEmpty.value = false;
                  }
                },
              ),
      ),
    );
  }

  _buildEditDescriptionArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(Icons.vertical_distribute_sharp),
          SizedBox(
            width: 80.w,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                updateCardController.editingDescription.value = true;
              },
              child: updateCardController.editingDescription.isFalse
                  ? Text(
                      updateCardController.cardUpdate.value.description == ""
                          ? "add_card_description".tr
                          : updateCardController.cardUpdate.value.description,
                      style: TextStyle(color: Colors.black, fontSize: 72.sp),
                    )
                  : TextFormField(
                      minLines: 3,
                      style: TextStyle(color: Colors.black, fontSize: 72.sp),
                      maxLines: null,
                      autofocus: true,
                      controller:
                          updateCardController.cardDescriptionController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      cursorColor: Colors.green,
                      cursorHeight: 25,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
