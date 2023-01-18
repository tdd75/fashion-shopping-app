import 'package:fashion_shopping_app/core/models/request/query_request.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProductRepository productRepository;

  HomeController({required this.productRepository});

  var products = Rxn<List<Product>>();
  var query = Rx<QueryRequest>(QueryRequest());
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    fetchProducts();
  }

  Future<void> fetchProducts() async {
    var response = await productRepository.getList(query.value.toMap());
    if (response != null) {
      products.value = response.results;
      products.refresh();
    }
  }
}
