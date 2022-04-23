import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class AttachItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onClick;
  const AttachItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          20.width,
          Text(
            title,
            style: primaryTextStyle(color: Colors.black, size: 18),
          ),
        ],
      ),
    );
  }
}
