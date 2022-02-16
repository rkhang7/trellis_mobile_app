import 'package:flutter/material.dart';

class EndDrawerModel {
  Widget? leading;
  String? title;
  Function? onTap;
  List<Widget>? contents = [];

  EndDrawerModel({this.leading, this.title, this.onTap, this.contents});
}
