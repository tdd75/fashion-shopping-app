import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    final productVariant = cartItem.productVariant;
    final product = productVariant.product!;

    return ListTile(
      leading: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.network(product.image, height: 56),
        ],
      ),
      title: BaseText(
        product.name,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Wrap(
        direction: Axis.vertical,
        spacing: 4,
        children: [
          Text('${productVariant.color} - ${productVariant.size}'),
          BaseCurrencyText(productVariant.price, fontSize: 14),
        ],
      ),
      trailing: BaseText('x ${cartItem.quantity}'),
    );
  }
}
