import 'package:get/get.dart';

import 'layout_controller.dart';

class LayoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LayoutController());
  }
}
