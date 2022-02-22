import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildItemAuth(
    {required String label,
    required String iconPath,
    required Function() onClick}) {
  return InkWell(
    onTap: onClick,
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(iconPath, height: 35, width: 40),
          SizedBox(
            width: 30.w,
          ),
          Text(
            label.toUpperCase(),
            style: TextStyle(
                fontSize: 64.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
