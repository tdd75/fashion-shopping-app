import 'package:get/get.dart';

enum PaymentMethod {
  cod('COD'),
  paypal('PAYPAL');

  const PaymentMethod(this.value);
  final String value;

  static PaymentMethod? fromString(String? value) {
    return PaymentMethod.values
        .firstWhereOrNull((element) => element.value == value?.toUpperCase());
  }
}
