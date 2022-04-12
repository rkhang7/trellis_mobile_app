import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/search_board_controller.dart';

class SearchBoardPage extends StatelessWidget {
  SearchBoardPage({Key? key}) : super(key: key);
  final searchBoardController = Get.find<SearchBoardController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Text("Search board"),
      ),
    ));
  }

  _buildAppBar() {
    return AppBar(
      title: TextFormField(
        autofocus: true,
        cursorColor: Colors.white,
        controller: searchBoardController.searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "search".tr,
          hintStyle: const TextStyle(color: Colors.white),
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
        onChanged: (value) {
          if (value.isEmpty) {
            searchBoardController.searchInputEmpty.value = true;
          } else {
            searchBoardController.searchInputEmpty.value = false;
          }
        },
      ),
    );
  }
}
