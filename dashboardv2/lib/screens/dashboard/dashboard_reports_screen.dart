import 'package:admin/models/Reports.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/components/reports_details.dart';
import 'package:admin/screens/dashboard/details_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/reports_list.dart';
import 'components/storage_details.dart';

class ReportsDashboardScreen extends StatefulWidget {
  @override
  State<ReportsDashboardScreen> createState() => _DashboardScreenState();
  late Function(Widget r) change;
}

class _DashboardScreenState extends State<ReportsDashboardScreen> {
  ScrollController scroll_controller = ScrollController();
  late Widget present = Consumer<ReportsProvider>(
      builder: (_, ReportsProvider reportsprovider, __) {
    return ReportsScreen(rep: reportsprovider.reports);
  });

  void update(Widget r) {
    scroll_controller.animateTo(
        //go to top of scroll
        0, //scroll offset to go
        duration: Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
    return setState(() {
      present = r;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.change = update;
    Repository r = Repository();
    r.fetchReports(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: scroll_controller,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // MyFiles(),
                      SizedBox(height: defaultPadding),
                      present

                      //RecentFiles(),
                      /*  if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),*/
                    ],
                  ),
                ),
                /*if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}
