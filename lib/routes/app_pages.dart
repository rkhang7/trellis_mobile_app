import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/board_background/board_background_binding.dart';
import 'package:trellis_mobile_app/modules/board/board_background/board_background_page.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/board_menu_binding.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/board_menu_page.dart';
import 'package:trellis_mobile_app/modules/board/invite_board_member/invite_board_member_binding.dart';
import 'package:trellis_mobile_app/modules/board/invite_board_member/invite_board_member_page.dart';
import 'package:trellis_mobile_app/modules/board/remove_board_member/remove_board_member_page.dart';
import 'package:trellis_mobile_app/modules/board/update_board/update_board_binding.dart';
import 'package:trellis_mobile_app/modules/board/update_board/update_board_page.dart';
import 'package:trellis_mobile_app/modules/card/my_card/my_card_binding.dart';
import 'package:trellis_mobile_app/modules/card/my_card/my_card_page.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_binding.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_page.dart';

import 'package:trellis_mobile_app/modules/dashboard/dashboard_binding.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_page.dart';
import 'package:trellis_mobile_app/modules/my_calendar/my_calendar_binding.dart';
import 'package:trellis_mobile_app/modules/my_calendar/my_calendar_page.dart';

import 'package:trellis_mobile_app/modules/notification/notification_binding.dart';
import 'package:trellis_mobile_app/modules/notification/notification_page.dart';

import 'package:trellis_mobile_app/modules/setting/setting_binding.dart';
import 'package:trellis_mobile_app/modules/setting/settings_page.dart';
import 'package:trellis_mobile_app/modules/sign_in/sign_in_binding.dart';
import 'package:trellis_mobile_app/modules/sign_in/sign_in_page.dart';
import 'package:trellis_mobile_app/modules/sign_up/sign_up_binding.dart';
import 'package:trellis_mobile_app/modules/sign_up/sign_up_page.dart';
import 'package:trellis_mobile_app/modules/splash_screen/splash_screen_binding.dart';
import 'package:trellis_mobile_app/modules/splash_screen/splash_screen_page.dart';
import 'package:trellis_mobile_app/modules/statistics/statistics_binding.dart';
import 'package:trellis_mobile_app/modules/statistics/statistics_page.dart';
import 'package:trellis_mobile_app/modules/walk_through/walk_through_binding.dart';
import 'package:trellis_mobile_app/modules/walk_through/view/walk_through_page.dart';

import 'package:trellis_mobile_app/routes/app_routes.dart';

import '../modules/board/create_board/create_board_binding.dart';
import '../modules/board/create_board/create_board_page.dart';
import '../modules/board/remove_board_member/remove_board_member_binding.dart';
import '../modules/board/search_board/search_board_binding.dart';
import '../modules/board/search_board/search_board_page.dart';

import '../modules/card/create_card/create_card_binding.dart';
import '../modules/card/create_card/view/create_card_page.dart';
import '../modules/detail_board/detail_board_binding.dart';
import '../modules/detail_board/detail_board_page.dart';

import '../modules/splash_screen/splash_screen_binding.dart';
import '../modules/workspace/create_workspace/create_workspace_binding.dart';
import '../modules/workspace/create_workspace/create_workspace_page.dart';
import '../modules/workspace/invite_member/invite_member_binding.dart';
import '../modules/workspace/invite_member/invite_member_page.dart';
import '../modules/workspace/remove_member/remove_member_binding.dart';
import '../modules/workspace/remove_member/remove_member_page.dart';
import '../modules/workspace/update_workspace/update_workspace_binding.dart';
import '../modules/workspace/update_workspace/update_workspace_page.dart';
import '../modules/workspace/workspace_menu/workspace_menu_binding.dart';
import '../modules/workspace/workspace_menu/workspace_menu_page.dart';

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
    GetPage(
      name: AppRoutes.INVITE_BOARD_MEMBER,
      page: () => InviteBoardMemberPage(),
      binding: InviteBoardMemberBinding(),
    ),
    GetPage(
      name: AppRoutes.REMOVE_BOARD_MEMBER,
      page: () => RemoveBoardMemberPage(),
      binding: RemoveBoardMemberBinding(),
    ),
    GetPage(
      name: AppRoutes.UPDATE_BOARD,
      page: () => UpdateBoardPage(),
      binding: UpdateBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.UPDATE_BOARD,
      page: () => UpdateBoardPage(),
      binding: UpdateBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.UPDATE_CARD,
      page: () => UpdateCardPage(),
      binding: UpdateCardBiding(),
    ),
    GetPage(
      name: AppRoutes.BOARD_BACKGROUND,
      page: () => BoardBackgroundPage(),
      binding: BoardBackgroundBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_CARD,
      page: () => MyCardPage(),
      binding: MyCardBinding(),
    ),
    GetPage(
      name: AppRoutes.STATISTICS,
      page: () => StatisticsPage(),
      binding: StatisticsBinding(),
    ),
    GetPage(
      name: AppRoutes.MY_CALENDAR,
      page: () => MyCalendarPage(),
      binding: MyCalendarBinding(),
    ),
  ];
}
