
import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/data/MyRepository.dart';
import 'package:flutter_app_original_sample/widget/MyListView.dart';

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

  MyRepository repository = MyRepository();

  void _requestHttp() async {

    // Qiita APIにHTTPリクエストを送る（GET）
    final params = {
      'page': '$page',
      'per_page': '20'
    };

    var items = await repository.getItems('/api/v2/items', params);

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
