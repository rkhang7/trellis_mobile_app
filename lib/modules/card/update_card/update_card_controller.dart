import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';

class UpdateCardController extends GetxController {
  final detailBoardController = Get.find<DetailBoardController>();
  final cardNameController = TextEditingController();
  final cardDescriptionController = TextEditingController();
  final cardRepository = Get.find<CardRepository>();
  var cardUpdate = CardResponse(
      card_id: -1,
      name: "name",
      description: "description",
      position: -1,
      start_date: -1,
      due_date: -1,
      reminder: -1,
      list_id: -1,
      is_complete: false,
      created_time: -1,
      updated_time: -1,
      created_by: "",
      members: []).obs;

  var editingName = false.obs;
  var cardNameIsEmpty = false.obs;

  var editingDescription = false.obs;

  @override
  void onInit() {
    cardUpdate.value = detailBoardController.selectedCard.value;
    cardNameController.text = cardUpdate.value.name;
    cardDescriptionController.text = cardUpdate.value.description;
    super.onInit();
  }

  void updateCardName() {
    EasyLoading.show(status: "please_wait".tr);
    var newCard = CardRequest(
      name: cardNameController.text.trim(),
      description: cardUpdate.value.description,
      position: cardUpdate.value.position,
      startDate: cardUpdate.value.start_date,
      dueDate: cardUpdate.value.due_date,
      reminder: cardUpdate.value.reminder,
      listId: cardUpdate.value.list_id,
      createdBy: cardUpdate.value.created_by,
    );

    cardRepository.updateCard(cardUpdate.value.card_id, newCard).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);

      cardUpdate.value.name = value.name;

      editingName.value = false;

      detailBoardController.lists.refresh();
    }).catchError((Object obj) {
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

  void updateCardDescription() {
    EasyLoading.show(status: "please_wait".tr);
    var newCard = CardRequest(
      name: cardUpdate.value.name,
      description: cardDescriptionController.text.trim(),
      position: cardUpdate.value.position,
      startDate: cardUpdate.value.start_date,
      dueDate: cardUpdate.value.due_date,
      reminder: cardUpdate.value.reminder,
      listId: cardUpdate.value.list_id,
      createdBy: cardUpdate.value.created_by,
    );

    cardRepository.updateCard(cardUpdate.value.card_id, newCard).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);

      cardUpdate.value.description = value.description;

      editingDescription.value = false;

      detailBoardController.lists.refresh();
    }).catchError((Object obj) {
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

  void handleLeading() {
    if (editingName.isTrue) {
      editingName.value = false;
    } else {
      Get.back();
    }
  }
}
