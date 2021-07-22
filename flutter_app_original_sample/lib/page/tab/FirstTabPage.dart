
import 'package:flutter/material.dart';
import 'package:flutter_app_original_sample/controller/MyController.dart';
import 'package:get/get.dart';

class FirstTabPage extends StatelessWidget {

  final controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
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
  }

  Future<void> _onRefresh() async {
    controller.refresh();
  }

}
