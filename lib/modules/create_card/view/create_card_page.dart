import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/create_card/controller/create_card_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/widget/input_field_create.dart';

class CreateCardPage extends StatelessWidget {
  CreateCardPage({Key? key}) : super(key: key);
  final createCardController = Get.find<CreateCardController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Bảng"),
                      _buildDropdownBoard(),
                      30.height,
                      const Text("Danh sách"),
                      _buildDropdownList(),
                    ],
                  ),
                ),
                Container(
                  height: Get.height / 2.5,
                  width: Get.width,
                  color: backgroundColor,
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    height: Get.height / 2.5,
                    width: Get.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InputFieldCreate(
                            title: "Tên thẻ",
                            controller: createCardController.cardNameController,
                            autoFocus: false,
                            primaryColor: Colors.grey,
                          ),
                          InputFieldCreate(
                              title: "Mô tả",
                              controller:
                                  createCardController.descriptionController,
                              autoFocus: false,
                              primaryColor: Colors.grey),
                          10.height,
                          Row(
                            children: [
                              const Icon(Icons.person_outline),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  primary: Colors.green,
                                ),
                                onPressed: () {},
                                child: const Icon(Icons.add),
                              )
                            ],
                          ),
                          5.height,
                          _buildStartDate(),
                          10.height,
                          _buildEndDate(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: const CloseButton(),
      title: Text(
        "Thêm thẻ",
        style: boldTextStyle(
          color: Colors.white,
          size: 18,
        ),
      ),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
    );
  }

  _buildDropdownBoard() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: const Text(
        "Test",
        style: TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {},
      items: [
        DropdownMenuItem(
            child: ListTile(
              leading: const Icon(
                Icons.group_outlined,
                color: Colors.black,
              ),
              title: const Text("Nhóm 1"),
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
              title: const Text("Nhóm 2"),
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
              title: const Text("Nhóm 3"),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
      ],
    );
  }

  _buildDropdownList() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: const Text(
        "Login",
        style: TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {},
      items: [
        DropdownMenuItem(
            child: ListTile(
              leading: const Icon(
                Icons.group_outlined,
                color: Colors.black,
              ),
              title: const Text("Nhóm 1"),
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
              title: const Text("Nhóm 2"),
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
              title: const Text("Nhóm 3"),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
      ],
    );
  }

  _buildStartDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(FontAwesomeIcons.clock),
        10.width,
        GestureDetector(
          onTap: () {
            Get.defaultDialog(
              contentPadding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              radius: 2,
              title: "Ngày bắt đầu",
              content: Row(
                children: [
                  _buildDropdownDateStartDate(),
                  30.width,
                  _buildDropdownTimeStartDate(),
                ],
              ),
              cancel: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 100, right: 20),
                  child: const Text(
                    "HỦY",
                    style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              confirm: GestureDetector(
                onTap: () {},
                child: const Text(
                  "HOÀN TẤT",
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 3,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Text(
            "Ngày bắt đầu...",
            style: primaryTextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildEndDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(null),
        10.width,
        GestureDetector(
          onTap: () {
            Get.defaultDialog(
              contentPadding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              radius: 2,
              title: "Ngày hết hạn",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildDropdownDateEndDate(),
                      30.width,
                      _buildDropdownTimeEndDate(),
                    ],
                  ),
                  10.height,
                  const Text(
                    "Thiết lập nhắc nhở",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  _buildDropdownRemind(),
                  10.height,
                  Text(
                    "Nhắc nhở chỉ được gửi đến các thành viên và người theo dõi thẻ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  10.height,
                  CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    onChanged: (value) {},
                    title: const Text(
                      "Thêm tôi vào thẻ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              cancel: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 100, right: 20),
                  child: const Text(
                    "HỦY",
                    style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              confirm: GestureDetector(
                onTap: () {},
                child: const Text(
                  "HOÀN TẤT",
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 3,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Text(
            "Ngày hết hạn...",
            style: primaryTextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildDropdownDateStartDate() {
    var now = DateTime.now().add(const Duration(days: 1));
    return SizedBox(
      width: 150,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          "Ngày ${now.day} tháng ${now.month}",
          style: const TextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Hôm nay",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Ngày mai",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Chọn một ngày",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
        ],
      ),
    );
  }

  _buildDropdownTimeStartDate() {
    return SizedBox(
      width: 100,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          "9:00",
          style: primaryTextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Buổi sáng",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Buổi chiều",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Buổi tối",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Đêm",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Chọn thời gian",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              value: '1'),
        ],
      ),
    );
  }

  _buildDropdownDateEndDate() {
    var now = DateTime.now().add(const Duration(days: 2));
    return SizedBox(
      width: 150,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          "Ngày ${now.day} tháng ${now.month}",
          style: TextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Hôm nay",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Ngày mai",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Chọn một ngày",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
        ],
      ),
    );
  }

  _buildDropdownTimeEndDate() {
    return SizedBox(
      width: 100,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          "9:00",
          style: primaryTextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Buổi sáng",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Buổi chiều",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Buổi tối",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Đêm",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "Chọn thời gian",
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              value: '1'),
        ],
      ),
    );
  }

  _buildDropdownRemind() {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: const Text(
        "1 ngày trước",
        style: TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {},
      items: [
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "Vào thời điểm ngày hết hạn",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "5 phút trước",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "10 phút trước",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "15 phút trước",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "1 giờ trước",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "2 giờ trước",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "1 ngày trước",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "2 ngày trước",
                style: primaryTextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.back();
              },
            ),
            value: '1'),
      ],
    );
  }
}