import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/drawer_component.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerComponent(),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(
            'Bảng',
            style: boldTextStyle(color: Colors.white, size: 18),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.search, color: iconColorPrimary),
                onPressed: () {
                  toast('Tìm kiếm');
                }),
            IconButton(
              icon:
                  const Icon(Icons.notifications_none, color: iconColorPrimary),
              onPressed: () {
                Get.toNamed(AppRoutes.NOTIFICATION);
              },
            ),
          ],
        ),
        body: Container(),
        floatingActionButton: SpeedDial(
          backgroundColor: buttonColor,
          foregroundColor: iconColorPrimary,
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 15,
          spaceBetweenChildren: 12,
          children: [
            SpeedDialChild(
                label: "Bảng",
                child: const Icon(
                  FontAwesomeIcons.table,
                  color: iconColorPrimary,
                ),
                backgroundColor: buttonColor,
                onTap: () {
                  Get.toNamed(AppRoutes.CREATE_TABLE);
                }),
            SpeedDialChild(
                label: "Thẻ",
                child: const Icon(
                  Icons.laptop,
                  color: iconColorPrimary,
                ),
                backgroundColor: buttonColor,
                onTap: () {
                  toast("Thêm thẻ");
                })
          ],
        ),
      ),
    );
  }
}
