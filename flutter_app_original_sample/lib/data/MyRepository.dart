
import 'package:flutter_app_original_sample/data/ApiClient.dart';
import 'package:flutter_app_original_sample/entity/item.dart';

class MyRepository {

  final _apiClient = ApiClient();

  Future<List<Item>> getItems(String path, Map<String, String> params) async {

    List<dynamic> response = await _apiClient.requestHttp(path, params);
    var items = response.map((i) => Item.fromJson(i)).toList();

    return items;
  }
}