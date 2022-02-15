import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/create_table/controller/create_table_controller.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/widgets.dart';

class CreateTablePage extends StatelessWidget {
  CreateTablePage({Key? key}) : super(key: key);
  final createTableController = Get.find<CreateTableController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: const CloseButton(
            color: iconColorPrimary,
          ),
          title: Text('Tạo bảng', style: boldTextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.done, color: iconColorPrimary),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Tên bảng",
                labelStyle: TextStyle(color: Colors.green),
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
            20.height,
            const Text("Không gian làm việc"),
            DropdownButton(
              underline: Container(
                height: 1,
                color: Colors.black,
              ),
              isExpanded: true,
              hint: const Text(
                "Nhóm 1",
                style: TextStyle(color: Colors.black),
              ),
              onChanged: (dynamic value) {},
              items: [
                DropdownMenuItem(
                    child: DrawerList(
                      leading: const Icon(Icons.group_outlined),
                      title: "Nhóm 1",
                    ),
                    value: '1'),
                DropdownMenuItem(
                    child: DrawerList(
                      leading: const Icon(Icons.group_outlined),
                      title: "Nhóm 2",
                    ),
                    value: '1'),
                DropdownMenuItem(
                    child: DrawerList(
                      leading: const Icon(Icons.group_outlined),
                      title: "Nhóm 3",
                    ),
                    value: '1'),
              ],
            ),
            30.height,
            const Text("Quyền xem"),
            DropdownButton(
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
                    child: DrawerList(
                      leading: const Icon(
                        FontAwesomeIcons.lock,
                      ),
                      title: "Riêng tư",
                    ),
                    value: '1'),
                DropdownMenuItem(
                    child: DrawerList(
                      leading: const Icon(
                        Icons.group_outlined,
                      ),
                      title: "Không gian làm việc",
                    ),
                    value: '1'),
                DropdownMenuItem(
                    child: DrawerList(
                      leading: const Icon(
                        Icons.public,
                      ),
                      title: "Công khai",
                    ),
                    value: '1'),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
