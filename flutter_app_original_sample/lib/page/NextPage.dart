
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextPage extends StatelessWidget {

  final arguments = Get.arguments as String?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NextPage'),
      ),
      body: Center(
        child: Text(
          '$arguments',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
