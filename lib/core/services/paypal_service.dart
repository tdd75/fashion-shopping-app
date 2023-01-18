import 'package:fashion_shopping_app/core/helpers/notify.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter_paypal_native/flutter_paypal_native.dart';
import 'package:flutter_paypal_native/models/environment.dart';
import 'package:flutter_paypal_native/models/currency_code.dart';
import 'package:flutter_paypal_native/models/user_action.dart';
import 'package:flutter_paypal_native/models/order_callback.dart';


class PaypalService extends GetxService {
  final _flutterPaypalNativePlugin = FlutterPaypalNative.instance;

  Future<FlutterPaypalNative> init() async {
    initPayPal();
    return _flutterPaypalNativePlugin;
  }

  void initPayPal() async {
    FlutterPaypalNative.isDebugMode = true;

    await _flutterPaypalNativePlugin.init(
      returnUrl: dotenv.get('PAYPAL_RETURN_URL'),
      clientID: dotenv.get('PAYPAL_CLIENT_ID'),
      payPalEnvironment: FPayPalEnvironment.sandbox,
      currencyCode: FPayPalCurrencyCode.usd,
      action: FPayPalUserAction.payNow,
    );

    _flutterPaypalNativePlugin.setPayPalOrderCallback(
      callback: FPayPalOrderCallback(
        onCancel: () {
          Notify.info('Order cancelled');
        },
        onSuccess: (data) {
          _flutterPaypalNativePlugin.removeAllPurchaseItems();
          String orderID = data.orderId ?? "";
          Notify.success('Order successful $orderID');
        },
        onError: (data) {
          Notify.error(data.reason);
        },
        onShippingChange: (data) {
          Notify.warning(
            data.shippingAddress?.addressLine1 ?? "",
            title: 'Shipping change',
          );
        },
      ),
    );
  }
}
