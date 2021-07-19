
import 'package:flutter_app_original_sample/data/MyRepository.dart';
import 'package:flutter_app_original_sample/entity/item.dart';
import 'package:get/get.dart';

class MyController extends GetxController {

  // State
  var page = 1;
  var list = <Item>[].obs;

  final repository = MyRepository();

  // Logic
  void requestHttp() async {
    // Qiita APIにHTTPリクエストを送る（GET）
    final params = {
      'page': '$page',
      'per_page': '20'
    };

    var items = await repository.getItems('/api/v2/items', params);

    list.addAll(items);
    page++;
  }
}