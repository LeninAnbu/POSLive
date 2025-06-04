import 'package:flutter/material.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';
import '../../../Controller/DashBoardController/DashboardController.dart';

class Announcement extends StatefulWidget {
  Announcement({
    super.key,
    required this.theme,
    required this.dbWidth,
    required this.dbHeight,
  });
  double dbHeight;
  double dbWidth;

  ThemeData theme;

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(
        widget.dbHeight * 0.02,
      ),
      width: widget.dbWidth * 1,
      height: widget.dbHeight * 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: widget.dbHeight * 0.02),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Announcement",
                style: widget.theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.dbHeight * 0.02,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: context.watch<DashBoardController>().notify.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      config.showDialogBox(
                          context
                              .read<DashBoardController>()
                              .notify[index]
                              .titile!,
                          context
                              .read<DashBoardController>()
                              .notify[index]
                              .description,
                          context);
                    },
                    child: Card(
                        child: Container(
                      width: widget.dbWidth,
                      padding: EdgeInsets.symmetric(
                          vertical: widget.dbHeight * 0.01,
                          horizontal: widget.dbWidth * 0.01),
                      margin: EdgeInsets.symmetric(
                        vertical: widget.dbHeight * 0.005,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.dbHeight * 0.01,
                            horizontal: widget.dbWidth * 0.02),
                        child: Column(children: [
                          SizedBox(
                            width: widget.dbWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.dbWidth * 0.65,
                                  child: Text(
                                    "${context.watch<DashBoardController>().getnotify[index].titile}",
                                    style: widget.theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: widget.dbWidth * 0.25,
                                  child: Text(
                                    context
                                        .read<DashBoardController>()
                                        .config
                                        .alignDate(context
                                            .watch<DashBoardController>()
                                            .getnotify[index]
                                            .receiveTime),
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(
                                            fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widget.dbHeight * 0.02,
                          ),
                          SizedBox(
                            width: widget.dbWidth,
                            child: Text(
                              context
                                  .watch<DashBoardController>()
                                  .getnotify[index]
                                  .description,
                              maxLines: 1,
                              style: widget.theme.textTheme.bodyMedium
                                  ?.copyWith(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          context
                                      .watch<DashBoardController>()
                                      .getnotify[index]
                                      .imgUrl ==
                                  'null'
                              ? Container()
                              : SizedBox(
                                  width: widget.dbWidth,
                                  height: widget.dbHeight * 0.2,
                                  child: Center(
                                      child: Image(
                                          image: NetworkImage(context
                                              .watch<DashBoardController>()
                                              .getnotify[index]
                                              .imgUrl),
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
