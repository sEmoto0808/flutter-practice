
import 'package:get/get.dart';

class NextPageAppBarCustomController extends GetxController {

  var tapCount = 0.obs;
  var searchText = ''.obs;

  void increment() => tapCount++;

  void decrement() => tapCount--;

  void changeSearchText(String text) {
    searchText.value = text;
  }
}