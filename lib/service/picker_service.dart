import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class PickerService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    log("init");
  }

  Future<PickerService> init() async {
    return this;
  }

  pickImageFromCamera() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      log(photo?.name);
    }
  }

  pickFile() async {
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
      } else {
        // User canceled the picker
      }
    }
  }
}
