import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/card/my_card/my_card_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

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
                        print(value);
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
                "Today",
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
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: myCardController.listBoard.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.red,
          );
        },
      ),
    );
  }
}
