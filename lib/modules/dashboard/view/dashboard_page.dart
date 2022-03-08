import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/drawer_component.dart';
import 'package:trellis_mobile_app/modules/detail_table/view/detail_board_page.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerComponent(),
        appBar: _buildAppBar(),
        body: ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration:
                      boxDecorationWithShadow(blurRadius: 5, spreadRadius: 2),
                  child: Text(
                    'Nhóm 1',
                    style: boldTextStyle(),
                  ).paddingAll(10),
                ),
                10.height,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () async {
                        await Get.toNamed(
                          AppRoutes.DETAIL_TABLE,
                          arguments: "Example $index",
                        );
                      },
                      leading: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT5guHEUeNVd1Uc_6NdURM_7h5P6UcDE1U_Lw&usqp=CAU",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ).cornerRadiusWithClipRRect(2),
                      title: Text(
                        "Example $index",
                        style: boldTextStyle(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: _buildFab(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        'boards'.tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
      actions: [
        IconButton(
            icon: const Icon(Icons.search, color: iconColorPrimary),
            onPressed: () {
              Get.toNamed(AppRoutes.SEARCH_BOARD);
            }),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: iconColorPrimary),
          onPressed: () {
            Get.toNamed(AppRoutes.NOTIFICATION);
          },
        ),
      ],
    );
  }

  SpeedDial _buildFab() {
    return SpeedDial(
      backgroundColor: buttonColor,
      foregroundColor: iconColorPrimary,
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 15,
      spaceBetweenChildren: 12,
      children: [
        SpeedDialChild(
          label: "workspace".tr,
          child: const Icon(
            Icons.workspaces,
            color: iconColorPrimary,
          ),
          backgroundColor: buttonColor,
          onTap: () {
            Get.toNamed(AppRoutes.CREATE_WORKSPACE);
          },
        ),
        SpeedDialChild(
            label: "board".tr,
            child: const Icon(
              FontAwesomeIcons.table,
              color: iconColorPrimary,
            ),
            backgroundColor: buttonColor,
            onTap: () {
              Get.toNamed(AppRoutes.CREATE_TABLE);
            }),
        SpeedDialChild(
          label: "card".tr,
          child: const Icon(
            Icons.laptop,
            color: iconColorPrimary,
          ),
          backgroundColor: buttonColor,
          onTap: () {
            Get.toNamed(AppRoutes.CREATE_CARD);
          },
        ),
      ],
    );
  }
}
