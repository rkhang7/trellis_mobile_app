import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/create_board/binding/create_board_binding.dart';
import 'package:trellis_mobile_app/modules/create_board/view/create_board_page.dart';
import 'package:trellis_mobile_app/modules/create_card/binding/create_card_binding.dart';
import 'package:trellis_mobile_app/modules/create_card/view/create_card_page.dart';
import 'package:trellis_mobile_app/modules/create_workspace/binding/create_workspace_binding.dart';
import 'package:trellis_mobile_app/modules/create_workspace/view/create_workspace_page.dart';
import 'package:trellis_mobile_app/modules/dashboard/binding/dashboard_binding.dart';
import 'package:trellis_mobile_app/modules/dashboard/view/dashboard_page.dart';
import 'package:trellis_mobile_app/modules/detail_table/binding/detail_table_binding.dart';
import 'package:trellis_mobile_app/modules/detail_table/view/detail_board_page.dart';
import 'package:trellis_mobile_app/modules/invite_member/binding/invite_member_binding.dart';
import 'package:trellis_mobile_app/modules/invite_member/view/invite_member_page.dart';
import 'package:trellis_mobile_app/modules/notification/binding/notification_binding.dart';
import 'package:trellis_mobile_app/modules/notification/view/notification_page.dart';
import 'package:trellis_mobile_app/modules/search_board/binding/search_board_binding.dart';
import 'package:trellis_mobile_app/modules/search_board/view/search_board_page.dart';
import 'package:trellis_mobile_app/modules/setting/binding/setting_binding.dart';
import 'package:trellis_mobile_app/modules/setting/view/settings_page.dart';
import 'package:trellis_mobile_app/modules/sign_in/binding/sign_in_binding.dart';
import 'package:trellis_mobile_app/modules/sign_in/view/sign_in_page.dart';
import 'package:trellis_mobile_app/modules/sign_up/binding/sign_up_binding.dart';
import 'package:trellis_mobile_app/modules/sign_up/view/sign_up_page.dart';
import 'package:trellis_mobile_app/modules/splash_screen/binding/splash_screen_binding.dart';
import 'package:trellis_mobile_app/modules/splash_screen/view/splash_screen_page.dart';
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
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATE_TABLE,
      page: () => CreateBoardPage(),
      binding: CreateBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_TABLE,
      page: () => DetailBoardPage(),
      binding: DetailBoardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.SPLASH_SCREEN,
      page: () => const SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATE_CARD,
      page: () => CreateCardPage(),
      binding: CreateCardBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATE_WORKSPACE,
      page: () => CreateWorkspacePage(),
      binding: CreateWorkspaceBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH_BOARD,
      page: () => SearchBoardPage(),
      binding: SearchBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.INVITE_MEMBER,
      page: () => InviteMemberPage(),
      binding: InviteMemberBinding(),
    ),
  ];
}
