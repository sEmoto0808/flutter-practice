import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/controller/MyController.dart';
import 'package:flutter_app_original_sample/entity/item.dart';
import 'package:get/get.dart';

class FirstTabPage extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    Get.put(MyController());
    return NotificationListener(
      onNotification: (scrollNotification) {
        if (controller.page == 1) {
          return true;
        }
        if (scrollNotification is ScrollEndNotification) {
          final scrollProportion = scrollNotification.metrics.pixels /
              scrollNotification.metrics.maxScrollExtent;

          if (scrollProportion >= 1.0) {
            controller.requestHttp();
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Obx(
          () => Scaffold(
            body: _myListView(context, controller.list),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    controller.refresh();
  }
}

Widget _myListView(BuildContext context, List<Item> items) {
  return ListView.separated(
    separatorBuilder: (BuildContext context, int index) => Divider(
      color: Colors.blueGrey,
    ),
    itemCount: items.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: Icon(Icons.flutter_dash),
        title: Text('No.$index: ' + items[index].title),
        onTap: () async {
          var result = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return _alertDialog(
                context,
                index,
                items[index].title,
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
              return _simpleDialog(
                context,
                index,
                items[index].title,
              );
            },
            barrierDismissible: false,
          );
          print(result);
        },
      );
    },
  );
}

/// AlertDialog アラートダイアログ
Widget _alertDialog(BuildContext context, int index, String content) {
  return AlertDialog(
    title: Text('No.$index'),
    content: Text(content),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop('Cancel: ' + content),
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop('OK: ' + content),
        child: Text('OK'),
      ),
    ],
  );
}

/// SimpleDialog シンプルダイアログ: 単一選択のダイアログ
Widget _simpleDialog(BuildContext context, int index, String title) {
  return SimpleDialog(
    title: Text('No.$index: ' + title),
    children: [
      SimpleDialogOption(
        onPressed: () => Navigator.of(context).pop('select Option1'),
        child: Text('Option1'),
      ),
      SimpleDialogOption(
        onPressed: () => Navigator.of(context).pop('select Option2'),
        child: Text('Option2'),
      ),
      SimpleDialogOption(
        onPressed: () => Navigator.of(context).pop('select Option3'),
        child: Text('Option3'),
      ),
    ],
  );
}
