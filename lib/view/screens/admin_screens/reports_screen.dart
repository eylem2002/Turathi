import 'package:flutter/material.dart';

import '../../../core/data_layer.dart';
import '../../view_layer.dart';

//page to  view all reports related to chosen place
//with an action to hide the place visibility
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportList? reportsList;

  @override
  Widget build(BuildContext context) {
    AdminService adminService = AdminService();

    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Admin Reports',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: adminService.getReports(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              reportsList = snapshot.data;
              if (reportsList!.reports.isEmpty)
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: LayoutManager.widthNHeight0(context, 1) * 0.4),
                  child: Center(
                      child: Text("NO Reports Yet",
                          style: TextStyle(
                            color: ThemeManager.primary,
                            fontFamily: "KohSantepheap",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                );
              List<String> ids = adminService.placesIds.toList();

              return ListView.builder(
                  itemCount: ids.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          List<ReportModel> temp = reportsList!.reports
                              .where((element) => element.placeId == ids[index])
                              .toList();
                          Navigator.of(context)
                              .pushNamed(placeReportsAdminRoute,
                                  arguments: temp)
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(
                              LayoutManager.widthNHeight0(context, 1) * 0.02),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 100,
                              color: ThemeManager.primary,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    LayoutManager.widthNHeight0(context, 1) *
                                        0.02,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "Place Id\n${ids[index]}",
                                    style: TextStyle(
                                        color: ThemeManager.second,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: ThemeManager.fontFamily,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
