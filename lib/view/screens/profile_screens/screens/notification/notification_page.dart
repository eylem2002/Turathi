import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//page to view user the notification such as new place added, admin response
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String appBarText='Notification ';
    NotificationList? notificationList;
    NotificationProvider notificationProvider = Provider.of<NotificationProvider>(context);
    notificationProvider.updateUserNotifications();
    return Scaffold(

     backgroundColor: ThemeManager.background,
      appBar: AppBar(
        key: Key("Notifications page"),
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          appBarText,
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),

      ),
      body: FutureBuilder(
        future: notificationProvider.notificationList,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          notificationList = data;
          if(notificationList!.notifications.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: LayoutManager.widthNHeight0(context, 0),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            notificationList!.notifications[index].text ?? ""),
                        subtitle: Text(notificationList!
                                .notifications[index].date
                                ?.toString() ??
                            ""),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: notificationList!.notifications.length),
              ),
            );
          }
          else {
            return Center(
              child: Text(
                "No Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  shadows: const [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 0.01,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),

      );

  }
}
