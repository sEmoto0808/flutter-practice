import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _requestHttp() async {

    // Qiita APIにHTTPリクエストを送る（GET）
    final params = {
      'page': '1',
      'per_page': '20'
    };
    final uri = Uri.https('qiita.com', '/api/v2/items', params);
    http.Response response = await http.get(uri);

    String body = response.body;
    int statusCode = response.statusCode;

    List<dynamic> itemMap = jsonDecode(body);
    var item = Item.fromJson(itemMap[0]);

    debugPrint('======================');
    print('body: $item');
    debugPrint('statusCode: $statusCode');
    debugPrint('======================');

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _requestHttp,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
