import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/end_drawer_component.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import '../controller/detail_board_controller.dart';

class DetailBoardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final name = Get.parameters['name'];
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
      backgroundColor: backgroundColor,
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
            name!,
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
                    // detailBoardController.nameListIsEmpty.isTrue
                    //     ? null
                    //     : _updateNameList();
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
                  onPressed: () {},
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
                      _handleDrawer();
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

  void _handleDrawer() {
    _key.currentState!.openEndDrawer();
  }

  Widget _buildBody() {
    return PageView.builder(
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
                          child: Container(
                        height: 200,
                      )), // _buildListCard(list.listCard, list.name, index)),
                      Obx(
                        () => _buildAddCard(index),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
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
    var addingCard = detailBoardController.listNameCardAdding[index];
    return addingCard
        ? Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: TextFormField(
              maxLines: null,
              autofocus: true,
              controller: detailBoardController.listNameCardController[index],
              decoration: InputDecoration(
                hintText: "card_name".tr,
                contentPadding: const EdgeInsets.all(0),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              cursorColor: Colors.green,
              cursorHeight: 25,
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  detailBoardController.nameCardIsEmpty.value = true;
                } else {
                  detailBoardController.nameCardIsEmpty.value = false;
                }
              },
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // scroll to last position
                  // detailBoardController.listCardScrollController[index].jumpTo(
                  //     detailBoardController.listCardScrollController[index]
                  //         .position.maxScrollExtent);
                  detailBoardController.listCardScrollController[index]
                      .animateTo(
                    detailBoardController.listCardScrollController[index]
                        .position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 500),
                  );
                  detailBoardController.listNameCardAdding[index] = true;

                  // change appBar
                  detailBoardController.nameCardAdding.value = true;
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

  // Widget _buildListCard(List<CardModel> listCard, String nameList, int index) {
  //   return ReorderableListView.builder(
  //     padding: EdgeInsets.all(16.h),
  //     scrollController: detailBoardController.listCardScrollController[index],
  //     shrinkWrap: true,
  //     onReorder: (oldIndex, newIndex) {
  //       swapCards(listCard, oldIndex, newIndex);
  //     },
  //     itemBuilder: (context, index) {
  //       CardModel cardModel = listCard[index];
  //       return _buildCard(cardModel);
  //     },
  //     itemCount: listCard.length,
  //   );
  // }

  // Container _buildCard(CardModel cardModel) {
  //   return Container(
  //     key: ValueKey(cardModel),
  //     margin: EdgeInsets.all(8.w),
  //     padding: EdgeInsets.all(24.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(4),
  //       boxShadow: const [
  //         BoxShadow(
  //             blurRadius: 8,
  //             offset: Offset(0, 0),
  //             color: Color.fromRGBO(127, 140, 141, 0.5),
  //             spreadRadius: 2)
  //       ],
  //     ),
  //     child: Text(
  //       cardModel.name,
  //       overflow: TextOverflow.clip,
  //       style: TextStyle(
  //         fontSize: 60.sp,
  //       ),
  //     ),
  //   );
  // }

  // void swapCards(List<CardModel> listCard, int oldIndex, int newIndex) {
  //   if (oldIndex < newIndex) {
  //     newIndex -= 1;
  //   }
  //   final CardModel item = listCard.removeAt(oldIndex);
  //   listCard.insert(newIndex, item);
  // }

  // _updateNameList() {
  //   var currentIndex = detailBoardController.listNameListEditing.indexOf(true);

  //   detailBoardController.listList[currentIndex].name =
  //       detailBoardController.listController[currentIndex].text;

  //   detailBoardController.nameListEditing.value = false;
  //   detailBoardController.listNameListEditing[currentIndex] = false;
  // }

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
