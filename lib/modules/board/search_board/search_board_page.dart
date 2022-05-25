import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';

import '../../../routes/app_routes.dart';
import 'search_board_controller.dart';

class SearchBoardPage extends StatelessWidget {
  SearchBoardPage({Key? key}) : super(key: key);
  final searchBoardController = Get.find<SearchBoardController>();
  final boardRepository = Get.find<BoardRepository>();
  final dashBoardController = Get.find<DashBoardController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(),
      body: Container(),
    ));
  }

  _buildAppBar() {
    return AppBar(
      // title: TextFormField(
      //   autofocus: true,
      //   cursorColor: Colors.white,
      //   controller: searchBoardController.searchController,
      //   style: const TextStyle(color: Colors.white),
      //   decoration: InputDecoration(
      //     hintText: "search".tr,
      //     hintStyle: const TextStyle(color: Colors.white),
      //     suffixIcon: Obx(
      //       () {
      //         return searchBoardController.searchInputEmpty.isTrue
      //             ? const SizedBox.shrink()
      //             : IconButton(
      //                 icon: Icon(
      //                   Icons.close,
      //                   color: Colors.white,
      //                   size: 80.w,
      //                 ),
      //                 onPressed: () {
      //                   searchBoardController.searchController.clear();
      //                   searchBoardController.searchInputEmpty.value = true;
      //                 },
      //               );
      //       },
      //     ),
      //   ),
      //   onChanged: (value) {
      //     if (value.isEmpty) {
      //       searchBoardController.searchInputEmpty.value = true;
      //     } else {
      //       searchBoardController.searchInputEmpty.value = false;
      //     }
      //   },
      // ),
      title: TypeAheadField<BoardResponse>(
        debounceDuration: const Duration(seconds: 2),
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          controller: searchBoardController.searchController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white),
            hintText: "search".tr,
            suffixIcon: Obx(
              () {
                return searchBoardController.searchInputEmpty.isTrue
                    ? const SizedBox.shrink()
                    : IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 80.w,
                        ),
                        onPressed: () {
                          searchBoardController.searchController.clear();
                          searchBoardController.searchInputEmpty.value = true;
                        },
                      );
              },
            ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return await boardRepository.getListBoardsInWorkspace(
              dashBoardController.workspaceSelected.value.workspaceId,
              dashBoardController.currentId,
              pattern);
        },
        keepSuggestionsOnLoading: true,
        itemBuilder: (context, boardResponse) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                dashBoardController.boardIdSelected = boardResponse.boardId;
                await Get.toNamed(
                  AppRoutes.DETAIL_BOARD,
                  parameters: {
                    'name': boardResponse.name,
                  },
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: HexColor(boardResponse.backgroundColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    boardResponse.name,
                    style: TextStyle(color: Colors.black, fontSize: 64.sp),
                  ),
                ],
              ),
            ),
          );
        },
        onSuggestionSelected: (suggestion) {},
        hideSuggestionsOnKeyboardHide: false,
        noItemsFoundBuilder: (_) {
          return Column(
            children: [
              Image.asset("assets/images/no_result_found.jpg"),
              Text(
                "no_results_found".tr,
                style: TextStyle(fontSize: 64.sp, color: Colors.red),
              ),
            ],
          );
        },
        hideOnLoading: false,
        loadingBuilder: (_) {
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
