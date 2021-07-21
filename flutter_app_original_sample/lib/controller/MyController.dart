
import 'package:flutter_app_original_sample/data/MyRepository.dart';
import 'package:flutter_app_original_sample/entity/item.dart';
import 'package:flutter_app_original_sample/navigator/MyRootNavigator.dart';
import 'package:get/get.dart';

class MyController extends GetxController {

  // State
  var page = 1;
  var list = <Item>[].obs;

  final _repository = MyRepository();
  final _navigator = MyRootNavigator();

  // Logic
  void requestHttp() async {
    // Qiita APIにHTTPリクエストを送る（GET）
    final params = {
      'page': '$page',
      'per_page': '20'
    };

    var items = await _repository.getItems('/api/v2/items', params);

    list.addAll(items);
    page++;
  }

  void refresh() async {
    page = 1;
    final params = {
      'page': '$page',
      'per_page': '20'
    };

    var items = await _repository.getItems('/api/v2/items', params);

    var listLength = list.length;
    if (listLength > 0) {
      list.removeRange(0, listLength - 1);
    }

    list.addAll(items);
    page++;
  }

  void navigateToNextPage() {
    _navigator.toNextPageByGetPackage();
  }
}