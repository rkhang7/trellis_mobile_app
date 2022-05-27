import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/drawer_component.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/constants.dart';

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
                Obx(
                  () => _buildListBoards(),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: _buildFab(),
      ),
    );
  }

  Widget _buildListBoards() {
    dashBoardController.listBoards;
    // return ListView.builder(
    //   physics: const NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   itemCount: dashBoardController.listBoards.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     final boardResponse = dashBoardController.listBoards[index];
    //     return ListTile(
    //       onTap: () async {
    //         dashBoardController.boardIdSelected = boardResponse.board_id;
    //         await Get.toNamed(
    //           AppRoutes.DETAIL_BOARD,
    //           parameters: {
    //             'name': boardResponse.name,
    //           },
    //         );
    //       },
    //       leading: Image.network(
    //         "https://znews-stc.zdn.vn/static/topic/person/cristiano-ronaldo.jpg",
    //         height: 40,
    //         width: 40,
    //         fit: BoxFit.cover,
    //       ).cornerRadiusWithClipRRect(2),
    //       title: Text(
    //         boardResponse.name,
    //         style: boldTextStyle(),
    //       ),
    //     );
    //   },
    // );
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: dashBoardController.refresh,
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        shrinkWrap: true,
        itemCount: dashBoardController.listBoards.length,
        itemBuilder: (context, index) {
          final boardResponse = dashBoardController.listBoards[index];
          return InkWell(
            onTap: () async {
              dashBoardController.boardIdSelected = boardResponse.boardId;
              await Get.toNamed(
                AppRoutes.DETAIL_BOARD,
                parameters: {
                  'name': boardResponse.name,
                },
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor(boardResponse.backgroundColor),
                  ),
                ),
                Positioned(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: HexColor(boardResponse.backgroundDarkColor),
                      ),
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          boardResponse.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 56.sp,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      alignment: Alignment.centerLeft),
                  bottom: 0,
                  left: 0,
                  right: 0,
                )
              ],
            ),
          );
        },
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
        // IconButton(
        //   icon: const Icon(Icons.notifications_none, color: iconColorPrimary),
        //   onPressed: () {
        //     Get.toNamed(AppRoutes.NOTIFICATION);
        //   },
        // ),
        IconButton(
          onPressed: () {
            if (dashBoardController.listWorkspace.isEmpty) {
              EasyLoading.showInfo("do_not_have_workspace".tr);
            } else {
              Get.toNamed(AppRoutes.WORKSPACE_MENU);
            }
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
              Get.toNamed(AppRoutes.CREATE_BOARD);
            }),
        // SpeedDialChild(
        //   label: "card".tr,
        //   child: const Icon(
        //     Icons.laptop,
        //     color: iconColorPrimary,
        //   ),
        //   backgroundColor: buttonColor,
        //   onTap: () {
        //     Get.toNamed(AppRoutes.CREATE_CARD);
        //   },
        // ),
      ],
    );
  }
}
