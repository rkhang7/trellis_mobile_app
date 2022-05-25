import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';

import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/service/auth_service.dart';
import 'package:trellis_mobile_app/utils/widgets.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  bool isExpandable = true;
  final authService = Get.find<AuthService>();
  var currentUser = FirebaseAuth.instance.currentUser;
  var userRepository = Get.find<UserRepository>();
  var workspaceRepository = Get.find<WorkspaceRepository>();
  var dashboardController = Get.find<DashBoardController>();
  var userResponse = UserResponse(
      uid: "uid",
      email: "email",
      firstName: "first_name",
      lastName: "last_name",
      avatarBackgroundColor: "ffffff",
      createdTime: 1,
      updatedTime: 1,
      avatarURL: "");

  var workspaces = <WorkSpaceResponse>[];

  init() async {
    await userRepository.getUserById(currentUser!.uid).then(
      (value) {
        setState(
          () {
            userResponse = value;
          },
        );
      },
    );

    await workspaceRepository
        .getWorkspacesByUid(currentUser!.uid)
        .then((value) {
      setState(() {
        workspaces.assignAll(value);
      });
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            arrowColor: Colors.white,
            onDetailsPressed: () {
              isExpandable = !isExpandable;
              setState(() {});
            },
            currentAccountPicture:
                currentUser!.providerData[0].providerId == "password"
                    ? CachedNetworkImage(
                        imageUrl:
                            "https://ui-avatars.com/api/?name=${userResponse.firstName}+${userResponse.lastName}&&size=120&&rounded=true&&background=${userResponse.avatarBackgroundColor}&&color=ffffff&&bold=true",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                      )
                    : Image.network(currentUser!.photoURL.toString())
                        .cornerRadiusWithClipRRect(50),
            accountName: currentUser!.providerData[0].providerId == "password"
                ? Text("${userResponse.firstName} ${userResponse.lastName}",
                    style: boldTextStyle(color: Colors.white, size: 16))
                : Text(currentUser!.displayName.toString(),
                    style: boldTextStyle(color: Colors.white, size: 16)),
            accountEmail: Text(currentUser!.email.toString(),
                style: primaryTextStyle(color: Colors.white, size: 14)),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              DrawerList(
                leading: const Icon(FontAwesomeIcons.table),
                title: "boards".tr,
                onTap: () {
                  Get.back();
                },
              ),
              DrawerList(
                leading: const Icon(Icons.home),
                title: "home".tr,
                onTap: () {},
              ),
              const Divider(
                height: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "workspaces".tr,
                      style: boldTextStyle(color: Colors.black87),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 600.h,
                        minHeight: 200.h,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              dashboardController.workspaceSelected.value =
                                  workspaces[index];
                              dashboardController.loadListBoards(
                                  workspaces[index].workspaceId);
                              Get.back();
                            },
                            child: DrawerList(
                              leading: const Icon(Icons.group_outlined),
                              title: workspaces[index].name,
                            ),
                          );
                        },
                        itemCount: workspaces.length,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 2,
                color: Colors.grey,
              ),
              DrawerList(
                leading: const Icon(Icons.laptop),
                title: "my_cards".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.MY_CARD);
                },
              ),
              // DrawerList(
              //   leading: const Icon(Icons.calendar_today),
              //   title: "my_calendar".tr,
              //   onTap: () {
              //     Get.toNamed(AppRoutes.MY_CALENDAR);
              //   },
              // ),
              DrawerList(
                leading: const Icon(Bootstrap.activity),
                title: "statistics".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.STATISTICS);
                },
              ),
              DrawerList(
                leading: const Icon(Icons.settings_outlined),
                title: "setting".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.SETTINGS);
                },
              ),
              DrawerList(
                leading: const Icon(Icons.info_outline),
                title: "help".tr,
                onTap: () {},
              ),
              DrawerList(
                leading: const Icon(Icons.logout_outlined),
                title: "log_out".tr,
                onTap: () async {
                  _openConfirmDialog();
                },
              ),
            ],
          ).visible(isExpandable),
          DrawerList(
            leading: const Icon(Icons.add),
            title: "add_account".tr,
            onTap: () {
              toast('Coming Soon');
            },
          ).visible(!isExpandable),
        ],
      ),
    );
  }

  void _openConfirmDialog() {
    Get.defaultDialog(
      title: "are_you_sure_logout".tr,
      titlePadding: const EdgeInsets.only(left: 32, right: 32, top: 32),
      titleStyle: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 18,
      ),
      radius: 5,
      content: Container(),
      confirm: GestureDetector(
        onTap: () async {
          authService.logout();
        },
        child: Container(
          margin: const EdgeInsets.only(left: 32, bottom: 12),
          child: Text(
            "yes".tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      cancel: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: const EdgeInsets.only(left: 64),
          child: Text(
            "no".tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
