
import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/controller/NextPageAppBarCustomController.dart';
import 'package:get/get.dart';

class NextPageAppBarCustom extends StatelessWidget {

  final _controller = Get.put(NextPageAppBarCustomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: Column(
        children: [
          Spacer(flex: 4,),
          Text(
              'Tap Count',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
          ),
          Spacer(flex: 1,),
          Center(
            child: Obx(
                  () => Text(
                '${_controller.tapCount}',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Spacer(flex: 3,),
          Text(
              'Search Text',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
          ),
          Spacer(flex: 1,),
          Center(
            child: Obx(
                  () => Text(
                '${_controller.searchText}',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Spacer(flex: 4,),
        ],
      )
    );
  }

  AppBar _createAppBar() => AppBar(
    title: Container(
      height: 44,
      child: TextField(
        onChanged: (text) {
          _controller.changeSearchText(text);
        },
        decoration: InputDecoration(
          hintText: 'Customise AppBar',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(top: 4, left: 8, bottom: 4, right: 8),
        ),
      ),
    ),
    actions: [
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _controller.increment();
          }
      ),
      IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            _controller.decrement();
          }
      ),
    ],
  );
}
