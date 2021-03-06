
import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/page/MyRootPage.dart';
import 'package:get/get.dart';

void main() {
  runApp(
      GetMaterialApp(
        home: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyRootPage(title: 'Flutter Demo Home Page'),
    );
  }
}
