import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/core/models/request/review_create.dart';
import 'package:fashion_shopping_app/core/models/response/review.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:get/get.dart';

class ReviewRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<Review>?> getList(int productId,
      {Map<String, dynamic> params = const {}}) async {
    final query = {
      'expand': 'owner,variant',
      'product': productId,
      ...params,
    };
    final res =
        await apiProvider.get('/reviews/', query: QueryString.convert(query));
    return res.status.isOk
        ? ListResponse<Review>.fromMap(res.body, Review.fromMap)
        : null;
  }

  Future<bool?> create(ReviewCreate data) async {
    final res = await apiProvider.post('/reviews/', data.toJson());
    return res.status.isOk;
  }
}
