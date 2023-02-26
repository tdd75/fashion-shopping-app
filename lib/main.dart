import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fashion_shopping_app/core/di/di.dart';
import 'package:fashion_shopping_app/core/app_binding.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/theme/theme_data.dart';
import 'package:fashion_shopping_app/shared/translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DenpendencyInjection.init();

  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      title: 'Fashion Shopping App',
      theme: ThemeConfig.lightTheme,
      translations: AppTranslations(),
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      defaultTransition: Transition.fade,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.pulse
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    // ..indicatorWidget = const BaseLoading()
    ..boxShadow = []
    ..textColor = ColorConstants.black
    ..userInteractions = false
    ..dismissOnTap = false;
}
