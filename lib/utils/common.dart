import 'package:flutter/cupertino.dart';
import 'package:trellis_mobile_app/models/my_color.dart';
import 'package:trellis_mobile_app/utils/constants.dart';

class Common {
  static List<MyColor> getListBackgroundBoard() {
    return <MyColor>[
      MyColor(color: myBlueColor, darkColor: myDarkBlueColor, isSelect: false),
      MyColor(
          color: myAmberColor, darkColor: myDarkAmberColor, isSelect: false),
      MyColor(
          color: myGreenColor, darkColor: myDarkGreenColor, isSelect: false),
      MyColor(color: myRedColor, darkColor: myDarkRedColor, isSelect: false),
      MyColor(
          color: myPurpleColor, darkColor: myDarkPurpleColor, isSelect: false),
      MyColor(color: myPinkColor, darkColor: myDarkPinkColor, isSelect: false),
      MyColor(color: myTealColor, darkColor: myDarkTealColor, isSelect: false),
      MyColor(color: myCyanColor, darkColor: myDarkCyanColor, isSelect: false),
      MyColor(color: myGreyColor, darkColor: myDarkGreyColor, isSelect: false),
    ];
  }

  static List<MyColor> getListLabelColor() {
    return <MyColor>[
      MyColor(color: myBlueColor, isSelect: true),
      MyColor(color: myAmberColor, isSelect: false),
      MyColor(color: myGreenColor, isSelect: false),
      MyColor(color: myRedColor, isSelect: false),
      MyColor(color: myPurpleColor, isSelect: false),
      MyColor(color: myPinkColor, isSelect: false),
      MyColor(color: myTealColor, isSelect: false),
      MyColor(color: myCyanColor, isSelect: false),
      MyColor(color: myGreyColor, isSelect: false),
    ];
  }
}
