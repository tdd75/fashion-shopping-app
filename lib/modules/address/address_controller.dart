import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/repositories/address_repository.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final AddressRepository addressRepository;

  AddressController({required this.addressRepository});

  var isLoading = false.obs;
  var addresses = Rx<List<Address>>([]);

  bool? hasCallback;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    hasCallback = Get.arguments;
    await fetchAddresses();
    isLoading.value = false;
  }

  Future<void> fetchAddresses() async {
    final response = await addressRepository.getList();
    if (response != null) {
      addresses.value = response.results;
    }
  }
}
