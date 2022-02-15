import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:nb_utils/nb_utils.dart';

import 'package:trellis_mobile_app/utils/widgets.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  bool isExpandable = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            arrowColor: Colors.white,
            onDetailsPressed: () {
              isExpandable = !isExpandable;
              setState(() {});
            },
            currentAccountPicture: Image.network(
                    'https://i.pinimg.com/736x/9a/a5/5f/9aa55f48dfe94797a6c2745b08c40e2d.jpg')
                .cornerRadiusWithClipRRect(50),
            accountName: Text('Hoàng Xuân Khang',
                style: boldTextStyle(color: Colors.white, size: 16)),
            accountEmail: Text('khang@gmail.com',
                style: primaryTextStyle(color: Colors.white, size: 14)),
          ),
          Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                DrawerList(
                  leading: const Icon(FontAwesomeIcons.table),
                  title: "Bảng",
                  onTap: () {},
                ),
                DrawerList(
                  leading: const Icon(Icons.home),
                  title: "Trang chủ",
                  onTap: () {},
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Các không gian làm việc",
                        style: boldTextStyle(color: Colors.black87),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return DrawerList(
                            leading: const Icon(Icons.group_outlined),
                            title: "Nhóm $index",
                          );
                        },
                        itemCount: 3,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                DrawerList(
                  leading: const Icon(Icons.laptop),
                  title: "Các thẻ của tôi",
                  onTap: () {},
                ),
                DrawerList(
                  leading: const Icon(Icons.settings_outlined),
                  title: "Cài đặt",
                  onTap: () {},
                ),
                DrawerList(
                  leading: const Icon(Icons.info_outline),
                  title: "Trợ giúp",
                  onTap: () {},
                ),
              ],
            ),
          ).visible(isExpandable),
          DrawerList(
            leading: const Icon(Icons.add),
            title: "Thêm tài khoản",
            onTap: () {
              toast('Coming Soon');
            },
          ).visible(!isExpandable),
        ],
      ),
    );
  }
}
