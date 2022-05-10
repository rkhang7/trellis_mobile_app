import 'package:get/get.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';
import 'package:trellis_mobile_app/repository/label_reposittory.dart';
import 'package:trellis_mobile_app/repository/list_repository.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/task_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => WorkspaceRepository(), fenix: true);
    Get.lazyPut(() => MemberRepository(), fenix: true);
    Get.lazyPut(() => BoardRepository(), fenix: true);
    Get.lazyPut(() => ListRepository(), fenix: true);
    Get.lazyPut(() => CardRepository(), fenix: true);
    Get.lazyPut(() => TaskRepository(), fenix: true);
    Get.lazyPut(() => LabelRepository(), fenix: true);
  }
}
