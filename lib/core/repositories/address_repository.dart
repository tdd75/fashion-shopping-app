import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/address_create.dart';
import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:get/get.dart';

class AddressRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<Address>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {...params};
    final res =
        await apiProvider.get('/addresses/', query: QueryString.convert(query));
    return res.status.isOk
        ? ListResponse<Address>.fromMap(res.body, Address.fromMap)
        : null;
  }

  Future<Address?> get(int id) async {
    final res = await apiProvider.get('/addresses/$id/');
    return res.status.isOk ? Address.fromMap(res.body) : null;
  }

  Future<bool> create(AddressCreate data) async {
    final res = await apiProvider.post('/addresses/', data.toJson());
    return res.status.isOk;
  }

  Future<bool> update(int id, AddressCreate data) async {
    final res = await apiProvider.patch('/addresses/$id/', data.toJson());
    return res.status.isOk;
  }

  Future<bool> delete(int id) async {
    final res = await apiProvider.delete('/addresses/$id/');
    return res.status.isOk;
  }
}
