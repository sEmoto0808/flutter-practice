
import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/page/NextPage.dart';
import 'package:get/get.dart';

class MyRootNavigator {

  void toNextPage(BuildContext context) {
    // Navigatorで画面遷移（基本）
    // Route Mapで画面遷移（基本）
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextPage())
    );
  }

  void toNextPageByGetPackage() {
    Get.to(NextPage());
  }
}