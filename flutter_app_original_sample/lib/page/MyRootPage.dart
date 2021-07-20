
import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/controller/MyController.dart';
import 'package:flutter_app_original_sample/page/NextPage.dart';
import 'package:get/get.dart';

class MyRootPage extends StatelessWidget {
  MyRootPage({Key? key, required this.title}) : super(key: key);

  final String title;

  // DI
  final controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Obx(
            () => Scaffold(
              body: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Text(controller.list[index].title);
                },
                itemCount: controller.list.length,
              ),
            )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNextPage(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    // // Navigatorで画面遷移（基本）
    // // Route Mapで画面遷移（基本）
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => NextPage())
    // );

    Get.to(NextPage());
  }
}
