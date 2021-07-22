
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
        onPressed: () => controller.requestHttp(),
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
      return NotificationListener(
        onNotification: (scrollNotification) {
          if (controller.page == 1) {
            return true;
          }
          if (scrollNotification is ScrollEndNotification) {
            final scrollProportion =
                scrollNotification.metrics.pixels / scrollNotification.metrics.maxScrollExtent;

            if (scrollProportion >= 1.0) {
              controller.requestHttp();
            }
          }
          return false;
        },
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Obx(() => Scaffold(
              body: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.blueGrey,),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.flutter_dash),
                    title: Text('No.$index: ' + controller.list[index].title),
                    onTap: () async {
                      var result = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('No.$index'),
                              content: Text(controller.list[index].title),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.of(context).pop('Cancel: ' + controller.list[index].title),
                                    child: Text('Cancel')
                                ),
                                TextButton(
                                    onPressed: () => Navigator.of(context).pop('OK: ' + controller.list[index].title),
                                    child: Text('OK')
                                )
                              ],
                            );
                          },
                        barrierDismissible: false,
                      );
                      print(result);
                    },
                    onLongPress: () async {
                      var result = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: Text('No.$index: ' + controller.list[index].title),
                            children: [
                              SimpleDialogOption(
                                  onPressed: () => Navigator.of(context).pop('select Option1'),
                                  child: Text('Option1')
                              ),
                              SimpleDialogOption(
                                  onPressed: () => Navigator.of(context).pop('select Option2'),
                                  child: Text('Option2')
                              ),
                              SimpleDialogOption(
                                  onPressed: () => Navigator.of(context).pop('select Option3'),
                                  child: Text('Option3')
                              )
                            ],
                          );
                        },
                        barrierDismissible: false,
                      );
                      print(result);
                    },
                  );
                },
                itemCount: controller.list.length,
              ),
            )
            ),
          )
      );
    } else if(tab.text == 'Two') {
      return Center(
        child: TextButton(
          child: Text('Next Page'),
          style: TextButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () => controller.navigateToNextPage(),
        ),
      );
    } else {
      return Center(
        child: Text(
          tab.text!,
          style: TextStyle(fontSize: 22),
        ),
      );
    }
  }

  Future<void> _onRefresh() async {
    controller.refresh();
  }
}
