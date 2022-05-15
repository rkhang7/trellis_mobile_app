import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trellis_mobile_app/models/statistics/statistics_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';

class StatisticsController extends GetxController {
  final dateRangeController = TextEditingController();
  final startDate = DateTime.now().subtract(const Duration(days: 7)).obs;
  final endDate = DateTime.now().obs;
  final cardRepository = Get.find<CardRepository>();
  final dashBoardController = Get.find<DashBoardController>();
  var statistics =
      StatisticsResponse(total: 0, completed: 0, in_completed: 0).obs;

  var dataMap = {
    "complete".tr: 5.1,
    "incomplete".tr: 3.2,
  }.obs;
  @override
  void onInit() {
    getStatisticsFromDateToDate(startDate.value, endDate.value);
    updateTextController(
        DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
    super.onInit();
  }

  void updateTextController(DateTime startDate, DateTime endDate) {
    dateRangeController.text =
        "${DateFormat("dd-MM-yyyy").format(startDate)} ${'to'.tr} ${DateFormat("dd-MM-yyyy").format(endDate)} ";
  }

  void getStatisticsFromDateToDate(DateTime startDate, DateTime endDate) {
    EasyLoading.show(status: "please_wait".tr);
    cardRepository
        .getStatistics(
      dashBoardController.currentId,
      startDate.toUtc().millisecondsSinceEpoch,
      endDate.toUtc().millisecondsSinceEpoch,
    )
        .then(
      (value) {
        statistics.value = value;
        dataMap["complete".tr] = value.completed.toDouble();
        dataMap["incomplete".tr] = value.in_completed.toDouble();
        dataMap.refresh();
        EasyLoading.dismiss();
      },
    ).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }
}
