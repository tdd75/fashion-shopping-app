import 'package:fashion_shopping_app/modules/home/bloc/cubit/product_cubit.dart';
import 'package:fashion_shopping_app/modules/home/bloc/state/product_state.dart';
import 'package:fashion_shopping_app/modules/home/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProductCubit>().fetchProductList();
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemBuilder: (context, index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductItem(
                product: state.productList[2 * index],
              ),
              ProductItem(
                product: state.productList[2 * index + 1],
              ),
            ],
          ),
          itemCount: (state.productList.length / 2).floor(),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }
}
