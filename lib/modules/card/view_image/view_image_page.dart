import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ViewImagePage extends StatelessWidget {
  ViewImagePage({Key? key}) : super(key: key);
  var url = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GestureDetector(
            onLongPress: () {
              Get.bottomSheet(
                Container(
                  width: Get.width,
                  height: 200.h,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      GallerySaver.saveImage(url).then((value) {
                        if (value ?? false) {
                          Get.back();
                        }
                      });
                      EasyLoading.showSuccess("download_image_success".tr);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download, color: Colors.black),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "download_image".tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 64.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
            child: PhotoView(
              backgroundDecoration: const BoxDecoration(color: Colors.white),
              imageProvider: NetworkImage(url),
            ),
          ),
        ],
      ),
    );
  }
}
