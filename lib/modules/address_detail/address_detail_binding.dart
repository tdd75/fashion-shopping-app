import 'package:get/get.dart';

import 'address_detail_controller.dart';

class AddressDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddressDetailController(addressRepository: Get.find()));
  }
}
