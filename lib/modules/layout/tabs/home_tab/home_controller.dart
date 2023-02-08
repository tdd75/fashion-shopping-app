import 'package:fashion_shopping_app/core/models/common/query_param.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProductRepository productRepository;

  HomeController({required this.productRepository});

  var isLoading = false.obs;
  var products = Rx<List<ProductShort>>([]);
  var query = Rx<QueryParam>(QueryParam());
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        loadMore();
      }
    });
    await fetchProducts();
    isLoading.value = false;
  }

  Future<void> loadMore() async {
    query.value.offset = query.value.offset + query.value.limit;
    await fetchProducts();
  }

  Future<void> fetchProducts({bool reset = false}) async {
    final response =
        await productRepository.getList(params: query.value.toMap());
    if (response != null) {
      if (reset) {
        products.value = response.results;
      } else {
        products.value.addAll(response.results);
      }
      products.refresh();
    }
  }

  Future<void> refreshProducts() async {
    final response =
        await productRepository.getList(params: query.value.toMap());
    if (response != null) {
      products.value = response.results;
    }
  }
}
