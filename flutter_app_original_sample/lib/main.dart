import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/widget/MyListView.dart';
import 'package:http/http.dart' as http;

import 'entity/item.dart';

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
  int page = 1;
  List<Item> list = [];

  Future<void> _requestHttp() async {

    // Qiita APIにHTTPリクエストを送る（GET）
    final params = {
      'page': '$page',
      'per_page': '20'
    };
    final uri = Uri.https('qiita.com', '/api/v2/items', params);
    http.Response response = await http.get(uri);

    String body = response.body;
    int statusCode = response.statusCode;

    List<dynamic> itemMap = jsonDecode(body);
    var items = itemMap.map((i) => Item.fromJson(i)).toList();
    var item = items[0];

    debugPrint('======================');
    print('body: $item');
    debugPrint('statusCode: $statusCode');
    debugPrint('======================');

    setState(() {
      list.addAll(items);
      page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: MyListView(list: list,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _requestHttp,
        child: Icon(Icons.add),
      ),
    );
  }
}
