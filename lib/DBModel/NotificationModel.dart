const String tableNotification = "Notification";

class Notification {
  static const String docEntry = "DocEntry";
  static const String title = "Title";
  static const String imgurl = "ImgUrl";
  static const String description = "Description";
  static const String receiveTime = "ReceiveTime";
  static const String seenTime = "SeenTime";
  static const String naviScn = "NavigateScreen";
}

class NotificationModel {
  int? id;
  int? docEntry;
  String? titile;
  String description;
  String receiveTime;
  String seenTime;
  String imgUrl;
  String naviScn;

  NotificationModel(
      {this.id,
      this.docEntry,
      required this.titile,
      required this.description,
      required this.receiveTime,
      required this.seenTime,
      required this.imgUrl,
      required this.naviScn});

  Map<String, Object?> toMap() => {
        Notification.title: titile,
        Notification.description: description,
        Notification.receiveTime: receiveTime,
        Notification.seenTime: seenTime,
        Notification.docEntry: docEntry,
        Notification.imgurl: imgUrl,
        Notification.naviScn: naviScn
      };
}
