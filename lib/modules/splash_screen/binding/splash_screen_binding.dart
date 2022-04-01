import 'package:get/get.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => WorkspaceRepository(), fenix: true);
    Get.lazyPut(() => MemberRepository(), fenix: true);
    Get.lazyPut(() => BoardRepository(), fenix: true);
  }
}
