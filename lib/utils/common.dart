import 'package:flutter/cupertino.dart';
import 'package:trellis_mobile_app/models/my_color.dart';
import 'package:trellis_mobile_app/utils/constants.dart';

class Common {
  static List<MyColor> getListBackgroundBoard() {
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
