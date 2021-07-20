
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextPage extends StatelessWidget {

  final arguments = Get.arguments as Map<String, String>?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NextPage'),
      ),
      body: Center(
        child: Text(
          "${arguments!['arg1']}",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
