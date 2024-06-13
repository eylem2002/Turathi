import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/core/models/notification_model.dart';
import 'package:turathi/view/view_layer.dart';

//user home page includes popular places,events,notifications and, actions such as:adding place,navigate through the app
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EventList? eventsList;
  NotificationList? notificationList;
  UserService userService = UserService();
  String _greeting = '';

  @override
  void initState() {
    super.initState();
    _setGreeting();
  }

  void _setGreeting() {
    DateTime now = DateTime.now();
    if (now.hour < 12) {
      setState(() {
        _greeting = 'Good Morning';
      });
    } else if (now.hour < 18) {
      setState(() {
        _greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        _greeting = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String containerHeader = "Share Your Favourite Place With Us";
    String popularPlaces = 'Popular Places';
    String event = 'Events';
    String seeAll = 'See All';
    String noEventsCase = 'No Events are available';
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    NotificationProvider notificationProvider =
        Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.042,
        actions: <Widget>[
          IconButton(
            key: Key("Notification"),
            icon: FutureBuilder(
              future: notificationProvider.notificationList,
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (data == null) {
                  return Icon(Icons.notifications_none_outlined,
                      color: ThemeManager.primary);
                }
                ;
                notificationList = data;
                return Icon(
                  notificationList!.notifications.where((element) => element.isRead==false).length == 0
                      ? Icons.notifications_none_outlined
                      : Icons.notifications_active,
                  color: ThemeManager.primary,
                );
              },
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(notificationPage);
            },
            iconSize: LayoutManager.widthNHeight0(context, 0) * 0.034,
          ),
          SizedBox(width: LayoutManager.widthNHeight0(context, 0) * 0.015),
        ],
      ),
      body: Container(
        color: ThemeManager.background,
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${sharedUser.name} !".toUpperCase(),
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.03,
                ),
              ),
              Text(
                _greeting,
                style: TextStyle(
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.02,
                  letterSpacing: 4.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.026,
              ),
              Container(
                height: LayoutManager.widthNHeight0(context, 1) * 0.15,
                width: LayoutManager.widthNHeight0(context, 0),
                decoration: BoxDecoration(
                  color: ThemeManager.second,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      containerHeader,
                      style: TextStyle(
                          fontFamily: ThemeManager.fontFamily,
                          color: ThemeManager.primary,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              LayoutManager.widthNHeight0(context, 0) * 0.017),
                    ),
                    AddButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(addNewPlaceRoute);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 0) * 0.014,
              ),
              Text(
                popularPlaces,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: ThemeManager.fontFamily,
                  color: ThemeManager.primary,
                  fontSize: LayoutManager.widthNHeight0(context, 0) * 0.015,
                ),
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.018,
              ),
              ImageSliderWidget(),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: ThemeManager.fontFamily,
                      color: ThemeManager.primary,
                      fontSize:
                          LayoutManager.widthNHeight0(context, 0) * 0.0165,
                      shadows: const [],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //nav to all events
                      Navigator.of(context).pushNamed(eventsRoute,
                          arguments: eventsList!.events);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right:
                              LayoutManager.widthNHeight0(context, 1) * 0.02),
                      child: Text(
                        seeAll,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: ThemeManager.fontFamily,
                          color: ThemeManager.primary,
                          fontSize:
                              LayoutManager.widthNHeight0(context, 0) * 0.0165,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: LayoutManager.widthNHeight0(context, 1) * 0.03,
              ),
              FutureBuilder(
                future: eventProvider.twoEventsList,
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (data == null) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: ThemeManager.primary,
                      color: ThemeManager.second,
                    ));
                  }
                  eventsList = data;

                  if (data.events.isNotEmpty) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ViewEvent(
                              eventModel: eventsList!.events[0],
                              flag: false,
                            ),
                            SizedBox(
                              height: LayoutManager.widthNHeight0(context, 1) *
                                  0.04,
                            ),
                            ViewEvent(
                              eventModel: eventsList!.events[1], //change 1 to 0
                              flag: false,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: LayoutManager.widthNHeight0(context, 1) * 0.2),
                      child: Center(
                        child: Text(
                          noEventsCase,
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
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
