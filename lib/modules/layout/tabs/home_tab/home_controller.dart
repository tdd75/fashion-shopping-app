import 'package:fashion_shopping_app/core/models/common/query_request.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProductRepository productRepository;

  HomeController({required this.productRepository});

  var isLoading = false.obs;
  var products = Rx<List<ProductShort>>([]);
  var query = Rx<QueryRequest>(QueryRequest());
  final searchController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    await fetchProducts();
    isLoading.value = false;
  }

  Future<void> fetchProducts() async {
    final response = await productRepository.getList(params: query.value.toMap());
    if (response != null) {
      products.value = response.results;
    }
  }
}
