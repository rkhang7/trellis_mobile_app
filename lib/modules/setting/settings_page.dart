import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/setting/setting_controller.dart';
import 'package:trellis_mobile_app/service/language_service.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final LanguageService languageService = LanguageService();
  final settingsController = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _languageArea(),
          const Divider(
            color: Colors.grey,
            thickness: 1.5,
          ),
        ],
      )),
    ));
  }

  _buildAppBar() {
    return AppBar(
      title: Text("settings".tr),
    );
  }

  _languageArea() {
    return Padding(
      padding: const EdgeInsets.only(left: 48, top: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "language".tr,
            style: boldTextStyle(color: Colors.green, size: 16),
          ),
          20.height,
          Row(
            children: [
              Text(
                "select_language".tr,
                style: primaryTextStyle(color: Colors.black, size: 18),
              ),
              20.width,
              Obx(
                () => _buildDropdownLanguage(),
              ),
            ],
          ),
          10.height,
        ],
      ),
    );
  }

  Widget _buildDropdownLanguage() {
    String selectedLanguage = settingsController.selectedLanguage.value;
    return DropdownButton<String>(
      underline: Container(),
      iconSize: 0,
      hint: languageService.loadLanguageFromBox() == "VN"
          ? Flag.fromCode(
              FlagsCode.VN,
              width: 60,
              height: 30,
            )
          : Flag.fromCode(
              FlagsCode.US,
              width: 60,
              height: 30,
            ),
      items: [
        DropdownMenuItem(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flag.fromCode(
                FlagsCode.VN,
                width: 50,
                height: 25,
              ),
              Text("Tiếng Việt"),
            ],
          ),
          value: "VN",
        ),
        DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flag.fromCode(
                FlagsCode.US,
                width: 50,
                height: 25,
              ),
              Text("English"),
            ],
          ),
          value: "US",
        ),
      ],
      onChanged: (value) {
        settingsController.selectedLanguage.value = value!;
        if (value == "US") {
          languageService.saveLanguageToBox("US");
          var locale = const Locale('en', 'US');
          Get.updateLocale(locale);
        } else {
          languageService.saveLanguageToBox("VN");
          var locale = const Locale('vi', 'VN');
          Get.updateLocale(locale);
        }
      },
    );
  }
}
