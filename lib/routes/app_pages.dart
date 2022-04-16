import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/binding/board_menu_binding.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/view/board_menu_page.dart';

import 'package:trellis_mobile_app/modules/create_card/binding/create_card_binding.dart';
import 'package:trellis_mobile_app/modules/create_card/view/create_card_page.dart';

import 'package:trellis_mobile_app/modules/dashboard/binding/dashboard_binding.dart';
import 'package:trellis_mobile_app/modules/dashboard/view/dashboard_page.dart';

import 'package:trellis_mobile_app/modules/notification/binding/notification_binding.dart';
import 'package:trellis_mobile_app/modules/notification/view/notification_page.dart';

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

import '../modules/board/create_board/binding/create_board_binding.dart';
import '../modules/board/create_board/view/create_board_page.dart';
import '../modules/board/search_board/binding/search_board_binding.dart';
import '../modules/board/search_board/view/search_board_page.dart';

import '../modules/detail_board/binding/detail_board_binding.dart';
import '../modules/detail_board/view/detail_board_page.dart';

import '../modules/workspace/create_workspace/binding/create_workspace_binding.dart';
import '../modules/workspace/create_workspace/view/create_workspace_page.dart';
import '../modules/workspace/invite_member/binding/invite_member_binding.dart';
import '../modules/workspace/invite_member/view/invite_member_page.dart';
import '../modules/workspace/remove_member/binding/remove_member_binding.dart';
import '../modules/workspace/remove_member/view/remove_member_page.dart';
import '../modules/workspace/update_workspace/binding/update_workspace_binding.dart';
import '../modules/workspace/update_workspace/view/update_workspace_page.dart';
import '../modules/workspace/workspace_menu/binding/workspace_menu_binding.dart';
import '../modules/workspace/workspace_menu/view/workspace_menu_page.dart';

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
      name: AppRoutes.CREATE_BOARD,
      page: () => CreateBoardPage(),
      binding: CreateBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL_BOARD,
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
      name: AppRoutes.WORKSPACE_MENU,
      page: () => WorkspaceMenuPage(),
      binding: WorkspaceMenuBinding(),
    ),
    GetPage(
      name: AppRoutes.INVITE_MEMBER,
      page: () => InviteMemberPage(),
      binding: InviteMemberBinding(),
    ),
    GetPage(
      name: AppRoutes.UPDATE_WORKSPACE,
      page: () => UpdateWorkspacePage(),
      binding: UpdateWorkSpaceBinding(),
    ),
    GetPage(
      name: AppRoutes.REMOVE_MEMBER,
      page: () => RemoveMemberPage(),
      binding: RemoveMemberBinding(),
    ),
    GetPage(
      name: AppRoutes.BOARD_MENU,
      page: () => BoardMenuPage(),
      binding: BoardMenuBinding(),
    ),
  ];
}
