import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//main page to view the places with actions:change the location
class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _Location_PageState();
}

class _Location_PageState extends State<LocationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isTabControllerInitialized = false;
  int selectedDistance = 10;
  int currentTab = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    if (!isTabControllerInitialized) {
      if (mounted) {
        setState(() {
          isTabControllerInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.04,
      ),
      body: Container(
        color: ThemeManager.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(

                builder: (context) {
              if (currentTab == 0)

                return HeaderPart(tab: "Update user location");
              else //if (tabController.index == 1)
                return HeaderPart(tab: "Nearest Place");
            }),
            Container(
              height: LayoutManager.widthNHeight0(context, 1) * 0.1,
              width: LayoutManager.widthNHeight0(context, 1) * 0.2,
              decoration: BoxDecoration(
                color: ThemeManager.second,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 2,
                    offset: const Offset(-1, -1),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: ThemeManager.primary,
                  width: 1,
                ),
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedDistance,
                    icon: SizedBox.shrink(), // Hide the dropdown arrow
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedDistance = newValue!;
                      });
                    },
                    items: <int>[10, 20, 30, 40, 50]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value.toString(),
                              style: TextStyle(color: ThemeManager.primary),
                            ),
                            const SizedBox(width: 4),
                            Text("Km",
                                style: TextStyle(color: ThemeManager.primary)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0), //50//
              child: TabBar(
                onTap: (selected) {
                  setState(() {
                    currentTab = selected;

                    log(currentTab.toString() +
                        "____" +
                        sharedUser.latitude.toString());
                  });
                },
                controller: tabController,
                labelStyle: TextStyle(
                  fontSize: LayoutManager.widthNHeight0(context, 1) * 0.035,
                  color: ThemeManager.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: ThemeManager.fontFamily,
                ),
                indicatorColor: ThemeManager.primary,
                labelColor: ThemeManager.primary,
                unselectedLabelColor: Colors.grey,
                dividerColor: ThemeManager.second,
                tabs: const [
                  Tab(text: 'My Location'),
                  Tab(text: 'Nearest Place'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  BodyPlaces(
                    tab: 'My Location',
                    dis_num: selectedDistance,

                    dataList: [sharedUser.latitude, sharedUser.longitude],
                  ),
                  isTabControllerInitialized
                      ? BodyPlaces(
                          dataList: [selectedNearestLat, selectedNearestLog],
                          tab: 'Nearest Place',
                          dis_num: selectedDistance)
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
