import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:fashion_shopping_app/core/api/client.dart';
import 'package:fashion_shopping_app/core/api/http_exception.dart';
import 'package:fashion_shopping_app/modules/home/data/model/product.dart';

class ProductRepository {
  final baseUrl = '${dotenv.get("DOMAIN")}/products';

  Future<List<Product>> getList() async {
    try {
      final response = await Client.instance.get('$baseUrl/');
      Product.fromJson(response.data['results'][0]);
      return response.data['results']
          .map<Product>((res) => Product.fromJson(res))
          .toList();
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    }
  }
}
