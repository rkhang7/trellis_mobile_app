import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
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
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
            currentAccountPicture: currentUser!.photoURL == null
                ? Image.asset("assets/icons/default_user.png")
                : Image.network(currentUser!.photoURL.toString())
                    .cornerRadiusWithClipRRect(50),
            accountName: currentUser!.displayName.toString() == null
                ? Text("null",
                    style: boldTextStyle(color: Colors.white, size: 16))
                : Text(currentUser!.displayName.toString(),
                    style: boldTextStyle(color: Colors.white, size: 16)),
            accountEmail: Text(currentUser!.email.toString(),
                style: primaryTextStyle(color: Colors.white, size: 14)),
          ),
          Container(
            child: ListView(
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
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return DrawerList(
                            leading: const Icon(Icons.group_outlined),
                            title: "Nhóm $index",
                          );
                        },
                        itemCount: 3,
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
                  onTap: () {},
                ),
                DrawerList(
                  leading: const Icon(Icons.settings_outlined),
                  title: "setting".tr,
                  onTap: () {},
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
            ),
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
