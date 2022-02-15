import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class DrawerList extends StatelessWidget {
  Widget? leading;
  String? title;
  Function? onTap;

  DrawerList({this.leading, this.title = 'Enter Title', this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          leading!,
          20.width,
          Text(
            title!,
            style: primaryTextStyle(),
          ),
        ],
      ),
    ).onTap(onTap);
  }
}
