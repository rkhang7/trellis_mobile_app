import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/my_color.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/common.dart';

class BoardBackgroundPage extends StatelessWidget {
  const BoardBackgroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: GridView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
        ),
        shrinkWrap: true,
        itemCount: Common.getListBackgroundBoard().length,
        itemBuilder: (context, index) {
          final myColor = Common.getListBackgroundBoard()[index];
          return InkWell(
            onTap: () async {},
            child: myColor.isSelect
                ? Card(
                    color: Color(myColor.color),
                    child:
                        const Icon(Icons.check, size: 80, color: Colors.white),
                  )
                : Card(
                    color: Color(myColor.color),
                  ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        'background_color'.tr,
        style: TextStyle(color: Colors.white, fontSize: 72.sp),
      ),
    );
  }
}
