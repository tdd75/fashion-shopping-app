import 'package:fashion_shopping_app/modules/inbox_tab/inbox_controller.dart';
import 'package:get/get.dart';

class InboxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InboxController());
  }
}
