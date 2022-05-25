import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/modules/card/my_card/my_card_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import '../../../routes/app_routes.dart';

class MyCardPage extends StatelessWidget {
  MyCardPage({Key? key}) : super(key: key);
  final myCardController = Get.find<MyCardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildTaskBar(context),
            _buildDateBar(),
            Obx(
              () => _buildListBoard(),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: backgroundColor,
      title: Text(
        'my_cards'.tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
    );
  }

  _buildDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: backgroundColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
        onDateChange: (date) {
          myCardController.dateSelected.value = date;
          myCardController.getBoardsByDate(date.toUtc().millisecondsSinceEpoch);
        },
        locale: Get.locale.toString() == "vi_VN" ? "vi-VN" : "en-US",
      ),
    );
  }

  _buildTaskBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    locale: Get.locale.toString() == "vi_VN"
                        ? const Locale("vi", "VN")
                        : const Locale("en", "US"),
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2040),
                  ).then(
                    (value) {
                      if (value != null) {
                        myCardController.dateSelected.value = value;
                        myCardController.getBoardsByDate(
                            value.toUtc().millisecondsSinceEpoch);
                      }
                    },
                  );
                },
                child: Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
              ),
              Text(
                "today".tr,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildListBoard() {
    return myCardController.listBoard.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: myCardController.listBoard.length,
              itemBuilder: (context, index) {
                final board = myCardController.listBoard[index];
                return Container(
                  color: Colors.grey.shade100,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              color: HexColor(board.backgroundColor),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Text(
                              board.name,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 64.sp),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: board.boardListResps.length,
                        itemBuilder: (context, index) {
                          final list = board.boardListResps[index];
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: list.cards.length,
                                itemBuilder: (context, index) {
                                  final card = list.cards[index];
                                  return _buildCard(card);
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "in_list".tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " ${list.name}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
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

  Widget _buildCard(CardResponse cardModel) {
    return Container(
      margin: const EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
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
          myCardController.selectedCard.value = cardModel;
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
                Text(myCardController.getDateShowUI(cardModel)),
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
                      color:
                          myCardController.getLengthTaskIsComplete(cardModel) ==
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
                          color: myCardController
                                      .getLengthTaskIsComplete(cardModel) ==
                                  cardModel.tasks.length
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                        Text(
                            "${myCardController.getLengthTaskIsComplete(cardModel)}/${cardModel.tasks.length}",
                            style: TextStyle(
                              color: myCardController
                                          .getLengthTaskIsComplete(cardModel) ==
                                      cardModel.tasks.length
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 48.sp,
                            )),
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
                          imageUrl: userResponse.avatarURL.isEmpty
                              ? "https://ui-avatars.com/api/?name=${userResponse.firstName}+${userResponse.lastName}&&size=120&&rounded=true&&background=${userResponse.avatarBackgroundColor}&&color=ffffff&&bold=true"
                              : userResponse.avatarURL,
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
          ],
        ),
      ),
    );
  }
}
