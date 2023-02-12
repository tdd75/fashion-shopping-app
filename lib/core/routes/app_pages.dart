import 'package:fashion_shopping_app/modules/checkout/checkout_binding.dart';
import 'package:fashion_shopping_app/modules/checkout/checkout_screen.dart';
import 'package:fashion_shopping_app/modules/checkout/select_ticket_screen.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/update_information.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/favorite_tab/favorite_binding.dart';
import 'package:fashion_shopping_app/modules/order/order_binding.dart';
import 'package:fashion_shopping_app/modules/order/order_screen.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/modules/address/address_binding.dart';
import 'package:fashion_shopping_app/modules/address/address_screen.dart';
import 'package:fashion_shopping_app/modules/address_detail/address_detail_binding.dart';
import 'package:fashion_shopping_app/modules/address_detail/address_detail_screen.dart';
import 'package:fashion_shopping_app/modules/discount_ticket/discount_ticket_binding.dart';
import 'package:fashion_shopping_app/modules/discount_ticket/discount_ticket_screen.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_binding.dart';
import 'package:fashion_shopping_app/modules/auth/auth_binding.dart';
import 'package:fashion_shopping_app/modules/auth/auth_screen.dart';
import 'package:fashion_shopping_app/modules/auth/login_screen.dart';
import 'package:fashion_shopping_app/modules/auth/register_screen.dart';
import 'package:fashion_shopping_app/modules/cart/cart_binding.dart';
import 'package:fashion_shopping_app/modules/cart/cart_screen.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/home_tab/home_binding.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/inbox_tab/inbox_binding.dart';
import 'package:fashion_shopping_app/modules/layout/layout_binding.dart';
import 'package:fashion_shopping_app/modules/layout/layout_screen.dart';
import 'package:fashion_shopping_app/modules/order_detail/order_detail_binding.dart';
import 'package:fashion_shopping_app/modules/order_detail/order_detail_screen.dart';
import 'package:fashion_shopping_app/modules/product_detail/product_detail_binding.dart';
import 'package:fashion_shopping_app/modules/product_detail/product_detail_screen.dart';
import 'package:fashion_shopping_app/modules/splash/splash_binding.dart';
import 'package:fashion_shopping_app/modules/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.auth,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(name: Routes.register, page: () => const RegisterScreen()),
        GetPage(name: Routes.login, page: () => const LoginScreen()),
      ],
    ),
    GetPage(
      name: Routes.layout,
      page: () => const LayoutScreen(),
      bindings: [
        LayoutBinding(),
        HomeBinding(),
        InboxBinding(),
        AccountBinding(),
        FavoriteBinding(),
        CartBinding(),
      ],
    ),
    GetPage(
      name: Routes.productDetail,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.address,
      page: () => const AddressScreen(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.addressDetail,
      page: () => const AddressDetailScreen(),
      binding: AddressDetailBinding(),
    ),
    GetPage(
      name: Routes.discountTicket,
      page: () => const DiscountTicketScreen(),
      binding: DiscountTicketBinding(),
    ),
    GetPage(
      name: Routes.order,
      page: () => const OrderScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.orderDetail,
      page: () => const OrderDetailScreen(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: Routes.checkout,
      page: () => const CheckoutScreen(),
      binding: CheckoutBinding(),
      children: [
        GetPage(
          name: Routes.selectTicket,
          page: () => const SelectTicketScreen(),
        ),
      ],
    ),
    GetPage(
      name: Routes.info,
      page: () => const UpdateInformation(),
      binding: AccountBinding(),
    ),
  ];
}
