import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/controller/MyController.dart';
import 'package:flutter_app_original_sample/page/tab/FirstTabPage.dart';
import 'package:get/get.dart';

class MyRootPage extends StatefulWidget {
  MyRootPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyRootPageState createState() => _MyRootPageState();
}

class _MyRootPageState extends State<MyRootPage>
    with SingleTickerProviderStateMixin {
  // DI
  final controller = Get.put(MyController());

  final List<Tab> _tabs = <Tab>[
    Tab(
      text: 'One',
    ),
    Tab(
      text: "Two",
    ),
    Tab(
      text: "Three",
    ),
    Tab(
      text: "Four",
    )
  ];

  late TabController _tabController;

  final _bottomNavigationItems = [
    BottomNavigationBarItem(label: 'One', icon: Icon(Icons.list_alt)),
    BottomNavigationBarItem(label: 'Two', icon: Icon(Icons.favorite)),
    BottomNavigationBarItem(label: 'Three', icon: Icon(Icons.add_a_photo)),
    BottomNavigationBarItem(label: 'Four', icon: Icon(Icons.message)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map(
          (tab) {
            return _createTab(tab);
          },
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.requestHttp(),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        currentIndex: 0,
        items: _bottomNavigationItems,
      ),
    );
  }

  Widget _createTab(Tab tab) {
    if (tab.text == 'One') {
      return FirstTabPage();
    } else if (tab.text == 'Two') {
      return Center(
        child: TextButton(
          child: Text('Next Page'),
          style: TextButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () => controller.navigateToNextPage(),
        ),
      );
    } else if (tab.text == 'Three') {
      return _thirdPage();
    } else {
      return Center(
        child: TextButton(
          child: Text('Next Page AppBar Custom'),
          style: TextButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () => controller.navigateToNextPageAppBarCustom(),
        ),
      );
    }
  }

  Widget _practiceFutureBuilder(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _getFutureValue(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.hasData) {
            return Text(snapshot.data!);
          } else {
            return Text('データが存在しません');
          }
        },
      ),
    );
  }

  Future<String> _getFutureValue() async {
    await Future.delayed(
      Duration(seconds: 1),
    );

    final isFailed = Random().nextBool();

    if (isFailed) {
      try {
        throw Exception('データの取得に失敗しました。');
      } catch (error) {
        return Future.error(error);
      }
    } else {
      return Future.value('データの取得に成功しました。');
    }
  }
}

/// ScrollViewと画像
Widget _thirdPage() {
  return SingleChildScrollView(
    child: Column(
      children: [
        Image.asset('assets/images/apple.png'),
        FadeInImage.assetNetwork(
          placeholder: 'assets/images/placeholder.png',
          image:
              'https://1.bp.blogspot.com/-ZOg0qAG4ewU/Xub_uw6q0DI/AAAAAAABZio/MshyuVBpHUgaOKJtL47LmVkCf5Vge6MQQCNcBGAsYHQ/s1600/pose_pien_uruuru_woman.png',
        ),
      ],
    ),
  );
}
