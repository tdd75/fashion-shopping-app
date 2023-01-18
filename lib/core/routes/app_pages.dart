import 'package:fashion_shopping_app/modules/account_tab/account_binding.dart';
import 'package:fashion_shopping_app/modules/auth/auth_binding.dart';
import 'package:fashion_shopping_app/modules/auth/auth_screen.dart';
import 'package:fashion_shopping_app/modules/auth/login_screen.dart';
import 'package:fashion_shopping_app/modules/auth/register_screen.dart';
import 'package:fashion_shopping_app/modules/cart/cart_binding.dart';
import 'package:fashion_shopping_app/modules/cart/cart_screen.dart';
import 'package:fashion_shopping_app/modules/home_tab/home_binding.dart';
import 'package:fashion_shopping_app/modules/inbox_tab/inbox_binding.dart';
import 'package:fashion_shopping_app/modules/layout/layout_binding.dart';
import 'package:fashion_shopping_app/modules/layout/layout_screen.dart';
import 'package:fashion_shopping_app/modules/product_detail/product_detail_binding.dart';
import 'package:fashion_shopping_app/modules/product_detail/product_detail_screen.dart';
import 'package:fashion_shopping_app/modules/splash/splash_binding.dart';
import 'package:fashion_shopping_app/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

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
        GetPage(name: Routes.register, page: () => RegisterScreen()),
        GetPage(name: Routes.login, page: () => LoginScreen()),
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
  ];
}
