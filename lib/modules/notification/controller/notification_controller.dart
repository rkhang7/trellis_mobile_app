import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationController extends GetxController {
  var list = [];
  var listTitle = <String>[];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initList();
    initTitle();
  }

  void initList() {
    list = [
      Container(
          child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.circular(0),
              /* border: Border(
              left: BorderSide(width: 2),
            ),*/
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 1),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_sharp,
                  size: 40,
                ),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    createRichText(list: [
                      TextSpan(text: 'Khang ', style: boldTextStyle(size: 14)),
                      TextSpan(
                          text: 'đã tạo ', style: primaryTextStyle(size: 14)),
                      TextSpan(
                          text: 'Nhóm KLTN ', style: boldTextStyle(size: 14)),
                      TextSpan(
                          text: 'vào ngày ', style: primaryTextStyle(size: 14)),
                      TextSpan(
                          text: '15/02/2022', style: boldTextStyle(size: 14)),
                    ]),
                    Text('7 giờ trước ', style: primaryTextStyle(size: 12)),
                  ],
                )
              ],
            ),
          );
        },
      )),
      const Text("Không có thông báo", style: const TextStyle(fontSize: 18))
          .center(),
      const Text("Không có thông báo", style: const TextStyle(fontSize: 18))
          .center(),
    ];
  }

  void initTitle() {
    listTitle = ['all'.tr, 'me'.tr, 'comments'.tr];
  }
}
