import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//ignore: must_be_immutable
class ChooseRangeDate extends StatelessWidget {
  int flex;
  TextEditingController controller;
  String hint;
  DateTime startDate;
  DateTime endDate;
  ValueSetter<DateTimeRange> onSave;
  ChooseRangeDate({
    Key? key,
    required this.flex,
    required this.hint,
    required this.startDate,
    required this.endDate,
    required this.controller,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        child: TextField(
          onTap: () {
            pickDateRange();
          },
          readOnly: true,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
              hintText: hint,
              labelText: hint,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey))),
          controller: controller,
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: Get.context!,
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (newDateRange == null) return;
    onSave(newDateRange);
  }
}
