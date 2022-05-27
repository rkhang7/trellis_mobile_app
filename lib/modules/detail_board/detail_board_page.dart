import 'package:awesome_dialog/awesome_dialog.dart' as dialog;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nb_utils/nb_utils.dart';
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
                  // IconButton(
                  //   onPressed: () {
                  //     toast('Coming Soon');
                  //   },
                  //   icon: const Icon(Icons.search, color: iconColorPrimary),
                  // ),
                  // IconButton(
                  //   onPressed: () {
                  //     Get.toNamed(AppRoutes.NOTIFICATION);
                  //   },
                  //   icon: const Icon(Icons.notifications_none_outlined,
                  //       color: iconColorPrimary),
                  // ),
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
                          () => _buildTitle(list.name, index, list.listId),
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

  Widget _buildTitle(String name, int index, int listId) {
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
              PopupMenuItem(
                child: Text("sort_by_created_desc".tr),
                onTap: () {
                  detailBoardController.sort(
                      listId, index, "created_date_desc");
                },
              ),
            );
            list.add(
              PopupMenuItem(
                child: Text("sort_by_created_asc".tr),
                onTap: () {
                  detailBoardController.sort(listId, index, "created_date_asc");
                },
              ),
            );
            list.add(
              PopupMenuItem(
                child: Text("sort_by_start_date".tr),
                onTap: () {
                  detailBoardController.sort(listId, index, "start_date");
                },
              ),
            );
            list.add(
              PopupMenuItem(
                child: Text("sort_by_due_date".tr),
                onTap: () {
                  detailBoardController.sort(listId, index, "due_asc");
                },
              ),
            );
            if (detailBoardController.getPermissionForCurrentUser() == 1) {
              list.add(
                PopupMenuItem(
                  child: InkWell(
                    child: Text(
                      "delete_list".tr,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  onTap: () async {
                    await Future.delayed(Duration.zero);
                    await dialog.AwesomeDialog(
                      context: context,
                      dialogType: dialog.DialogType.WARNING,
                      animType: dialog.AnimType.BOTTOMSLIDE,
                      title: 'delete_list'.tr,
                      desc: 'are_you_sure_delete_this_list'.tr,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        detailBoardController.deleteList(listId, index);
                      },
                    ).show();
                  },
                ),
              );
            }

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
              "listId": detailBoardController.lists[index].listId.toString(),
              "listName": detailBoardController.lists[index].name,
            });
          },
          child: Text(
            "+ ${"add_card".tr}",
            style: const TextStyle(color: Colors.green),
          ),
        ),
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.image_outlined),
        // ),
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
        return _buildCard(cardModel, index);
      },
      itemCount: listCard.length,
    );
  }

  Widget _buildCard(CardResponse cardModel, int index) {
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
        onDoubleTap: () {
          openBottomSheet(cardModel, index);
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
                Expanded(
                    child:
                        Text(detailBoardController.getDateShowUI(cardModel))),
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
                          ),
                        ),
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
                          imageUrl: userResponse.avatarURL.isEmpty
                              ? "https://ui-avatars.com/api/?name=${userResponse.firstName}+${userResponse.lastName}&&size=120&&rounded=true&&background=${userResponse.avatarBackgroundColor}&&color=ffffff&&bold=true"
                              : userResponse.avatarURL,
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
            const SizedBox(
              height: 5,
            ),
            cardModel.isComplete
                ? Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.green,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "complete".tr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "incomplete".tr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> openBottomSheet(CardResponse cardResponse, int index) {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        height: 650.h,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "choose_action".tr,
              style: TextStyle(color: Colors.black, fontSize: 72.sp),
            ),
            const SizedBox(
              height: 8,
            ),
            cardResponse.isComplete
                ? InkWell(
                    onTap: () {
                      detailBoardController.updateCardRework(
                          cardResponse, index);
                      Get.back();
                    },
                    child: Container(
                      width: Get.width,
                      height: 150.h,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.undo, color: Colors.white),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "rework".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64.sp,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      detailBoardController.updateCardComplete(
                          cardResponse, index);
                      Get.back();
                    },
                    child: Container(
                      width: Get.width,
                      height: 150.h,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check, color: Colors.white),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "confirm_complete".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64.sp,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () async {
                await dialog.AwesomeDialog(
                  context: Get.context!,
                  dialogType: dialog.DialogType.WARNING,
                  animType: dialog.AnimType.BOTTOMSLIDE,
                  title: 'delete_list'.tr,
                  desc: 'are_you_sure_delete_this_card'.tr,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    detailBoardController.deleteCard(
                      cardResponse,
                      index,
                    );
                  },
                ).show();

                Get.back();
              },
              child: Container(
                width: Get.width,
                height: 150.h,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete, color: Colors.white),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "delete_card".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64.sp,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
      isDismissible: true,
    );
  }

  void swapCards(
      List<CardResponse> listCard, int oldIndex, int newIndex, int index) {
    detailBoardController.moveCards(
        detailBoardController.lists[index].listId, oldIndex, newIndex);

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
