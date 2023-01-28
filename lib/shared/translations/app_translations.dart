import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/shared/translations/locales/en_US.dart';
import 'package:fashion_shopping_app/shared/translations/locales/vi_VN.dart';

class AppTranslations extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'vi_VN': vi_VN,
      };
}
