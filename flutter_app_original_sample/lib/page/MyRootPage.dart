
import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/controller/MyController.dart';
import 'package:get/get.dart';

class MyRootPage extends StatefulWidget {
  MyRootPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyRootPageState createState() => _MyRootPageState();
}

class _MyRootPageState extends State<MyRootPage> with SingleTickerProviderStateMixin {

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
        children: _tabs.map((tab) {
          return _createTab(tab);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.navigateToNextPage(),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        currentIndex: 0,
        items: _bottomNavigationItems,
      )
    );
  }

  Widget _createTab(Tab tab) {
    if (tab.text == 'One') {
      return Center(
          child: Obx(() => Scaffold(
                body: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Text(controller.list[index].title);
                  },
                  itemCount: controller.list.length,
                ),
              )));
    } else {
      return Center(
        child: Text(
          tab.text!,
          style: TextStyle(fontSize: 22),
        ),
      );
    }
  }
}
