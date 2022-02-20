import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class CreateCardPage extends StatelessWidget {
  const CreateCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: const CloseButton(),
          title: Text(
            "Thêm thẻ",
            style: boldTextStyle(
              color: Colors.white,
              size: 18,
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.check))
          ],
        ),
        body: const Center(
          child: Text("Create Cards"),
        ),
      ),
    );
  }
}
