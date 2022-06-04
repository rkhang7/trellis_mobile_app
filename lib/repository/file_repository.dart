import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getX;
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/file/file_response.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_controller.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_page.dart';

class FileRepository {
  final updateCardController = getX.Get.find<UpdateCardController>();
  void uploadImage(XFile file, int cardId) async {
    EasyLoading.show(status: "please_wait".tr);
    FileResponse fileResponse = FileResponse(
        id: -1,
        cardId: -1,
        name: "",
        url: "url",
        createdTime: 1,
        updatedTime: 1);
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    await dio
        .post(
            "http://ec2-54-144-207-65.compute-1.amazonaws.com:8080/storage/uploadFile?cardId=$cardId",
            data: data)
        .then(
      (value) {
        Map<String, dynamic> map = value.data;

        var _item = FileResponse.fromJson(map);

        fileResponse = _item;
        EasyLoading.dismiss();

        updateCardController.cardUpdate.value.cardAttachments
            .insert(0, fileResponse);
        updateCardController.cardUpdate.refresh();
        log(jsonEncode(fileResponse));
      },
    ).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
    ;
  }

  void uploadFile(File file, int cardId) async {
    EasyLoading.show(status: "please_wait".tr);
    FileResponse fileResponse = FileResponse(
        id: -1,
        cardId: -1,
        name: "",
        url: "url",
        createdTime: 1,
        updatedTime: 1);
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    await dio
        .post(
            "http://ec2-54-144-207-65.compute-1.amazonaws.com:8080/storage/uploadFile?cardId=$cardId",
            data: data)
        .then(
      (value) {
        Map<String, dynamic> map = value.data;

        var _item = FileResponse.fromJson(map);

        fileResponse = _item;

        updateCardController.cardUpdate.value.cardAttachments
            .insert(0, fileResponse);
        // int count = 0;
        // var _tasks = [];

        // _tasks.addAll(
        //   updateCardController.getListDocument().map(
        //         (file) => TaskInfo(name: file.name, link: file.url),
        //       ),
        // );

        // _tasks.insert(0, TaskInfo(name: fileResponse.name, link: fileResponse.url));

        // for (int i = 0; i < _tasks!.length; i++) {
        //   updateCardController.items
        //       .add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
        //   count++;
        // }
        updateCardController.items.insert(
          0,
          ItemHolder(
            name: fileResponse.name,
            task: TaskInfo(name: fileResponse.name, link: fileResponse.url),
          ),
        );
        updateCardController.cardUpdate.refresh();

        EasyLoading.dismiss();

        log(jsonEncode(fileResponse));
      },
    ).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }
}
