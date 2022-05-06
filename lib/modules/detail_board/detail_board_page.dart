import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/end_drawer_component.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import 'detail_board_controller.dart';

class DetailBoardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final detailBoardController = Get.find<DetailBoardController>();

  DetailBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            key: _key,

            // endDrawer: EndDrawerComponent(),
            appBar: _buildAppBar(),
            body: Obx(
              () {
                return _buildBody();
              },
            ),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Obx(() {
        if (detailBoardController.nameListEditing.isTrue) {
          return IconButton(
            icon: const Icon(Icons.close, color: iconColorPrimary),
            onPressed: () {
              detailBoardController.nameListEditing.value = false;
              for (int i = 0;
                  i < detailBoardController.listNameListEditing.length;
                  i++) {
                detailBoardController.listNameListEditing[i] = false;
              }
            },
          );
        } else if (detailBoardController.nameCardAdding.isTrue) {
          return IconButton(
            icon: const Icon(Icons.close, color: iconColorPrimary),
            onPressed: () {
              detailBoardController.nameCardAdding.value = false;
              for (int i = 0;
                  i < detailBoardController.listNameCardAdding.length;
                  i++) {
                detailBoardController.listNameCardAdding[i] = false;
              }
            },
          );
        } else if (detailBoardController.nameListAdding.isTrue) {
          return IconButton(
            icon: const Icon(Icons.close, color: iconColorPrimary),
            onPressed: () {
              detailBoardController.nameListAdding.value = false;
            },
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.arrow_back, color: iconColorPrimary),
            onPressed: () {
              Get.back();
            },
          );
        }
      }),
      backgroundColor: HexColor(detailBoardController.appBarColor.value),
      title: Obx(() {
        if (detailBoardController.nameListEditing.isTrue) {
          return Text(
            "edit_list_name".tr,
            style: boldTextStyle(size: 18, color: Colors.white),
          );
        } else if (detailBoardController.nameCardAdding.isTrue) {
          return Text(
            "add_card".tr,
            style: boldTextStyle(size: 18, color: Colors.white),
          );
        } else if (detailBoardController.nameListAdding.isTrue) {
          return Text(
            "add_list".tr,
            style: boldTextStyle(size: 18, color: Colors.white),
          );
        } else {
          return Text(
            detailBoardController.name.toString(),
            style: boldTextStyle(size: 18, color: Colors.white),
          );
        }
      }),
      actions: [
        Obx(
          () {
            if (detailBoardController.nameListEditing.isTrue) {
              return Obx(
                () => IconButton(
                  onPressed: () {
                    detailBoardController.nameListIsEmpty.isTrue
                        ? null
                        : detailBoardController.updateNameList();
                  },
                  icon: Icon(Icons.check,
                      color: detailBoardController.nameListIsEmpty.isTrue
                          ? Colors.grey
                          : Colors.white),
                ),
              );
            } else if (detailBoardController.nameCardAdding.isTrue) {
              return Obx(
                () => IconButton(
                  onPressed: () {
                    // detailBoardController.nameCardIsEmpty.isTrue
                    //     ? null
                    //     : _addCardToList();
                  },
                  icon: Icon(Icons.check,
                      color: detailBoardController.nameCardIsEmpty.isTrue
                          ? Colors.grey
                          : Colors.white),
                ),
              );
            } else if (detailBoardController.nameListAdding.isTrue) {
              return Obx(
                () => IconButton(
                  onPressed: () {
                    detailBoardController.createList();
                  },
                  icon: Icon(Icons.check,
                      color: detailBoardController.nameListIsEmpty.isTrue
                          ? Colors.grey
                          : Colors.white),
                ),
              );
            } else {
              return Row(
                children: [
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
                      Get.toNamed(AppRoutes.BOARD_MENU);
                    },
                    icon: const Icon(Icons.more_horiz, color: iconColorPrimary),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      color: HexColor(detailBoardController.backgroundColor.value),
      child: PageView.builder(
        physics: (detailBoardController.nameListEditing.isTrue ||
                detailBoardController.nameCardAdding.isTrue ||
                detailBoardController.nameListAdding.isTrue)
            ? const NeverScrollableScrollPhysics()
            : null,
        itemCount: detailBoardController.lists.length + 1,
        controller: detailBoardController.pageController,
        itemBuilder: (context, index) {
          if (index == detailBoardController.lists.length) {
            return Obx(() => _buildAddList());
          } else {
            var list = detailBoardController.lists[index];
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 48.h, horizontal: 48.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => _buildTitle(list.name, index),
                        ),
                        Expanded(
                          child: _buildListCard(list.cards, list.name, index),
                        ),
                        _buildAddCard(index),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTitle(String name, int index) {
    detailBoardController.listController[index].text = name;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        detailBoardController.listNameListEditing[index]
            ? Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: TextFormField(
                    maxLines: null,
                    autofocus: true,
                    controller: detailBoardController.listController[index],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                    cursorColor: Colors.green,
                    cursorHeight: 25,
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        detailBoardController.nameListIsEmpty.value = true;
                      } else {
                        detailBoardController.nameListIsEmpty.value = false;
                      }
                    },
                  ),
                ),
              )
            : Expanded(
                child: InkWell(
                  onTap: () {
                    detailBoardController.listNameListEditing[index] = true;
                    detailBoardController.nameListEditing.value = true;
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Text(
                            name,
                            style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                color: Colors.black87,
                                fontSize: 60.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildAddCard(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            // // scroll to last position
            // // detailBoardController.listCardScrollController[index].jumpTo(
            // //     detailBoardController.listCardScrollController[index]
            // //         .position.maxScrollExtent);
            // detailBoardController.listCardScrollController[index].animateTo(
            //   detailBoardController
            //       .listCardScrollController[index].position.maxScrollExtent,
            //   curve: Curves.easeOut,
            //   duration: const Duration(milliseconds: 500),
            // );
            // detailBoardController.listNameCardAdding[index] = true;

            // // change appBar
            // detailBoardController.nameCardAdding.value = true;
            Get.toNamed(AppRoutes.CREATE_CARD, parameters: {
              "listId": detailBoardController.lists[index].list_id.toString()
            });
          },
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

  Widget _buildListCard(
      List<CardResponse> listCard, String nameList, int index) {
    return ReorderableListView.builder(
      padding: EdgeInsets.all(16.h),
      scrollController: detailBoardController.listCardScrollController[index],
      shrinkWrap: true,
      onReorder: (oldIndex, newIndex) {
        swapCards(listCard, oldIndex, newIndex, index);
      },
      itemBuilder: (context, index) {
        CardResponse cardModel = listCard[index];
        return _buildCard(cardModel);
      },
      itemCount: listCard.length,
    );
  }

  Widget _buildCard(CardResponse cardModel) {
    return Container(
      key: ValueKey(cardModel),
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 0),
              color: Color.fromRGBO(127, 140, 141, 0.5),
              spreadRadius: 2)
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.UPDATE_CARD);
          detailBoardController.selectedCard.value = cardModel;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardModel.name,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 60.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                const Icon(Icons.access_time),
                SizedBox(
                  width: 30.w,
                ),
                Text(detailBoardController.getDateShowUI(cardModel)),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            cardModel.tasks.isNotEmpty
                ? Container(
                    width: 45,
                    height: 20,
                    decoration: BoxDecoration(
                      color: detailBoardController
                                  .getLengthTaskIsComplete(cardModel) ==
                              cardModel.tasks.length
                          ? Colors.green
                          : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          color: detailBoardController
                                      .getLengthTaskIsComplete(cardModel) ==
                                  cardModel.tasks.length
                              ? Colors.white
                              : Colors.black,
                          size: 20,
                        ),
                        Text(
                            "${detailBoardController.getLengthTaskIsComplete(cardModel)}/${cardModel.tasks.length}",
                            style: TextStyle(
                              color: detailBoardController
                                          .getLengthTaskIsComplete(cardModel) ==
                                      cardModel.tasks.length
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 48.sp,
                            )),
                      ],
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  runSpacing: 20.h,
                  spacing: 20.h,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: cardModel.members.map((userResponse) {
                    return Container(
                      width: 40,
                      height: 40,
                      color: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userResponse.avatar_url.isEmpty
                              ? "https://ui-avatars.com/api/?name=${userResponse.first_name}+${userResponse.last_name}&&size=120&&rounded=true&&background=${userResponse.avatar_background_color}&&color=ffffff&&bold=true"
                              : userResponse.avatar_url,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    );
                    // return Container(
                    //   width: 50,
                    //   height: 50,
                    //   color: Colors.red,
                    // );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void swapCards(
      List<CardResponse> listCard, int oldIndex, int newIndex, int index) {
    detailBoardController.moveCards(
        detailBoardController.lists[index].list_id, oldIndex, newIndex);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final CardResponse item = listCard.removeAt(oldIndex);
    listCard.insert(newIndex, item);
  }

  // _addCardToList() {
  //   var currentAddingIndex =
  //       detailBoardController.listNameCardAdding.indexOf(true);

  //   String nameCard =
  //       detailBoardController.listNameCardController[currentAddingIndex].text;
  //   int lengthListCard =
  //       detailBoardController.lists[currentAddingIndex].listCard.length;
  //   detailBoardController.lists[currentAddingIndex].listCard.add(CardModel(
  //       id: "id",
  //       name: nameCard,
  //       description: "description",
  //       position: lengthListCard));

  //   // update gui
  //   detailBoardController.nameCardAdding.value = false;
  //   detailBoardController.listNameCardAdding[currentAddingIndex] = false;
  //   detailBoardController.listNameCardController[currentAddingIndex].clear();

  //   // after add, scroll to last position
  //   detailBoardController.listCardScrollController[currentAddingIndex]
  //       .animateTo(
  //     (detailBoardController.listCardScrollController[currentAddingIndex]
  //             .position.maxScrollExtent) +
  //         1,
  //     curve: Curves.easeOut,
  //     duration: const Duration(milliseconds: 500),
  //   );
  // }

  Widget _buildAddList() {
    var nameListAdding = detailBoardController.nameListAdding.value;
    return Column(
      children: [
        InkWell(
          onTap: () {
            detailBoardController.nameListAdding.value = true;
          },
          child: Container(
            alignment: Alignment.center,
            height: 240.h,
            margin: EdgeInsets.symmetric(vertical: 48.h, horizontal: 48.w),
            decoration: BoxDecoration(
              color: Colors.grey[200]!,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: nameListAdding
                ? Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: TextFormField(
                      maxLines: null,
                      autofocus: true,
                      controller:
                          detailBoardController.nameListAddingController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      cursorColor: Colors.green,
                      cursorHeight: 25,
                      onChanged: (value) {
                        if (value.trim().isEmpty) {
                          detailBoardController.nameListIsEmpty.value = true;
                        } else {
                          detailBoardController.nameListIsEmpty.value = false;
                        }
                      },
                    ),
                  )
                : Text(
                    "add_list".tr,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
