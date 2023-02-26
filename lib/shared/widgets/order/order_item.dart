import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/models/response/product_variant.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderItemCard extends StatelessWidget {
  final CartItem cartItem;
  final bool onlyContent;
  final bool isShort;

  const OrderItemCard({
    super.key,
    required this.cartItem,
    this.onlyContent = false,
    this.isShort = false,
  });

  ProductVariant get productVariant => cartItem.productVariant;
  ProductShort get product => productVariant.product!;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.productDetail,
        arguments: product.id,
      ),
      child: Container(
          padding: EdgeInsets.all(onlyContent ? 0 : 8),
          height: 80,
          width: 288,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border:
                onlyContent ? null : Border.all(color: ColorConstants.darkGray),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  height: double.infinity,
                  child: Image.network(product.image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText(
                      product.name,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            const SizedBox(height: 4),
                            BaseText(
                              'Color: ${productVariant.color}',
                              color: Colors.grey,
                            ),
                            BaseText(
                              'Size: ${productVariant.size}',
                              color: Colors.grey,
                            ),
                            if (!isShort)
                              BaseText(
                                'Quantity: ${cartItem.quantity}',
                                color: Colors.grey,
                              ),
                          ],
                        ),
                        BaseCurrencyText(
                          productVariant.price,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}


// ListTile(

//         style: ListTileStyle.drawer,
//         leading: Image.network(
//           product.image,
//           fit: BoxFit.fitHeight,
//         ),
//         title: BaseText(product.name, fontSize: 16),
//         subtitle: Wrap(
//           direction: Axis.vertical,
//           children: [
//             BaseText(
//               'Color: ${productVariant.color}',
//               color: Colors.grey,
//             ),
//             BaseText(
//               'Size: ${productVariant.size}',
//               color: Colors.grey,
//             ),
//             BaseText(
//               'Quantity: ${cartItem.quantity}',
//               color: Colors.grey,
//             ),
//           ],
//         ),
//         trailing: Wrap(
//           crossAxisAlignment: WrapCrossAlignment.end,
//           direction: Axis.vertical,
//           spacing: 8,
//           children: [
//             BaseCurrencyText(
//               productVariant.price,
//               color: ColorConstants.black,
//               fontWeight: FontWeight.w400,
//               fontSize: 14,
//             ),
//           ],
//         ),
//       ),