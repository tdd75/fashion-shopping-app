import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_filter.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final ProductRepository productRepository;

  HomeController({required this.productRepository});

  var isLoading = false.obs;
  final products = Rx<List<ProductShort>>([]);
  final filter = Rxn<ProductFilter>();
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  final initQuery = const <String, dynamic>{
    'limit': 10,
    'offset': 0,
  };

  var query = RxMap<String, dynamic>();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    query.addAll(initQuery);
    scrollController.addListener(_triggerloadMore);
    await fetchProducts();
    isLoading.value = false;
  }

  @override
  void onClose() {
    scrollController.removeListener(_triggerloadMore);
    super.onClose();
  }

  void resetQuery() {
    query = RxMap<String, dynamic>.from(initQuery);
  }

  Future<void> _triggerloadMore() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      query['offset'] = query['offset'] + query['limit'];
      await fetchProducts(append: true);
    }
  }

  Future<void> fetchProducts({bool append = false}) async {
    final response = await productRepository.getList(params: query);
    if (response != null) {
      if (append) {
        products.value.addAll(response.results);
      } else {
        products.value = response.results;
      }
      products.refresh();
    }
  }

  Future<void> searchByImage(XFile imageFile) async {
    final data = await imageFile.readAsBytes();
    final encodedData = base64Encode(data);
    final response = await productRepository.searchByImage(encodedData);

    if (response != null) {
      products.value = response.results;
      products.refresh();
    }
  }

  Future<void> refreshProducts() async {
    final response = await productRepository.getList(params: query);
    if (response != null) {
      products.value = response.results;
    }
  }

  Future<void> getFilter() async {
    final response = await productRepository.getFilter();
    if (response != null) {
      filter.value = response;
    }
  }
}
