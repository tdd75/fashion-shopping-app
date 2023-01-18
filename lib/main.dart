import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fashion_shopping_app/di.dart';
import 'package:fashion_shopping_app/app_binding.dart';
import 'package:fashion_shopping_app/core/constants/color.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/core/theme/theme_data.dart';
import 'package:fashion_shopping_app/core/translations/app_translations.dart';

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
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 5
    ..boxShadow = []
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = ColorConstants.primary
    ..textColor = ColorConstants.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
