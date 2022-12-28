import 'package:fashion_shopping_app/modules/home/data/model/product.dart';
import 'package:fashion_shopping_app/modules/home/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_shopping_app/core/api/http_response.dart';
import 'package:fashion_shopping_app/modules/home/bloc/state/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({
    required this.productRepository,
  }) : super(ProductState());

  void updateState({
    List<Product>? productList,
  }) {
    emit(state.copyWith(productList: productList));
  }

  Future<HttpResponse<List<Product>>> fetchProductList() async {
    try {
      final productListData = await productRepository.getList();
      emit(state.copyWith(productList: productListData));
      return HttpResponse(data: productListData);
    } catch (error) {
      return HttpResponse(error: error.toString());
    }
  }
}
