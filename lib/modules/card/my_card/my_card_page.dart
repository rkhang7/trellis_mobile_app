import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class MyCardPage extends StatelessWidget {
  const MyCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildTaskBar(context),
            _buildDateBar(),
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
        onDateChange: (date) {},
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
                onTap: () {
                  _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This is called when the user changes the time.
                      onDateTimeChanged: (DateTime newTime) {},
                    ),
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

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
