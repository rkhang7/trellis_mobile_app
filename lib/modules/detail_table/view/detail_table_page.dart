import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/end_drawer_component.dart';
import 'package:trellis_mobile_app/models/card_model.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/drag_widget/drag_and_drop_list.dart';

class DetailTablePage extends StatefulWidget {
  const DetailTablePage({Key? key}) : super(key: key);

  @override
  State<DetailTablePage> createState() => _DetailTablePageState();
}

class _DetailTablePageState extends State<DetailTablePage> {
  String name = Get.arguments;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  List<List<CardModel?>> cards = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _key,
          backgroundColor: backgroundColor,
          endDrawer: EndDrawerComponent(),
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: Text(
              name,
              style: boldTextStyle(size: 18, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  toast('Coming Soon');
                },
                icon: const Icon(Icons.search, color: iconColorPrimary),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.NOTIFICATION);
                },
                icon: const Icon(Icons.notifications_none_outlined,
                    color: iconColorPrimary),
              ),
              IconButton(
                onPressed: () {
                  _handleDrawer();
                },
                icon: const Icon(Icons.more_horiz, color: iconColorPrimary),
              )
            ],
          ),
          body: Center(
            child: Text("Detail page"),
          )),
    );
  }

  void _handleDrawer() {
    _key.currentState!.openEndDrawer();
  }
}
