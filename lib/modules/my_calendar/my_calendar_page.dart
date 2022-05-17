import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendarPage extends StatelessWidget {
  const MyCalendarPage({Key? key}) : super(key: key);

  get backgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(
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

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(days: 3));

    final DateTime startTime1 =
        DateTime(today.year, today.month, today.day, 9, 0, 0)
            .add(Duration(days: 3));
    final DateTime endTime1 = startTime.add(const Duration(days: 7));
    meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644)),
    );
    meetings.add(
      Meeting('sad', startTime, endTime, const Color(0xFF0F8644)),
    );
    meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644)),
    );
    meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644)),
    );
    meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644)),
    );
    meetings.add(
      Meeting('Conference', startTime1, endTime1, const Color(0xFF0F8644)),
    );
    return meetings;
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

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }
    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  Meeting(this.eventName, this.from, this.to, this.background);
}
