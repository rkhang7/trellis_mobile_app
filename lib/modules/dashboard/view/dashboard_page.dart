import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/drawer_component.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class DashBoardPage extends StatelessWidget {
  DashBoardPage({Key? key}) : super(key: key);
  final dashBoardController = Get.find<DashBoardController>();
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
                Obx(
                  (() => Visibility(
                        visible: dashBoardController.isVisibleWorkspace.isTrue,
                        child: Container(
                          decoration: boxDecorationWithShadow(
                              blurRadius: 5, spreadRadius: 2),
                          child: Text(
                            dashBoardController.workspaceSelected.value.name,
                            style: boldTextStyle(),
                          ).paddingAll(10),
                        ),
                      )),
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
                        "https://sohanews.sohacdn.com/thumb_w/660/160588918557773824/2022/2/23/photo1645602282713-16456022828641944752645.jpg",
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
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.INVITE_MEMBER);
          },
          icon: const Icon(Icons.more_horiz, color: iconColorPrimary),
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
