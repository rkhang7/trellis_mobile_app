import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trellis_mobile_app/models/statistics/statistics_response.dart';
import 'package:trellis_mobile_app/modules/statistics/statistics_controller.dart';
import 'package:trellis_mobile_app/utils/widget/choose_range_date.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({Key? key}) : super(key: key);
  final statisticsController = Get.find<StatisticsController>();
  get backgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => ChooseRangeDate(
                      flex: 3,
                      hint: "",
                      startDate: statisticsController.startDate.value,
                      endDate: statisticsController.endDate.value,
                      controller: statisticsController.dateRangeController,
                      onSave: (DateTimeRange dateTimeRange) {
                        statisticsController.updateTextController(
                            dateTimeRange.start, dateTimeRange.end);
                        statisticsController.startDate.value =
                            dateTimeRange.start;
                        statisticsController.endDate.value = dateTimeRange.end;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text("statistics".tr),
                      onPressed: () {
                        statisticsController.getStatisticsFromDateToDate(
                          statisticsController.startDate.value,
                          statisticsController.endDate.value,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100.h,
              ),
              Obx(
                () => _buildStatistics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        'statistics'.tr,
        style: TextStyle(color: Colors.white, fontSize: 72.sp),
      ),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget _buildStatistics() {
    return statisticsController.statistics.value.total != 0
        ? PieChart(
            dataMap: statisticsController.dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: Get.width / 3.2,

            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            colorList: [
              Colors.green,
              Colors.blue,
            ],
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 0,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )
        : Expanded(
            child: Center(
              child: Text(
                "no_have_tasks".tr,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 96.sp),
              ),
            ),
          );
  }
}
