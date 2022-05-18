import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/modules/my_calendar/my_calendar_controller.dart';

import '../../utils/colors.dart';

class MyCalendarPage extends StatefulWidget {
  MyCalendarPage({Key? key}) : super(key: key);

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  final myCalendarController = Get.find<MyCalendarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
          child: Obx(
        () => SfCalendar(
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
            print(t.appointments!.length.toString());
            openDialog(context, t.appointments as List<CardResponse>).show();
          },
        ),
      )),
    );
  }

  AwesomeDialog openDialog(BuildContext context, List<CardResponse> list) {
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
            itemCount: list.length,
            itemBuilder: (_, index) {
              final card = myCalendarController.listCard[index];
              return _buildCard(card, index);
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

  Widget _buildCard(CardResponse cardModel, int index) {
    return Container(
      key: ValueKey(cardModel),
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 0),
              color: Color.fromRGBO(127, 140, 141, 0.5),
              spreadRadius: 2)
        ],
      ),
      child: InkWell(
        onTap: () {
          // Get.toNamed(AppRoutes.UPDATE_CARD);
          // detailBoardController.selectedCard.value = cardModel;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardModel.name,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 60.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                const Icon(Icons.access_time),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                    child: Text(myCalendarController.getDateShowUI(cardModel))),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            cardModel.tasks.isNotEmpty
                ? Container(
                    width: 45,
                    height: 20,
                    decoration: BoxDecoration(
                      color: myCalendarController
                                  .getLengthTaskIsComplete(cardModel) ==
                              cardModel.tasks.length
                          ? Colors.green
                          : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          color: myCalendarController
                                      .getLengthTaskIsComplete(cardModel) ==
                                  cardModel.tasks.length
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                        Text(
                          "${myCalendarController.getLengthTaskIsComplete(cardModel)}/${cardModel.tasks.length}",
                          style: TextStyle(
                            color: myCalendarController
                                        .getLengthTaskIsComplete(cardModel) ==
                                    cardModel.tasks.length
                                ? Colors.white
                                : Colors.black,
                            fontSize: 48.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  runSpacing: 20.h,
                  spacing: 20.h,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: cardModel.members.map((userResponse) {
                    return Container(
                      width: 40,
                      height: 40,
                      color: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userResponse.avatar_url.isEmpty
                              ? "https://ui-avatars.com/api/?name=${userResponse.first_name}+${userResponse.last_name}&&size=120&&rounded=true&&background=${userResponse.avatar_background_color}&&color=ffffff&&bold=true"
                              : userResponse.avatar_url,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    );
                    // return Container(
                    //   width: 50,
                    //   height: 50,
                    //   color: Colors.red,
                    // );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            cardModel.is_complete
                ? Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.green,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "complete".tr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "incomplete".tr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
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

