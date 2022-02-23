import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService {
  final _box = GetStorage();

  final _key = "language";
  String loadLanguageFromBox() => _box.read(_key) ?? "VN";
  saveLanguageToBox(String language) => _box.write(_key, language);

  Locale get language => loadLanguageFromBox() == "VN"
      ? const Locale("vi", "VN")
      : const Locale("en", "US");
}
