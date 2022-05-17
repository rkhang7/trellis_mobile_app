import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/modules/my_calendar/my_calendar_controller.dart';

import '../../utils/colors.dart';

class MyCalendarPage extends StatelessWidget {
  MyCalendarPage({Key? key}) : super(key: key);
  final myCalendarController = Get.find<MyCalendarController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: CardResponseDataSource(
            _getDataSource(),
          ),
          // by default the month appointment display mode set as Indicator, we can
          // change the display mode as appointment using the appointment display
          // mode property
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
          allowAppointmentResize: true,
          allowDragAndDrop: true,
          onTap: (CalendarTapDetails t) {
            // Get.dialog(
            //   Container(
            //     color: Colors.red,
            //     width: 200,
            //     height: 200,
            //   ),
            // );
          },
          onLongPress: (CalendarLongPressDetails t) {
            openDialog(context).show();
          },
        ),
      ),
    );
  }

  AwesomeDialog openDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (_, index) {
              // final userResponse =
              //     updateCardController.listMemberInBoard[index];
              return Container(
                width: 200,
                height: 200,
                color: Colors.red,
              );
            },
          )
        ],
      ),
      btnOkOnPress: () {},
    );
  }

  List<CardResponse> _getDataSource() {
    final List<CardResponse> listCard = myCalendarController.listCard.value;

    return listCard;
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        'my_calendar'.tr,
        style: TextStyle(color: Colors.white, fontSize: 72.sp),
      ),
    );
  }
}

class CardResponseDataSource extends CalendarDataSource {
  CardResponseDataSource(List<CardResponse> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(
        _getCardReponseData(index).start_date);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(
        _getCardReponseData(index).due_date);
  }

  @override
  String getSubject(int index) {
    return _getCardReponseData(index).name;
  }

  @override
  Color getColor(int index) {
    return _getCardReponseData(index).is_complete ? Colors.green : Colors.blue;
  }

  CardResponse _getCardReponseData(int index) {
    final dynamic cardResponse = appointments![index];
    late final CardResponse cardResponseData;
    if (cardResponse is CardResponse) {
      cardResponseData = cardResponse;
    }
    return cardResponseData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.

