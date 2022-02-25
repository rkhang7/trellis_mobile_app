import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/end_drawer_model.dart';
import 'package:trellis_mobile_app/utils/widgets.dart';

class EndDrawerComponent extends StatefulWidget {
  final int? index;

  EndDrawerComponent({this.index});

  @override
  _EndDrawerComponentState createState() => _EndDrawerComponentState();
}

class _EndDrawerComponentState extends State<EndDrawerComponent> {
  List<EndDrawerModel> endDrawer = [];
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  int? index;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    print(widget.index);
    index = widget.index;
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(Feather.info),
        title: "about_this_board".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(MaterialIcons.person_outline),
        title: "members".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(Feather.activity),
        title: "activity".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(SimpleLineIcons.rocket),
        title: "power_ups".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(Feather.credit_card),
        title: "archived_cards".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(MaterialCommunityIcons.format_list_checkbox),
        title: "archived_list".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );
    endDrawer.add(
      EndDrawerModel(
          leading: const Icon(SimpleLineIcons.settings),
          title: "board_settings".tr,
          onTap: () {
            toast('Coming Soon');
          },
          contents: [
            const ListTile(
              title: Text('AppClone'),
              subtitle: const Text('Name'),
            )
          ]),
    );
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(MaterialCommunityIcons.star_outline),
        title: "star_board".tr,
        contents: [],
        onTap: () {
          //
        },
      ),
    );
    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(MaterialCommunityIcons.pin_outline),
        title: "pin_to_home_screen".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );

    endDrawer.add(
      EndDrawerModel(
        leading: const Icon(Icons.copy_outlined),
        title: "copy_board".tr,
        contents: [],
        onTap: () {
          toast('Coming Soon');
        },
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            itemCount: endDrawer.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: [
                    DrawerList(
                      leading: endDrawer[index].leading,
                      onTap: endDrawer[index].onTap,
                      title: endDrawer[index].title,
                    ),
                    const Divider(color: Colors.black, thickness: 0)
                        .visible(index == 2 || index == 3 || index == 6)
                  ],
                ),
              );
            },
          ),
          DrawerList(
              leading: const Icon(Icons.sync),
              title: "synced".tr,
              onTap: () {
                toast('Coming Soon');
              }),
        ],
      )),
    );
  }
}
