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

InputDecoration textFieldInputDecoration(
    {String? labelText,
    Color color = Colors.white,
    EdgeInsetsGeometry? padding}) {
  return InputDecoration(
    contentPadding: padding,
    labelText: labelText,
    labelStyle: primaryTextStyle(color: color),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: color),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: color),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: color),
    ),
  );
}
