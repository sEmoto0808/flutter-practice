import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/entity/item.dart';

class MyListView extends StatefulWidget {
  MyListView({Key? key, required this.list}) : super(key: key);

  final List<Item> list;

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text(widget.list[index].title);
        },
        itemCount: widget.list.length,
      ),
    );
  }
}

class MyListView2 extends StatelessWidget {
  MyListView2({Key? key, required this.list}) : super(key: key);

  final List<Item> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text(list[index].title);
        },
        itemCount: list.length,
      ),
    );
  }
}
