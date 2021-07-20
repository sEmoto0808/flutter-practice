
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NextPage'),
      ),
      body: Center(
        child: Text(
          '画面遷移',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
