import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Constant/Configuration.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../DB Helper/DBOperation.dart';
import '../../../DB Helper/DBhelper.dart';
import '../../../DBModel/NotificationModel.dart';

class TabNotification extends StatefulWidget {
  const TabNotification({super.key});

  @override
  State<TabNotification> createState() => _TabNotificationState();
}

class _TabNotificationState extends State<TabNotification> {
  List<NotificationModel> notify = [];
  List<NotificationModel> get getnotify => notify;

  List<NotificationModel> notifyreverse = [];
  getNotification() async {
    final Database db = (await DBHelper.getInstance())!;
    notifyreverse = await DBOperation.getNotification(db);
    notify = notifyreverse.reversed.toList();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getNotification();
    });
  }

  Configure config = Configure();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(
        Screens.padingHeight(context) * 0.02,
      ),
      width: Screens.width(context) * 1,
      height: Screens.padingHeight(context) * 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: notify.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      config.showDialogBox(notify[index].titile!,
                          notify[index].description, context);
                    },
                    child: Card(
                        child: Container(
                      //  color: Colors.red,
                      width: Screens.width(context),
                      // padding: EdgeInsets.symmetric(
                      //     vertical: Screens.padingHeight(context) * 0.01,
                      //     horizontal: Screens.width(context) * 0.01),

                      margin: EdgeInsets.symmetric(
                        vertical: Screens.padingHeight(context) * 0.005,
                      ),

                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Screens.padingHeight(context) * 0.01,
                            horizontal: Screens.width(context) * 0.02),
                        child: Column(children: [
                          SizedBox(
                            width: Screens.width(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.65,
                                  child: Text(
                                    "${getnotify[index].titile}",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.25,
                                  child: Text(
                                    config.alignDate(
                                        getnotify[index].receiveTime),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.02,
                          ),
                          SizedBox(
                            width: Screens.width(context),
                            child: Text(
                              getnotify[index].description,
                              maxLines: 1,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          getnotify[index].imgUrl == 'null'
                              ? Container()
                              : SizedBox(
                                  width: Screens.width(context),
                                  height: Screens.padingHeight(context) * 0.2,
                                  child: Center(
                                      child: Image(
                                          image: NetworkImage(
                                              getnotify[index].imgUrl),
                                          fit: BoxFit.cover)),
                                ),
                        ]),
                      ),
                    )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
