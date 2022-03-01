import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/end_drawer_component.dart';
import 'package:trellis_mobile_app/models/core/card_model.dart';
import 'package:trellis_mobile_app/models/core/list_model.dart';
import 'package:trellis_mobile_app/modules/detail_table/controller/detail_board_controller.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class DetailBoardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final name = Get.arguments;
  final detailBoardController = Get.find<DetailBoardController>();

  DetailBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: _key,
          backgroundColor: backgroundColor,
          endDrawer: EndDrawerComponent(),
          appBar: _buildAppBar(),
          body: Obx(() {
            return _buildBody();
          })),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: iconColorPrimary),
        onPressed: () {
          Get.back();
        },
      ),
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
        ),
      ],
    );
  }

  void _handleDrawer() {
    _key.currentState!.openEndDrawer();
  }

  Widget _buildBody() {
    return PageView.builder(
      itemCount: detailBoardController.listList.length,
      controller: detailBoardController.pageController,
      itemBuilder: (context, index) {
        var list = detailBoardController.listList[index];
        return Container(
          constraints: const BoxConstraints.expand(),
          margin: EdgeInsets.symmetric(vertical: 48.h, horizontal: 48.w),
          decoration: BoxDecoration(
            color: Colors.grey[200]!,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: _buildListCard(list.listCard),
        );
      },
    );
  }

  Widget _buildTitle(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.w),
          child: Text(
            name,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 60.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert_outlined),
          itemBuilder: (BuildContext context) {
            List<PopupMenuEntry<Object>> list = [];
            list.add(
              PopupMenuItem(child: Text("add_card".tr), value: 1),
            );
            list.add(
              PopupMenuItem(child: Text("move_list".tr), value: 1),
            );
            return list;
          },
        )
      ],
    );
  }

  _buildAddCard() {
    return Row(
      key: ValueKey(CardModel(
          id: "id", name: "name", description: "description", position: 1)),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "+ ${"add_card".tr}",
            style: const TextStyle(color: Colors.green),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.image_outlined),
        ),
      ],
    );
  }

  Widget _buildListCard(List<CardModel> listCard) {
    return ReorderableListView.builder(
      header: _buildTitle("asd"),
      padding: EdgeInsets.all(16.h),
      shrinkWrap: true,
      onReorder: (oldIndex, newIndex) {
        swapCards(listCard, oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        if (index == listCard.length) {
          return _buildAddCard();
        } else {
          CardModel cardModel = listCard[index];
          return _buildCard(cardModel);
        }
      },
      itemCount: listCard.length + 1,
    );
  }

  Container _buildCard(CardModel cardModel) {
    return Container(
      key: ValueKey(cardModel),
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            blurStyle: BlurStyle.normal,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Text(
        cardModel.name,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontSize: 60.sp,
        ),
      ),
    );
  }

  void swapCards(List<CardModel> listCard, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final CardModel item = listCard.removeAt(oldIndex);
    listCard.insert(newIndex, item);
  }
}
