import 'package:admin/models/Reports.dart';
import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/provider/UsersProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/announces_list.dart';
import 'package:admin/screens/dashboard/components/authoritie_details.dart';
import 'package:admin/screens/dashboard/components/authoritie_list.dart';
import 'package:admin/screens/dashboard/components/incident_list.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/components/reports_details.dart';
import 'package:admin/screens/dashboard/components/users_list.dart';
import 'package:admin/screens/dashboard/details_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/incidents_provider.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/reports_list.dart';
import 'components/storage_details.dart';

class GeneralDashboardScreen extends StatefulWidget {
  late Function(Widget r) update;
  @override
  State<GeneralDashboardScreen> createState() => _GeneralDashboardScreenState();
}

class _GeneralDashboardScreenState extends State<GeneralDashboardScreen> {
  ScrollController scroll_controller = ScrollController();
  late Widget present;
  final box = GetStorage();
  void dash(Widget r) {
    scroll_controller.animateTo(
        //go to top of scroll
        0, //scroll offset to go
        duration: Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );

    setState(() {
      present = r;
    });
  }

  @override
  void initState() {
    present = Consumer<AuthoritiesProvider>(
        builder: (_, AuthoritiesProvider reportsprovider, __) {
      String authoritie = box.read("authoritie");
      return AuthoritieDetails(
          rep: reportsprovider.authorities.data
              .firstWhere((element) => element.id == int.parse(authoritie)));
    });
    super.initState();
    widget.update = dash;
    // TODO: implement initState
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
