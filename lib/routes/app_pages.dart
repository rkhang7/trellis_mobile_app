import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/dashboard/binding/dashboard_binding.dart';
import 'package:trellis_mobile_app/modules/dashboard/view/dashboard_page.dart';
import 'package:trellis_mobile_app/modules/notification/binding/notification_binding.dart';
import 'package:trellis_mobile_app/modules/notification/view/notification_page.dart';
import 'package:trellis_mobile_app/modules/walk_through/binding/walk_through_binding.dart';
import 'package:trellis_mobile_app/modules/walk_through/view/walk_through_page.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';

class AppPages {
  static var getPages = [
    GetPage(
      name: AppRoutes.WALK_THROUGH,
      page: () => WalkThroughPage(),
      binding: WalkThroughBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
  ];
}
