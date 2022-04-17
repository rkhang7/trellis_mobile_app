import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/notification/notification_controller.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/custom_tabview.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);
  final notificationController = Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: const CloseButton(
          color: iconColorPrimary,
        ),
        title: Text(
          'notifications'.tr,
          style: boldTextStyle(size: 18, color: Colors.white),
        ),
        actions: [
          const IconButton(
            icon: Icon(Icons.check_box_outlined, color: iconColorPrimary),
            onPressed: null,
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: iconColorPrimary),
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(
                PopupMenuItem(
                    child: Text("notifications_setting".tr), value: 1),
              );
              return list;
            },
          )
        ],
      ),
      body: CustomTabView(
        initPosition: 0,
        itemCount: 3,
        tabBuilder: (context, index) {
          return Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                notificationController.listTitle[index],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 45.sp),
              ));
        },
        pageBuilder: (context, index) {
          return notificationController.list[index];
        },
      ),
    ));
  }
}
