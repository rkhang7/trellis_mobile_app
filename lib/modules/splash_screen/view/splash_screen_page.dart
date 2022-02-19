import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.back();
    Get.offNamed(AppRoutes.WALK_THROUGH);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildAnimations(),
      ),
    );
  }

  Widget _buildAnimations() {
    return Lottie.asset(
      'assets/animation/todo.json',
      height: 300,
      width: 300,
    );
  }
}
