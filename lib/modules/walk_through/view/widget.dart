import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
          const SizedBox(
            width: 20,
          ),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
